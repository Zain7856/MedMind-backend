import Database from "better-sqlite3";

const db = new Database("./database/app.db");

async function createMedicine(Name, Price) {
    const query = db.prepare(
        "INSERT INTO medicines (Name,Price) VALUES (?, ?)"
    );  
    const result = query.run(Name, Price);
    return result.lastInsertRowid;
}

function getallMedicines() {
    const query = db.prepare("SELECT * FROM medicines");
    const result = query.all();
    return result;
}

function getMedicineById(ID) {
    const query = db.prepare("SELECT * FROM medicines WHERE ID = ?");
    const result = query.get(ID);
    return result;
}

function updateMedicine(ID, Name, Price) {
    try {
        const query = db.prepare(
            "UPDATE medicines SET Name = ?, Price = ? WHERE ID = ?"
        );
        const result = query.run(Name, Price, ID);
        console.log(`Updated medicine with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating medicine:", error.message);
        throw error;
    }
}
function deleteMedicine(ID) {
    try {
        // Foreign key constraints with ON DELETE CASCADE will handle related records
        const query = db.prepare("DELETE FROM medicines WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted medicine with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting medicine:", error.message);
        throw error;
    }
}




export {
    createMedicine,
    getallMedicines,
    getMedicineById,
    updateMedicine,
    deleteMedicine
}