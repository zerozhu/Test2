CREATE TABLE IF NOT EXISTS DAILYSTEPS (
ID integer NOT NULL PRIMARY KEY AUTOINCREMENT DEFAULT 0,
DATEYMD integer UNIQUE DEFAULT 0,
STEPCOUNT0 integer DEFAULT 0,
STEPCOUNT1 integer DEFAULT 0,
STEPCOUNT2 integer DEFAULT 0,
STEPCOUNT3 integer DEFAULT 0,
STEPCOUNT4 integer DEFAULT 0,
STEPCOUNT5 integer DEFAULT 0,
STEPCOUNT6 integer DEFAULT 0,
STEPCOUNT7 integer DEFAULT 0,
STEPCOUNT8 integer DEFAULT 0,
STEPCOUNT9 integer DEFAULT 0,
STEPCOUNT10 integer DEFAULT 0,
STEPCOUNT11 integer DEFAULT 0,
STEPCOUNT12 integer DEFAULT 0,
STEPCOUNT13 integer DEFAULT 0,
STEPCOUNT14 integer DEFAULT 0,
STEPCOUNT15 integer DEFAULT 0,
STEPCOUNT16 integer DEFAULT 0,
STEPCOUNT17 integer DEFAULT 0,
STEPCOUNT18 integer DEFAULT 0,
STEPCOUNT19 integer DEFAULT 0,
STEPCOUNT20 integer DEFAULT 0,
STEPCOUNT21 integer DEFAULT 0,
STEPCOUNT22 integer DEFAULT 0,
STEPCOUNT23 integer DEFAULT 0);
CREATE TABLE IF NOT EXISTS SETTING(
ID integer NOT NULL PRIMARY KEY AUTOINCREMENT DEFAULT 0,
ALARM VARCHAR DEFAULT '',
DAYTIMESTARTHOUR integer DEFAULT 0,
DAYTIMEENDTHOUR integer DEFAULT 0,
TARGETSTEP integer DEFAULT 0);
CREATE TABLE IF NOT EXISTS PROFILE(
ID integer NOT NULL PRIMARY KEY AUTOINCREMENT DEFAULT 0,
NAME Varchar DEFAULT '',
PHOTOPATH VARCHAR DEFAULT '',
SEX integer DEFAULT 0,
BIRTHDAY VARCHAR DEFAULT '',
HEIGHT integer DEFAULT 0,
WEIGHT integer DEFAULT 0,
PHYSIOLOGICALDATESTRING VARCHAR DEFAULT '',
PHYSIOLOGICALDAYS integer DEFAULT 0);
INSERT INTO SETTING(DAYTIMESTARTHOUR,DAYTIMEENDTHOUR,TARGETSTEP) VALUES(9,21,2500);
INSERT INTO PROFILE(BIRTHDAY,HEIGHT,WEIGHT) VALUES('1988/09/17',170,55);
CREATE TABLE IF NOT EXISTS LOCATION (
ID integer NOT NULL PRIMARY KEY AUTOINCREMENT DEFAULT 0,
DATEYMD integer DEFAULT 0,
LONGITUDE DOUBLE DEFAULT 0,
LATITUDE DOUBLE DEFAULT 0);