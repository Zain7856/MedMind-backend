import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createHospital(Name, Location, Phone) {
    const query = db.prepare(
        "INSERT INTO hospitals (Name,Location,Phone) VALUES (?, ?, ?)"
    );
    const result = query.run(Name, Location, Phone);
    return result.lastInsertRowid;
}

function getallHospitals() {
    const query = db.prepare("SELECT * FROM hospitals");
    const result = query.all();
    return result;
}

function getHospitalById(ID) {
    const query = db.prepare("SELECT * FROM hospitals WHERE ID = ?");
    const result = query.get(ID);
    return result;
}

function getHospitalByName(Name) {
    const query = db.prepare("SELECT * FROM hospitals WHERE Name = ?");
    const result = query.get(Name);
    return result;
}

function updateHospital(ID, Name, Location, Phone) {
    try {
        const query = db.prepare(
            "UPDATE hospitals SET Name = ?, Location = ?, Phone = ? WHERE ID = ?"
        );
        const result = query.run(Name, Location, Phone, ID);
        console.log(`Updated hospital with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating hospital:", error.message);
        throw error;
    }
}
function deleteHospital(ID) {
    try {
        // Foreign key constraints with ON DELETE CASCADE will handle related records
        const query = db.prepare("DELETE FROM hospitals WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted hospital with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting hospital:", error.message);
        throw error;
    }
}




export {
    createHospital,
    getallHospitals,
    getHospitalById,
    getHospitalByName,
    updateHospital,
    deleteHospital
}