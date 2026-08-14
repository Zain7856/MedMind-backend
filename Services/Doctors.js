import db from "./db.js";

async function createDoctor(UserID, Name, Img, Specialization, Phone, Location, cost, About) {
    const query = db.prepare(
        "INSERT INTO doctors (UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
    );
    const result = query.run(UserID || null, Name, Img ?? null, Specialization ?? null, Phone ?? null, Location ?? null, cost ?? null, About ?? null);
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

function getDoctorByUserId(UserID) {
    const query = db.prepare("SELECT * FROM doctors WHERE UserID = ?");
    const result = query.get(UserID);
    return result;
}

function upsertDoctorProfile(UserID, Name, Img, Specialization, Phone, Location, cost, About) {
    // Check if entry exists for this UserID
    const existing = getDoctorByUserId(UserID);
    if (existing) {
        return updateDoctor(existing.ID, Name, Img, Specialization, Phone, Location, cost, About);
    } else {
        return createDoctor(UserID, Name, Img, Specialization, Phone, Location, cost, About);
    }
}

function updateDoctor(ID, Name, Img, Specialization, Phone, Location, cost, About) {
    try {
        const query = db.prepare(
            "UPDATE doctors SET Name = ?, Img = ?, Specialization = ?, Phone = ?, Location = ?, cost = ?, About = ? WHERE ID = ?"
        );
        const result = query.run(Name, Img ?? null, Specialization, Phone, Location, cost, About ?? null, ID);
        console.log(`Updated Doctor with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating Doctor:", error.message);
        throw error;
    }
}

function deleteDoctor(ID) {
    try {
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
    upsertDoctorProfile,
    updateDoctor,
    deleteDoctor
}
