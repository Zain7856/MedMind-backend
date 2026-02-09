
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


import cors from 'cors';

const app = express();

app.use(express.json());
app.use(cors());


app.use(usersApi);
app.use(diseasesApi);
app.use(medicinesApi);
app.use(appointmentsApi);
app.use(doctorsApi);
app.use(hospitalsApi);
app.use(symptomsApi);
app.use(userSymptomsApi);
app.use(symptomDiseasesApi);
app.use(diseaseMedicinesApi);


app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});

