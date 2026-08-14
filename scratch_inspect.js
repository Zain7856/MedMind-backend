import Database from "better-sqlite3";
import path from "path";

const db = new Database("./database/app.db");

console.log("=== TABLES ===");
const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all();
console.log(tables.map(t => t.name));

for (const t of tables) {
    if (t.name === 'sqlite_sequence') continue;
    const count = db.prepare(`SELECT count(*) as c FROM ${t.name}`).get();
    console.log(`Table ${t.name}: ${count.c} rows`);
    const cols = db.prepare(`PRAGMA table_info(${t.name})`).all();
    console.log(`  Columns: ${cols.map(c => c.name).join(", ")}`);
}
