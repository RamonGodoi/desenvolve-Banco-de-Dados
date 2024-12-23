CREATE DATABASE PartnerService;
USE PartnerService;

CREATE TABLE Partners (
    id VARCHAR(255) PRIMARY KEY,
    tradingName VARCHAR(255) NOT NULL,
    ownerName VARCHAR(255) NOT NULL,
    document VARCHAR(255) UNIQUE NOT NULL,
    address GEOMETRY NOT NULL,
    coverageArea GEOMETRY NOT NULL
);

INSERT INTO Partners (id, tradingName, ownerName, document, address, coverageArea)
VALUES 
(
    '1',
    'Adega da Cerveja - Pinheiros',
    'Zé da Silva',
    '1432132123891/0001',
    ST_GeomFromText('POINT(-46.57421 -21.785741)'),
    ST_GeomFromText('MULTIPOLYGON(((
        30 20, 45 40, 10 40, 30 20
    )), ((
        15 5, 40 10, 10 20, 5 10, 15 5
    )))')
);
