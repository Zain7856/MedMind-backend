
import express from 'express';
import usersApi from './API/apiUsers.js';
import diseasesApi from './API/apiDisease.js';
import medicinesApi from './API/apiMedcines.js';
import appointmentsApi from './API/apiAppointment.js';
import doctorsApi from './API/apiDoctors.js';
import hospitalsApi from './API/apiHospitals.js';
import symptomsApi from './API/apiSymptoms.js';
import userSymptomsApi from './API/apiUserSymptoms.js';
import symptomDiseasesApi from './API/apiSymptomDiseases.js';
import diseaseMedicinesApi from './API/apiDiseaseMedicines.js';

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

