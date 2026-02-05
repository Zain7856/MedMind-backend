import express from "express";
import {
    createSymptomDisease,
    getAllSymptomDiseases,
    getSymptomDiseasesBySymptomId,
    getSymptomDiseaseById,
    deleteSymptomDisease
} from "../Services/SymptomDiseases.js";

const router = express.Router();

router.post("/symptomdiseases", async (req, res) => {
    try {
        const { SymptomID, DiseaseID } = req.body;

        if (!SymptomID || !DiseaseID) {
            return res.status(400).json({
                error: "Missing required fields: SymptomID, DiseaseID"
            });
        }

        const id = await createSymptomDisease(SymptomID, DiseaseID);
        res.status(201).json({
            message: "Symptom disease created successfully",
            id
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/symptomdiseases", (req, res) => {
    try {
        const symptomDiseases = getAllSymptomDiseases();
        res.status(200).json(symptomDiseases);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/symptomdiseases/:id", (req, res) => {
    try {
        const { id } = req.params;
        const symptomDisease = getSymptomDiseaseById(id);

        if (!symptomDisease) {
            return res.status(404).json({ error: "Symptom disease not found" });
        }

        res.status(200).json(symptomDisease);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/symptomdiseases/symptom/:symptomId", (req, res) => {
    try {
        const { symptomId } = req.params;
        const symptomDiseases = getSymptomDiseasesBySymptomId(symptomId);
        res.status(200).json(symptomDiseases);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete("/symptomdiseases/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deleteSymptomDisease(id);

        if (result.changes === 0) {
            return res.status(404).json({ error: "Symptom disease not found" });
        }

        res.status(200).json({
            message: "Symptom disease deleted successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default router;
