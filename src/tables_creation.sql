CREATE DATABASE IF NOT EXISTS acme_commercial_property;

USE acme_commercial_property;
CREATE TABLE Category (
      CategoryID INT AUTO_INCREMENT PRIMARY KEY,
      Name VARCHAR(150) NOT NULL
);

CREATE TABLE Manufacturer (
      ManufacturerID INT AUTO_INCREMENT PRIMARY KEY,
      Name VARCHAR(150)
);

CREATE TABLE Product (
     ProductID INT AUTO_INCREMENT PRIMARY KEY ,
     Name VARCHAR(300) NOT NULL,
     CategoryID INT NOT NULL,
     ManufacturerID INT NOT NULL,
     ModelNum VARCHAR(150),
     CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID)
         REFERENCES Category (CategoryID),
     CONSTRAINT FK_Product_Manufacturer FOREIGN KEY (ManufacturerID)
         REFERENCES Manufacturer (ManufacturerID)
);

CREATE TABLE Asset (
   AssetID INT AUTO_INCREMENT PRIMARY KEY,
   Name VARCHAR(300) NOT NULL,
   ProductID INT NOT NULL,
   SerialNumber INT,
   CONSTRAINT FK_Asset_Product FOREIGN KEY (ProductID)
       REFERENCES Product (ProductID)
);
