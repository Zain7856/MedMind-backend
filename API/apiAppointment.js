import express from "express";
import {
    createAppointment,
    getallAppointments,
    getAppointmentById,
    updateAppointment,
    deleteAppointment
} from "../Services/Appointments.js";

const ap = express.Router();








ap.post("/appointments", (req, res) => {
    try {
        const { UserID, DoctorID, HospitalID, AppointmentDate, Status } = req.body;

        if (!UserID || !DoctorID || !HospitalID || !AppointmentDate || !Status) {
            return res.status(400).json({
                error: "Missing required fields: UserID, DoctorID, HospitalID, AppointmentDate, Status"
            });
        }

        const appointmentId = createAppointment(UserID, DoctorID, HospitalID, AppointmentDate, Status);
        res.status(201).json({
            message: "Appointment created successfully",
            appointmentId
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
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

        if (!UserID || !DoctorID || !HospitalID || !AppointmentDate || !Status) {
            return res.status(400).json({
                error: "Missing required fields: UserID, DoctorID, HospitalID, AppointmentDate, Status"
            });
        }

        const result = updateAppointment(id, UserID, DoctorID, HospitalID, AppointmentDate, Status);

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

