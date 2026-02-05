import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createSymptomDisease(SymptomID, DiseaseID) {
    const query = db.prepare(
        "INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (?, ?)"
    );
    const result = query.run(SymptomID, DiseaseID);
    return result.lastInsertRowid;
}

function getAllSymptomDiseases() {
    const query = db.prepare(`
        SELECT sd.ID, sd.SymptomID, sd.DiseaseID, 
               s.Name as SymptomName, d.Name as DiseaseName, d.Level 
        FROM symptomdiseases sd 
        JOIN symptoms s ON sd.SymptomID = s.ID 
        JOIN diseases d ON sd.DiseaseID = d.ID
    `);
    const result = query.all();
    return result;
}

function getSymptomDiseasesBySymptomId(SymptomID) {
    const query = db.prepare(`
        SELECT sd.ID, sd.SymptomID, sd.DiseaseID, 
               s.Name as SymptomName, d.Name as DiseaseName, d.Level 
        FROM symptomdiseases sd 
        JOIN symptoms s ON sd.SymptomID = s.ID 
        JOIN diseases d ON sd.DiseaseID = d.ID 
        WHERE sd.SymptomID = ?
    `);
    const result = query.all(SymptomID);
    return result;
}

function getSymptomDiseaseById(ID) {
    const query = db.prepare(`
        SELECT sd.ID, sd.SymptomID, sd.DiseaseID, 
               s.Name as SymptomName, d.Name as DiseaseName, d.Level 
        FROM symptomdiseases sd 
        JOIN symptoms s ON sd.SymptomID = s.ID 
        JOIN diseases d ON sd.DiseaseID = d.ID 
        WHERE sd.ID = ?
    `);
    const result = query.get(ID);
    return result;
}

function deleteSymptomDisease(ID) {
    try {
        const query = db.prepare("DELETE FROM symptomdiseases WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted symptom disease with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting symptom disease:", error.message);
        throw error;
    }
}

export {
    createSymptomDisease,
    getAllSymptomDiseases,
    getSymptomDiseasesBySymptomId,
    getSymptomDiseaseById,
    deleteSymptomDisease
}
