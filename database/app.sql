CREATE TABLE users (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Age INTEGER,
    Phone VARCHAR(20),
    Role VARCHAR(50) NOT NULL DEFAULT 'Patient'
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
    treatment VARCHAR(500),
    INFO VARCHAR(600)
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
    cost VARCHAR(100)
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
    DoctorID INTEGER,
    HospitalID INTEGER,
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

INSERT INTO diseases (Name, description, symptoms, treatment, INFO)
VALUES 
    ('Flu', 'Viral infection causing fever, cough, and body aches', 'Fever, cough, sore throat, body aches, fatigue', 'Rest, fluids, antiviral medications', 'Flu spreads through respiratory droplets when infected people cough or sneeze. You can get it by touching contaminated surfaces then touching your face. You may feel lazy because your body is fighting the infection and using energy to produce immune cells.'),
    
    ('Covid-19', 'Coronavirus disease causing respiratory illness', 'Fever, dry cough, fatigue, loss of taste/smell', 'Antiviral drugs, oxygen therapy, rest', 'COVID-19 spreads through airborne particles and close contact. You get infected when virus enters your nose, mouth, or eyes. Fatigue occurs as your immune system battles the virus and inflammation affects your energy levels.'),
    
    ('Migraine', 'Severe headache often with nausea', 'Intense throbbing pain, nausea, light/sound sensitivity', 'Pain relievers, triptans, preventive medications', 'Migraines result from abnormal brain activity affecting nerve signals and blood vessels. Genetics and environmental triggers play a role. You may feel lazy before/after attacks as your brain recovers from the neurological disruption.'),
    
    ('Heart Disease', 'Conditions affecting heart function', 'Chest pain, shortness of breath, fatigue', 'Lifestyle changes, medications, surgery', 'Heart disease develops from plaque buildup in arteries, high blood pressure, or genetic factors. You may feel lazy as reduced blood flow limits oxygen to muscles and brain, causing fatigue and reduced physical capacity.'),
    
    ('Stroke', 'Brain damage from interrupted blood flow', 'Sudden numbness, confusion, vision problems, trouble walking', 'Emergency medical care, rehabilitation, medications', 'Stroke occurs when blood flow to brain stops due to clots or bleeding. Risk factors include high blood pressure and smoking. You may feel lazy as brain damage affects motor control and energy regulation.'),
    
    ('Diabetes', 'High blood sugar affecting metabolism', 'Increased thirst, frequent urination, fatigue', 'Insulin therapy, diet management, exercise', 'Diabetes results from insulin resistance or insufficient insulin production. Genetics and lifestyle factors contribute. You may feel lazy as cells cannot properly use glucose for energy, leading to fatigue.'),
    
    ('Hypertension', 'High blood pressure condition', 'Often no symptoms, headaches, shortness of breath', 'Lifestyle changes, medications, regular monitoring', 'Hypertension develops from genetic factors, stress, poor diet, and lack of exercise. You may feel lazy as high blood pressure strains your heart and reduces blood flow efficiency.'),
    
    ('Cancer', 'Uncontrolled cell growth', 'Varies by type: fatigue, pain, weight loss', 'Chemotherapy, radiation, surgery, immunotherapy', 'Cancer occurs from genetic mutations causing uncontrolled cell division. Risk factors include genetics, environmental exposures, and lifestyle. You may feel lazy due to cancer cells consuming energy and treatment side effects.'),
    
    ('Liver Disease', 'Conditions affecting liver function', 'Fatigue, yellowing skin, abdominal pain', 'Lifestyle changes, medications, transplant', 'Liver disease results from alcohol, viruses, fatty liver, or genetic conditions. You may feel lazy as the liver cannot properly detoxify blood and regulate energy metabolism.'),
    
    ('Kidney Disease', 'Impaired kidney function', 'Fatigue, swelling, changes in urination', 'Diet changes, medications, dialysis', 'Kidney disease develops from diabetes, high blood pressure, or genetic conditions. You may feel lazy as waste buildup in blood affects energy levels and overall body function.'),
    
    ('Asthma', 'Chronic airway inflammation', 'Wheezing, shortness of breath, chest tightness', 'Inhalers, medications, trigger avoidance', 'Asthma results from genetic and environmental factors causing airway hyperresponsiveness. You may feel lazy during attacks as breathing difficulties limit oxygen intake and physical activity.'),
    
    ('Pneumonia', 'Lung infection causing inflammation', 'Cough, fever, chest pain, difficulty breathing', 'Antibiotics, rest, oxygen therapy', 'Pneumonia occurs when bacteria, viruses, or fungi infect lung air sacs. You may feel lazy as your body fights infection and inflammation reduces lung efficiency.'),
    
    ('Tuberculosis', 'Bacterial lung infection', 'Persistent cough, weight loss, night sweats', 'Antibiotics for several months', 'TB spreads through airborne bacteria from infected persons. You may feel lazy as your body fights the chronic infection and inflammation affects overall energy levels.'),
    
    ('Alzheimer''s Disease', 'Progressive memory loss disorder', 'Memory loss, confusion, behavior changes', 'Medications, therapy, support care', 'Alzheimer''s results from protein buildup damaging brain cells. Genetics and lifestyle factors contribute. You may appear lazy as cognitive decline affects motivation, planning, and physical activity initiation.');
INSERT INTO medicines (Name, Price)
VALUES ('Panadol', 25),
    ('Cough Syrup', 40),
    ('Vitamin C', 15);
INSERT INTO doctors (Name, Img, Specialization, Phone, Location, cost)
VALUES ('Dr Mahmoud', 'https://www.bing.com/images/search?view=detailV2&ccid=0Ttue7YQ&id=D646AE1A38BFB5D48420C01E82948451C0F94FD6&thid=OIP.0Ttue7YQAsl2DKGwh4POzgHaHa&mediaurl=https%3A%2F%2Fwallpapers.com%2Fimages%2Fhd%2Fdoctor-pictures-l5y1qs2998u7rf0x.jpg&cdnurl=https%3A%2F%2Fth.bing.com%2Fth%2Fid%2FR.d13b6e7bb61002c9760ca1b08783cece%3Frik%3D1k%252f5wFGElIIewA%26pid%3DImgRaw%26r%3D0&exph=1200&expw=1200&q=doctor+imgs+URL&FORM=IRPRST&ck=4FDAEF7FBF89D4E90FE5C76CB524E7A6&selectedIndex=1&itb=0&cw=1375&ch=701&mode=overlay', 'Cardiology', '01033344455', 'Cairo', '500 L.E'),
    ('Dr Hany', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150&h=100&fit=crop&crop=face', 'Neurology', '01022233344', 'Giza', '750 L.E'),
    ('Dr Lina', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=150&h=100&fit=crop&crop=face', 'Pediatrics', '01055566677', 'Alexandria', '600 L.E'),
    ('Dr Ahmed', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=150&h=100&fit=crop&crop=face', 'Orthopedics', '01011112222', 'Mansoura', '450 L.E'),
    ('Dr Fatima', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=150&h=100&fit=crop&crop=face', 'Dermatology', '01099988777', 'Tanta', '550 L.E'),
    ('Dr Mohamed', 'https://images.unsplash.com/photo-1625363529958-80bae9c20b3f?w=150&h=100&fit=crop&crop=face', 'General Surgery', '01234567890', 'Luxor', '400 L.E'),
    ('Dr Sarah', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=150&h=100&fit=crop&crop=face', 'Ophthalmology', '01012344321', 'Aswan', '480 L.E'),
    ('Dr Omar', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150&h=100&fit=crop&crop=face', 'Psychiatry', '01098765432', 'Sharm El Sheikh', '650 L.E'),
    ('Dr Nour', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=150&h=100&fit=crop&crop=face', 'Gynecology', '01055544433', 'Hurghada', '520 L.E'),
    ('Dr Karim', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=150&h=100&fit=crop&crop=face', 'ENT', '01122334455', 'Ismailia', '470 L.E'),
    ('Dr Youssef', 'https://images.unsplash.com/photo-1625363529958-80bae9c20b3f?w=150&h=100&fit=crop&crop=face', 'Urology', '01066778899', 'Damanhur', '530 L.E'),
    ('Dr Amira', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=150&h=100&fit=crop&crop=face', 'Radiology', '01077889900', 'Kafr El Sheikh', '580 L.E');
INSERT INTO hospitals (Name, Location, Phone, img)
VALUES ('Cairo Hospital', 'Nasr City', '022345678', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300&h=200&fit=crop'),
    ('Mansoura General', 'Mansoura', '0501234567', 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=300&h=200&fit=crop'),
    ('Tanta Medical', 'Tanta', '0409876543', 'https://images.unsplash.com/photo-1582750433479-648f1274e350?w=300&h=200&fit=crop'),
    ('Luxor International', 'Luxor', '0955556666', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=300&h=200&fit=crop'),
    ('Aswan Medical', 'Aswan', '0971234567', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300&h=200&fit=crop'),
    ('Sharm Hospital', 'Sharm El Sheikh', '0691234567', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=300&h=200&fit=crop'),
    ('Hurghada Medical Center', 'Hurghada', '0651234567', 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=300&h=200&fit=crop'),
    ('Suez Canal Hospital', 'Ismailia', '0641234567', 'https://images.unsplash.com/photo-1582750433479-648f1274e350?w=300&h=200&fit=crop'),
    ('Alexandria Medical Center', 'Alexandria', '0312345678', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=300&h=200&fit=crop'),
    ('Giza General Hospital', 'Giza', '0234567890', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300&h=200&fit=crop'),
    ('Kafr El Sheikh Medical', 'Kafr El Sheikh', '0471234567', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=300&h=200&fit=crop'),
    ('Port Said Hospital', 'Port Said', '0661234567', 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=300&h=200&fit=crop');
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



