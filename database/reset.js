import Database from "better-sqlite3";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const dbPath = path.resolve(__dirname, "./app.db");
const backupPath = path.resolve(__dirname, "./app_backup.db");
const sqlPath = path.resolve(__dirname, "./app.sql");

export function resetDatabase() {
  console.log("Resetting database to seed state from app.sql...");
  
  // Close any active connections or delete db file
  if (fs.existsSync(dbPath)) {
    try {
      fs.unlinkSync(dbPath);
    } catch (e) {
      console.log("Could not delete app.db directly (it might be locked). Overwriting tables instead...");
    }
  }

  const db = new Database(dbPath);
  db.pragma("foreign_keys = OFF"); // Disable keys for safe recreation

  if (fs.existsSync(sqlPath)) {
    const sql = fs.readFileSync(sqlPath, "utf8");
    db.exec(sql);
    console.log("Database successfully reset and seeded from app.sql.");
  } else {
    console.error("app.sql file not found. Run migrate first.");
  }
  
  db.pragma("foreign_keys = ON");
  db.close();
}

// Run if called directly from node
if (process.argv[1] === fileURLToPath(import.meta.url)) {
  resetDatabase();
}
