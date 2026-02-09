import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createDoctor(Name, Img, Specialization, Phone, Location, cost) {
    const query = db.prepare(
        "INSERT INTO doctors (Name, Img, Specialization, Phone, Location, cost) VALUES (?, ?, ?, ?, ?, ?)"
    );
    const result = query.run(Name, Img ?? null, Specialization, Phone, Location, cost);
    return result.lastInsertRowid;
}

function getallDoctors() {
    const query = db.prepare("SELECT * FROM doctors");
    const result = query.all();
    return result;
}

function getDoctorById(ID) {
    const query = db.prepare("SELECT * FROM doctors WHERE ID = ?");
    const result = query.get(ID);
    return result;
}

function updateDoctor(ID, Name, Img, Specialization, Phone, Location, cost) {
    try {
        const query = db.prepare(
            "UPDATE doctors SET Name = ?, Img = ?, Specialization = ?, Phone = ?, Location = ?, cost = ? WHERE ID = ?"
        );
        const result = query.run(Name, Img ?? null, Specialization, Phone, Location, cost, ID);
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
    updateDoctor,
    deleteDoctor
}
