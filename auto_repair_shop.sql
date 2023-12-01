USE [master]

IF DB_ID('auto_repair_shop') IS NOT NULL
DROP DATABASE auto_repair_shop
GO
   CREATE DATABASE auto_repair_shop
GO

USE auto_repair_shop

IF OBJECT_ID(N'dbo.Clients', N'U') IS NOT NULL
DROP TABLE Clients

IF OBJECT_ID(N'dbo.Cars', N'U') IS NOT NULL
DROP TABLE Cars

IF OBJECT_ID(N'dbo.Orders', N'U') IS NOT NULL
DROP TABLE Orders

IF OBJECT_ID(N'dbo.Spare_Parts', N'U') IS NOT NULL
DROP TABLE Spare_Parts

IF OBJECT_ID(N'dbo.Services', N'U') IS NOT NULL
DROP TABLE Services

IF OBJECT_ID(N'dbo.Specialities', N'U') IS NOT NULL
DROP TABLE Specialities

IF OBJECT_ID(N'dbo.Employees', N'U') IS NOT NULL
DROP TABLE Employees

IF OBJECT_ID(N'dbo.History_Orders', N'U') IS NOT NULL
DROP TABLE History_Orders

GO

CREATE TABLE Clients(
  id_client int IDENTITY(1, 1) PRIMARY KEY,
  name varchar(50) NULL,
  surname varchar(50) NULL,
  patronymic varchar(50) NULL,
  login varchar(50) NULL,
  password varchar(50) NULL,
  email varchar(100) NULL,
)
GO

CREATE TABLE Cars(
  id_car int IDENTITY(1, 1) PRIMARY KEY,
  id_client int NULL,
  car_brand varchar(50) NULL,
  car_model varchar(50) NULL,
  year_of_manufacture int NULL,
  number_car varchar(10) NULL,
  photo varbinary(MAX) NULL,
  FOREIGN KEY(id_client) REFERENCES Clients(id_client) ON DELETE CASCADE ON UPDATE CASCADE
)
GO

CREATE TABLE Services(
  id_service int IDENTITY(1, 1) PRIMARY KEY,
  name_service varchar(50) NULL,
  description varchar(100) NULL,
  price int NULL,
)
GO

CREATE TABLE Orders(
  id_order int IDENTITY(1, 1) PRIMARY KEY,
  id_client int NULL,
  id_service int NULL,
  id_car int NULL,
  date_order date NULL,
  execution_status int NULL,
  price int NULL,
  FOREIGN KEY(id_client) REFERENCES Clients(id_client) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(id_service) REFERENCES Services(id_service),
  FOREIGN KEY(id_car) REFERENCES Cars(id_car),
) 
GO

CREATE TABLE Spare_Parts(
  id_part int IDENTITY(1, 1) PRIMARY KEY,
  id_service int NULL,
  name_parts varchar(50) NULL,
  photo varbinary(MAX) NULL,
  description varchar(100) NULL,
  price int NULL,
  presence int NULL,
  FOREIGN KEY(id_service) REFERENCES Services(id_service) ON DELETE CASCADE ON UPDATE CASCADE,
)
GO

CREATE TABLE Specialities(
  id_specialties int IDENTITY(1, 1) PRIMARY KEY,
  name_specialties varchar(50) NULL,
)
GO

CREATE TABLE Employees(
  id_employee int IDENTITY(1, 1) PRIMARY KEY,
  id_specialties int NULL,
  name varchar(50) NULL,
  surname varchar(50) NULL,
  patronymic varchar(50) NULL,
  job_title varchar(50) NULL,
  login varchar(50) NULL,
  password varchar(50) NULL,
  email varchar(50) NULL,
  FOREIGN KEY (id_specialties) REFERENCES Specialities(id_specialties) ON DELETE CASCADE ON UPDATE CASCADE
)
GO

CREATE TABLE History_Orders(
  id_record int IDENTITY(1, 1) PRIMARY KEY,
  id_client int NULL,
  id_car int NULL,
  id_services int NULL,
  id_part int NULL,
  id_employer int NULL,
  FOREIGN KEY(id_client) REFERENCES Clients(id_client),
  FOREIGN KEY(id_car) REFERENCES Cars(id_car),
  FOREIGN KEY(id_services) REFERENCES Services(id_service),
  FOREIGN KEY(id_part) REFERENCES Spare_Parts(id_part),
  FOREIGN KEY(id_employer) REFERENCES Employees(id_employee),
)
GO

CREATE TABLE Admin(
  login varchar(50) PRIMARY KEY,
  password varchar(50) NULL,
)
GO

INSERT INTO Clients (name, surname, patronymic, login, password, email)
VALUES
  ('Иван', 'Иванов', 'Иванович', '123', '123', 'ivan@example.com'),
  ('Мария', 'Петрова', 'Александровна', 'maria456', 'mariapass', 'maria@example.com'),
  ('Алексей', 'Сидоров', 'Павлович', 'alex789', 'alexpass', 'alex@example.com');

INSERT INTO Cars (id_client, car_brand, car_model, year_of_manufacture, number_car)
VALUES
  (1, 'Toyota', 'Camry', 2018, 'A123BC'),
  (2, 'Ford', 'Focus', 2020, 'X456YZ'),
  (3, 'Chevrolet', 'Cruze', 2019, 'K789LM');

INSERT INTO Services (name_service, description, price)
VALUES
  ('Замена масла', 'Замена моторного масла и фильтра', 800),
  ('Ремонт тормозов', 'Работы по ремонту тормозной системы', 1200),
  ('Замена свечей зажигания', 'Замена свечей зажигания в двигателе', 300);

INSERT INTO Orders (id_client, id_service, id_car, date_order, execution_status, price)
VALUES
  (1, 1, 1, '2023-08-01', 1, 1500),
  (2, 2, 2, '2023-08-05', 2, 2000),
  (3, 3, 3, '2023-08-10', 1, 1800);

INSERT INTO Spare_Parts (id_service, name_parts, description, price, presence)
VALUES
  (1, 'Масляный фильтр', 'Фильтр для масла двигателя', 300, 50),
  (2, 'Тормозные колодки', 'Колодки для тормозной системы', 500, 30),
  (3, 'Свечи зажигания', 'Свечи для зажигания двигателя', 150, 70);

INSERT INTO Specialities (name_specialties)
VALUES
  ('Механик'),
  ('Электрик'),
  ('Слесарь');

INSERT INTO Employees (id_specialties, name, surname, patronymic, job_title, login, password, email)
VALUES
  (1, 'Петр', 'Смирнов', 'Игоревич', 'Механик', 'petrmech', 'petrpass', 'petr@example.com'),
  (2, 'Елена', 'Васильева', 'Андреевна', 'Электрик', 'elenaelec', 'elenapass', 'elena@example.com'),
  (3, 'Иван', 'Зайцев', 'Алексеевич', 'Слесарь', 'ivan', 'ivanpass', 'ivan@example.com');

INSERT INTO History_Orders (id_client, id_car, id_services, id_part, id_employer)
VALUES
  (1, 1, 1, 1, 1),
  (2, 2, 3, 2, 2),
  (3, 3, 2, 3, 3);

INSERT INTO Admin (login, password)
VALUES
  ('admin', 'admin')
  
UPDATE Cars
SET photo = (SELECT * FROM OPENROWSET(BULK N'C:\Users\nb msi\Desktop\auto_repair_shopProject\photo\toyota.jpg', SINGLE_BLOB) AS image)
WHERE id_client = 1

UPDATE Cars
SET photo = (SELECT * FROM OPENROWSET(BULK N'C:\Users\nb msi\Desktop\auto_repair_shopProject\photo\Ford_Focus.jpg', SINGLE_BLOB) AS image)
WHERE id_client = 2

UPDATE Cars
SET photo = (SELECT * FROM OPENROWSET(BULK N'C:\Users\nb msi\Desktop\auto_repair_shopProject\photo\chevrolet_cruze.jpg', SINGLE_BLOB) AS image)
WHERE id_client = 3


UPDATE Spare_Parts
SET photo = (SELECT * FROM OPENROWSET(BULK N'C:\Users\nb msi\Desktop\auto_repair_shopProject\photo\maslo.jpg', SINGLE_BLOB) AS image)
WHERE name_parts = 'Масляный фильтр'

UPDATE Spare_Parts
SET photo = (SELECT * FROM OPENROWSET(BULK N'C:\Users\nb msi\Desktop\auto_repair_shopProject\photo\tormoz.jpg', SINGLE_BLOB) AS image)
WHERE name_parts = 'Тормозные колодки'

UPDATE Spare_Parts
SET photo = (SELECT * FROM OPENROWSET(BULK N'C:\Users\nb msi\Desktop\auto_repair_shopProject\photo\svechi.jpg', SINGLE_BLOB) AS image)
WHERE name_parts = 'Свечи зажигания'
