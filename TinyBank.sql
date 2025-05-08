	USE master
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TinyBank')
BEGIN
    ALTER DATABASE TinyBank SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE TinyBank
END

CREATE DATABASE TinyBank
GO
 
USE TinyBank
GO

CREATE TABLE AccountType (
	AccountTypeID INT IDENTITY(1,1) PRIMARY KEY,
	AccountTypeName NVARCHAR(30) NOT NULL)
GO

INSERT INTO AccountType (AccountTypeName)
VALUES	
		('DebetAccount'),
		('CredidAccount'),
		('SavingsFlex'),
		('Savings1Year'),
		('Savings3Year'),
		('Savings5Year')
GO

CREATE TABLE TransactionType (
	TransactionTypeID INT IDENTITY(1,1) PRIMARY KEY,
	TransactionTypeName NVARCHAR(30) NOT NULL)
GO

INSERT INTO TransactionType (TransactionTypeName)
VALUES	
		('DebetTransaction'),
		('CreditTransaction'),
		('TransferInternal'),
		('TransferExternal'),
		('BankGiro'),
		('PostGiro')
GO

CREATE TABLE DocumentType (
	DocumentTypeID INT IDENTITY(1,1) PRIMARY KEY,
	DocumentTypeName NVARCHAR(50) NOT NULL)
GO

INSERT INTO DocumentType (DocumentTypeName)
VALUES	
		('MortgageAgreement'),
		('UnsecLoanAgreement'),
		('DebetAccountAgreement'),
		('CreditAccountAgreement'),
		('MortgageIntrestAdjustmentInfo'),
		('ArreasLev1'),
		('ArreasLev2'),
		('TerminatedMortgage'),
		('TerminatedUnesLoan'),
		('SavingsAccountAgreement')
GO

CREATE TABLE Customer (
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerFirstName NVARCHAR(30) NOT NULL,
	CustomerLastNAme NVARCHAR(30) NOT NULL,
	PersonalNumber NVARCHAR(30) NOT NULL,
	RelationStartDate DATE NOT NULL, 
	StreetName NVARCHAR(30) NOT NULL,
	PostalCode NVARCHAR(10) NOT NULL, 
	County NVARCHAR(30) NOT NULL, 
	Municipality NVARCHAR(30) NOT NULL,
	EmailAddress NVARCHAR(50)
	)
GO

	
CREATE TABLE [Platform] (
	PlatformID INT IDENTITY(1,1) PRIMARY KEY,
	PlatformName NVARCHAR(30) NOT NULL)
GO

INSERT INTO [Platform] (PlatformName)
VALUES
		('FortNox'),
		('S2'),
		('MHS'),
		('SeBa'),
		('TinyPortal')
GO

CREATE TABLE Department (
	DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
	DepartmentName NVARCHAR(30) NOT NULL)
GO

INSERT INTO Department (DepartmentName)
VALUES
		('Finance'),
		('CustomerService'),
		('Marketing'),
		('Credit'),
		('Collection'),
		('Treasury'),
		('Analytics'),
		('BackOffice')
GO

CREATE TABLE CardType (
	CardTypeID INT IDENTITY(1,1) PRIMARY KEY,
	CardTypeName NVARCHAR(30) NOT NULL)
GO

INSERT INTO CardType (CardTypeName)
VALUES	
		('Debet'),
		('Credit')
GO

CREATE TABLE MortgageCollateral (
	MortgageCollateralID INT IDENTITY(1,1) PRIMARY KEY,
	CollateralType CHAR(2) NOT NULL CHECK (CollateralType IN ('BR', 'FE')),
	Municipality NVARCHAR(30),
	StreetName NVARCHAR(30),
	PostalCode NVARCHAR(10),
	County NVARCHAR(30),
	ValuationAtPayout INT,
	OriginalLTV DECIMAL(4,2),
	CurrentLTV DECIMAL(4,2),
	PropertyCode NVARCHAR(30))
GO

INSERT INTO MortgageCollateral (CollateralType, Municipality, StreetName, PostalCode, County, ValuationAtPayout, OriginalLTV, CurrentLTV, PropertyCode)
VALUES	
		('BR', 'Haninge', 'Skyttens gata 33', '13661', 'Brandbergen', 1600000, 85, 83.22, 'Skytten 4:23'),
		('FE', 'Haninge', 'Fiskens gata 11', '13660', 'Brandbergen', 4850000, 85, 76.43, 'Fisken 9:432'),
		('BR', 'Haninge', 'Vattumannens gata 22', '13662', 'Brandbergen', 2300000, 80, 78.09, 'Vattumannen 2:80'),
		('FE', 'Haninge', 'Lodjurets gata 44', '13664', 'Brandbergen', 5500000, 85, 84.78, 'Lodjuret 3:891'),
		('FE', 'Haninge', 'Oxens gata 88', '13661', 'Brandbergen', 6900000, 60, 45.14, 'Oxen 1:110')
GO

CREATE TABLE Employee (
	EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeFirstName NVARCHAR(30) NOT NULL,
	EmployeeLastName NVARCHAR(30) NOT NULL,
	EmailAddress NVARCHAR(50),
	EmploymentDate DATE, 
	BirthDate DATE,
	Gender CHAR(1),
	MonthlySalary INT, 
	DepartmentID INT, 
	CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) 
	)
GO

INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, EmailAddress, EmploymentDate, BirthDate, Gender, MonthlySalary, DepartmentID)
VALUES
		('Anna', 'Nguyen', 'anna.nguyen@tinybank.se', '2019-03-15', '1990-06-12', 'F', 42000, 1),
		('Erik', 'Kowalski', 'erik.kowalski@tinybank.se', '2020-07-01', '1988-11-23', 'M', 46000, 2),
		('Amina', 'Hussein', 'amina.hussein@tinybank.se', '2021-01-10', '1992-09-05', 'F', 39500, 3),
		('Johan', 'Andersson', 'johan.andersson@tinybank.se', '2018-05-18', '1985-03-30', 'M', 51000, 4),
		('Fatima', 'El-Fakir', 'fatima.elfakir@tinybank.se', '2022-08-22', '1995-12-14', 'F', 38500, 5),
		('Oskar', 'Chen', 'oskar.chen@tinybank.se', '2023-04-12', '1998-01-19', 'M', 37000, 6),
		('Sara', 'Patel', 'sara.patel@tinybank.se', '2017-02-05', '1983-07-11', 'F', 47000, 7),
		('Nils', 'Aliyev', 'nils.aliyev@tinybank.se', '2016-11-30', '1979-10-22', 'M', 53000, 8),
		('Karin', 'Rodriguez', 'karin.rodriguez@tinybank.se', '2020-06-09', '1991-04-18', 'F', 44000, 1),
		('Lars', 'Pettersson', 'lars.pettersson@tinybank.se', '2022-01-03', '1989-08-03', 'M', 40000, 2),
		('Maja', 'Cissé', 'maja.cisse@tinybank.se', '2019-12-12', '1993-02-28', 'F', 41000, 3),
		('Daniel', 'Nowak', 'daniel.nowak@tinybank.se', '2021-09-09', '1987-05-15', 'M', 45500, 4),
		('Sofia', 'Yilmaz', 'sofia.yilmaz@tinybank.se', '2015-04-04', '1982-06-06', 'F', 49000, 5),
		('Fredrik', 'Okafor', 'fredrik.okafor@tinybank.se', '2018-10-20', '1986-09-09', 'M', 48000, 6),
		('Elin', 'Kaur', 'elin.kaur@tinybank.se', '2023-07-14', '1996-03-25', 'F', 39000, 7),
		('Martin', 'Duarte', 'martin.duarte@tinybank.se', '2020-03-17', '1990-12-01', 'M', 43500, 8),
		('Hanna', 'Singh', 'hanna.singh@tinybank.se', '2019-09-01', '1994-07-29', 'F', 42000, 1),
		('Tom', 'Ibrahim', 'tom.ibrahim@tinybank.se', '2016-01-15', '1981-05-05', 'M', 50000, 2),
		('Julia', 'Salim', 'julia.salim@tinybank.se', '2021-05-21', '1993-11-10', 'F', 40500, 3),
		('Andreas', 'Tanaka', 'andreas.tanaka@tinybank.se', '2022-11-11', '1989-02-17', 'M', 46000, 4)
GO

CREATE TABLE EmployeeUser (
	EmployeeUserID INT IDENTITY(1,1) PRIMARY KEY,
	PlatformID INT,
	EmployeeID INT,
	UserName NVARCHAR(50) NOT NULL,
	PassWordHash NVARCHAR(256) NOT NULL,
	Salt NVARCHAR(64) NOT NULL,
	ValidToDate DATE DEFAULT (DATEADD(YEAR, 1, GETDATE()))
)
GO 

INSERT INTO EmployeeUser (PlatformID, EmployeeID, UserName, PassWordHash, Salt, ValidToDate)
VALUES
		(1, 1, 'anna.nguyen', 'hash1', 'salt1', '2026-12-31'),
		(3, 2, 'erik.kowalski', 'hash3', 'salt3', '2026-12-31'),
		(1, 3, 'amina.hussein', 'hash4', 'salt4', '2026-12-31'),
		(2, 4, 'johan.andersson', 'hash5', 'salt5', '2026-12-31'),
		(3, 5, 'fatima.elfakir', 'hash6', 'salt6', '2026-12-31'),
		(4, 6, 'oskar.chen', 'hash7', 'salt7', '2026-12-31'),
		(5, 7, 'sara.patel', 'hash8', 'salt8', '2026-12-31'),
		(1, 8, 'nils.aliyev', 'hash9', 'salt9', '2026-12-31'),
		(2, 9, 'karin.rodriguez', 'hash10', 'salt10', '2026-12-31'),
		(3, 10, 'lars.pettersson', 'hash11', 'salt11', '2026-12-31'),
		(4, 11, 'maja.cisse', 'hash12', 'salt12', '2026-12-31'),
		(5, 12, 'daniel.nowak', 'hash13', 'salt13', '2026-12-31'),
		(1, 13, 'sofia.yilmaz', 'hash14', 'salt14', '2026-12-31'),
		(2, 14, 'fredrik.okafor', 'hash15', 'salt15', '2026-12-31'),
		(3, 15, 'elin.kaur', 'hash16', 'salt16', '2026-12-31'),
		(4, 16, 'martin.duarte', 'hash17', 'salt17', '2026-12-31'),
		(5, 17, 'hanna.singh', 'hash18', 'salt18', '2026-12-31'),
		(1, 18, 'tom.ibrahim', 'hash19', 'salt19', '2026-12-31'),
		(2, 19, 'julia.salim', 'hash20', 'salt20', '2026-12-31'),
		(3, 20, 'andreas.tanaka', 'hash21', 'salt21', '2026-12-31'),
		(5, 1, 'anna.alt', 'hash1', 'salt1', '2026-12-31'),
		(4, 2, 'erik.k.alt', 'hash22', 'salt22', '2026-12-31'),
		(5, 3, 'amina.alt', 'hash23', 'salt23', '2026-12-31'),
		(1, 5, 'fatima.alt', 'hash24', 'salt24', '2026-12-31'),
		(2, 7, 'sara.alt', 'hash25', 'salt25', '2026-12-31'),
		(3, 9, 'karin.alt', 'hash26', 'salt26', '2026-12-31'),
		(4, 11, 'maja.alt', 'hash27', 'salt27', '2026-12-31'),
		(5, 13, 'sofia.alt', 'hash28', 'salt28', '2026-12-31'),
		(1, 15, 'elin.alt', 'hash29', 'salt29', '2026-12-31'),
		(2, 17, 'hanna.alt', 'hash30', 'salt30', '2026-12-31')
GO

CREATE TABLE UnsecuredLoan (
	UnsecuredLoanID INT IDENTITY(1,1) PRIMARY KEY,
	CurrentBalance INT NOT NULL,
	OriginalAmount INT NOT NULL,
	PayOutDate DATE NOT NULL,
	IntrestRate DECIMAL(4,2)
	)
GO

INSERT INTO UnsecuredLoan (CurrentBalance, OriginalAmount, PayOutDate, IntrestRate)
VALUES
		(32000, 40000, '2022-08-15', 7.42),
		(11000, 15000, '2024-01-10', 9.01),
		(5000, 10000, '2021-05-20', 14.5),
		(28000, 30000, '2023-07-05', 9.75),
		(42000, 50000, '2020-11-30', 7.05),
		(10000, 10000, '2024-03-01', 12.8),
		(18000, 20000, '2022-09-18', 14.11),
		(9000, 15000, '2020-03-12', 7.42),
		(23000, 25000, '2021-12-09', 9.1),
		(6000, 10000, '2023-05-22', 12.0)
	
GO

CREATE TABLE ArrearsUnsecuredLoan (
	UnsecuredLoanID INT PRIMARY KEY, 
	ArrearsAmount INT NOT NULL, 
	NextContactDate DATE NOT NULL, 
	LastContactDate DATE
	CONSTRAINT FK_ArrearsUnsecuredLoan_UnsecuredLoan FOREIGN KEY (UnsecuredLoanID) REFERENCES UnsecuredLoan(UnsecuredLoanID)
	)
GO 

INSERT INTO ArrearsUnsecuredLoan (UnsecuredLoanID, ArrearsAmount, NextContactDate, LastContactDate)
VALUES
		(1, 1500, '2025-04-22', '2025-04-10'),
		(3, 1000, '2025-04-18', '2025-04-05'),
		(5, 2300, '2025-04-20', '2025-04-08'),
		(7, 800, '2025-04-25', '2025-04-12'),
		(9, 1200, '2025-04-19', '2025-04-06')
GO

INSERT INTO Customer (CustomerFirstName, CustomerLastNAme, PersonalNumber, RelationStartDate, StreetName, PostalCode, County, Municipality, EmailAddress)
VALUES
		('Anna', 'Svensson', '19900312-1234', '2021-05-15', 'Storgatan 12', '11432', 'Stockholm', 'Stockholm', 'anna.svensson@gmail.com'),
		('Johan', 'Ali', '19890504-2345', '2020-09-01', 'Västra vägen 22', '41745', 'Hovås', 'Göteborg', 'johan.ali@hotmail.com'),
		('Fatima', 'Nguyen', '19950823-3456', '2022-03-10', 'Södra Allén 5', '21111', 'Oxie', 'Malmö', 'fatima.nguyen@yahoo.com'),
		('Erik', 'Pettersson', '19911112-4567', '2019-11-20', 'Norra Gränden 9', '70372', 'Örebro', 'Örebro', 'erik.pettersson@outlook.com'),
		('Sara', 'Jabari', '19970130-5678', '2023-01-12', 'Östra Stigen 7', '75450', 'Alunda', 'Uppsala', 'sara.jabari@customdomain.com'),
		('Noah', 'Andersson', '19981205-6789', '2022-06-17', 'Lundavägen 34', '22222', 'Genarp', 'Lund', 'noah.andersson@hotmail.com'),
		('Leila', 'Mohamed', '19920607-7890', '2021-08-03', 'Solgatan 1', '98132', 'Kiruna', 'Kiruna', 'leila.mohamed@gmail.com'),
		('Oskar', 'Zhang', '19940914-8901', '2020-10-26', 'Lundavägen 12', '42110', 'Lund', 'Lund', 'oskar.zhang@yahoo.com'),
		('Ella', 'Lindberg', '19860322-9012', '2022-04-18', 'Östersjövägen 1', '12345', 'Bredared', 'Borås', 'ella.lindberg@hotmail.com'),
		('Lucas', 'Olsson', '19950717-0123', '2021-06-09', 'Kyrkogatan 3', '54123', 'Karlstad', 'Karlstad', 'lucas.olsson@gmail.com'),
		('Maja', 'Johansson', '19990114-1234', '2020-08-25', 'Torggatan 18', '14789', 'Solna', 'Solna', 'maja.johansson@hotmail.com'),
		('Max', 'Persson', '19920603-2345', '2019-12-12', 'Västervången 8', '65321', 'Jönköping', 'Jönköping', 'max.persson@live.com'),
		('Isabelle', 'Karlsson', '19901225-3456', '2022-07-22', 'Uppdraget 45', '95214', 'Värmdö', 'Värmdö', 'isabelle.karlsson@bolaget.com'),
		('Oliver', 'Lund', '19980416-4567', '2023-03-19', 'Rådhusgatan 20', '22112', 'Malmö', 'Malmö', 'oliver.lund@hotmail.com'),
		('Tilda', 'Vikström', '19930307-5678', '2022-01-08', 'Södra Gatan 8', '11022', 'Luleå', 'Luleå', 'tilda.vikstrom@yahoo.com'),
		('David', 'Jansson', '19941201-6789', '2020-11-14', 'Höjdvägen 13', '25413', 'Helsingborg', 'Helsingborg', 'david.jansson@gmail.com'),
		('Hanna', 'Berg', '19850720-7890', '2021-07-30', 'Pärlvägen 6', '23645', 'Nacka', 'Nacka', 'hanna.berg@outlook.com'),
		('Vera', 'Dahl', '19920809-8901', '2022-10-14', 'Källgatan 5', '34567', 'Västerås', 'Västerås', 'vera.dahl@hotmail.com'),
		('Nils', 'Sjöberg', '19960124-9012', '2023-02-05', 'Koppargatan 10', '50234', 'Linköping', 'Linköping', 'nils.sjoberg@gmail.com'),
		('Amina', 'Olofsson', '19930328-0123', '2022-11-10', 'Ekebacken 7', '22345', 'Gävle', 'Gävle', 'amina.olofsson@outlook.com'),
		('Ali', 'Hassan', '19920314-1234', '2022-05-10', 'Rågstigen 12', '13660', 'Brandbergen', 'Haninge', 'ali.hassan@gmail.com'),
		('Emma', 'Johansson', '19880506-5678', '2018-09-01', 'Storgatan 3', '70211', 'Örebro', 'Örebro', 'emma.johansson@hotmail.com'),
		('Mei', 'Wang', '19951122-2345', '2020-01-15', 'Drottninggatan 58', '80311', 'Gävle', 'Gävle', 'mei.wang@ab.se'),
		('Carlos', 'Martinez', '19900730-9876', '2017-11-20', 'Kungsgatan 41', '75421', 'Uppsala', 'Uppsala', 'carlos.martinez@gmail.com'),
		('Sara', 'Ahmed', '19960317-4321', '2023-03-05', 'Skolgatan 7', '21420', 'Malmö', 'Malmö', 'sara.ahmed@hotmail.com'),
		('Liam', 'Nilsson', '20010110-1235', '2021-04-22', 'Norrlandsgatan 5', '90326', 'Umeå', 'Umeå', 'liam.nilsson@gmail.com'),
		('Amina', 'Abdi', '19981203-5566', '2019-10-10', 'Fleminggatan 45', '19530', 'Märsta', 'Sigtuna', 'amina.abdi@live.se'),
		('Erik', 'Svensson', '19860119-1111', '2016-06-14', 'Odengatan 12', '23143', 'Trelleborg', 'Trelleborg', 'erik.svensson@ikea.se'),
		('Chen', 'Li', '19941005-2222', '2020-08-19', 'Tegnergatan 9', '17145', 'Solna', 'Solna', 'chen.li@gmail.com'),
		('Maja', 'Persson', '19970521-4444', '2024-02-01', 'Östra Hamngatan 25', '41109', 'Göteborg', 'Göteborg', 'maja.persson@hotmail.com'),
		('Ahmad', 'Yousef', '19910911-6666', '2018-03-28', 'Kungsängsgatan 18', '63342', 'Eskilstuna', 'Eskilstuna', 'ahmad.yousef@gmail.com'),
		('Nina', 'Andersson', '19930530-5555', '2022-11-11', 'Rosenlundsgatan 6', '11853', 'Stockholm', 'Stockholm', 'nina.andersson@banken.se'),
		('Jonas', 'Bergström', '19781212-8888', '2015-07-05', 'Lilla Nygatan 3', '96134', 'Boden', 'Boden', 'jonas.bergstrom@gmail.com'),
		('Fatima', 'Yilmaz', '19920622-4321', '2021-12-01', 'Torpvägen 1', '61133', 'Nyköping', 'Nyköping', 'fatima.yilmaz@hotmail.com'),
		('Oskar', 'Eklund', '19890115-7766', '2017-01-25', 'Backavägen 11', '29132', 'Kristianstad', 'Kristianstad', 'oskar.eklund@sas.se'),
		('Leila', 'Hussein', '19931010-9999', '2020-06-18', 'Stenåldersgatan 6', '41527', 'Göteborg', 'Göteborg', 'leila.hussein@gmail.com'),
		('Hassan', 'Farah', '19951230-3456', '2023-04-09', 'Lövstigen 4', '16356', 'Spånga', 'Stockholm', 'hassan.farah@hotmail.com'),
		('Annika', 'Lind', '19821102-9988', '2016-03-30', 'Ringvägen 19', '54130', 'Skövde', 'Skövde', 'annika.lind@spotify.se'),
		('David', 'Nguyen', '19991012-1111', '2022-07-07', 'Bergslagsgatan 3', '70361', 'Örebro', 'Örebro', 'david.nguyen@gmail.com'),
		('Zahra', 'Mohamed', '19970519-8888', '2019-08-08', 'Täppgatan 2', '15145', 'Södertälje', 'Södertälje', 'zahra.mohamed@live.se')
GO

CREATE TABLE CustomerUnsecuredLoan (
	CustomerUnsecuredLoanID INT PRIMARY KEY, 
	CustomerID INT,
	UnsecuredLoanID INT,
	CONSTRAINT FK_CustomerUnsecuredLoan_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT FK_CustomerUnsecuredLoan_UnsecuredLoan FOREIGN KEY (UnsecuredLoanID) REFERENCES UnsecuredLoan(UnsecuredLoanID)
	)
GO

INSERT INTO CustomerUnsecuredLoan (CustomerUnsecuredLoanID, CustomerID, UnsecuredLoanID)
VALUES
		(1, 1, 1),
		(2, 2, 2),
		(3, 3, 3),
		(4, 4, 4),
		(5, 5, 5),
		(6, 6, 6),
		(7, 7, 7),
		(8, 8, 8),
		(9, 9, 9),
		(10, 10, 10)
GO

CREATE TABLE Mortgage (
	MortgageID INT IDENTITY(1,1) PRIMARY KEY,
	PayoutDate DATE,
	OriginalAmount INT, 
	CurrentBalance INT,
	IntrestRate DECIMAL(4,2),
	AdjustmentDate DATE, 
	MortgageCollateralID INT,
	CONSTRAINT FK_Mortgage_MortgageCollateral FOREIGN KEY (MortgageCollateralID) REFERENCES MortgageCollateral(MortgageCollateralID))
GO

INSERT INTO Mortgage (PayoutDate, OriginalAmount, CurrentBalance, IntrestRate, AdjustmentDate, MortgageCollateralID)
VALUES	
		('2023-05-01', 1360000, 1331520, 3.23, '2025-08-01', 1), 
		('2020-01-03', 4122500, 3706855, 2.89, '2025-09-01', 2),
		('2024-06-01', 1840000, 1796070, 2.75, '2027-06-01', 3),
		('2025-02-01', 4675000, 4662900, 3.05, '2030-02-01', 4),
		('2019-02-01', 4140000, 3114660, 2.01, '2025-05-01', 5)
GO

CREATE TABLE ArrearsMortgage (
	MortgageID INT PRIMARY KEY,
	ArrearsAmount INT, 
	LastContactDate DATE, 
	NextContactDate DATE,
	CONSTRAINT FK_ArrearsMortgage_Mortgage FOREIGN KEY (MortgageID) REFERENCES Mortgage(MortgageID))
GO

INSERT INTO ArrearsMortgage (MortgageID, ArrearsAmount, LastContactDate, NextContactDate)
VALUES 
		(2, 4500, '2025-02-01', '2025-05-01'),
		(3, 1796070, '2025-05-01', '2025-05-15')
GO

CREATE TABLE CustomerMortgage (
	CustomerMortgageID INT IDENTITY(1,1) PRIMARY KEY,
	MortgageID INT,
	CustomerID INT,
	CONSTRAINT FK_CustomerMortgage_Mortgage FOREIGN KEY (MortgageID) REFERENCES Mortgage(MortgageID),
	CONSTRAINT FK_CustomerMortgage_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID))
GO

INSERT INTO CustomerMortgage (MortgageID, CustomerID)
VALUES
		(1,11),
		(1,12),
		(2,13),
		(2,14),
		(3,15),
		(3,16),
		(4,17),
		(4,18),
		(5,19),
		(5,20)
GO

CREATE TABLE CustomerUser (
	CustomerUserID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT,
	UserName NVARCHAR(30),
	PassWordHash NVARCHAR(256),
	Salt NVARCHAR(64),
	ValidToDate DATE DEFAULT (DATEADD(YEAR, 1, GETDATE())))
GO

INSERT INTO CustomerUser (CustomerID, UserName, PassWordHash, Salt, ValidToDate)
VALUES
		(1, 'anna.svensson@gmail.com', 'RandomHash1', 'RandomSalt1', '2026-01-01'),
		(2, 'johan.ali@hotmail.com', 'RandomHash2', 'RandomSalt2', '2026-02-01'),
		(3, 'fatima.nguyen@yahoo.com', 'RandomHash3', 'RandomSalt3', '2026-03-01'),
		(4, 'erik.pettersson@outlook.com', 'RandomHash4', 'RandomSalt4', '2026-04-01'),
		(5, 'sara.jabari@customdomain.com', 'RandomHash5', 'RandomSalt5', '2026-05-01'),
		(6, 'noah.andersson@hotmail.com', 'RandomHash6', 'RandomSalt6', '2026-06-01'),
		(7, 'leila.mohamed@gmail.com', 'RandomHash7', 'RandomSalt7', '2026-07-01'),
		(8, 'oskar.zhang@yahoo.com', 'RandomHash8', 'RandomSalt8', '2026-08-01'),
		(9, 'ella.lindberg@hotmail.com', 'RandomHash9', 'RandomSalt9', '2026-09-01'),
		(10, 'lucas.olsson@gmail.com', 'RandomHash10', 'RandomSalt10', '2026-10-01'),
		(11, 'maja.johansson@hotmail.com', 'RandomHash11', 'RandomSalt11', '2026-11-01'),
		(12, 'max.persson@live.com', 'RandomHash12', 'RandomSalt12', '2026-12-01'),
		(13, 'isabelle.karlsson@bolaget.com', 'RandomHash13', 'RandomSalt13', '2026-01-01'),
		(14, 'oliver.lund@hotmail.com', 'RandomHash14', 'RandomSalt14', '2026-01-02'),
		(15, 'tilda.vikstrom@yahoo.com', 'RandomHash15', 'RandomSalt15', '2026-01-03'),
		(16, 'david.jansson@gmail.com', 'RandomHash16', 'RandomSalt16', '2026-01-04'),
		(17, 'hanna.berg@outlook.com', 'RandomHash17', 'RandomSalt17', '2026-01-05'),
		(18, 'vera.dahl@hotmail.com', 'RandomHash18', 'RandomSalt18', '2026-01-06'),
		(19, 'nils.sjoberg@gmail.com', 'RandomHash19', 'RandomSalt19', '2026-01-07'),
		(20, 'amina.olofsson@outlook.com', 'RandomHash20', 'RandomSalt20', '2026-01-08'),
		(21, 'ali.hassan@gmail.com', 'RandomHash21', 'RandomSalt21', '2026-01-09'),
		(22, 'emma.johansson@hotmail.com', 'RandomHash22', 'RandomSalt22', '2026-02-02'),
		(23, 'mei.wang@ab.se', 'RandomHash23', 'RandomSalt23', '2026-03-03'),
		(24, 'carlos.martinez@gmail.com', 'RandomHash24', 'RandomSalt24', '2026-04-04'),
		(25, 'sara.ahmed@hotmail.com', 'RandomHash25', 'RandomSalt25', '2026-05-05'),
		(26, 'liam.nilsson@gmail.com', 'RandomHash26', 'RandomSalt26', '2026-06-06'),
		(27, 'amina.abdi@live.se', 'RandomHash27', 'RandomSalt27', '2026-07-07'),
		(28, 'erik.svensson@ikea.se', 'RandomHash28', 'RandomSalt28', '2026-08-08'),
		(29, 'chen.li@gmail.com', 'RandomHash29', 'RandomSalt29', '2026-09-09'),
		(30, 'maja.persson@hotmail.com', 'RandomHash30', 'RandomSalt30', '2026-10-10'),
		(31, 'ahmad.yousef@gmail.com', 'RandomHash31', 'RandomSalt31', '2026-11-11'),
		(32, 'nina.andersson@banken.se', 'RandomHash32', 'RandomSalt32', '2026-12-12'),
		(33, 'jonas.bergstrom@gmail.com', 'RandomHash33', 'RandomSalt33', '2026-01-20'),
		(34, 'fatima.yilmaz@hotmail.com', 'RandomHash34', 'RandomSalt34', '2026-01-21'),
		(35, 'oskar.eklund@sas.se', 'RandomHash35', 'RandomSalt35', '2026-01-22'),
		(36, 'leila.hussein@gmail.com', 'RandomHash36', 'RandomSalt36', '2026-01-23'),
		(37, 'hassan.farah@hotmail.com', 'RandomHash37', 'RandomSalt37', '2026-01-24'),
		(38, 'annika.lind@spotify.se', 'RandomHash38', 'RandomSalt38', '2026-01-25'),
		(39, 'david.nguyen@gmail.com', 'RandomHash39', 'RandomSalt39', '2026-01-26'),
		(40, 'zahra.mohamed@live.se', 'RandomHash40', 'RandomSalt40', '2026-01-27')
GO

CREATE TABLE LoginAttempt (
	LoginAttemptID INT IDENTITY(1,1) PRIMARY KEY, 
	CustomerUserID INT,
	EmployeeUserID INT, 
	IPAddress NVARCHAR(30),
	LoginSuccessful BIT, 
	AttemptDateTime DATETIME,
	CONSTRAINT FK_LoginAttempt_CustomerUser FOREIGN KEY (CustomerUserID) REFERENCES CustomerUser(CustomerUserID),
	CONSTRAINT FK_LoginAttempt_EmployeeUser FOREIGN KEY (EmployeeUserID) REFERENCES EmployeeUser(EmployeeUserID))
GO

INSERT INTO LoginAttempt (CustomerUserID, EmployeeUserID, IPAddress, LoginSuccessful, AttemptDateTime)
VALUES 
		(NULL, 12, '10.0.0.6', 1, '2024-12-18'),
		(33, NULL, '192.168.1.8', 1, '2024-11-03'),
		(NULL, 18, '10.0.0.9', 1, '2025-01-10'),
		(16, NULL, '192.168.1.5', 0, '2024-09-28'),
		(NULL, 20, '10.0.0.10', 0, '2025-03-04'),
		(40, NULL, '192.168.1.10', 0, '2024-10-15'),
		(NULL, 8, '10.0.0.4', 1, '2025-02-01'),
		(27, NULL, '192.168.1.7', 0, '2024-08-11'),
		(NULL, 10, '10.0.0.5', 0, '2025-01-23'),
		(5, NULL, '192.168.1.2', 0, '2025-02-19'),
		(NULL, 14, '10.0.0.7', 0, '2024-11-27'),
		(23, NULL, '192.168.1.6', 1, '2024-07-05'),
		(37, NULL, '192.168.1.9', 1, '2025-03-01'),
		(NULL, 16, '10.0.0.8', 1, '2025-01-04'),
		(NULL, 6, '10.0.0.3', 1, '2024-10-30'),
		(8, NULL, '192.168.1.3', 1, '2024-09-12'),
		(NULL, 2, '10.0.0.1', 1, '2024-08-23'),
		(1, NULL, '192.168.1.1', 1, '2024-06-14'),
		(12, NULL, '192.168.1.4', 1, '2025-02-25'),
		(NULL, 4, '10.0.0.2', 0, '2024-12-03')
GO

CREATE TABLE ResetPasswordToken (
	ResetPasswordTokenID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerUserID INT, 
	EmployeeUserID INT, 
	PasswordToken NVARCHAR(100), 
	TokenSentDateTime SMALLDATETIME,
	ValidTo SMALLDATETIME,
	CONSTRAINT FK_ResetPasswordToken_CustomerUser FOREIGN KEY (CustomerUserID) REFERENCES CustomerUser(CustomerUserID),
	CONSTRAINT FK_ResetPasswordToken_EmployeeUser FOREIGN KEY (EmployeeUserID) REFERENCES EmployeeUser(EmployeeUserID))
GO

INSERT INTO ResetPasswordToken (CustomerUserID, EmployeeUserID, PasswordToken, TokenSentDateTime, ValidTo)
VALUES
		(14, NULL, 'c2fe59dd-a3d1-41cb-921a-1badae01bc90', '2024-11-02 14:30:00', '2024-11-02 14:45:00'),
		(NULL, 7, '5af3cc80-b88c-42fb-9c3d-42c36bbf82fb', '2025-01-15 11:02:43', '2025-01-15 11:17:43'),
		(31, NULL, '1d047e63-0e6d-4fc5-b6b6-c643f1c14b02', '2024-12-08 09:28:55', '2024-12-08 09:43:55'),
		(NULL, 15, 'b96bff77-58be-4f23-b1de-91f41958f918', '2025-03-20 15:42:03', '2025-03-20 15:57:03'),
		(6, NULL, 'f3ab195e-7300-43d4-ae0e-b4ddf70e4f5f', '2024-09-30 10:59:32', '2024-09-30 11:14:32')
GO

CREATE TABLE Document (
	DocumentID INT IDENTITY(1,1) PRIMARY KEY,
	DocumentTypeID INT, 
	DocumentSentDate DATE,
	CONSTRAINT FK_Document_DocumentType FOREIGN KEY (DocumentTypeID) REFERENCES DocumentType(DocumentTypeID))
GO

INSERT INTO Document (DocumentTypeID, DocumentSentDate)
VALUES
		(1, '2023-04-01'),
		(1, '2023-04-01'),
		(1, '2019-12-03'),
		(1, '2019-12-03'),
		(1, '2024-05-01'),
		(1, '2024-05-01'),
		(1, '2025-01-01'),
		(1, '2025-01-01'),
		(1, '2019-01-01'),
		(1, '2019-01-01'),
		(2, '2022-07-15'),
		(2, '2024-12-10'),
		(2, '2021-04-20'),
		(2, '2023-06-05'),
		(2, '2020-10-30'),
		(2, '2024-02-01'),
		(2, '2022-08-18'),
		(2, '2020-02-12'),
		(2, '2021-11-09'),
		(2, '2023-04-22'),
		(6, '2025-04-21'),
		(6, '2025-03-26'),
		(6, '2025-03-21'),
		(6, '2025-04-17'),
		(6, '2025-02-04'),
		(7, '2025-03-23'),
		(7, '2025-04-29'),
		(8, '2025-02-28'),
		(8, '2025-04-14'),
		(3, '2020-11-04'),
		(3, '2020-08-27'),
		(3, '2018-01-04'),
		(3, '2019-01-04'),
		(3, '2022-12-04'),
		(3, '2021-02-24'),
		(10, '2021-09-30'),
		(10, '2023-05-12'),
		(10, '2022-03-18'),
		(10, '2021-10-19')
GO

CREATE TABLE CustomerDocument (
	CustomerDocumentID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT, 
	DocumentID INT,
	CONSTRAINT FK_CustomerDocument_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), 
	CONSTRAINT FK_CustomerDocument_Document FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID))
GO

INSERT INTO CustomerDocument (CustomerID, DocumentID)
VALUES
		(11,1),
		(12,2),
		(13,3),
		(14,4),
		(15,5),
		(16,6),
		(17,7),
		(18,8),
		(19,9),
		(20,10),
		(1,11),
		(2,12),
		(3,13),
		(4,14),
		(5,15),
		(6,16),
		(7,17),
		(8,18),
		(9,19),
		(10,20),
		(1,21),
		(3,22),
		(5,23),
		(13,24),
		(14,25),
		(7,26),
		(9,27),
		(15,28),
		(16,29),
		(7,30),
		(8,31),
		(11,32),
		(12,33),
		(13,34),
		(14,35),
		(1,36),
		(2,37),
		(3,38),
		(4,39)

GO

CREATE TABLE Account (
	AccountID INT IDENTITY(1,1) PRIMARY KEY,
	AccountNumber NVARCHAR(30),
	Balance DECIMAL(20,2),
	LastUpdated DATETIME, 
	AccountTypeID INT,
	CONSTRAINT FK_Account_AccounType FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID))
GO

INSERT INTO Account (AccountNumber, Balance, LastUpdated, AccountTypeID)
VALUES
		('2741059832', 12500.50, '2025-04-18', 1),
		('8302194765', 320.00, '2025-04-21', 1),
		('5412780369', 9470.10, '2025-04-19', 1),
		('1039846217', 800.00, '2025-04-17', 1),
		('3981720456', 15000.75, '2025-04-22', 1),
		('7691234805', 212.10, '2025-04-23', 1),
		('6570913842', 3600.00, '2025-04-20', 3),
		('8941023671', 54000.25, '2025-04-21', 6),
		('1728304659', 176000.00, '2025-04-18', 4),
		('3849021673', 92000.30, '2025-04-22', 5)
GO

CREATE TABLE [Card] (
	CardID INT IDENTITY(1,1) PRIMARY KEY, 
	CardNumber NVARCHAR(30),
	ExpDate DATE,
	CVC NVARCHAR(10),
	CardTypeID INT,
	CONSTRAINT FK_Card_CardType FOREIGN KEY (CardTypeID) REFERENCES CardType(CardTypeID))
GO

INSERT INTO [Card] (CardNumber, ExpDate, CVC, CardTypeID)
VALUES
		('123456789012', '2027-06-30', '321', 1),
		('987654321098', '2026-11-30', '472', 1),
		('456123789456', '2028-02-28', '903', 1),
		('654987321654', '2025-12-31', '187', 1),
		('741852963147', '2027-03-31', '245', 1),
		('369258147369', '2026-09-30', '659', 1)
GO

CREATE TABLE Disposition (
	DispositionID INT IDENTITY(1,1) PRIMARY KEY, 
	AccountID INT,
	CardID INT, 
	CustomerID INT, 
	OwnerCustomerID INT,
	CONSTRAINT FK_Disposition_Account FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
	CONSTRAINT FK_Disposition_Card FOREIGN KEY (CardID) REFERENCES [Card](CardID),
	CONSTRAINT FK_Disposition_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT FK_Disposition_OwnerCustomer FOREIGN KEY (OwnerCustomerID) REFERENCES Customer(CustomerID))
GO

INSERT INTO Disposition (AccountID, CardID, CustomerID, OwnerCustomerID)
VALUES
		(7, NULL, 1, 1), 
		(8, NULL, 2, 2),
		(9, NULL, 3, 3),
		(9, NULL, 4, 3),
		(10, NULL, 5, 5),
		(10, NULL, 6, 5),
		(1, 1, 7, 7),
		(2, 2, 8, 8),
		(3, 3, 11, 11),
		(4, 4, 12, 12),
		(5, 5, 13, 13),
		(5, 5, 14, 13),
		(6, 6, 15, 15),
		(6, 6, 16, 15)
GO

CREATE TABLE [Transaction] (
	TransactionID INT IDENTITY(1,1) PRIMARY KEY,
	TransactionDateTime SMALLDATETIME, 
	TransactionTypeID INT, 
	DispositionID INT, 
	RecievingBank NVARCHAR(30), 
	RecievingAccountNumber NVARCHAR(30),
	Amount INT,
	CONSTRAINT FK_Transaction_TransactionType FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(TransactionTypeID), 
	CONSTRAINT FK_Transaction_Disposition FOREIGN KEY (DispositionID) REFERENCES Disposition(DispositionID))
GO

INSERT INTO [Transaction] (TransactionDateTime, TransactionTypeID, DispositionID, RecievingBank, RecievingAccountNumber, Amount)
VALUES
		('2025-04-23 14:45', 3, 14, 'Tiny Bank', '432431423532', 76000),
		('2025-04-23 12:04', 4, 13, 'Swedbank', '54354352355',110200),
		('2025-04-22 07:41', 4, 12, 'Avanza', '987348373',23740),
		('2025-04-22 09:22', 5, 11, 'Skandia Banken', '12487349387',809),
		('2025-04-21 01:02', 6, 10, 'Nordax', '8279872482',500),
		('2025-04-21 08:32', 5, 9, 'Ica Banken', '23298389237',1300),
		('2025-04-21 22:51', 6, 8, 'Nordnet', '63403646224',3981),
		('2025-04-23 14:45', 1, 1, 'Nordea', '7372627633',19),
		('2025-04-23 14:45', 1, 3, 'Handelsbanken', '323523423',288),
		('2025-04-23 14:45', 1, 5, 'Nordea', '5464564564',47)
GO

CREATE TABLE RePayment (
	RePaymentID INT IDENTITY(1,1) PRIMARY KEY, 
	MortgageID INT,
	UnSecuredLoanID INT, 
	IntrestPeriodStart DATE,
	IntrestPeriodEnd DATE, 
	IntrestAmount INT, 
	AmortizationAmount INT, 
	TotalAmount INT,
	PaymentRecievedDate DATE)
GO

INSERT INTO RePayment (MortgageID, UnSecuredLoanID, IntrestPeriodStart, IntrestPeriodEnd, IntrestAmount, AmortizationAmount, TotalAmount, PaymentRecievedDate)
VALUES 
		(1, NULL, '2025-01-01', '2025-03-31', 1200, 3000, 4200, '2025-04-01'),
		(2, NULL, '2025-02-01', '2025-04-30', 950, 2800, 3750, '2025-05-01'),
		(3, NULL, '2025-01-15', '2025-04-15', 1000, 3200, 4200, '2025-04-16'),
		(4, NULL, '2025-03-01', '2025-06-01', 1100, 2900, 4000, '2025-06-02'),
		(5, NULL, '2025-02-10', '2025-05-10', 800, 2500, 3300, '2025-05-11'),
    	(NULL, 1, '2025-01-01', '2025-03-31', 600, 1500, 2100, '2025-04-01'),
		(NULL, 3, '2025-01-20', '2025-04-20', 700, 1600, 2300, '2025-04-21'),
		(NULL, 5, '2025-02-05', '2025-05-05', 650, 1400, 2050, '2025-05-06'),
		(NULL, 7, '2025-03-01', '2025-06-01', 800, 1700, 2500, '2025-06-02'),
		(NULL, 9, '2025-02-15', '2025-05-15', 900, 2000, 2900, '2025-05-16')
GO
		