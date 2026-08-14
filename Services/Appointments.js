import db from "./db.js";

async function createAppointment(UserID, DoctorID, HospitalID, AppointmentDate, Status) {
<<<<<<< HEAD
    // Validate if User exists
    const userQuery = db.prepare("SELECT ID FROM users WHERE ID = ?");
    const user = userQuery.get(UserID);
    
=======
    // Validate if User, Doctor, and Hospital exist
    const userQuery = db.prepare("SELECT ID FROM users WHERE ID = ?");
    const user = userQuery.get(UserID);
    
    const doctorQuery = db.prepare("SELECT ID FROM doctors WHERE ID = ?");
    const doctor = doctorQuery.get(DoctorID);
    
    const hospitalQuery = db.prepare("SELECT ID FROM hospitals WHERE ID = ?");
    const hospital = hospitalQuery.get(HospitalID);
    
>>>>>>> 1eba6a3741a38a4a94e36bc7cfd87cee2bf89b96
    if (!user) {
        throw new Error(`User with ID ${UserID} does not exist`);
    }
    
<<<<<<< HEAD
    // Validate Doctor only if DoctorID is provided
    if (DoctorID) {
        const doctorQuery = db.prepare("SELECT ID FROM doctors WHERE ID = ?");
        const doctor = doctorQuery.get(DoctorID);
        
        if (!doctor) {
            throw new Error(`Doctor with ID ${DoctorID} does not exist`);
        }
    }
    
    // Validate Hospital only if HospitalID is provided
    if (HospitalID) {
        const hospitalQuery = db.prepare("SELECT ID FROM hospitals WHERE ID = ?");
        const hospital = hospitalQuery.get(HospitalID);
        
        if (!hospital) {
            throw new Error(`Hospital with ID ${HospitalID} does not exist`);
        }
=======
    if (DoctorID && !doctor) {
        throw new Error(`Doctor with ID ${DoctorID} does not exist`);
    }
    
    if (HospitalID && !hospital) {
        throw new Error(`Hospital with ID ${HospitalID} does not exist`);
>>>>>>> 1eba6a3741a38a4a94e36bc7cfd87cee2bf89b96
    }
    
    const query = db.prepare(
        "INSERT INTO appointments (UserID, DoctorID, HospitalID, AppointmentDate, Status) VALUES (?, ?, ?, ?, ?)"
    );
    const result = query.run(UserID, DoctorID || null, HospitalID || null, AppointmentDate, Status);
    return result.lastInsertRowid;
}

function getallAppointments() {
    const query = db.prepare(`
        SELECT a.*, u.Name as UserName, h.Name as HospitalName, d.Name as DoctorName 
        FROM appointments a 
        LEFT JOIN users u ON a.UserID = u.ID 
        LEFT JOIN hospitals h ON a.HospitalID = h.ID
        LEFT JOIN doctors d ON a.DoctorID = d.ID
    `);
    const result = query.all();
    return result;
}

function getAppointmentById(ID) {
    const query = db.prepare(`
        SELECT a.*, u.Name as UserName, h.Name as HospitalName, d.Name as DoctorName 
        FROM appointments a 
        LEFT JOIN users u ON a.UserID = u.ID 
        LEFT JOIN hospitals h ON a.HospitalID = h.ID 
        LEFT JOIN doctors d ON a.DoctorID = d.ID
        WHERE a.ID = ?
    `);
    const result = query.get(ID);
    return result;
}

function getAppointmentsByDoctorUserId(doctorUserId) {
    const query = db.prepare(`
        SELECT a.*, u.Name as UserName, u.Phone as PatientPhone, u.Age as PatientAge, d.Name as DoctorName 
        FROM appointments a 
        JOIN users u ON a.UserID = u.ID 
        JOIN doctors d ON a.DoctorID = d.ID
        WHERE d.UserID = ?
    `);
    const result = query.all(doctorUserId);
    return result;
}

function getAppointmentsByHospitalUserId(hospitalUserId) {
    const query = db.prepare(`
        SELECT a.*, u.Name as UserName, u.Phone as PatientPhone, u.Age as PatientAge, h.Name as HospitalName 
        FROM appointments a 
        JOIN users u ON a.UserID = u.ID 
        JOIN hospitals h ON a.HospitalID = h.ID
        WHERE h.UserID = ?
    `);
    const result = query.all(hospitalUserId);
    return result;
}

function updateAppointment(ID, UserID, DoctorID, HospitalID, AppointmentDate, Status) {
    try {
        const query = db.prepare(
            "UPDATE appointments SET UserID = ?, DoctorID = ?, HospitalID = ?, AppointmentDate = ?, Status = ? WHERE ID = ?"
        );
        const result = query.run(UserID, DoctorID || null, HospitalID || null, AppointmentDate, Status, ID);
        console.log(`Updated appointment with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating appointment:", error.message);
        throw error;
    }
}

function updateAppointmentStatus(ID, Status) {
    try {
        const query = db.prepare(
            "UPDATE appointments SET Status = ? WHERE ID = ?"
        );
        const result = query.run(Status, ID);
        console.log(`Updated appointment status to ${Status} for ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating appointment status:", error.message);
        throw error;
    }
}

function deleteAppointment(ID) {
    try {
        const query = db.prepare("DELETE FROM appointments WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted appointment with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting appointment:", error.message);
        throw error;
    }
}

export {
    createAppointment,
    getallAppointments,
    getAppointmentById,
    getAppointmentsByDoctorUserId,
    getAppointmentsByHospitalUserId,
    updateAppointment,
    updateAppointmentStatus,
    deleteAppointment
}
