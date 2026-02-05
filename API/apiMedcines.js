import express from "express";
import {
    createMedicine,
    getallMedicines,
    getMedicineById,
    updateMedicine,
    deleteMedicine
} from "../Services/Medicines.js";

const md = express.Router();

md.post("/medicines", async (req, res) => {
    try {
        const { Name, Price } = req.body;
        
        if (!Name || !Price) {
            return res.status(400).json({ 
                error: "Missing required fields: Name, Price" 
            });
        }
        
        const medicineId = await createMedicine(Name, Price);
        res.status(201).json({ 
            message: "Medicine created successfully", 
            medicineId 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

md.get("/medicines", (req, res) => {
    try {
        const medicines = getallMedicines();
        res.status(200).json(medicines);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

md.get("/medicines/:id", (req, res) => {
    try {
        const { id } = req.params;
        const medicine = getMedicineById(id);
        
        if (!medicine) {
            return res.status(404).json({ error: "Medicine not found" });
        }
        
        res.status(200).json(medicine);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

md.put("/medicines/:id", (req, res) => {
    try {
        const { id } = req.params;
        const { Name, Price } = req.body;
        
        if (!Name || !Price) {
            return res.status(400).json({ 
                error: "Missing required fields: Name, Price" 
            });
        }
        
        const result = updateMedicine(id, Name, Price);
        
        if (result.changes === 0) {
            return res.status(404).json({ error: "Medicine not found" });
        }
        
        res.status(200).json({ 
            message: "Medicine updated successfully",
            changes: result.changes 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

md.delete("/medicines/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deleteMedicine(id);
        
        if (result.changes === 0) {
            return res.status(404).json({ error: "Medicine not found" });
        }
        
        res.status(200).json({ 
            message: "Medicine deleted successfully",
            changes: result.changes 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default md;