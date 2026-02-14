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
    treatment VARCHAR(500),
    img_url TEXT
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
        'p@ssword123',
        22,
        '01012345678',
        'Patient'
    ),
    (
        'Sara Ahmed',
        'sara@example.com',
        'p@ssword123',
        19,
        '01098765432',
        'Patient'
    ),
    (
        'Mahmoud Hassan',
        'mahmoud@example.com',
        'doc_pass_456',
        45,
        '01033344455',
        'Doctor'
    ),
    (
        'Laila Selim',
        'laila@example.com',
        'p@ssword123',
        28,
        '01122334455',
        'Patient'
    ),
    (
        'Ahmed Fawzy',
        'ahmed@example.com',
        'p@ssword123',
        35,
        '01233445566',
        'Patient'
    ),
    (
        'Hanya Mansour',
        'hanya@example.com',
        'p@ssword123',
        31,
        '01011223344',
        'Patient'
    ),
    (
        'Ziad Mostafa',
        'ziad@example.com',
        'p@ssword123',
        24,
        '01555666777',
        'Patient'
    ),
    (
        'Mariam Nour',
        'mariam@example.com',
        'p@ssword123',
        42,
        '01099887766',
        'Patient'
    );
INSERT INTO symptoms (Name, Description)
VALUES (
        'Headache',
        'Pain or discomfort in the head, scalp, or neck area.'
    ),
    (
        'Fever',
        'An elevation in body temperature above the normal range (37°C or 98.6°F).'
    ),
    (
        'Cough',
        'A sudden, forceful expulsion of air from the lungs, can be dry or productive.'
    ),
    (
        'Fatigue',
        'A persistent feeling of tiredness, weariness, or lack of energy.'
    ),
    (
        'Nausea',
        'A sensation of unease and discomfort in the upper stomach with an urge to vomit.'
    ),
    (
        'Shortness of Breath',
        'Difficulty breathing or the feeling of breathlessness (dyspnea).'
    ),
    (
        'Chest Pain',
        'Discomfort or pain felt anywhere along the front of the body between the neck and upper abdomen.'
    ),
    (
        'Dizziness',
        'A sensation of spinning or lightheadedness, affecting balance.'
    ),
    (
        'Sore Throat',
        'Pain, scratchiness, or irritation of the throat that often worsens when swallowing.'
    ),
    (
        'Muscle Aches',
        'Pain or discomfort in the muscles, often caused by tension or infection.'
    ),
    (
        'Loss of Taste or Smell',
        'Anosmia or ageusia, a reduced ability to perceive scents or flavors.'
    ),
    (
        'Rash',
        'An area of irritated or swollen skin, often red, itchy, or painful.'
    ),
    (
        'Joint Pain',
        'Discomfort, pain, or inflammation in any of the body''s joints.'
    ),
    (
        'Chills',
        'A feeling of coldness with shivering, often preceding a fever.'
    ),
    (
        'Sweating',
        'The production of moisture from sweat glands, can be excessive (diaphoresis).'
    ),
    (
        'Anxiety',
        'Feelings of worry, nervousness, or unease about an uncertain outcome.'
    ),
    (
        'Insomnia',
        'Difficulty falling asleep or staying asleep through the night.'
    ),
    (
        'Weight Loss',
        'An unintentional reduction in total body mass.'
    ),
    (
        'Bloating',
        'Abdominal swelling or fullness, often due to digestive gas.'
    ),
    (
        'Constipation',
        'Infrequent or difficult evacuation of the bowels.'
    ),
    (
        'Diarrhea',
        'Frequent passage of loose, watery stools.'
    ),
    (
        'Abdominal Pain',
        'Pain or cramping in the stomach or intestinal area.'
    ),
    (
        'Sneezing',
        'A sudden, involuntary expulsion of air through the nose and mouth.'
    ),
    (
        'Runny Nose',
        'Excessive nasal discharge or congestion.'
    ),
    (
        'Blurred Vision',
        'A lack of sharpness of vision resulting in inability to see fine detail.'
    ),
    (
        'Thirst',
        'An intense desire to drink fluids, often Excessive thirst (polydipsia).'
    ),
    (
        'Frequent Urination',
        'The need to urinate more often than usual (polyuria).'
    ),
    (
        'Heartburn',
        'A burning sensation in the chest, usually occurring after eating.'
    ),
    (
        'Dry Skin',
        'Rough, scaly, or itchy skin due to lack of moisture.'
    ),
    (
        'Tremors',
        'Involuntary, rhythmic muscle movements.'
    );
INSERT INTO diseases (Name, description, symptoms, treatment, img_url)
VALUES (
        'Seasonal Flu',
        'A contagious respiratory illness caused by influenza viruses.',
        'Fever, Muscle Aches, Chills, Headache, Fatigue',
        'Rest, hydration, and antivirals if necessary.',
        'https://images.unsplash.com/photo-1584634731339-252c581abfc5?w=800'
    ),
    (
        'COVID-19',
        'An infectious disease caused by the SARS-CoV-2 virus.',
        'Fever, Cough, Loss of Taste or Smell, Shortness of Breath',
        'Symptomatic care, isolation, and antivirals for severe cases.',
        'https://images.unsplash.com/photo-1584118624012-df456149ad7b?w=800'
    ),
    (
        'Migraine',
        'A neurological condition that causes intense, debilitating headaches.',
        'Headache, Nausea, Dizziness, Blurred Vision',
        'Pain relief, hydration, and avoiding triggers.',
        'https://images.unsplash.com/photo-1517404281639-092f70af9fc9?w=800'
    ),
    (
        'Type 2 Diabetes',
        'A chronic condition that affects how the body processes blood sugar.',
        'Thirst, Frequent Urination, Fatigue, Blurred Vision',
        'Dietary control, exercise, and insulin or oral medications.',
        'https://images.unsplash.com/photo-1504813184591-01592fd03cf7?w=800'
    ),
    (
        'Hypertension',
        'A long-term medical condition where blood pressure is persistently elevated.',
        'Headache, Dizziness, Chest Pain, Shortness of Breath',
        'Lifestyle changes and antihypertensive medication.',
        'https://images.unsplash.com/photo-1516549655169-df83a0774514?w=800'
    ),
    (
        'Asthma',
        'A condition where the airways narrow and swell and may produce extra mucus.',
        'Shortness of Breath, Chest Pain, Cough, Fatigue',
        'Inhalers and avoiding environmental triggers.',
        'https://images.unsplash.com/photo-1559757175-5700dde675bc?w=800'
    ),
    (
        'GERD',
        'A digestive disorder where stomach acid flows back into the esophagus.',
        'Heartburn, Chest Pain, Nausea, Bloating',
        'Antacids, avoiding spicy foods, and weight management.',
        'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=800'
    ),
    (
        'Viral Gastroenteritis',
        'An intestinal infection marked by diarrhea, cramps, and nausea.',
        'Diarrhea, Nausea, Abdominal Pain, Fever',
        'Rehydration and resting the digestive system.',
        'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=800'
    ),
    (
        'Iron Deficiency Anemia',
        'A condition where blood lacks adequate healthy red blood cells.',
        'Fatigue, Shortness of Breath, Dizziness, Chills',
        'Iron supplements and iron-rich diet.',
        'https://images.unsplash.com/photo-1584036561498-f2b7a956be87?w=800'
    ),
    (
        'Common Cold',
        'A viral infection of the upper respiratory tract.',
        'Sore Throat, Sneezing, Runny Nose, Cough',
        'Rest, fluids, and over-the-counter remedies.',
        'https://images.unsplash.com/photo-1511174511562-5f7f1858548a?w=800'
    ),
    (
        'Clinical Depression',
        'A mental health disorder characterized by persistent low mood.',
        'Fatigue, Insomnia, Weight Loss, Anxiety',
        'Therapy, social support, and antidepressant medication.',
        'https://images.unsplash.com/photo-1474244419014-9921db334d5a?w=800'
    ),
    (
        'Arthritis',
        'The swelling and tenderness of one or more joints.',
        'Joint Pain, Muscle Aches, Fatigue, Dizziness',
        'Physical therapy and anti-inflammatory drugs.',
        'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?w=800'
    ),
    (
        'Allergic Rhinitis',
        'Inflammation in the nose which occurs when the immune system overreacts to allergens.',
        'Sneezing, Runny Nose, Sore Throat, Rash',
        'Antihistamines and avoiding allergens.',
        'https://images.unsplash.com/photo-1589133177093-47cb2320b923?w=800'
    ),
    (
        'Hyperthyroidism',
        'Overactivity of the thyroid gland, resulting in a rapid heartbeat.',
        'Weight Loss, Sweating, Anxiety, Tremors',
        'Anti-thyroid medication and specialist care.',
        'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?w=800'
    ),
    (
        'Hypothyroidism',
        'Underactivity of the thyroid gland, leading to slow metabolism.',
        'Weight Gain, Fatigue, Dry Skin, Muscle Aches',
        'Thyronine replacement therapy.',
        'https://images.unsplash.com/photo-1581594693702-fbdc51b2763b?w=800'
    ),
    (
        'Gastritis',
        'Inflammation, irritation, or erosion of the lining of the stomach.',
        'Abdominal Pain, Nausea, Bloating, Heartburn',
        'Avoiding irritating substances and antacids.',
        'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=800'
    ),
    (
        'Pneumonia',
        'An infection that inflames the air sacs in one or both lungs.',
        'Cough, Fever, Shortness of Breath, Chills',
        'Antibiotics or antivirals depending on the cause.',
        'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=800'
    ),
    (
        'IBS',
        'A common disorder that affects the large intestine.',
        'Abdominal Pain, Bloating, Constipation, Diarrhea',
        'Stress management and dietary changes.',
        'https://images.unsplash.com/photo-1586773860418-d3b9795056f9?w=800'
    ),
    (
        'Panic Disorder',
        'An anxiety disorder where you regularly have sudden attacks of panic or fear.',
        'Anxiety, Sweating, Tremors, Chest Pain',
        'Therapy and cognitive behavioral management.',
        'https://images.unsplash.com/photo-1527137342181-19aab11a8ee1?w=800'
    ),
    (
        'Ophthalmic Herpes',
        'A viral infection of the eye that can cause vision loss.',
        'Blurred Vision, Rash, Sore Throat, Headache',
        'Antiviral eye drops and specialist monitoring.',
        'https://images.unsplash.com/photo-1581595221033-0bbd4a275f63?w=800'
    );
INSERT INTO medicines (Name, Price)
VALUES ('Oseltamivir', 120.00),
    ('Paxlovid', 450.00),
    ('Sumatriptan', 85.00),
    ('Metformin', 25.00),
    ('Lisinopril', 30.00),
    ('Albuterol', 45.00),
    ('Omeprazole', 20.00),
    ('Iron Gluconate', 15.00),
    ('Loperamide', 10.00),
    ('Guaifenesin', 12.00),
    ('Sertraline', 55.00),
    ('Naproxen', 18.00),
    ('Loratadine', 14.00),
    ('Melatonin', 12.50),
    ('Hydrocortisone', 15.00),
    ('Ibuprofen', 8.00),
    ('Vitamin C', 15.00),
    ('Antihistamine', 22.00),
    ('Cough Syrup', 40.00),
    ('Panadol', 25.00),
    ('Aspirin', 10.00),
    ('Acetaminophen', 9.00),
    ('Methimazole', 60.00),
    ('Levothyroxine', 35.00),
    ('Amoxicillin', 50.00),
    ('Dimenhydrinate', 18.00),
    ('Ranitidine', 28.00),
    ('Psyllium Husk', 20.00),
    ('Alprazolam', 75.00),
    ('Acyclovir', 90.00);
INSERT INTO doctors (Name, Img, Specialization, Phone, Location, cost)
VALUES (
        'Dr. Omar Ali',
        'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400',
        'General Practice',
        '01011112222',
        'Cairo',
        300.00
    ),
    (
        'Dr. Ahmed Zaki',
        'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=400',
        'Cardiology',
        '01122334455',
        'Giza',
        600.00
    ),
    (
        'Dr. Sarah Ezzat',
        'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=400',
        'Neurology',
        '01233445566',
        'Alexandria',
        550.00
    ),
    (
        'Dr. Mahmoud Hassan',
        'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400',
        'Endocrinology',
        '01033334444',
        'Cairo',
        450.00
    ),
    (
        'Dr. Mona Salem',
        'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400',
        'Pediatrics',
        '01155667788',
        'Mansoura',
        350.00
    ),
    (
        'Dr. Khalid Nour',
        'https://images.unsplash.com/photo-1612273576881-2287c6b96e62?w=400',
        'Orthopedics',
        '01055566677',
        'Tanta',
        500.00
    ),
    (
        'Dr. Fatma Khalil',
        'https://images.unsplash.com/photo-1594311434241-dfbf02347bd7?w=400',
        'Dermatology',
        '01222334455',
        'Luxor',
        400.00
    ),
    (
        'Dr. Yasser Adel',
        'https://images.unsplash.com/photo-1551601651-2a8555f1a136?w=400',
        'Urology',
        '01188990011',
        'Aswan',
        480.00
    ),
    (
        'Dr. Reem Taha',
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
        'Psychiatry',
        '01000112233',
        'Sharm El Sheikh',
        700.00
    ),
    (
        'Dr. Sameh Fouad',
        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=400',
        'ENT',
        '01144556677',
        'Hurghada',
        420.00
    ),
    (
        'Dr. Hend Morsy',
        'https://images.unsplash.com/photo-1550831107-1553da8c8464?w=400',
        'Gynecology',
        '01066778899',
        'Ismailia',
        520.00
    ),
    (
        'Dr. Walid Refaat',
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
        'Ophthalmology',
        '01555443322',
        'Suez',
        460.00
    ),
    (
        'Dr. Dina Kamel',
        'https://images.unsplash.com/photo-1527613426441-4da17471b66d?w=400',
        'Oncology',
        '01077889900',
        'Cairo',
        800.00
    ),
    (
        'Dr. Tarek Hegazi',
        'https://images.unsplash.com/photo-1542884748-2b87b36c6b90?w=400',
        'Pulmonology',
        '01111222333',
        'Alexandria',
        580.00
    ),
    (
        'Dr. Inas Hamdy',
        'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=400',
        'Rheumatology',
        '01222114455',
        'Giza',
        490.00
    );
INSERT INTO hospitals (Name, Location, Phone, img)
VALUES (
        'City General Hospital',
        'Cairo Central',
        '0233445566',
        'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=800'
    ),
    (
        'HealthCare Medical Center',
        'Alexandria Harbor',
        '0344556677',
        'https://images.unsplash.com/photo-1586773860418-d3b9795056f9?w=800'
    ),
    (
        'Nile Valley Hospital',
        'Giza Pyramid Road',
        '0223445566',
        'https://images.unsplash.com/photo-1512678080530-7760d81faba6?w=800'
    ),
    (
        'Delta Care Hospital',
        'Mansoura University',
        '0501122334',
        'https://images.unsplash.com/photo-1516549655169-df83a0774514?w=800'
    ),
    (
        'Red Sea Medical',
        'Hurghada Coast',
        '0652233445',
        'https://images.unsplash.com/photo-1596541223130-5d31a73fb6c6?w=800'
    ),
    (
        'Aswan Royal Hospital',
        'Aswan City Center',
        '0972233445',
        'https://images.unsplash.com/photo-1551076805-e1869033e561?w=800'
    ),
    (
        'Sinai Oasis Clinic',
        'Sharm El Sheikh Square',
        '0691122334',
        'https://images.unsplash.com/photo-1502740479796-62da97840190?w=800'
    ),
    (
        'Port Said Hope Hospital',
        'Port Said Entrance',
        '0661122334',
        'https://images.unsplash.com/photo-1513224502586-d1e602410265?w=800'
    ),
    (
        'Tanta Advanced Medical',
        'Tanta Main Street',
        '0403344556',
        'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=800'
    ),
    (
        'Luxor Heritage Hospital',
        'Luxor East Bank',
        '0952233445',
        'https://images.unsplash.com/photo-1527613426441-4da17471b66d?w=800'
    );
INSERT INTO symptomdiseases (SymptomID, DiseaseID)
VALUES (1, 1),
    (2, 1),
    (3, 1),
    (14, 1),
    (10, 1),
    -- Flu
    (2, 2),
    (3, 2),
    (11, 2),
    (6, 2),
    (4, 2),
    -- COVID
    (1, 3),
    (5, 3),
    (8, 3),
    (25, 1),
    -- Migraine
    (4, 4),
    (26, 4),
    (27, 4),
    (25, 4),
    -- Diabetes
    (1, 5),
    (8, 5),
    (7, 5),
    (6, 5),
    -- Hypertension
    (6, 6),
    (7, 6),
    (3, 6),
    (4, 6),
    -- Asthma
    (28, 7),
    (7, 7),
    (5, 7),
    (19, 7),
    -- GERD
    (21, 8),
    (5, 8),
    (22, 8),
    (2, 8),
    -- Gastroenteritis
    (4, 9),
    (6, 9),
    (8, 9),
    (14, 9),
    -- Anemia
    (9, 10),
    (23, 10),
    (24, 10),
    (3, 10),
    -- Cold
    (4, 11),
    (17, 11),
    (18, 11),
    (16, 11),
    -- Depression
    (13, 12),
    (10, 12),
    (4, 12),
    (8, 12),
    -- Arthritis
    (23, 13),
    (24, 13),
    (9, 13),
    (12, 13),
    -- Allergies
    (18, 14),
    (15, 14),
    (16, 14),
    (30, 14),
    -- Hyperthyroidism
    (18, 15),
    (4, 15),
    (29, 15),
    (10, 15),
    -- Hypothyroidism
    (22, 16),
    (5, 16),
    (19, 16),
    (28, 16),
    -- Gastritis
    (3, 17),
    (2, 17),
    (6, 17),
    (14, 17),
    -- Pneumonia
    (22, 18),
    (19, 18),
    (20, 18),
    (21, 18),
    -- IBS
    (16, 19),
    (15, 19),
    (30, 19),
    (7, 19),
    -- Panic Disorder
    (25, 20),
    (12, 20),
    (9, 20),
    (1, 20);
-- Ophthalmic Herpes
INSERT INTO diseasemedicines (DiseaseID, MedicineID)
VALUES (1, 1),
    (1, 20),
    (1, 22),
    -- Flu
    (2, 2),
    (2, 17),
    (2, 16),
    -- COVID
    (3, 3),
    (3, 16),
    (3, 21),
    -- Migraine
    (4, 4),
    (4, 24),
    -- Diabetes
    (5, 5),
    (5, 21),
    -- Hypertension
    (6, 6),
    (6, 15),
    -- Asthma
    (7, 7),
    (7, 27),
    -- GERD
    (8, 26),
    (8, 9),
    -- Gastroenteritis
    (9, 8),
    (9, 17),
    -- Anemia
    (10, 19),
    (10, 20),
    (10, 10),
    -- Cold
    (11, 11),
    (11, 29),
    -- Depression
    (12, 12),
    (12, 16),
    -- Arthritis
    (13, 13),
    (13, 18),
    -- Allergies
    (14, 23),
    -- Hyperthyroidism
    (15, 24),
    -- Hypothyroidism
    (16, 7),
    (16, 27),
    -- Gastritis
    (17, 25),
    (17, 22),
    -- Pneumonia
    (18, 28),
    (18, 9),
    -- IBS
    (19, 29),
    (19, 11),
    -- Panic Disorder
    (20, 30);
-- Ophthalmic Herpes