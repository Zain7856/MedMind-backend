import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createAppointment(UserID, DoctorID, HospitalID, AppointmentDate, Status) {
    const query = db.prepare(
        "INSERT INTO appointments (UserID, DoctorID, HospitalID, AppointmentDate, Status) VALUES (?, ?, ?, ?, ?)"
    );
    const result = query.run(UserID, DoctorID, HospitalID, AppointmentDate, Status);
    return result.lastInsertRowid;
}

function getallAppointments() {
    const query = db.prepare(`
        SELECT a.*, u.Name as UserName, h.Name as HospitalName 
        FROM appointments a 
        JOIN users u ON a.UserID = u.ID 
        JOIN hospitals h ON a.HospitalID = h.ID
    `);
    const result = query.all();
    return result;
}

function getAppointmentById(ID) {
    const query = db.prepare(`
        SELECT a.*, u.Name as UserName, h.Name as HospitalName 
        FROM appointments a 
        JOIN users u ON a.UserID = u.ID 
        JOIN hospitals h ON a.HospitalID = h.ID 
        WHERE a.ID = ?
    `);
    const result = query.get(ID);
    return result;
}

function updateAppointment(ID, UserID, DoctorID, HospitalID, AppointmentDate, Status) {
    try {
        const query = db.prepare(
            "UPDATE appointments SET UserID = ?, DoctorID = ?, HospitalID = ?, AppointmentDate = ?, Status = ? WHERE ID = ?"
        );
        const result = query.run(UserID, DoctorID, HospitalID, AppointmentDate, Status, ID);
        console.log(`Updated appointment with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating appointment:", error.message);
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
    updateAppointment,
    deleteAppointment
}
