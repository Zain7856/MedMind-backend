import express from "express";
import {
    createUserSymptom,
    getAllUserSymptoms,
    getUserSymptomsByUserId,
    getUserSymptomById,
    deleteUserSymptom
} from "../Services/UserSymptoms.js";

const router = express.Router();

router.post("/usersymptoms", async (req, res) => {
    try {
        const { UserID, SymptomID } = req.body;

        if (!UserID || !SymptomID) {
            return res.status(400).json({
                error: "Missing required fields: UserID, SymptomID"
            });
        }

        const id = await createUserSymptom(UserID, SymptomID);
        res.status(201).json({
            message: "User symptom created successfully",
            id
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/usersymptoms", (req, res) => {
    try {
        const userSymptoms = getAllUserSymptoms();
        res.status(200).json(userSymptoms);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/usersymptoms/:id", (req, res) => {
    try {
        const { id } = req.params;
        const userSymptom = getUserSymptomById(id);

        if (!userSymptom) {
            return res.status(404).json({ error: "User symptom not found" });
        }

        res.status(200).json(userSymptom);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/usersymptoms/user/:userId", (req, res) => {
    try {
        const { userId } = req.params;
        const userSymptoms = getUserSymptomsByUserId(userId);
        res.status(200).json(userSymptoms);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete("/usersymptoms/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deleteUserSymptom(id);

        if (result.changes === 0) {
            return res.status(404).json({ error: "User symptom not found" });
        }

        res.status(200).json({
            message: "User symptom deleted successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default router;
