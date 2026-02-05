import express from "express";
import {
    createDiseaseMedicine,
    getAllDiseaseMedicines,
    getDiseaseMedicinesByDiseaseId,
    getDiseaseMedicineById,
    deleteDiseaseMedicine
} from "../Services/DiseaseMedicines.js";

const router = express.Router();

router.post("/diseasemedicines", async (req, res) => {
    try {
        const { DiseaseID, MedicineID } = req.body;

        if (!DiseaseID || !MedicineID) {
            return res.status(400).json({
                error: "Missing required fields: DiseaseID, MedicineID"
            });
        }

        const id = await createDiseaseMedicine(DiseaseID, MedicineID);
        res.status(201).json({
            message: "Disease medicine created successfully",
            id
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/diseasemedicines", (req, res) => {
    try {
        const diseaseMedicines = getAllDiseaseMedicines();
        res.status(200).json(diseaseMedicines);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/diseasemedicines/:id", (req, res) => {
    try {
        const { id } = req.params;
        const diseaseMedicine = getDiseaseMedicineById(id);

        if (!diseaseMedicine) {
            return res.status(404).json({ error: "Disease medicine not found" });
        }

        res.status(200).json(diseaseMedicine);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/diseasemedicines/disease/:diseaseId", (req, res) => {
    try {
        const { diseaseId } = req.params;
        const diseaseMedicines = getDiseaseMedicinesByDiseaseId(diseaseId);
        res.status(200).json(diseaseMedicines);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete("/diseasemedicines/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deleteDiseaseMedicine(id);

        if (result.changes === 0) {
            return res.status(404).json({ error: "Disease medicine not found" });
        }

        res.status(200).json({
            message: "Disease medicine deleted successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default router;
