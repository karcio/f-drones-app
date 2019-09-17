CREATE DATABASE IF NOT EXISTS RCDB;
FLUSH PRIVILEGES;
CREATE USER 'dbuser'@'localhost' IDENTIFIED BY 'pa88w0rd';
GRANT ALL ON RCDB.* TO 'dbuser'@'localhost';
FLUSH PRIVILEGES;
USE RCDB;

DROP TABLE IF EXISTS DRONES;
CREATE TABLE DRONES (
    ID int(3) NOT NULL AUTO_INCREMENT,
    DRONE_ID int(3) NOT NULL DEFAULT '0',
    DRONE_NAME varchar(15) NOT NULL,
    FC varchar(20) NOT NULL,
    ESC varchar(30) NOT NULL,
    FPV_CAM varchar(15) NOT NULL,
    PRIMARY KEY (DRONE_ID),
    KEY ID (ID)
);

DROP TABLE IF EXISTS FLIGHT_LOG;
CREATE TABLE FLIGHT_LOG (
    ID int(3) NOT NULL AUTO_INCREMENT,
    DATE date NOT NULL,
    PLACE varchar(30) NOT NULL,
    DRONE_ID int(3) NOT NULL,
    LIPO int(3) NOT NULL,
    NOTES tinytext NOT NULL,
    PRIMARY KEY (ID),
    KEY DRONE_ID (DRONE_ID),
    CONSTRAINT FLIGHT_LOG_ibfk_1 FOREIGN KEY (DRONE_ID) REFERENCES DRONES (DRONE_ID)
);

DROP TABLE IF EXISTS LIPO;
CREATE TABLE LIPO (
    ID int(3) NOT NULL AUTO_INCREMENT,
    LIPO_ID varchar(10) NOT NULL,
    LIPO_NAME varchar(20) NOT NULL,
    LABEL varchar(4) NOT NULL,
    PRIMARY KEY (ID)
);

DROP VIEW IF EXISTS VIEW_DRONES;
CREATE VIEW VIEW_DRONES 
AS 
    select DRONES.DRONE_NAME AS DRONE_NAME, 
        DRONES.FC AS FC, 
        DRONES.ESC AS ESC, 
        DRONES.FPV_CAM AS FPV_CAM 
    from DRONES 
    order by DRONES.DRONE_NAME;

DROP VIEW IF EXISTS VIEW_DRONES_ID;
CREATE VIEW VIEW_DRONES_ID 
AS 
    select DRONES.DRONE_NAME AS DRONE_NAME, 
        DRONES.DRONE_ID AS ID 
    from DRONES 
    order by DRONES.DRONE_NAME;

DROP VIEW IF EXISTS VIEW_FLIGHT_LOG;
CREATE VIEW VIEW_FLIGHT_LOG 
AS 
    select FLIGHT_LOG.DATE AS DATE, 
        FLIGHT_LOG.PLACE AS PLACE, 
        DRONES.DRONE_NAME AS DRONE_NAME, 
        FLIGHT_LOG.LIPO AS LIPO, 
        FLIGHT_LOG.NOTES AS NOTES 
    from (FLIGHT_LOG 
        join DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID))) 
    order by FLIGHT_LOG.DATE DESC; 

DROP VIEW IF EXISTS VIEW_TOTAL_FLIGHTS;
CREATE VIEW VIEW_TOTAL_FLIGHTS 
AS 
    select sum(FLIGHT_LOG.LIPO) AS FLIGHTS 
    from FLIGHT_LOG; 

DROP VIEW IF EXISTS VIEW_TOTAL_FLIGHTS_2018;
CREATE VIEW VIEW_TOTAL_FLIGHTS_2018 
AS 
    select sum(FLIGHT_LOG.LIPO) AS FLIGHTS 
    from FLIGHT_LOG 
    where DATE BETWEEN '2018-01-01' and '2018-12-31';

DROP VIEW IF EXISTS VIEW_TOTAL_FLIGHTS_2019;
CREATE VIEW VIEW_TOTAL_FLIGHTS_2019 
AS 
    select sum(FLIGHT_LOG.LIPO) AS FLIGHTS 
    from FLIGHT_LOG 
    where DATE BETWEEN '2019-01-01' and '2019-12-31';

DROP VIEW IF EXISTS VIEW_FLIGHTS_BY_DRONES;
CREATE VIEW VIEW_FLIGHTS_BY_DRONES AS
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 1
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 2
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 3
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 4
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 5
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 6
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 7
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 8
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 9
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 10
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 11 
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 12 
UNION
SELECT DRONES.DRONE_NAME,
       sum(FLIGHT_LOG.LIPO) AS FLIGHTS
FROM (FLIGHT_LOG
      JOIN DRONES on((DRONES.DRONE_ID = FLIGHT_LOG.DRONE_ID)))
WHERE DRONES.DRONE_ID = 13 ORDER BY FLIGHTS DESC;

CREATE VIEW VIEW_HOME_FLIGHTS 
AS 
    select sum(FLIGHT_LOG.LIPO) AS FLIGHTS 
    from FLIGHT_LOG 
    WHERE PLACE = 'Home' OR PLACE = 'home';

CREATE VIEW VIEW_OUTSIDE_FLIGHTS 
AS 
    select sum(FLIGHT_LOG.LIPO) AS FLIGHTS 
    from FLIGHT_LOG 
    WHERE PLACE != 'Home' OR PLACE != 'home';