
CREATE TABLE geographical_location (
    Location_ID INT PRIMARY KEY,
    Village VARCHAR(100),
    Parish VARCHAR(100),
    Sub_County VARCHAR(100),
    County VARCHAR(100),
    Region VARCHAR(100),
    Population INT,
    Coordinates VARCHAR(100),
    Malaria_Risk_Level VARCHAR(50),
    ITN_Coverage DECIMAL(5, 2),
    Health_Facilities_Count INT,
    Reported_Cases INT
);

CREATE TABLE health_facility (
    Facility_ID INT PRIMARY KEY,
    Location_ID INT,
    Facility_Name VARCHAR(100),
    Capacity INT,
    Contact_Details VARCHAR(100),
    Facility_Type_ID INT,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID),
    FOREIGN KEY (Facility_Type_ID) REFERENCES facility_type(Facility_Type_ID)
);

CREATE TABLE patient_data (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_Of_Birth DATE,
    Phone_Number VARCHAR(20),
    Next_Of_Kin VARCHAR(50),
    Location_ID INT,
    Date_Added DATE,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);

CREATE TABLE visit_record (
    Visit_ID INT PRIMARY KEY,
    Patient_ID INT,
    Facility_ID INT,
    Visit_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE treatment (
    Treatment_ID INT PRIMARY KEY,
    Treatment_Name VARCHAR(50),
    Dosage VARCHAR(50),
    Facility_ID INT,
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE treatment_outcome (
    Outcome_ID INT PRIMARY KEY,
    Outcome_Name VARCHAR(50),
    Outcome_Description TEXT,
    Date_Added DATE,
    Added_By INT,
    Update_Date DATE,
    FOREIGN KEY (Added_By) REFERENCES user(User_ID)
);

CREATE TABLE laboratory_tests (
    Test_ID INT PRIMARY KEY,
    Visit_ID INT,
    Test_Result VARCHAR(50),
    Test_Date DATE,
    Technician_ID INT,
    FOREIGN KEY (Visit_ID) REFERENCES visit_record(Visit_ID),
    FOREIGN KEY (Technician_ID) REFERENCES user(User_ID)
);

CREATE TABLE epidemiological_data (
    Data_ID INT PRIMARY KEY,
    Location_ID INT,
    Recorded_Date DATE,
    Cases_Per_Thousand_People INT,
    Aerial_ITN INT,
    Status VARCHAR(50),
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);

CREATE TABLE resource (
    Resource_ID INT PRIMARY KEY,
    Facility_ID INT,
    Resource_Type VARCHAR(50),
    Quantity INT,
    Date_Added DATE,
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE supply_chain (
    Supply_ID INT PRIMARY KEY,
    Resource_ID INT,
    Facility_ID INT,
    Quantity_Shipped INT,
    Shipment_Date DATE,
    Expected_Arrival_Date DATE,
    Shipped_By INT,
    Status VARCHAR(50),
    FOREIGN KEY (Resource_ID) REFERENCES resource(Resource_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Shipped_By) REFERENCES user(User_ID)
);

CREATE TABLE user (
    User_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Preferred_Name VARCHAR(50),
    Role_ID INT,
    Username VARCHAR(50),
    Password VARCHAR(100),
    FOREIGN KEY (Role_ID) REFERENCES user_role(Role_ID)
);

CREATE TABLE user_role (
    Role_ID INT PRIMARY KEY,
    Role_Name VARCHAR(50),
    Role_Description TEXT,
    Update_Date DATE
);

CREATE TABLE facility_type (
    Facility_Type_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Description TEXT,
    Date_Updated DATE
);

CREATE TABLE malaria_cases (
    Case_ID INT PRIMARY KEY,
    Facility_ID INT,
    Patient_ID INT,
    Date_Of_Diagnosis DATE,
    Type_Of_Malaria VARCHAR(50),
    Treatment_ID INT,
    Outcome_ID INT,
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Treatment_ID) REFERENCES treatment(Treatment_ID),
    FOREIGN KEY (Outcome_ID) REFERENCES treatment_outcome(Outcome_ID)
);

CREATE TABLE interventions (
    Intervention_ID INT PRIMARY KEY,
    Type VARCHAR(50),
    Location_ID INT,
    Start_Date DATE,
    End_Date DATE,
    Outcome VARCHAR(50),
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);
