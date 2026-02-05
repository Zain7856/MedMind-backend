
import express from 'express';
import usersApi from './apiUsers.js';
import diseasesApi from './apiDisease.js';
import medicinesApi from './apiMedcines.js';
import appointmentsApi from './apiAppointment.js';
import doctorsApi from './apiDoctors.js';
import hospitalsApi from './apiHospitals.js';
import symptomsApi from './apiSymptoms.js';
import userSymptomsApi from './apiUserSymptoms.js';
import symptomDiseasesApi from './apiSymptomDiseases.js';
import diseaseMedicinesApi from './apiDiseaseMedicines.js';

const app = express();

app.use(express.json());


app.use('/api', usersApi);
app.use('/api', diseasesApi);
app.use('/api', medicinesApi);
app.use('/api', appointmentsApi);
app.use('/api', doctorsApi);
app.use('/api', hospitalsApi);
app.use('/api', symptomsApi);
app.use('/api', userSymptomsApi);
app.use('/api', symptomDiseasesApi);
app.use('/api', diseaseMedicinesApi);


app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});

