CREATE DATABASE TrainSystem;
USE TrainSystem;

                          -- create table (train)
CREATE TABLE Train (
    Train_ID INT PRIMARY KEY,
    Type VARCHAR(50) NOT NULL,
    Capacity INT CHECK (Capacity > 0),
    Status VARCHAR(30) NOT NULL
);
-- Insert data into Train table
INSERT INTO Train (Train_ID, Type, Capacity, Status)
VALUES
(1, 'Individual', 180, 'Active'),
(2, 'Family', 200, 'Active'),
(3, 'First Class', 150, 'Active'),
(4, 'Family', 120, 'Under Maintenance'),
(5, 'Individual', 160, 'Inactive');

SELECT * FROM Train;

                            -- create table (trip)
CREATE TABLE Trip (
    Trip_ID INT PRIMARY KEY,
    Dep_DateTime DATETIME NOT NULL,
    Arr_DateTime DATETIME NOT NULL,
    Status VARCHAR(30),
    Train_ID INT,
    FOREIGN KEY (Train_ID) REFERENCES Train(Train_ID)
);

-- Insert data into Trip table
INSERT INTO Trip (Trip_ID, Dep_DateTime, Arr_DateTime, Status, Train_ID)
VALUES
(1, '2025-11-10 08:00:00', '2025-11-10 12:00:00', 'Completed', 1),
(2, '2025-11-11 09:00:00', '2025-11-11 13:00:00', 'Scheduled', 3),
(3, '2025-11-12 10:30:00', '2025-11-12 14:30:00', 'Cancelled', 2),
(4, '2025-11-13 06:00:00', '2025-11-13 09:30:00', 'Completed', 4),
(5, '2025-11-14 15:00:00', '2025-11-14 19:30:00', 'Scheduled', 5);

SELECT * FROM Trip;

-- create table (Route)
CREATE TABLE Route (
    Route_ID INT PRIMARY KEY,
    Route_name VARCHAR(100) NOT NULL,
    Trip_num INT,
    Main_stations VARCHAR(255) NOT NULL,
    Total_distance DECIMAL(6,2) CHECK (Total_distance > 0)
);
                             -- Insert data into Route table
INSERT INTO Route (Route_ID, Route_name, Trip_num, Main_stations, Total_distance)
VALUES
(1, 'Makkah–Jeddah', 101, 'Al Rusaifah, Al Sulaymaniyah', 85.0),
(2, 'Jeddah–Madinah', 102, 'Al Sulaymaniyah, King Abdullah Economic City, Madinah', 420.0),
(3, 'Makkah–Taif', 103, 'Al Rusaifah, Al Hada, Taif', 120.0),
(4, 'Riyadh–Dammam', 104, 'Riyadh, Hofuf, Dammam', 400.0),
(5, 'Jeddah–Yanbu', 105, 'Al Sulaymaniyah, Rabigh, Yanbu', 350.0);
SELECT * FROM Route;

                            -- create table (Station)
CREATE TABLE Station (
    Trip_ID INT,
    Route_ID INT,
    Station_stop VARCHAR(100),
    FOREIGN KEY (Trip_ID) REFERENCES Trip(Trip_ID),
    FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID)
);

                        -- Insert data into Station table
INSERT INTO Station (Trip_ID, Route_ID, Station_stop)
VALUES
    (1, 2, 'Madinah'),
    (2, 1, 'Al Sulaymaniyah'),
    (3, 5, 'Yanbu'),
    (4, 4, 'Dammam'),
    (5, 3, 'Taif');

SELECT * FROM Station;

                         -- create table (Employee)
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    F_name VARCHAR(50) NOT NULL,
    L_name VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) UNIQUE,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Trip_ID INT,
    FOREIGN KEY (Trip_ID) REFERENCES Trip(Trip_ID)
    );
    
                       -- Insert data into Employee table
INSERT INTO Employee (Emp_ID, F_name, L_name, Phone, Salary, Trip_ID)
VALUES
(1, 'Reema', 'Saed', '0557324189', 7200.00, 1),
(2, 'Jumanah', 'Al-Ghamdi', '0562895403', 6800.00, 1),
(3, 'Aram', 'Mohammed', '0573941256', 6500.00, 2),
(4, 'Asayel', 'Hamdan', '0581027394', 7000.00, 3),
(5, 'Fahad', 'Al-Qahtani', '0598742635', 7500.00, 5);

SELECT * FROM Employee;

                   -- create table (Employee_Role)
CREATE TABLE Employee_Role (
    Emp_ID INT,
    Role VARCHAR(50) NOT NULL,
    FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID)
);

                       -- Insert data into Employee_Role table
INSERT INTO Employee_Role (Emp_ID, Role)
VALUES
    (1, 'Supervisor'),
    (2, 'Ticket Officer'),
    (3, 'Train Driver'),
    (4, 'Station Manager'),
    (5, 'Technician');

SELECT * FROM Employee_Role;

                   -- create table (Passenger)
CREATE TABLE Passenger (
    Passenger_ID INT PRIMARY KEY,
    F_name VARCHAR(50) NOT NULL,
    L_name VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) UNIQUE
);

                       -- Insert data into Passenger table
INSERT INTO Passenger (Passenger_ID, F_name, L_name, Phone)
VALUES
    (1, 'Yara', 'Al-Fahad', '0557324189'),
    (2, 'Lina', 'Al-Mutairi', '0562895403'),
    (3, 'Sara', 'Al-Harbi', '0573941256'),
    (4, 'Amal', 'Al-Qahtani', '0581027394'),
    (5, 'Nora', 'Al-Ghamdi', '0598742635');

SELECT * FROM Passenger;

                   -- create table (Reservation)
CREATE TABLE Reservation (
    Res_ID INT PRIMARY KEY,
    Res_time DATETIME NOT NULL,
    Total_fare DECIMAL(10,2),
    Status VARCHAR(30),
    Passenger_ID INT,
    Trip_ID INT,
    FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID),
    FOREIGN KEY (Trip_ID) REFERENCES Trip(Trip_ID)
);
                       -- Insert data into Reservation table
INSERT INTO Reservation (Res_ID, Res_time, Total_fare, Status, Passenger_ID, Trip_ID)
VALUES
    (1, '2025-11-10 08:30:00', 150.00, 'Confirmed', 1, 1),
    (2, '2025-11-11 09:45:00', 200.00, 'Confirmed', 2, 2),
    (3, '2025-11-12 14:20:00', 180.00, 'Pending', 3, 3),
    (4, '2025-11-13 16:00:00', 220.00, 'Cancelled', 4, 4),
    (5, '2025-11-14 12:15:00', 170.00, 'Confirmed', 5, 5);

SELECT * FROM Reservation;

                   -- create table (Ticket)
CREATE TABLE Ticket (
    Ticket_ID INT PRIMARY KEY,
    Issuee_dateTime DATETIME NOT NULL,
    Ticket_fare DECIMAL(10,2),
    Ticket_status VARCHAR(30),
    Res_ID INT,
    Passenger_ID INT,
    FOREIGN KEY (Res_ID) REFERENCES Reservation(Res_ID),
    FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID)
);

                       -- Insert data into Ticket table
INSERT INTO Ticket (Ticket_ID, Issuee_dateTime, Ticket_fare, Ticket_status, Res_ID, Passenger_ID)
VALUES
    (1, '2025-11-08 08:00:00', 150.00, 'Active', 1, 1),
    (2, '2025-11-09 09:30:00', 200.00, 'Used', 2, 2),
    (3, '2025-11-10 10:15:00', 180.00, 'Cancelled', 3, 3),
    (4, '2025-11-11 11:45:00', 220.00, 'Active', 4, 4),
    (5, '2025-11-12 12:30:00', 170.00, 'Used', 5, 5);


SELECT * FROM Ticket;



-- Active trains with capacity > 150
SELECT 
    Train_ID,
    Type,
    Capacity,
    Status
FROM 
    Train
WHERE
    Status = 'Active' AND Capacity > 150;  
    
    
-- Routes with distance > 300 km
SELECT
    Route_ID,
    Route_name,
    Trip_num,
    Main_stations,
    Total_distance
FROM
    Route
WHERE
    Total_distance > 300.00;
    
    
-- Calculate average salary for employees on Trip ID 1
SELECT 
    AVG(Salary) AS avg_salary_Trip1
FROM
    Employee
WHERE 
    Trip_ID = 1;
   
   
-- Count passengers by family name
SELECT
    L_name, COUNT(Passenger_ID) AS Passengers_by_Family
FROM
    Passenger
GROUP BY 
	L_name;
    
    
-- employee details, role, and trip schedule
SELECT
    E.F_name AS Employee_Name,
    E.L_name AS Employee_Family,
    E.Salary,
    ER.Role,
    T.Dep_DateTime,
    T.Arr_DateTime
FROM
    Employee E
INNER JOIN
    Employee_Role ER ON E.Emp_ID = ER.Emp_ID
INNER JOIN
    Trip T ON E.Trip_ID = T.Trip_ID;   
    
    
-- Select employees by Trip ID 1 using a subquery
SELECT
    F_name,
    L_name,
    Trip_ID
FROM
	Employee
WHERE
    Trip_ID IN (
        SELECT Trip_ID
        FROM Trip
        WHERE Trip_ID = 1
    );    
    
    
-- Create a reusable view for the Crew Report
CREATE VIEW Trip_Crew_Details AS
SELECT
    E.Emp_ID,
    E.F_name AS Employee_FirstName,
    E.L_name AS Employee_LastName,
    ER.Role,
    T.Trip_ID,
    T.Dep_DateTime
FROM
    Employee E
JOIN
    Employee_Role ER ON E.Emp_ID = ER.Emp_ID
JOIN
    Trip T ON E.Trip_ID = T.Trip_ID;
    
    
-- to check the VIEW
SELECT * FROM Trip_Crew_Details;    
    
    