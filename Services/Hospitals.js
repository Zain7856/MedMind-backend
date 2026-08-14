import db from "./db.js";

async function createHospital(UserID, Name, Location, Phone, img, Services) {
    const query = db.prepare(
        "INSERT INTO hospitals (UserID, Name, Location, Phone, img, Services) VALUES (?, ?, ?, ?, ?, ?)"
    );
    const result = query.run(UserID || null, Name, Location || null, Phone || null, img || null, Services || null);
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

<<<<<<< HEAD
function getHospitalByUserId(UserID) {
    const query = db.prepare("SELECT * FROM hospitals WHERE UserID = ?");
    const result = query.get(UserID);
    return result;
}

function upsertHospitalProfile(UserID, Name, Location, Phone, img, Services) {
    const existing = getHospitalByUserId(UserID);
    if (existing) {
        return updateHospital(existing.ID, Name, Location, Phone, img, Services);
    } else {
        return createHospital(UserID, Name, Location, Phone, img, Services);
    }
}

function updateHospital(ID, Name, Location, Phone, img, Services) {
=======
function updateHospital(ID, Name, Location, Phone) {
>>>>>>> 1eba6a3741a38a4a94e36bc7cfd87cee2bf89b96
    try {
        const query = db.prepare(
            "UPDATE hospitals SET Name = ?, Location = ?, Phone = ?, img = ?, Services = ? WHERE ID = ?"
        );
        const result = query.run(Name, Location, Phone, img || null, Services || null, ID);
        console.log(`Updated hospital with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating hospital:", error.message);
        throw error;
    }
}

function deleteHospital(ID) {
    try {
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
<<<<<<< HEAD
    getHospitalByUserId,
    upsertHospitalProfile,
=======
>>>>>>> 1eba6a3741a38a4a94e36bc7cfd87cee2bf89b96
    updateHospital,
    deleteHospital
}