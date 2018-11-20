REM------------------------------------------------------------
REM [[APP_NAME]] ([[APP_URL]])
REM
REM @link      [[APP_REPOSITORY_URL]]
REM @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
REM @license   [[LICENSE_URL]] ([[LICENSE]])
REM--------------------------------------------------------------

REM------------------------------------------------------
REM Scripts to setup MySQL database
REM------------------------------------------------------

REM Create new database user
SET CREATE_USER_SQL="CREATE USER '%DB_USER%'@'localhost' IDENTIFIED BY '%DB_PASSW%';"

REM Create database with same name as user
SET CREATE_DB_SQL="CREATE DATABASE \`%DB_USER%\`;"

REM set privilege user to new database
SET SET_PRIVILEGE_SQL="GRANT ALL PRIVILEGES ON \`%DB_USER%\`.* TO '%DB_USER%'@'localhost';"

SET USE_DATABASE_SQL="USE \`%DB_USER%\`;"

REM create table users in new database
SET CREATE_TABLE_SQL=CREATE TABLE users ^

(id INT PRIMARY KEY NOT NULL, ^

name VARCHAR(100) NOT NULL, ^

email VARCHAR(100) NOT NULL);

REM seed sample data
SET SEED_DATA_SQL=INSERT INTO users (id, name, email) VALUES ^

(1, 'Joko Widowo', 'joko@widowo.com'), ^

(2, 'Pradowo Subiakto', 'pradowo@subiakto.com');

REM main SQL command
SET SQL="%CREATE_USER_SQL% %CREATE_DB_SQL% %USE_DATABASE_SQL% %SET_PRIVILEGE_SQL% %CREATE_TABLE_SQL% %SEED_DATA_SQL%"

REM execute mysql command
mysql -h localhost -u %DB_ADMIN% -p -e "%SQL%"
