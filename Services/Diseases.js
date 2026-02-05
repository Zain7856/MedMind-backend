import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createdisease(Name, Level) {
    const query = db.prepare(
        "INSERT INTO diseases (Name,Level) VALUES (?, ?)"
    );
    const result = query.run(Name, Level);
    return result.lastInsertRowid;
}

function getalldiseases() {
    const query = db.prepare("SELECT * FROM diseases");
    const result = query.all();
    return result;
}

function getdiseaseById(ID) {
    const query = db.prepare("SELECT * FROM diseases WHERE ID = ?");
    const result = query.get(ID);
    return result;
}

function updatedisease(ID, Name, Level) {
    try {
        const query = db.prepare(
            "UPDATE diseases SET Name = ?, Level = ? WHERE ID =. ?"
        );
        const result = query.run(Name, Level, ID);
        console.log(`Updated disease with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating disease:", error.message);
        throw error;
    }
}
function deletedisease(ID) {
    try {
        // Foreign key constraints with ON DELETE CASCADE will handle related records
        const query = db.prepare("DELETE FROM diseases WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted disease with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting disease:", error.message);
        throw error;
    }
}




export {
    createdisease,
    getalldiseases,
    getdiseaseById,
    updatedisease,
    deletedisease
}