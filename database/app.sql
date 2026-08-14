CREATE TABLE users (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name VARCHAR(100) NOT NULL,
      Email VARCHAR(100) UNIQUE NOT NULL,
      Password VARCHAR(255) NOT NULL,
      Age INTEGER,
      Phone VARCHAR(20),
      Role VARCHAR(20) NOT NULL CHECK (Role IN ('Patient', 'Doctor', 'Hospital', 'Admin')) DEFAULT 'Patient',
      ApprovalStatus VARCHAR(20) NOT NULL CHECK (ApprovalStatus IN ('Pending', 'Approved', 'Rejected')) DEFAULT 'Pending',
      IsBanned INTEGER NOT NULL DEFAULT 0 CHECK (IsBanned IN (0, 1))
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
      treatment VARCHAR(500),
      img TEXT
    );

CREATE TABLE doctors (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      UserID INTEGER UNIQUE,
      Name VARCHAR(100) NOT NULL,
      Img TEXT,
      Specialization VARCHAR(100),
      Phone VARCHAR(20),
      Location TEXT,
      cost NUMERIC(10, 2),
      About TEXT,
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE
    );

CREATE TABLE hospitals (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      UserID INTEGER UNIQUE,
      Name VARCHAR(100) NOT NULL,
      Location TEXT,
      Phone VARCHAR(20),
      img TEXT,
      Services TEXT,
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE
    );

CREATE TABLE usersymptoms (
      UserID INTEGER NOT NULL,
      SymptomID INTEGER NOT NULL,
      PRIMARY KEY (UserID, SymptomID),
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
      FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE
    );

CREATE TABLE symptomdiseases (
      SymptomID INTEGER NOT NULL,
      DiseaseID INTEGER NOT NULL,
      PRIMARY KEY (SymptomID, DiseaseID),
      FOREIGN KEY(SymptomID) REFERENCES symptoms(ID) ON DELETE CASCADE,
      FOREIGN KEY(DiseaseID) REFERENCES diseases(ID) ON DELETE CASCADE
    );

CREATE TABLE appointments (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      UserID INTEGER NOT NULL,
      DoctorID INTEGER,
      HospitalID INTEGER,
      AppointmentDate DATETIME NOT NULL,
      Status VARCHAR(50) NOT NULL CHECK(Status IN ('Pending', 'Confirmed', 'Cancelled')) DEFAULT 'Pending',
      FOREIGN KEY(UserID) REFERENCES users(ID) ON DELETE CASCADE,
      FOREIGN KEY(DoctorID) REFERENCES doctors(ID) ON DELETE CASCADE,
      FOREIGN KEY(HospitalID) REFERENCES hospitals(ID) ON DELETE CASCADE,
      CHECK ((DoctorID IS NULL) <> (HospitalID IS NULL))
    );

CREATE UNIQUE INDEX idx_users_email ON users(Email);
CREATE INDEX idx_appointments_user ON appointments(UserID);
CREATE INDEX idx_appointments_doctor ON appointments(DoctorID);
CREATE INDEX idx_appointments_hospital ON appointments(HospitalID);

-- Seed data for users
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (1, 'Admin', 'admin@medmind.com', 'admin123', 35, '01000000000', 'Admin', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (2, 'Omar Ali', 'omar@example.com', 'p@ssword123', 22, '01012345678', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (3, 'Sara Ahmed', 'sara@example.com', 'p@ssword123', 19, '01098765432', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (4, 'Mahmoud Hassan', 'mahmoud@example.com', 'doc_pass_456', 45, '01033344455', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (5, 'Laila Selim', 'laila@example.com', 'p@ssword123', 28, '01122334455', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (6, 'Ahmed Fawzy', 'ahmed@example.com', 'p@ssword123', 35, '01233445566', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (7, 'Hanya Mansour', 'hanya@example.com', 'p@ssword123', 31, '01011223344', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (8, 'Ziad Mostafa', 'ziad@example.com', 'p@ssword123', 24, '01555666777', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (9, 'Mariam Nour', 'mariam@example.com', 'p@ssword123', 42, '01099887766', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (10, 'Ibrahim Ahmed', 'ibrhmahmd743@gmail.com', '123456789', 23, '01008520964', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (11, 'Khaled', 'zainmohamed3001@gmail.com', '223123', 15, '01098676556', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (12, 'Khaled', 'zainmohamed3101@gmail.com', '45567567', 15, '01098676556', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (13, 'MO', 'zainmohamed3401@gmail.com', '123456', 15, '01098676556', 'Patient', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (14, 'Dr. Omar Ali', 'dromarali@medmind-doc.com', 'password123', 40, '01011112222', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (15, 'Dr. Mahmoud Hassan', 'drmahmoudhassan@medmind-doc.com', 'password123', 40, '01033334444', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (16, 'Dr. Mona Salem', 'drmonasalem@medmind-doc.com', 'password123', 40, '01155667788', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (17, 'Dr. Khalid Nour', 'drkhalidnour@medmind-doc.com', 'password123', 40, '01055566677', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (18, 'Dr. Fatma Khalil', 'drfatmakhalil@medmind-doc.com', 'password123', 40, '01222334455', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (19, 'Dr. Yasser Adel', 'dryasseradel@medmind-doc.com', 'password123', 40, '01188990011', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (20, 'Dr. Reem Taha', 'drreemtaha@medmind-doc.com', 'password123', 40, '01000112233', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (21, 'Dr. Sameh Fouad', 'drsamehfouad@medmind-doc.com', 'password123', 40, '01144556677', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (22, 'Dr. Hend Morsy', 'drhendmorsy@medmind-doc.com', 'password123', 40, '01066778899', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (23, 'Dr. Walid Refaat', 'drwalidrefaat@medmind-doc.com', 'password123', 40, '01555443322', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (24, 'Dr. Dina Kamel', 'drdinakamel@medmind-doc.com', 'password123', 40, '01077889900', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (25, 'Dr. Tarek Hegazi', 'drtarekhegazi@medmind-doc.com', 'password123', 40, '01111222333', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (26, 'Dr. Inas Hamdy', 'drinashamdy@medmind-doc.com', 'password123', 40, '01222114455', 'Doctor', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (27, 'City General Hospital', 'citygeneralhospital@medmind-hos.com', 'password123', NULL, '0233445566', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (28, 'HealthCare Medical Center', 'healthcaremedicalcenter@medmind-hos.com', 'password123', NULL, '0344556677', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (29, 'Nile Valley Hospital', 'nilevalleyhospital@medmind-hos.com', 'password123', NULL, '0223445566', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (30, 'Delta Care Hospital', 'deltacarehospital@medmind-hos.com', 'password123', NULL, '0501122334', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (31, 'Red Sea Medical', 'redseamedical@medmind-hos.com', 'password123', NULL, '0652233445', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (32, 'Aswan Royal Hospital', 'aswanroyalhospital@medmind-hos.com', 'password123', NULL, '0972233445', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (33, 'Sinai Oasis Clinic', 'sinaioasisclinic@medmind-hos.com', 'password123', NULL, '0691122334', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (34, 'Port Said Hope Hospital', 'portsaidhopehospital@medmind-hos.com', 'password123', NULL, '0661122334', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (35, 'Tanta Advanced Medical', 'tantaadvancedmedical@medmind-hos.com', 'password123', NULL, '0403344556', 'Hospital', 'Approved', 0);
INSERT INTO users (ID, Name, Email, Password, Age, Phone, Role, ApprovalStatus, IsBanned) VALUES (36, 'Luxor Heritage Hospital', 'luxorheritagehospital@medmind-hos.com', 'password123', NULL, '0952233445', 'Hospital', 'Approved', 0);

-- Seed data for symptoms
INSERT INTO symptoms (ID, Name, Description) VALUES (1, 'Headache', 'Pain or discomfort in the head, scalp, or neck area.');
INSERT INTO symptoms (ID, Name, Description) VALUES (2, 'Fever', 'An elevation in body temperature above the normal range (37°C or 98.6°F).');
INSERT INTO symptoms (ID, Name, Description) VALUES (3, 'Cough', 'A sudden, forceful expulsion of air from the lungs, can be dry or productive.');
INSERT INTO symptoms (ID, Name, Description) VALUES (4, 'Fatigue', 'A persistent feeling of tiredness, weariness, or lack of energy.');
INSERT INTO symptoms (ID, Name, Description) VALUES (5, 'Nausea', 'A sensation of unease and discomfort in the upper stomach with an urge to vomit.');
INSERT INTO symptoms (ID, Name, Description) VALUES (6, 'Shortness of Breath', 'Difficulty breathing or the feeling of breathlessness (dyspnea).');
INSERT INTO symptoms (ID, Name, Description) VALUES (7, 'Chest Pain', 'Discomfort or pain felt anywhere along the front of the body between the neck and upper abdomen.');
INSERT INTO symptoms (ID, Name, Description) VALUES (8, 'Dizziness', 'A sensation of spinning or lightheadedness, affecting balance.');
INSERT INTO symptoms (ID, Name, Description) VALUES (9, 'Sore Throat', 'Pain, scratchiness, or irritation of the throat that often worsens when swallowing.');
INSERT INTO symptoms (ID, Name, Description) VALUES (10, 'Muscle Aches', 'Pain or discomfort in the muscles, often caused by tension or infection.');
INSERT INTO symptoms (ID, Name, Description) VALUES (11, 'Loss of Taste or Smell', 'Anosmia or ageusia, a reduced ability to perceive scents or flavors.');
INSERT INTO symptoms (ID, Name, Description) VALUES (12, 'Rash', 'An area of irritated or swollen skin, often red, itchy, or painful.');
INSERT INTO symptoms (ID, Name, Description) VALUES (13, 'Joint Pain', 'Discomfort, pain, or inflammation in any of the body''s joints.');
INSERT INTO symptoms (ID, Name, Description) VALUES (14, 'Chills', 'A feeling of coldness with shivering, often preceding a fever.');
INSERT INTO symptoms (ID, Name, Description) VALUES (15, 'Sweating', 'The production of moisture from sweat glands, can be excessive (diaphoresis).');
INSERT INTO symptoms (ID, Name, Description) VALUES (16, 'Anxiety', 'Feelings of worry, nervousness, or unease about an uncertain outcome.');
INSERT INTO symptoms (ID, Name, Description) VALUES (17, 'Insomnia', 'Difficulty falling asleep or staying asleep through the night.');
INSERT INTO symptoms (ID, Name, Description) VALUES (18, 'Weight Loss', 'An unintentional reduction in total body mass.');
INSERT INTO symptoms (ID, Name, Description) VALUES (19, 'Bloating', 'Abdominal swelling or fullness, often due to digestive gas.');
INSERT INTO symptoms (ID, Name, Description) VALUES (20, 'Constipation', 'Infrequent or difficult evacuation of the bowels.');
INSERT INTO symptoms (ID, Name, Description) VALUES (21, 'Diarrhea', 'Frequent passage of loose, watery stools.');
INSERT INTO symptoms (ID, Name, Description) VALUES (22, 'Abdominal Pain', 'Pain or cramping in the stomach or intestinal area.');
INSERT INTO symptoms (ID, Name, Description) VALUES (23, 'Sneezing', 'A sudden, involuntary expulsion of air through the nose and mouth.');
INSERT INTO symptoms (ID, Name, Description) VALUES (24, 'Runny Nose', 'Excessive nasal discharge or congestion.');
INSERT INTO symptoms (ID, Name, Description) VALUES (25, 'Blurred Vision', 'A lack of sharpness of vision resulting in inability to see fine detail.');
INSERT INTO symptoms (ID, Name, Description) VALUES (26, 'Thirst', 'An intense desire to drink fluids, often Excessive thirst (polydipsia).');
INSERT INTO symptoms (ID, Name, Description) VALUES (27, 'Frequent Urination', 'The need to urinate more often than usual (polyuria).');
INSERT INTO symptoms (ID, Name, Description) VALUES (28, 'Heartburn', 'A burning sensation in the chest, usually occurring after eating.');
INSERT INTO symptoms (ID, Name, Description) VALUES (29, 'Dry Skin', 'Rough, scaly, or itchy skin due to lack of moisture.');
INSERT INTO symptoms (ID, Name, Description) VALUES (30, 'Tremors', 'Involuntary, rhythmic muscle movements.');
INSERT INTO symptoms (ID, Name, Description) VALUES (31, 'Weight gain', '');

-- Seed data for diseases
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (1, 'Seasonal Flu', 'A contagious respiratory illness caused by influenza viruses.', 'Rest, hydration, and antivirals if necessary.', 'https://images.unsplash.com/photo-1584634731339-252c581abfc5?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (2, 'COVID-19', 'An infectious disease caused by the SARS-CoV-2 virus.', 'Symptomatic care, isolation, and antivirals for severe cases.', 'https://images.unsplash.com/photo-1584118624012-df456149ad7b?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (3, 'Migraine', 'A neurological condition that causes intense, debilitating headaches.', 'Pain relief, hydration, and avoiding triggers.', 'https://images.unsplash.com/photo-1517404281639-092f70af9fc9?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (4, 'Type 2 Diabetes', 'A chronic condition that affects how the body processes blood sugar.', 'Dietary control, exercise, and insulin or oral medications.', 'https://images.unsplash.com/photo-1504813184591-01592fd03cf7?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (5, 'Hypertension', 'A long-term medical condition where blood pressure is persistently elevated.', 'Lifestyle changes and antihypertensive medication.', 'https://images.unsplash.com/photo-1516549655169-df83a0774514?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (6, 'Asthma', 'A condition where the airways narrow and swell and may produce extra mucus.', 'Inhalers and avoiding environmental triggers.', 'https://images.unsplash.com/photo-1559757175-5700dde675bc?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (7, 'GERD', 'A digestive disorder where stomach acid flows back into the esophagus.', 'Antacids, avoiding spicy foods, and weight management.', 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (8, 'Viral Gastroenteritis', 'An intestinal infection marked by diarrhea, cramps, and nausea.', 'Rehydration and resting the digestive system.', 'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (9, 'Iron Deficiency Anemia', 'A condition where blood lacks adequate healthy red blood cells.', 'Iron supplements and iron-rich diet.', 'https://images.unsplash.com/photo-1584036561498-f2b7a956be87?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (10, 'Common Cold', 'A viral infection of the upper respiratory tract.', 'Rest, fluids, and over-the-counter remedies.', 'https://images.unsplash.com/photo-1511174511562-5f7f1858548a?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (11, 'Clinical Depression', 'A mental health disorder characterized by persistent low mood.', 'Therapy, social support, and antidepressant medication.', 'https://images.unsplash.com/photo-1474244419014-9921db334d5a?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (12, 'Arthritis', 'The swelling and tenderness of one or more joints.', 'Physical therapy and anti-inflammatory drugs.', 'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (13, 'Allergic Rhinitis', 'Inflammation in the nose which occurs when the immune system overreacts to allergens.', 'Antihistamines and avoiding allergens.', 'https://images.unsplash.com/photo-1589133177093-47cb2320b923?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (14, 'Hyperthyroidism', 'Overactivity of the thyroid gland, resulting in a rapid heartbeat.', 'Anti-thyroid medication and specialist care.', 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (15, 'Hypothyroidism', 'Underactivity of the thyroid gland, leading to slow metabolism.', 'Thyronine replacement therapy.', 'https://images.unsplash.com/photo-1581594693702-fbdc51b2763b?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (16, 'Gastritis', 'Inflammation, irritation, or erosion of the lining of the stomach.', 'Avoiding irritating substances and antacids.', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (17, 'Pneumonia', 'An infection that inflames the air sacs in one or both lungs.', 'Antibiotics or antivirals depending on the cause.', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (18, 'IBS', 'A common disorder that affects the large intestine.', 'Stress management and dietary changes.', 'https://images.unsplash.com/photo-1586773860418-d3b9795056f9?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (19, 'Panic Disorder', 'An anxiety disorder where you regularly have sudden attacks of panic or fear.', 'Therapy and cognitive behavioral management.', 'https://images.unsplash.com/photo-1527137342181-19aab11a8ee1?w=800');
INSERT INTO diseases (ID, Name, description, treatment, img) VALUES (20, 'Ophthalmic Herpes', 'A viral infection of the eye that can cause vision loss.', 'Antiviral eye drops and specialist monitoring.', 'https://images.unsplash.com/photo-1581595221033-0bbd4a275f63?w=800');

-- Seed data for doctors
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (1, 14, 'Dr. Omar Ali', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400', 'General Practice', '01011112222', 'Cairo', 300, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (2, 5, 'Dr. Ahmed Zaki', 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=400', 'Cardiology', '01122334455', 'Giza', 600, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (3, 6, 'Dr. Sarah Ezzat', 'https://images.unsplash.com/photo-1559839734-2b0ea4f6808f?w=400', 'Neurology', '01233445566', 'Alexandria', 550, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (4, 15, 'Dr. Mahmoud Hassan', 'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400', 'Endocrinology', '01033334444', 'Cairo', 450, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (5, 16, 'Dr. Mona Salem', 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400', 'Pediatrics', '01155667788', 'Mansoura', 350, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (6, 17, 'Dr. Khalid Nour', 'https://images.unsplash.com/photo-1612273576881-2287c6b96e62?w=400', 'Orthopedics', '01055566677', 'Tanta', 500, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (7, 18, 'Dr. Fatma Khalil', 'https://images.unsplash.com/photo-1594311434241-dfbf02347bd7?w=400', 'Dermatology', '01222334455', 'Luxor', 400, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (8, 19, 'Dr. Yasser Adel', 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?w=400', 'Urology', '01188990011', 'Aswan', 480, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (9, 20, 'Dr. Reem Taha', 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400', 'Psychiatry', '01000112233', 'Sharm El Sheikh', 700, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (10, 21, 'Dr. Sameh Fouad', 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=400', 'ENT', '01144556677', 'Hurghada', 420, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (11, 22, 'Dr. Hend Morsy', 'https://images.unsplash.com/photo-1550831107-1553da8c8464?w=400', 'Gynecology', '01066778899', 'Ismailia', 520, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (12, 23, 'Dr. Walid Refaat', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400', 'Ophthalmology', '01555443322', 'Suez', 460, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (13, 24, 'Dr. Dina Kamel', 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?w=400', 'Oncology', '01077889900', 'Cairo', 800, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (14, 25, 'Dr. Tarek Hegazi', 'https://images.unsplash.com/photo-1542884748-2b87b36c6b90?w=400', 'Pulmonology', '01111222333', 'Alexandria', 580, NULL);
INSERT INTO doctors (ID, UserID, Name, Img, Specialization, Phone, Location, cost, About) VALUES (15, 26, 'Dr. Inas Hamdy', 'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=400', 'Rheumatology', '01222114455', 'Giza', 490, NULL);

-- Seed data for hospitals
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (1, 27, 'City General Hospital', 'Cairo Central', '0233445566', 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (2, 28, 'HealthCare Medical Center', 'Alexandria Harbor', '0344556677', 'https://images.unsplash.com/photo-1586773860418-d3b9795056f9?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (3, 29, 'Nile Valley Hospital', 'Giza Pyramid Road', '0223445566', 'https://images.unsplash.com/photo-1512678080530-7760d81faba6?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (4, 30, 'Delta Care Hospital', 'Mansoura University', '0501122334', 'https://images.unsplash.com/photo-1516549655169-df83a0774514?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (5, 31, 'Red Sea Medical', 'Hurghada Coast', '0652233445', 'https://images.unsplash.com/photo-1596541223130-5d31a73fb6c6?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (6, 32, 'Aswan Royal Hospital', 'Aswan City Center', '0972233445', 'https://images.unsplash.com/photo-1551076805-e1869033e561?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (7, 33, 'Sinai Oasis Clinic', 'Sharm El Sheikh Square', '0691122334', 'https://images.unsplash.com/photo-1502740479796-62da97840190?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (8, 34, 'Port Said Hope Hospital', 'Port Said Entrance', '0661122334', 'https://images.unsplash.com/photo-1513224502586-d1e602410265?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (9, 35, 'Tanta Advanced Medical', 'Tanta Main Street', '0403344556', 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=800', NULL);
INSERT INTO hospitals (ID, UserID, Name, Location, Phone, img, Services) VALUES (10, 36, 'Luxor Heritage Hospital', 'Luxor East Bank', '0952233445', 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?w=800', NULL);

-- Seed data for symptomdiseases
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (2, 1);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (10, 1);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (14, 1);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (1, 1);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 1);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (2, 2);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (3, 2);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (11, 2);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (6, 2);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (1, 3);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (5, 3);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (8, 3);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (25, 3);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (26, 4);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (27, 4);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 4);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (25, 4);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (1, 5);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (8, 5);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (7, 5);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (6, 5);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (6, 6);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (7, 6);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (3, 6);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 6);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (28, 7);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (7, 7);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (5, 7);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (19, 7);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (21, 8);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (5, 8);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (22, 8);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (2, 8);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 9);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (6, 9);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (8, 9);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (14, 9);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (9, 10);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (23, 10);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (24, 10);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (3, 10);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 11);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (17, 11);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (18, 11);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (16, 11);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (13, 12);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (10, 12);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 12);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (8, 12);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (23, 13);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (24, 13);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (9, 13);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (12, 13);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (18, 14);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (15, 14);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (16, 14);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (30, 14);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (31, 15);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 15);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (29, 15);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (10, 15);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (22, 16);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (5, 16);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (19, 16);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (28, 16);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (3, 17);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (2, 17);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (6, 17);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (14, 17);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (22, 18);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (19, 18);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (20, 18);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (21, 18);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (16, 19);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (15, 19);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (30, 19);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (7, 19);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (25, 20);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (12, 20);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (9, 20);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (1, 20);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (3, 1);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (4, 2);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (25, 1);
INSERT INTO symptomdiseases (SymptomID, DiseaseID) VALUES (18, 15);

-- Seed data for appointments
INSERT INTO appointments (ID, UserID, DoctorID, HospitalID, AppointmentDate, Status) VALUES (1, 2, NULL, 1, '2025-12-20T10:00:00', 'Pending');
INSERT INTO appointments (ID, UserID, DoctorID, HospitalID, AppointmentDate, Status) VALUES (2, 2, 1, NULL, '2025-12-21T14:00:00', 'Pending');
INSERT INTO appointments (ID, UserID, DoctorID, HospitalID, AppointmentDate, Status) VALUES (3, 11, NULL, 1, '2026-04-17T19:45:00', 'Pending');
INSERT INTO appointments (ID, UserID, DoctorID, HospitalID, AppointmentDate, Status) VALUES (4, 11, NULL, 3, '2026-07-21T15:10:00', 'Pending');
INSERT INTO appointments (ID, UserID, DoctorID, HospitalID, AppointmentDate, Status) VALUES (5, 11, NULL, 2, '2026-07-21T15:14:00', 'Pending');

