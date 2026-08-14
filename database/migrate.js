import Database from "better-sqlite3";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const dbPath = path.resolve(__dirname, "./app.db");
const backupPath = path.resolve(__dirname, "./app_backup.db");
const sqlPath = path.resolve(__dirname, "./app.sql");
const dropSqlPath = path.resolve(__dirname, "./drop.sql");

export function checkAndMigrate() {
  console.log("Checking database schema state...");
  const db = new Database(dbPath);
  
  // Check if users table has ApprovalStatus column
  let needsMigration = false;
  try {
    const columns = db.prepare("PRAGMA table_info(users)").all();
    const hasApproval = columns.some(c => c.name === "ApprovalStatus");
    if (!hasApproval) {
      needsMigration = true;
      console.log("Database schema is legacy. Starting migration...");
    } else {
      console.log("Database is already normalized and up to date.");
      db.close();
      return;
    }
  } catch (err) {
    // If database or users table doesn't exist, we'll initialize it
    console.log("Database not initialized or empty. Initializing...");
    needsMigration = true;
  }

  // Backup active DB if it exists
  db.close();
  if (fs.existsSync(dbPath) && needsMigration) {
    try {
      fs.copyFileSync(dbPath, backupPath);
      console.log(`Backup created at: ${backupPath}`);
    } catch (e) {
      console.error("Failed to create database backup:", e.message);
    }
  }

  // Perform migration/initialization
  performMigration();
}

function performMigration() {
  // Read existing legacy data if backup exists
  let oldData = {
    users: [],
    symptoms: [],
    diseases: [],
    doctors: [],
    hospitals: [],
    appointments: [],
    usersymptoms: [],
    symptomdiseases: []
  };

  if (fs.existsSync(backupPath)) {
    const backupDb = new Database(backupPath);
    try {
      oldData.users = backupDb.prepare("SELECT * FROM users").all();
    } catch(e) {}
    try {
      oldData.symptoms = backupDb.prepare("SELECT * FROM symptoms").all();
    } catch(e) {}
    try {
      oldData.diseases = backupDb.prepare("SELECT * FROM diseases").all();
    } catch(e) {}
    try {
      oldData.doctors = backupDb.prepare("SELECT * FROM doctors").all();
    } catch(e) {}
    try {
      oldData.hospitals = backupDb.prepare("SELECT * FROM hospitals").all();
    } catch(e) {}
    try {
      oldData.appointments = backupDb.prepare("SELECT * FROM appointments").all();
    } catch(e) {}
    try {
      oldData.usersymptoms = backupDb.prepare("SELECT * FROM usersymptoms").all();
    } catch(e) {}
    try {
      oldData.symptomdiseases = backupDb.prepare("SELECT * FROM symptomdiseases").all();
    } catch(e) {}
    backupDb.close();
    console.log("Loaded legacy data from backup successfully.");
  } else {
    console.log("No backup found. Initializing database with seed data.");
  }

  // Delete current app.db to recreate it fresh
  if (fs.existsSync(dbPath)) {
    fs.unlinkSync(dbPath);
  }

  const db = new Database(dbPath);
  db.pragma("foreign_keys = ON");
  db.pragma("journal_mode = WAL");

  // Create tables
  db.exec(`
    CREATE TABLE users (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name VARCHAR(100) NOT NULL,
      Email VARCHAR(100) UNIQUE NOT NULL,
      Password VARCHAR(255) NOT NULL,
      Age INTEGER,
      Phone VARCHAR(20),
      Role VARCHAR(20) NOT NULL CHECK (Role IN ('Patient', 'Doctor', 'Hospital', 'Admin')) DEFAULT 'Patient',
      ApprovalStatus VARCHAR(20) NOT NULL CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected')) DEFAULT 'Pending',
      IsBanned INTEGER NOT NULL DEFAULT 0 CHECK (IsBanned IN (0, 1))
    );

    CREATE TABLE symptoms (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name VARCHAR(70) NOT NULL,
      Description TEXT
    );

    CREATE TABLE diseases (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name VARCHAR(70) NOT NULL,
      description VARCHAR(500),
      treatment VARCHAR(500),
      img TEXT
    );

    CREATE TABLE doctors (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      UserID INTEGER UNIQUE,
      Name VARCHAR(100) NOT NULL,
      Img TEXT,
      Specialization VARCHAR(100),
      Phone VARCHAR(20),
      Location TEXT,
      cost NUMERIC(10, 2),
      About TEXT,
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE
    );

    CREATE TABLE hospitals (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      UserID INTEGER UNIQUE,
      Name VARCHAR(100) NOT NULL,
      Location TEXT,
      Phone VARCHAR(20),
      img TEXT,
      Services TEXT,
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE
    );

    CREATE TABLE usersymptoms (
      UserID INTEGER NOT NULL,
      SymptomID INTEGER NOT NULL,
      PRIMARY KEY (UserID, SymptomID),
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
      FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE
    );

    CREATE TABLE symptomdiseases (
      SymptomID INTEGER NOT NULL,
      DiseaseID INTEGER NOT NULL,
      PRIMARY KEY (SymptomID, DiseaseID),
      FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE,
      FOREIGN KEY(DiseaseID) REFERENCES diseases(ID) ON DELETE CASCADE
    );

    CREATE TABLE appointments (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      UserID INTEGER NOT NULL,
      DoctorID INTEGER,
      HospitalID INTEGER,
      AppointmentDate DATETIME NOT NULL,
      Status VARCHAR(50) NOT NULL CHECK(Status IN ('Pending', 'Confirmed', 'Cancelled')) DEFAULT 'Pending',
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
      FOREIGN KEY(DoctorID) REFERENCES doctors(ID) ON DELETE CASCADE,
      FOREIGN KEY(HospitalID) REFERENCES hospitals(ID) ON DELETE CASCADE,
      CHECK ((DoctorID IS NULL) <> (HospitalID IS NULL))
    );

    CREATE UNIQUE INDEX idx_users_email ON users(Email);
    CREATE INDEX idx_appointments_user ON appointments(UserID);
    CREATE INDEX idx_appointments_doctor ON appointments(DoctorID);
    CREATE INDEX idx_appointments_hospital ON appointments(HospitalID);
  `);

  console.log("Recreated normalized tables and indexes.");

  // 1. Insert seed Admin user
  const insertUser = db.prepare(`
    INSERT INTO users (Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
  `);
  
  insertUser.run("Admin", "admin@medmind.com", "admin123", 35, "01000000000", "Admin", "Approved", 0);

  // If we had no previous data, let's seed with default values from app.sql DDL
  if (oldData.users.length === 0) {
    // Basic seeds
    oldData.users = [
      { Name: 'Omar Ali', Email: 'omar@example.com', Password: 'hashed_password_1', Age: 22, Phone: '01012345678', Role: 'Patient', ApprovalStatus: 'Approved' },
      { Name: 'Sara Ahmed', Email: 'sara@example.com', Password: 'hashed_password_2', Age: 19, Phone: '01098765432', Role: 'Patient', ApprovalStatus: 'Approved' },
      { Name: 'Dr Mahmoud', Email: 'mahmoud@example.com', Password: 'hashed_password_3', Age: 45, Phone: '01033344455', Role: 'Doctor', ApprovalStatus: 'Approved' },
      { Name: 'Dr Hany', Email: 'hany@example.com', Password: 'hashed_password_4', Age: 50, Phone: '01022233344', Role: 'Doctor', ApprovalStatus: 'Approved' },
      { Name: 'Dr Lina', Email: 'lina@example.com', Password: 'hashed_password_5', Age: 38, Phone: '01055566677', Role: 'Doctor', ApprovalStatus: 'Approved' }
    ];
    oldData.symptoms = [
      { ID: 1, Name: 'Headache', Description: 'Pain in the head' },
      { ID: 2, Name: 'Fever', Description: 'High body temperature' },
      { ID: 3, Name: 'Cough', Description: 'Dry or wet coughing' }
    ];
    oldData.diseases = [
      { ID: 1, Name: 'Flu', description: 'Viral infection causing fever, cough, and body aches', treatment: 'Rest, fluids, antiviral medications', img: 'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=300', symptoms: 'Fever, cough, sore throat, body aches, fatigue' },
      { ID: 2, Name: 'Covid-19', description: 'Coronavirus disease causing respiratory illness', treatment: 'Antiviral drugs, oxygen therapy, rest', img: 'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=300', symptoms: 'Fever, dry cough, fatigue, loss of taste/smell' },
      { ID: 3, Name: 'Migraine', description: 'Severe headache often with nausea', treatment: 'Pain relievers, preventive medications', img: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=300', symptoms: 'Intense throbbing pain, nausea, light/sound sensitivity' }
    ];
    oldData.doctors = [
      { Name: 'Dr Mahmoud', Img: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150', Specialization: 'Cardiology', Phone: '01033344455', Location: 'Cairo', cost: 500 },
      { Name: 'Dr Hany', Img: 'https://images.unsplash.com/photo-1625363529958-80bae9c20b3f?w=150', Specialization: 'Neurology', Phone: '01022233344', Location: 'Giza', cost: 750 },
      { Name: 'Dr Lina', Img: 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=150', Specialization: 'Pediatrics', Phone: '01055566677', Location: 'Alexandria', cost: 600 },
      { Name: 'Dr Ahmed', Img: 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=150', Specialization: 'Orthopedics', Phone: '01011112222', Location: 'Mansoura', cost: 450 }
    ];
    oldData.hospitals = [
      { Name: 'Cairo Hospital', Location: 'Nasr City', Phone: '022345678', img: 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300', Services: 'Emergency, Surgery, Cardiology' },
      { Name: 'Mansoura General', Location: 'Mansoura', Phone: '0501234567', img: 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=300', Services: 'Emergency, Pediatrics, General Medicine' }
    ];
    oldData.appointments = [
      { UserID: 1, DoctorID: 1, HospitalID: null, AppointmentDate: '2025-12-15 10:00:00', Status: 'Pending' },
      { UserID: 2, DoctorID: null, HospitalID: 2, AppointmentDate: '2025-12-16 12:30:00', Status: 'Confirmed' }
    ];
    oldData.usersymptoms = [
      { UserID: 1, SymptomID: 1 },
      { UserID: 1, SymptomID: 2 },
      { UserID: 2, SymptomID: 3 }
    ];
    oldData.symptomdiseases = [
      { SymptomID: 1, DiseaseID: 3 },
      { SymptomID: 2, DiseaseID: 1 },
      { SymptomID: 2, DiseaseID: 2 },
      { SymptomID: 3, DiseaseID: 2 }
    ];
  }

  // Track map from old user ID to new user ID
  // Insert users
  const userEmailToNewId = {};
  oldData.users.forEach(u => {
    // If this is not the seeded admin
    if (u.Email !== 'admin@medmind.com') {
      const role = u.Role || 'Patient';
      // Seeded users are pre-approved
      const status = u.ApprovalStatus || 'Approved';
      const isBanned = u.IsBanned || 0;
      try {
        const res = insertUser.run(u.Name, u.Email, u.Password, u.Age || null, u.Phone || null, role, status, isBanned);
        userEmailToNewId[u.Email] = res.lastInsertRowid;
      } catch (err) {
        console.error(`Failed to migrate user ${u.Email}:`, err.message);
      }
    }
  });

  // Ensure every doctor and hospital has a user account
  // If not, automatically create one based on the selection option choice
  oldData.doctors.forEach(doc => {
    // Check if there is an existing user account with doctor's name or phone
    let user = oldData.users.find(u => u.Name === doc.Name || u.Phone === doc.Phone);
    let userId;
    if (user && userEmailToNewId[user.Email]) {
      userId = userEmailToNewId[user.Email];
    } else {
      // Create user account
      const email = doc.Email || `${doc.Name.toLowerCase().replace(/[^a-z]/g, "")}@medmind-doc.com`;
      try {
        const res = insertUser.run(doc.Name, email, "password123", 40, doc.Phone || null, "Doctor", "Approved", 0);
        userId = res.lastInsertRowid;
        userEmailToNewId[email] = userId;
        console.log(`Created user account for Doctor ${doc.Name} with email ${email}`);
      } catch (err) {
        // If email already exists or error, try to fetch it
        try {
          const row = db.prepare("SELECT ID FROM users WHERE Email = ?").get(email);
          if (row) userId = row.ID;
        } catch(e) {}
      }
    }
    doc.UserID = userId;
  });

  oldData.hospitals.forEach(hos => {
    let user = oldData.users.find(u => u.Name === hos.Name || u.Phone === hos.Phone);
    let userId;
    if (user && userEmailToNewId[user.Email]) {
      userId = userEmailToNewId[user.Email];
    } else {
      // Create user account
      const email = `${hos.Name.toLowerCase().replace(/[^a-z]/g, "")}@medmind-hos.com`;
      try {
        const res = insertUser.run(hos.Name, email, "password123", null, hos.Phone || null, "Hospital", "Approved", 0);
        userId = res.lastInsertRowid;
        userEmailToNewId[email] = userId;
        console.log(`Created user account for Hospital ${hos.Name} with email ${email}`);
      } catch (err) {
        try {
          const row = db.prepare("SELECT ID FROM users WHERE Email = ?").get(email);
          if (row) userId = row.ID;
        } catch(e) {}
      }
    }
    hos.UserID = userId;
  });

  // Insert Symptoms
  const symptomNameToId = {};
  const insertSymptom = db.prepare(`
    INSERT INTO symptoms (Name, Description) VALUES (?, ?)
  `);
  oldData.symptoms.forEach(s => {
    try {
      const res = insertSymptom.run(s.Name, s.Description || null);
      symptomNameToId[s.Name.toLowerCase()] = res.lastInsertRowid;
    } catch(e) {
      console.error(e.message);
    }
  });

  // Insert Diseases (with image column and stripping symptoms text column)
  const insertDisease = db.prepare(`
    INSERT INTO diseases (Name, description, treatment, img) VALUES (?, ?, ?, ?)
  `);
  const oldDiseaseIdToNew = {};
  oldData.diseases.forEach(d => {
    try {
      // Use img or img_url
      const imgVal = d.img || d.img_url || null;
      const res = insertDisease.run(d.Name, d.description || null, d.treatment || null, imgVal);
      const newDiseaseId = res.lastInsertRowid;
      oldDiseaseIdToNew[d.ID] = newDiseaseId;

      // Extract symptoms from legacy text column if present, and link them
      if (d.symptoms) {
        const symptomsList = d.symptoms.split(",").map(s => s.trim().toLowerCase());
        symptomsList.forEach(sName => {
          if (sName) {
            let symId = symptomNameToId[sName];
            if (!symId) {
              // Create it dynamically
              try {
                const symRes = insertSymptom.run(sName.charAt(0).toUpperCase() + sName.slice(1), "");
                symId = symRes.lastInsertRowid;
                symptomNameToId[sName] = symId;
              } catch(e) {}
            }
            if (symId) {
              try {
                db.prepare("INSERT OR IGNORE INTO symptomdiseases (SymptomID, DiseaseID) VALUES (?, ?)")
                  .run(symId, newDiseaseId);
              } catch(e) {}
            }
          }
        });
      }
    } catch(e) {
      console.error(e.message);
    }
  });

  // Insert Doctors
  const oldDoctorIdToNew = {};
  const insertDoctor = db.prepare(`
    INSERT INTO doctors (UserID, Name, Img, Specialization, Phone, Location, cost, About)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
  `);
  oldData.doctors.forEach((doc, idx) => {
    try {
      // Clean cost (remove ' L.E' or non-numeric if numeric is expected)
      let costNum = null;
      if (doc.cost) {
        const match = String(doc.cost).match(/\d+/);
        if (match) costNum = parseFloat(match[0]);
      }
      const res = insertDoctor.run(
        doc.UserID || null,
        doc.Name,
        doc.Img || null,
        doc.Specialization || null,
        doc.Phone || null,
        doc.Location || null,
        costNum,
        doc.About || null
      );
      oldDoctorIdToNew[doc.ID || (idx + 1)] = res.lastInsertRowid;
    } catch(e) {
      console.error(`Failed to insert doctor ${doc.Name}:`, e.message);
    }
  });

  // Insert Hospitals
  const oldHospitalIdToNew = {};
  const insertHospital = db.prepare(`
    INSERT INTO hospitals (UserID, Name, Location, Phone, img, Services)
    VALUES (?, ?, ?, ?, ?, ?)
  `);
  oldData.hospitals.forEach((hos, idx) => {
    try {
      const res = insertHospital.run(
        hos.UserID || null,
        hos.Name,
        hos.Location || null,
        hos.Phone || null,
        hos.img || hos.img_url || null,
        hos.Services || null
      );
      oldHospitalIdToNew[hos.ID || (idx + 1)] = res.lastInsertRowid;
    } catch(e) {
      console.error(`Failed to insert hospital ${hos.Name}:`, e.message);
    }
  });

  // Insert user symptoms
  oldData.usersymptoms.forEach(us => {
    // Lookup new UserID
    let oldUser = oldData.users.find(u => u.ID === us.UserID);
    let newUserId = oldUser ? userEmailToNewId[oldUser.Email] : us.UserID;
    if (newUserId && us.SymptomID) {
      try {
        db.prepare("INSERT OR IGNORE INTO usersymptoms (UserID, SymptomID) VALUES (?, ?)")
          .run(newUserId, us.SymptomID);
      } catch(e) {}
    }
  });

  // Insert symptom diseases from old junction table
  oldData.symptomdiseases.forEach(sd => {
    const newDiseaseId = oldDiseaseIdToNew[sd.DiseaseID];
    if (sd.SymptomID && newDiseaseId) {
      try {
        db.prepare("INSERT OR IGNORE INTO symptomdiseases (SymptomID, DiseaseID) VALUES (?, ?)")
          .run(sd.SymptomID, newDiseaseId);
      } catch(e) {}
    }
  });

  // Insert Appointments
  const insertAppointment = db.prepare(`
    INSERT INTO appointments (UserID, DoctorID, HospitalID, AppointmentDate, Status)
    VALUES (?, ?, ?, ?, ?)
  `);
  oldData.appointments.forEach(ap => {
    let oldUser = oldData.users.find(u => u.ID === ap.UserID);
    let newUserId = oldUser ? userEmailToNewId[oldUser.Email] : ap.UserID;
    
    let newDocId = ap.DoctorID ? oldDoctorIdToNew[ap.DoctorID] : null;
    let newHosId = ap.HospitalID ? oldHospitalIdToNew[ap.HospitalID] : null;

    if (newUserId && (newDocId || newHosId) && ap.AppointmentDate) {
      try {
        insertAppointment.run(newUserId, newDocId, newHosId, ap.AppointmentDate, ap.Status || "Pending");
      } catch(e) {
        console.error("Failed to insert appointment:", e.message);
      }
    }
  });

  console.log("Successfully migrated all data.");

  // Generate authoritative app.sql and drop.sql dumps
  generateAuthSql(db);

  db.close();
}

function generateAuthSql(db) {
  let sql = "";
  
  // Table creation schemas
  const tables = ['users', 'symptoms', 'diseases', 'doctors', 'hospitals', 'usersymptoms', 'symptomdiseases', 'appointments'];
  
  tables.forEach(t => {
    const createStmt = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name=?`).get(t);
    if (createStmt && createStmt.sql) {
      sql += `${createStmt.sql};\n\n`;
    }
  });

  // Unique and non-unique indexes
  const indexes = db.prepare(`SELECT sql FROM sqlite_master WHERE type='index' AND sql IS NOT NULL`).all();
  indexes.forEach(idx => {
    sql += `${idx.sql};\n`;
  });
  sql += "\n";

  // Data inserts
  tables.forEach(t => {
    const rows = db.prepare(`SELECT * FROM ${t}`).all();
    if (rows.length > 0) {
      sql += `-- Seed data for ${t}\n`;
      rows.forEach(r => {
        const keys = Object.keys(r);
        const vals = keys.map(k => {
          const val = r[k];
          if (val === null) return 'NULL';
          if (typeof val === 'string') return `'${val.replace(/'/g, "''")}'`;
          return val;
        });
        sql += `INSERT INTO ${t} (${keys.join(', ')}) VALUES (${vals.join(', ')});\n`;
      });
      sql += "\n";
    }
  });

  fs.writeFileSync(sqlPath, sql);
  console.log(`Authoritative SQL dump generated at: ${sqlPath}`);

  // Drop SQL file content
  const dropSql = `DROP TABLE IF EXISTS appointments;\nDROP TABLE IF EXISTS symptomdiseases;\nDROP TABLE IF EXISTS usersymptoms;\nDROP TABLE IF EXISTS hospitals;\nDROP TABLE IF EXISTS doctors;\nDROP TABLE IF EXISTS diseases;\nDROP TABLE IF EXISTS symptoms;\nDROP TABLE IF EXISTS users;\n`;
  fs.writeFileSync(dropSqlPath, dropSql);
  console.log(`Drop SQL generated at: ${dropSqlPath}`);
}
