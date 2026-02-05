import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createDoctor(UserID, Specialization, Phone) {
    const query = db.prepare(
        "INSERT INTO doctors (UserID, Specialization, Phone) VALUES (?, ?, ?)"
    );
    const result = query.run(UserID, Specialization, Phone);
    return result.lastInsertRowid;
}

function getallDoctors() {
    const query = db.prepare(`
        SELECT d.ID, d.UserID, d.Specialization, d.Phone, 
               u.Name, u.Email, u.Age 
        FROM doctors d 
        JOIN users u ON d.UserID = u.ID
    `);
    const result = query.all();
    return result;
}

function getDoctorById(ID) {
    const query = db.prepare(`
        SELECT d.ID, d.UserID, d.Specialization, d.Phone, 
               u.Name, u.Email, u.Age 
        FROM doctors d 
        JOIN users u ON d.UserID = u.ID 
        WHERE d.ID = ?
    `);
    const result = query.get(ID);
    return result;
}

function getDoctorByUserId(UserID) {
    const query = db.prepare(`
        SELECT d.ID, d.UserID, d.Specialization, d.Phone, 
               u.Name, u.Email, u.Age 
        FROM doctors d 
        JOIN users u ON d.UserID = u.ID 
        WHERE d.UserID = ?
    `);
    const result = query.get(UserID);
    return result;
}

function updateDoctor(ID, Specialization, Phone) {
    try {
        const query = db.prepare(
            "UPDATE doctors SET Specialization = ?, Phone = ? WHERE ID = ?"
        );
        const result = query.run(Specialization, Phone, ID);
        console.log(`Updated Doctor with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating Doctor:", error.message);
        throw error;
    }
}

function deleteDoctor(ID) {
    try {
        // Foreign key constraints with ON DELETE CASCADE will handle related records
        const query = db.prepare("DELETE FROM doctors WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted Doctor with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting Doctor:", error.message);
        throw error;
    }
}

export {
    createDoctor,
    getallDoctors,
    getDoctorById,
    getDoctorByUserId,
    updateDoctor,
    deleteDoctor
}
