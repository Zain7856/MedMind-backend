import db from "./db.js";


async function createdisease(Name, description, treatment, img) {
    const query = db.prepare(
        "INSERT INTO diseases (Name, description, treatment, img) VALUES (?, ?, ?, ?)"
    );
    const result = query.run(Name, description ?? null, treatment ?? null, img ?? null);
    const diseaseId = result.lastInsertRowid;

    // Link symptoms dynamically if provided as a comma-separated string
    if (symptoms) {
        const symptomsList = symptoms.split(",").map(s => s.trim());
        symptomsList.forEach(sName => {
            if (sName) {
                // Find or create symptom
                let symptomId;
                const existing = db.prepare("SELECT ID FROM symptoms WHERE LOWER(Name) = LOWER(?)").get(sName);
                if (existing) {
                    symptomId = existing.ID;
                } else {
                    const insertSym = db.prepare("INSERT INTO symptoms (Name) VALUES (?)").run(sName);
                    symptomId = insertSym.lastInsertRowid;
                }

                // Link
                try {
                    db.prepare("INSERT OR IGNORE INTO symptomdiseases (SymptomID, DiseaseID) VALUES (?, ?)")
                        .run(symptomId, diseaseId);
                } catch (e) { }
            }
        });
    }

    return diseaseId;
}

function getalldiseases() {
    const query = db.prepare(`
        SELECT d.ID, d.Name, d.description, d.treatment, d.img,
               GROUP_CONCAT(s.Name, ', ') AS symptoms
        FROM diseases d
        LEFT JOIN symptomdiseases sd ON sd.DiseaseID = d.ID
        LEFT JOIN symptoms s ON s.ID = sd.SymptomID
        GROUP BY d.ID
    `);
    const result = query.all();
    return result;
}

function getdiseaseById(ID) {
    const query = db.prepare(`
        SELECT d.ID, d.Name, d.description, d.treatment, d.img,
               GROUP_CONCAT(s.Name, ', ') AS symptoms
        FROM diseases d
        LEFT JOIN symptomdiseases sd ON sd.DiseaseID = d.ID
        LEFT JOIN symptoms s ON s.ID = sd.SymptomID
        WHERE d.ID = ?
        GROUP BY d.ID
    `);
    const result = query.get(ID);
    return result;
}

function getdiseaseByName(Name) {
    const query = db.prepare(`
        SELECT d.ID, d.Name, d.description, d.treatment, d.img,
               GROUP_CONCAT(s.Name, ', ') AS symptoms
        FROM diseases d
        LEFT JOIN symptomdiseases sd ON sd.DiseaseID = d.ID
        LEFT JOIN symptoms s ON s.ID = sd.SymptomID
        WHERE LOWER(d.Name) = LOWER(?)
        GROUP BY d.ID
    `);
    const result = query.get(Name);
    return result;
}

function updatedisease(ID, Name, description, symptoms, treatment, img) {
    try {
        const query = db.prepare(
            "UPDATE diseases SET Name = ?, description = ?, treatment = ?, img = ? WHERE ID = ?"
        );
        const result = query.run(Name, description ?? null, treatment ?? null, img ?? null, ID);

        // Sync symptoms if passed
        if (symptoms !== undefined) {
            // Delete old links
            db.prepare("DELETE FROM symptomdiseases WHERE DiseaseID = ?").run(ID);

            if (symptoms) {
                const symptomsList = symptoms.split(",").map(s => s.trim());
                symptomsList.forEach(sName => {
                    if (sName) {
                        let symptomId;
                        const existing = db.prepare("SELECT ID FROM symptoms WHERE LOWER(Name) = LOWER(?)").get(sName);
                        if (existing) {
                            symptomId = existing.ID;
                        } else {
                            const insertSym = db.prepare("INSERT INTO symptoms (Name) VALUES (?)").run(sName);
                            symptomId = insertSym.lastInsertRowid;
                        }

                        try {
                            db.prepare("INSERT OR IGNORE INTO symptomdiseases (SymptomID, DiseaseID) VALUES (?, ?)")
                                .run(symptomId, ID);
                        } catch (e) { }
                    }
                });
            }
        }

        console.log(`Updated disease with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating disease:", error.message);
        throw error;
    }
}

function deletedisease(ID) {
    try {
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
    getdiseaseByName,
    updatedisease,
    deletedisease
}