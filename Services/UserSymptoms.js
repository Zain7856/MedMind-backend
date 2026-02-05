import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createUserSymptom(UserID, SymptomID) {
    const query = db.prepare(
        "INSERT INTO usersymptoms (UserID, SymptomID) VALUES (?, ?)"
    );
    const result = query.run(UserID, SymptomID);
    return result.lastInsertRowid;
}

function getAllUserSymptoms() {
    const query = db.prepare(`
        SELECT us.ID, us.UserID, us.SymptomID, 
               u.Name as UserName, s.Name as SymptomName 
        FROM usersymptoms us 
        JOIN users u ON us.UserID = u.ID 
        JOIN symptoms s ON us.SymptomID = s.ID
    `);
    const result = query.all();
    return result;
}

function getUserSymptomsByUserId(UserID) {
    const query = db.prepare(`
        SELECT us.ID, us.UserID, us.SymptomID, 
               u.Name as UserName, s.Name as SymptomName, s.Description 
        FROM usersymptoms us 
        JOIN users u ON us.UserID = u.ID 
        JOIN symptoms s ON us.SymptomID = s.ID 
        WHERE us.UserID = ?
    `);
    const result = query.all(UserID);
    return result;
}

function getUserSymptomById(ID) {
    const query = db.prepare(`
        SELECT us.ID, us.UserID, us.SymptomID, 
               u.Name as UserName, s.Name as SymptomName, s.Description 
        FROM usersymptoms us 
        JOIN users u ON us.UserID = u.ID 
        JOIN symptoms s ON us.SymptomID = s.ID 
        WHERE us.ID = ?
    `);
    const result = query.get(ID);
    return result;
}

function deleteUserSymptom(ID) {
    try {
        const query = db.prepare("DELETE FROM usersymptoms WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted user symptom with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting user symptom:", error.message);
        throw error;
    }
}

export {
    createUserSymptom,
    getAllUserSymptoms,
    getUserSymptomsByUserId,
    getUserSymptomById,
    deleteUserSymptom
}
