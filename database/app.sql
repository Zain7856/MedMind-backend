CREATE TABLE users (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Age INTEGER,
    Phone VARCHAR(20),
    Role VARCHAR(20) NOT NULL DEFAULT 'Patient' 
);
CREATE TABLE symptoms (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    Description TEXT
);


CREATE TABLE diseases (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    Level VARCHAR(20)
);
CREATE TABLE medicines (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    Price NUMERIC(10, 2) NOT NULL
);
CREATE TABLE doctors (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER NOT NULL,
    Specialization VARCHAR(70),
    Phone VARCHAR(20),
    FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE
);
CREATE TABLE hospitals (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(100) NOT NULL,
    Location TEXT,
    Phone VARCHAR(20)
);
CREATE TABLE appointments (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER NOT NULL,
    DoctorID INTEGER NOT NULL,
    HospitalID INTEGER NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK(Status IN ('Pending', 'Confirmed', 'Cancelled')),
    FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
    FOREIGN KEY(DoctorID) REFERENCES doctors(ID) ON DELETE CASCADE,
    FOREIGN KEY(HospitalID) REFERENCES hospitals(ID) ON DELETE CASCADE
);
CREATE TABLE usersymptoms (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER NOT NULL,
    SymptomID INTEGER NOT NULL,
    FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
    FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE
); 

CREATE TABLE symptomdiseases (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    SymptomID INTEGER NOT NULL,
    DiseaseID INTEGER NOT NULL,
    FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE,
    FOREIGN KEY(DiseaseID) REFERENCES diseases(ID) ON DELETE CASCADE
);
CREATE TABLE diseasemedicines (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    DiseaseID INTEGER NOT NULL,
    MedicineID INTEGER NOT NULL,
    FOREIGN KEY(DiseaseID) REFERENCES diseases(ID) ON DELETE CASCADE,
    FOREIGN KEY(MedicineID) REFERENCES medicines(ID) ON DELETE CASCADE
);

INSERT INTO users (Name, Email, Password, Age, Phone, Role)
VALUES (
        'Omar Ali',
        'omar@example.com',
        'hashed_password_1',
        22,
        '01012345678',
        'Patient'
    ),
    (
        'Sara Ahmed',
        'sara@example.com',
        'hashed_password_2',
        19,
        '01098765432',
        'Patient'
    ),
    (
        'Dr Mahmoud',
        'mahmoud@example.com',
        'hashed_password_3',
        45,
        '01033344455',
        'Doctor'
    ),
    (
        'Dr Hany',
        'hany@example.com',
        'hashed_password_4',
        50,
        '01022233344',
        'Doctor'
    ),
    (
        'Dr Lina',
        'lina@example.com',
        'hashed_password_5',
        38,
        '01055566677',
        'Doctor'
    );
INSERT INTO symptoms (Name, Description)
VALUES ('Headache', 'Pain in the head'),
    ('Fever', 'High body temperature'),
    ('Cough', 'Dry or wet coughing');

INSERT INTO diseases (Name, Level)
VALUES ('Flu', 'Low'),
    ('Covid-19', 'High'),
    ('Migraine', 'Medium');
INSERT INTO medicines (Name, Price)
VALUES ('Panadol', 25),
    ('Cough Syrup', 40),
    ('Vitamin C', 15);
INSERT INTO doctors (UserID, Specialization, Phone)
VALUES (3, 'General', '01033344455'),
    (4, 'Chest', '01022233344'),
    (5, 'Neurology', '01055566677');
INSERT INTO hospitals (Name, Location, Phone)
VALUES ('Cairo Hospital', 'Nasr City', '022345678'),
    ('Health Center', 'Heliopolis', '022987654');
INSERT INTO appointments (
        UserID,
        DoctorID,
        HospitalID,
        AppointmentDate,
        Status
    )
VALUES (1, 3, 1, '2025-12-15 10:00:00', 'Pending'),
    (2, 5, 2, '2025-12-16 12:30:00', 'Confirmed');
INSERT INTO usersymptoms (UserID, SymptomID)
VALUES (1, 1),
    (1, 2),
    (2, 3);
INSERT INTO symptomdiseases (SymptomID, DiseaseID)
VALUES (1, 3),
    (2, 1),
    (2, 2),
    (3, 2);
INSERT INTO diseasemedicines (DiseaseID, MedicineID)
VALUES (1, 1),
    (1, 3),
    (2, 2),
    (3, 1);