import express from "express";
import {
    createuser,
    getallusers,
    getuserById,
    getuserByEmail,
    updateuser,
    updateuserPassword,
    deleteuser
} from "../Services/Users.js";

const router = express.Router();

router.post("/users",  (req, res) => {
    try {
        const { Name, Email, Password, Age, Phone, Role } = req.body;

        if (!Name || !Email || !Password) {
            return res.status(400).json({
                error: "Missing required fields: Name, Email, PasswordHash"
            });
        }

        const userId = createuser(Name, Email, Password, Age, Phone, Role);
        res.status(201).json({
            message: "User created successfully",
            userId
        });
    } 

    catch (error) {
        res.status(500).json({ error: error.message });
    }
});






router.get("/users", (req, res) => {
    try {
        const users = getallusers();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/users/:id", (req, res) => {
    try {
        const { id } = req.params;
        const user = getuserById(id);

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        res.status(200).json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/users/email/:email", (req, res) => {
    try {
        const { email } = req.params;
        const user = getuserByEmail(email);

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        res.status(200).json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.put("/users/:id", (req, res) => {
    try {
        const { id } = req.params;
        const { Name, Email, Age, Phone, Role } = req.body;

        if (!Name || !Email) {
            return res.status(400).json({
                error: "Missing required fields: Name, Email"
            });
        }

        const result = updateuser(id, Name, Email, Age, Phone, Role);

        if (result.changes === 0) {
            return res.status(404).json({ error: "User not found" });
        }

        res.status(200).json({
            message: "User updated successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.put("/users/:id/password", (req, res) => {
    try {
        const { id } = req.params;
        const { PasswordHash } = req.body;

        if (!PasswordHash) {
            return res.status(400).json({
                error: "Missing required field: PasswordHash"
            });
        }

        const result = updateuserPassword(id, PasswordHash);

        if (result.changes === 0) {
            return res.status(404).json({ error: "User not found" });
        }

        res.status(200).json({
            message: "Password updated successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete("/users/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deleteuser(id);

        if (result.changes === 0) {
            return res.status(404).json({ error: "User not found" });
        }

        res.status(200).json({
            message: "User deleted successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default router;

