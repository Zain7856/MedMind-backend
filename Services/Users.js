import Database from "better-sqlite3";

const db = new Database("./database/app.db");

function createuser(Name, Email, Password, Age, Phone, Role) {
    const query = db.prepare(
        "INSERT INTO users (Name, Email, Password, Age, Phone, Role) VALUES (?, ?, ?, ?, ?, ?)"
    );
    const result = query.run(Name, Email, Password, Age, Phone, Role);
    return result.lastInsertRowid;
}

function getallusers() {
    const query = db.prepare("SELECT * FROM users");
    const result = query.all();
    return result;
}

function getuserById(ID) {
    const query = db.prepare("SELECT * FROM users WHERE ID = ?");
    const result = query.get(ID);
    return result;
}

function getuserByEmail(Email) {
    const query = db.prepare("SELECT * FROM users WHERE Email = ?");
    const result = query.get(Email);
    return result;
}

function updateuser(ID, Name, Email, Age, Phone, Role) {
    try {
        const query = db.prepare(
            "UPDATE users SET Name = ?, Email = ?, Age = ?, Phone = ?, Role = ? WHERE ID = ?"
        );
        const result = query.run(Name, Email, Age, Phone, Role, ID);
        console.log(`Updated user with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating user:", error.message);
        throw error;
    }
}

function updateuserPassword(ID, Password) {
    try {
        const query = db.prepare(
            "UPDATE users SET Password = ? WHERE ID = ?"
        );
        const result = query.run(Password, ID);
        console.log(`Updated password for user with ID: ${ID}`);
        
        return result;
    } catch (error) {
        console.error("Error updating password:", error.message);
        throw error;
    }
}

function deleteuser(ID) {
    try {
        const query = db.prepare("DELETE FROM users WHERE ID = ?");
        const result = query.run(ID);
        console.log(`Deleted user with ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error deleting user:", error.message);
        throw error;
    }
}

export {
    createuser,
    getallusers,
    getuserById,
    getuserByEmail,
    updateuser,
    updateuserPassword,
    deleteuser
}
