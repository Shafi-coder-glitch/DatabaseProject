CREATE DATABASE helpdesk;
USE helpdesk;

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Email VARCHAR(100)
);

-- ITStaff Table
CREATE TABLE ITStaff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    StaffName VARCHAR(100),
    Email VARCHAR(100)
);

-- TicketStatus Table
CREATE TABLE TicketStatus (
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(50)
);

-- Ticket Table
CREATE TABLE Ticket (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    StaffID INT,
    StatusID INT,
    Description TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (StaffID) REFERENCES ITStaff(StaffID),
    FOREIGN KEY (StatusID) REFERENCES TicketStatus(StatusID)
);

-- TicketComment Table
CREATE TABLE TicketComment (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    TicketID INT,
    CommentText TEXT,
    CommentDate DATETIME,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- Insert sample data into Employee
INSERT INTO Employee (EmployeeName, Email) VALUES
('John Smith', 'john@example.com'),
('Shafi Abdullahi', 'shafi@example.com'),
('David Brown', 'david@example.com');

-- Insert sample data into ITStaff
INSERT INTO ITStaff (StaffName, Email) VALUES
('Ahmed Ali', 'ahmed@example.com'),
('Sarah Miller', 'sarah@example.com'),
('Michael Wilson', 'michael@example.com');

-- Insert sample data into TicketStatus
INSERT INTO TicketStatus (StatusName) VALUES
('Open'),
('In Progress'),
('Closed');

-- Insert sample data into Ticket
INSERT INTO Ticket (EmployeeID, StaffID, StatusID, Description) VALUES
(1, 1, 1, 'Computer is not working'),
(2, 2, 2, 'Unable to connect to Wi-Fi'),
(3, 3, 3, 'Password reset request');

-- Insert sample data into TicketComment
INSERT INTO TicketComment (TicketID, CommentText, CommentDate) VALUES
(1, 'Computer needs inspection', '2026-11-19 09:00:00'),
(2, 'Checking network connection', '2026-11-19 10:00:00'),
(3, 'Password reset completed', '2026-11-19 11:00:00');

-- Display tickets with employee names
SELECT Ticket.TicketID, Employee.EmployeeName, Ticket.Description
FROM Ticket
JOIN Employee ON Ticket.EmployeeID = Employee.EmployeeID;

-- Display employees sorted by name
SELECT * FROM Employee
ORDER BY EmployeeName;

-- Display tickets with Open status
SELECT * FROM Ticket
WHERE StatusID = 1;

-- Stored procedure to add a new employee
DELIMITER //

CREATE PROCEDURE AddEmployee(
    IN p_Name VARCHAR(100),
    IN p_Email VARCHAR(100)
)
BEGIN
    INSERT INTO Employee (EmployeeName, Email)
    VALUES (p_Name, p_Email);
END //

DELIMITER ;

-- Function to count the total number of tickets
DELIMITER //

CREATE FUNCTION CountTickets()
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Ticket;
    RETURN total;
END //

DELIMITER ;

-- Test the CountTickets function
SELECT CountTickets() AS TotalTickets;

-- List all database tables
SHOW TABLES;

-- Inspect the structure of each table
DESCRIBE Employee;
DESCRIBE ITStaff;
DESCRIBE TicketStatus;
DESCRIBE Ticket;
DESCRIBE TicketComment;

-- Verify sample data in each table
SELECT * FROM Employee;
SELECT * FROM ITStaff;
SELECT * FROM TicketStatus;
SELECT * FROM Ticket;
SELECT * FROM TicketComment;