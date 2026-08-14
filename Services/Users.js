import db from "./db.js";

function createuser(Name, Email, Password, Age, Phone, Role, ApprovalStatus = 'Pending') {
    const query = db.prepare(
        "INSERT INTO users (Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (?, ?, ?, ?, ?, ?, ?, 0)"
    );
    const result = query.run(Name, Email, Password, Age || null, Phone || null, Role || 'Patient', ApprovalStatus);
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

function getuserbyage(Age) {
    const query = db.prepare("SELECT * FROM users WHERE Age >= ?");
    const result = query.all(Age);
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

function updateUserStatus(ID, ApprovalStatus) {
    try {
        const query = db.prepare(
            "UPDATE users SET ApprovalStatus = ? WHERE ID = ?"
        );
        const result = query.run(ApprovalStatus, ID);
        console.log(`Updated user approval status to ${ApprovalStatus} for ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating user approval status:", error.message);
        throw error;
    }
}

function updateUserBanned(ID, IsBanned) {
    try {
        // When banning, cancel all active appointments automatically
        const result = db.transaction(() => {
            const updateBan = db.prepare("UPDATE users SET IsBanned = ? WHERE ID = ?");
            const banRes = updateBan.run(IsBanned, ID);
            
            if (IsBanned === 1) {
                const cancelAppointments = db.prepare("UPDATE appointments SET Status = 'Cancelled' WHERE UserID = ? AND Status = 'Pending'");
                cancelAppointments.run(ID);
            }
            return banRes;
        })();
        console.log(`Updated user banned status to ${IsBanned} for ID: ${ID}`);
        return result;
    } catch (error) {
        console.error("Error updating user banned status:", error.message);
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

function loginuser(Email, Password) {
    const query = db.prepare("SELECT * FROM users WHERE Email = ? AND Password = ?");
    const result = query.get(Email, Password);
    return result;
}

export {
    createuser,
    getallusers,
    getuserById,
    getuserByEmail,
    updateuser,
    updateUserStatus,
    updateUserBanned,
    updateuserPassword,
    deleteuser,
    loginuser
}
