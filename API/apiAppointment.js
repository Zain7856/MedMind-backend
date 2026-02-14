import express from "express";
import Database from "better-sqlite3";
import {
    createAppointment,
    getallAppointments,
    getAppointmentById,
    updateAppointment,
    deleteAppointment
} from "../Services/Appointments.js";

const db = new Database("./database/app.db");
const ap = express.Router();








ap.post("/appointments", async (req, res) => {
    try {
        const { UserID, DoctorID, HospitalID, AppointmentDate, Status } = req.body;

        // Require UserID and AppointmentDate, and either DoctorID OR HospitalID
        if (!UserID || !AppointmentDate) {
            return res.status(400).json({
                error: "Missing required fields: UserID, AppointmentDate"
            });
        }

        if (!DoctorID && !HospitalID) {
            return res.status(400).json({
                error: "Either DoctorID or HospitalID is required"
            });
        }

        // Handle email as UserID - convert to numeric ID
        let userIdNumeric;
        if (isNaN(UserID)) {
            // UserID is an email, look up the numeric ID
            const userQuery = db.prepare("SELECT ID FROM users WHERE Email = ?");
            const user = userQuery.get(UserID);
            if (!user) {
                return res.status(400).json({
                    error: "User not found with this email"
                });
            }
            userIdNumeric = user.ID;
        } else {
            userIdNumeric = UserID;
        }

        // Set default status if not provided
        const appointmentStatus = Status || 'Pending';
        
        try {
            const appointmentId = await createAppointment(userIdNumeric, DoctorID || null, HospitalID || null, AppointmentDate, appointmentStatus);
            res.status(201).json({
                message: "Appointment created successfully",
                appointmentId,
                DoctorID,
                HospitalID
            });
        } catch (validationError) {
            console.error('Validation error:', validationError);
            res.status(400).json({ 
                error: validationError.message 
            });
        }
    } catch (error) {
        console.error('Error creating appointment:', error);
        res.status(500).json({ 
            error: error.message 
        });
    }
});





ap.get("/appointments", (req, res) => {
    try {
        const appointments = getallAppointments();
        res.status(200).json(appointments);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});








ap.get("/appointments/:id", (req, res) => {
    try {
        const { id } = req.params;
        const appointment = getAppointmentById(id);

        if (!appointment) {
            return res.status(404).json({ error: "Appointment not found" });
        }

        res.status(200).json(appointment);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});










ap.put("/appointments/:id", (req, res) => {
    try {
        const { id } = req.params;
        const { UserID, DoctorID, HospitalID, AppointmentDate, Status } = req.body;

        if (!UserID || !DoctorID || !HospitalID || !AppointmentDate) {
            return res.status(400).json({
                error: "Missing required fields: UserID, DoctorID, HospitalID, AppointmentDate"
            });
        }

        // Set default status if not provided
        const appointmentStatus = Status || 'Pending';
        const result = updateAppointment(id, UserID, DoctorID, HospitalID, AppointmentDate, appointmentStatus);

        if (result.changes === 0) {
            return res.status(404).json({ error: "Appointment not found" });
        }

        res.status(200).json({
            message: "Appointment updated successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});














ap.delete("/appointments/:id", (req, res) => {
    try {
        const { id } = req.params;
        const result = deleteAppointment(id);

        if (result.changes === 0) {
            return res.status(404).json({ error: "Appointment not found" });
        }

        res.status(200).json({
            message: "Appointment deleted successfully",
            changes: result.changes
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});






export default ap;

