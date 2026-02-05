import express from "express";
import {
    createHospital,
    getallHospitals,
    getHospitalById,
    updateHospital,
    deleteHospital
} from "../Services/Hospitals.js";

const hs = express.Router();

hs.post("/hospitals", async (req, res) => {
    try {
        const { Name, Location, Phone } = req.body;
        
        if (!Name || !Location || !Phone) {
            return res.status(400).json({ 
                error: "Missing required fields: Name, Location, Phone" 
            });
        }
        
        const hospitalId = await createHospital(Name, Location, Phone);
        res.status(201).json({ 
            message: "Hospital created successfully", 
            hospitalId 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

hs.get("/hospitals", (req, res) => {
    try {
        const hospitals = getallHospitals();
        res.status(200).json(hospitals);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

hs.get("/hospitals/:id", (req, res) => {
    try {
        const { id } = req.params;
        const hospital = getHospitalById(id);
        
        if (!hospital) {
            return res.status(404).json({ error: "Hospital not found" });
        }
        
        res.status(200).json(hospital);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

hs.put("/hospitals/:id", (req, res) => {
    try {
        const { id } = req.params;
        const { Name, Location, Phone } = req.body;
        
        if (!Name || !Location || !Phone) {
            return res.status(400).json({ 
                error: "Missing required fields: Name, Location, Phone" 
            });
        }
        
        const result = updateHospital(id, Name, Location, Phone);
        
        if (result.changes === 0) {
            return res.status(404).json({ error: "Hospital not found" });
        }
        
        res.status(200).json({ 
            message: "Hospital updated successfully",
            changes: result.changes 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

hs.delete("/hospitals/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deleteHospital(id);
        
        if (result.changes === 0) {
            return res.status(404).json({ error: "Hospital not found" });
        }
        
        res.status(200).json({ 
            message: "Hospital deleted successfully",
            changes: result.changes 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default hs;

