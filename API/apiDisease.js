import express from "express";
import {
    createdisease,
    getalldiseases,
    getdiseaseById,
    updatedisease,
    deletedisease
} from "../Services/Diseases.js";

const ds = express.Router();

ds.post("/diseases", async (req, res) => {
    try {
        const { Name, Level } = req.body;
        
        if (!Name || !Level) {
            return res.status(400).json({ 
                error: "Missing required fields: Name, Level" 
            });
        }
        
        const diseaseId = await createdisease(Name, Level);
        res.status(201).json({ 
            message: "Disease created successfully", 
            diseaseId 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}); 

ds.get("/diseases", (req, res) => {
    try {
        const diseases = getalldiseases();
        res.status(200).json(diseases);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

ds.get("/diseases/:id", (req, res) => {
    try {
        const { id } = req.params;
        const disease = getdiseaseById(id);
        
        if (!disease) {
            return res.status(404).json({ error: "Disease not found" });
        }
        
        res.status(200).json(disease);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

ds.put("/diseases/:id", (req, res) => {
    try {
        const { id } = req.params;
        const { Name, Level } = req.body;
        
        if (!Name || !Level) {
            return res.status(400).json({ 
                error: "Missing required fields: Name, Level" 
            });
        }
        
        const result = updatedisease(id, Name, Level);
        
        if (result.changes === 0) {
            return res.status(404).json({ error: "Disease not found" });
        }
        
        res.status(200).json({ 
            message: "Disease updated successfully",
            changes: result.changes 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

ds.delete("/diseases/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deletedisease(id);
        
        if (result.changes === 0) {
            return res.status(404).json({ error: "Disease not found" });
        }
        
        res.status(200).json({ 
            message: "Disease deleted successfully",
            changes: result.changes 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default ds;

