import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createdisease(Name, description, symptoms, treatment, img) {
    const query = db.prepare(
        "INSERT INTO diseases (Name, description, symptoms, treatment, img) VALUES (?, ?, ?, ?, ?)"
    );
    const result = query.run(Name, description ?? null, symptoms ?? null, treatment ?? null, img ?? null);
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

function updatedisease(ID, Name, description, symptoms, treatment, img) {
    try {
        const query = db.prepare(
            "UPDATE diseases SET Name = ?, description = ?, symptoms = ?, treatment = ?, img = ? WHERE ID = ?"
        );
        const result = query.run(Name, description ?? null, symptoms ?? null, treatment ?? null, img ?? null, ID);
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