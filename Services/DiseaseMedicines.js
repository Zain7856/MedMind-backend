import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createDiseaseMedicine(DiseaseID, MedicineID) {
    const query = db.prepare(
        "INSERT INTO diseasemedicines (DiseaseID, MedicineID) VALUES (?, ?)"
    );
    const result = query.run(DiseaseID, MedicineID);
    return result.lastInsertRowid;
}

function getAllDiseaseMedicines() {
    const query = db.prepare(`
        SELECT dm.ID, dm.DiseaseID, dm.MedicineID, 
               d.Name as DiseaseName, m.Name as MedicineName, m.Price 
        FROM diseasemedicines dm 
        JOIN diseases d ON dm.DiseaseID = d.ID 
        JOIN medicines m ON dm.MedicineID = m.ID
    `);
    const result = query.all();
    return result;
}

function getDiseaseMedicinesByDiseaseId(DiseaseID) {
    const query = db.prepare(`
        SELECT dm.ID, dm.DiseaseID, dm.MedicineID, 
               d.Name as DiseaseName, m.Name as MedicineName, m.Price 
        FROM diseasemedicines dm 
        JOIN diseases d ON dm.DiseaseID = d.ID 
        JOIN medicines m ON dm.MedicineID = m.ID 
        WHERE dm.DiseaseID = ?
    `);
    const result = query.all(DiseaseID);
    return result;
}

function getDiseaseMedicineById(ID) {
    const query = db.prepare(`
        SELECT dm.ID, dm.DiseaseID, dm.MedicineID, 
               d.Name as DiseaseName, m.Name as MedicineName, m.Price 
        FROM diseasemedicines dm 
        JOIN diseases d ON dm.DiseaseID = d.ID 
        JOIN medicines m ON dm.MedicineID = m.ID 
        WHERE dm.ID = ?
    `);
    const result = query.get(ID);
    return result;
}

function deleteDiseaseMedicine(ID) {
    try {
        const query = db.prepare("DELETE FROM diseasemedicines WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted disease medicine with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting disease medicine:", error.message);
        throw error;
    }
}

export {
    createDiseaseMedicine,
    getAllDiseaseMedicines,
    getDiseaseMedicinesByDiseaseId,
    getDiseaseMedicineById,
    deleteDiseaseMedicine
}
