CREATE TABLE users (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Age INTEGER,
    Phone VARCHAR(20),
    Role VARCHAR(20) NOT NULL DEFAULT 'Patient' 
);


CREATE TABLE symptoms (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    Description TEXT
);


CREATE TABLE diseases (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    description VARCHAR(500),
    symptoms VARCHAR(500),
    treatment VARCHAR(500)
);
CREATE TABLE medicines (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(70) NOT NULL,
    Price NUMERIC(10, 2) NOT NULL
);
CREATE TABLE doctors (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(100) NOT NULL,
    Img TEXT,
    Specialization VARCHAR(100),
    Phone VARCHAR(20),
    Location TEXT,
    cost NUMERIC(10, 2)
);
CREATE TABLE hospitals (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(100) NOT NULL,
    Location TEXT,
    Phone VARCHAR(20),
    img TEXT
);
CREATE TABLE appointments (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER NOT NULL,
    DoctorID INTEGER NOT NULL,
    HospitalID INTEGER NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK(Status IN ('Pending', 'Confirmed', 'Cancelled')),
    FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
    FOREIGN KEY(DoctorID) REFERENCES doctors(ID) ON DELETE CASCADE,
    FOREIGN KEY(HospitalID) REFERENCES hospitals(ID) ON DELETE CASCADE
);
CREATE TABLE usersymptoms (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER NOT NULL,
    SymptomID INTEGER NOT NULL,
    FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
    FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE
); 

CREATE TABLE symptomdiseases (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    SymptomID INTEGER NOT NULL,
    DiseaseID INTEGER NOT NULL,
    FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE,
    FOREIGN KEY(DiseaseID) REFERENCES diseases(ID) ON DELETE CASCADE
);
CREATE TABLE diseasemedicines (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    DiseaseID INTEGER NOT NULL,
    MedicineID INTEGER NOT NULL,
    FOREIGN KEY(DiseaseID) REFERENCES diseases(ID) ON DELETE CASCADE,
    FOREIGN KEY(MedicineID) REFERENCES medicines(ID) ON DELETE CASCADE
);






INSERT INTO users (Name, Email, Password, Age, Phone, Role)
VALUES (
        'Omar Ali',
        'omar@example.com',
        'hashed_password_1',
        22,
        '01012345678',
        'Patient'
    ),
    (
        'Sara Ahmed',
        'sara@example.com',
        'hashed_password_2',
        19,
        '01098765432',
        'Patient'
    ),
    (
        'Dr Mahmoud',
        'mahmoud@example.com',
        'hashed_password_3',
        45,
        '01033344455',
        'Doctor'
    ),
    (
        'Dr Hany',
        'hany@example.com',
        'hashed_password_4',
        50,
        '01022233344',
        'Doctor'
    ),
    (
        'Dr Lina',
        'lina@example.com',
        'hashed_password_5',
        38,
        '01055566677',
        'Doctor'
    );
INSERT INTO symptoms (Name, Description)
VALUES ('Headache', 'Pain in the head'),
    ('Fever', 'High body temperature'),
    ('Cough', 'Dry or wet coughing');

INSERT INTO diseases (Name, description, symptoms, treatment, img_url)
VALUES ('Flu', 'dkjoisdjfoijdo', 'dkjoisdjfoijdo', 'dkjoisdjfoijdo', "https://example.com/flu.jpg"),
    ('Covid-19', 'dkjoisdjfoijdo', 'dkjoisdjfoijdo', 'dkjoisdjfoijdo', "https://example.com/covid.jpg"),
    ('Migraine', 'dkjoisdjfoijdo', 'dkjoisdjfoijdo', 'dkjoisdjfoijdo', "https://example.com/migraine.jpg");
INSERT INTO medicines (Name, Price)
VALUES ('Panadol', 25),
    ('Cough Syrup', 40),
    ('Vitamin C', 15);
INSERT INTO doctors (Name, Img, Specialization, Phone, Location, cost)
VALUES ('Dr Mahmoud', 'https://www.freepik.com/free-photo/hospital-healthcare-workers-covid-19-treatment-concept-young-doctor-scrubs-making-daily-errands-clinic-listening-patient-symptoms-look-camera-professional-physician-curing-diseases_16839894.htm#fromView=search&page=1&position=2&uuid=08728093-2eb5-458c-86a9-88d9223c84ec&query=MALE+DOCTOR', 'Cardiology', '01033344455', 'Cairo', 500.00L.E),
    ('Dr Hany', 'https://www.freepik.com/free-photo/doctor-smiling-with-stethoscope_916503.htm#fromView=search&page=1&position=7&uuid=08728093-2eb5-458c-86a9-88d9223c84ec&query=MALE+DOCTOR', 'Neurology', '01022233344', 'Giza', 750.00L.E),
    ('Dr Lina', 'https://www.freepik.com/free-photo/woman-doctor-wearing-lab-coat-with-stethoscope-isolated_20999926.htm#fromView=search&page=1&position=1&uuid=6a278cbd-c452-4f7c-9f25-36aefb07b81e&query=FEMALE+DOCTOR', 'Pediatrics', '01055566677', 'Alexandria', 600.00L.E),
    ('Dr Ahmed', 'https://www.freepik.com/free-photo/portrait-professional-medical-worker-posing-picture-with-arms-folded_5699273.htm#fromView=search&page=1&position=10&uuid=08728093-2eb5-458c-86a9-88d9223c84ec&query=MALE+DOCTOR', 'Orthopedics', '01011112222', 'Mansoura', 450.00L.E),
    ('Dr Fatima', 'https://www.freepik.com/free-photo/pleased-young-female-doctor-wearing-medical-robe-stethoscope-around-neck-standing-with-closed-posture_13835400.htm#fromView=search&page=1&position=4&uuid=6a278cbd-c452-4f7c-9f25-36aefb07b81e&query=FEMALE+DOCTOR', 'Dermatology', '01099988777', 'Tanta', 550.00L.E),
    ('Dr Mohamed', 'https://www.freepik.com/free-photo/doctor-with-his-arms-crossed-white-background_1197402.htm#fromView=search&page=1&position=13&uuid=08728093-2eb5-458c-86a9-88d9223c84ec&query=MALE+DOCTOR', 'General Surgery', '01234567890', 'Luxor', 400.00L.E),
    ('Dr Sarah', 'https://www.freepik.com/free-photo/beautiful-female-doctor-white-coat-standing-arms-crossed-white-wall_13724314.htm#fromView=search&page=1&position=9&uuid=6a278cbd-c452-4f7c-9f25-36aefb07b81e&query=FEMALE+DOCTOR', 'Ophthalmology', '01012344321', 'Aswan', 480.00L.E),
    ('Dr Omar', 'https://www.freepik.com/free-photo/portrait-smiling-handsome-male-doctor-man_6871477.htm#fromView=search&page=1&position=19&uuid=08728093-2eb5-458c-86a9-88d9223c84ec&query=MALE+DOCTOR', 'Psychiatry', '01098765432', 'Sharm El Sheikh', 650.00L.E),
    ('Dr Nour', 'https://www.freepik.com/free-photo/doctor-examines-patient-medicine-health-care-concept_7458947.htm#fromView=search&page=1&position=24&uuid=08728093-2eb5-458c-86a9-88d9223c84ec&query=MALE+DOCTOR', 'Gynecology', '01055544433', 'Hurghada', 520.00L.E),
    ('Dr Karim', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150&h=150&fit=crop&crop=face', 'ENT', '01122334455', 'Ismailia', 470.00L.E),
    ('Dr Youssef', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=150&h=150&fit=crop&crop=face', 'Urology', '01066778899', 'Damanhur', 530.00L.E),
    ('Dr Amira', 'https://www.freepik.com/premium-psd/female-doctor-png-isolated-transparent-background_371837269.htm#fromView=search&page=1&position=10&uuid=6a278cbd-c452-4f7c-9f25-36aefb07b81e&query=FEMALE+DOCTOR', 'Radiology', '01077889900', 'Kafr El Sheikh', 580.00L.E);
INSERT INTO hospitals (Name, Location, Phone, img)
VALUES ('Cairo Hospital', 'Nasr City', '022345678', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300&h=200&fit=crop'),
    ('Health Center', 'Heliopolis', '022987654', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=300&h=200&fit=crop'),
    ('Mansoura General', 'Mansoura', '0501234567', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300&h=200&fit=crop'),
    ('Tanta Medical', 'Tanta', '0409876543', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300&h=200&fit=crop'),
    ('Luxor International', 'Luxor', '0955556666', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=300&h=200&fit=crop'),
    ('Aswan Medical', 'Aswan', '0971234567', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300&h=200&fit=crop'),
    ('Sharm Hospital', 'Sharm El Sheikh', '0691234567', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300&h=200&fit=crop'),
    ('Hurghada Medical Center', 'Hurghada', '0651234567', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=300&h=200&fit=crop'),
    ('Suez Canal Hospital', 'Ismailia', '0641234567', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300&h=200&fit=crop'),
    ('Alexandria Medical Center', 'Alexandria', '0312345678', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300&h=200&fit=crop'),
    ('Giza General Hospital', 'Giza', '0234567890', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=300&h=200&fit=crop'),
    ('Kafr El Sheikh Medical', 'Kafr El Sheikh', '0471234567', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=300&h=200&fit=crop'),
    ('Port Said Hospital', 'Port Said', '0661234567', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=300&h=200&fit=crop');
INSERT INTO appointments (
        UserID,
        DoctorID,
        HospitalID,
        AppointmentDate,
        Status
    )
VALUES (1, 3, 1, '2025-12-15 10:00:00', 'Pending'),
    (2, 5, 2, '2025-12-16 12:30:00', 'Confirmed');
INSERT INTO usersymptoms (UserID, SymptomID)
VALUES (1, 1),
    (1, 2),
    (2, 3);
INSERT INTO symptomdiseases (SymptomID, DiseaseID)
VALUES (1, 3),
    (2, 1),
    (2, 2),
    (3, 2);
INSERT INTO diseasemedicines (DiseaseID, MedicineID)
VALUES (1, 1),
    (1, 3),
    (2, 2),
    (3, 1);






alter table  diseases 
add column img_url text;