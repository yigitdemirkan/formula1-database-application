CREATE DATABASE mydatabase;
USE mydatabase;

CREATE TABLE Engine_Supplier (esid INTEGER, ename CHAR(50), country CHAR(50), PRIMARY KEY (esid));

CREATE TABLE Team_Supplies_Engine (tid INTEGER, tname CHAR(50), principal CHAR(50), esid INTEGER NOT NULL,
PRIMARY KEY (tid), FOREIGN KEY (esid) REFERENCES Engine_Supplier(esid));

CREATE TABLE Driver_Races_for (did INTEGER NOT NULL, dname CHAR(50), nationality CHAR(50), tid INTEGER NOT NULL,
PRIMARY KEY (did), FOREIGN KEY (tid) REFERENCES Team_Supplies_Engine(tid));

CREATE TABLE Race (rid INTEGER, circuit CHAR(50), LapCount INTEGER, PRIMARY KEY (rid));

CREATE TABLE Race_Result (rrid INTEGER, position INTEGER, FastestLapTime REAL, PRIMARY KEY (rrid));

CREATE TABLE Results_in (did INTEGER NOT NULL, rid INTEGER NOT NULL, rrid INTEGER NOT NULL, PRIMARY KEY (rrid, did, rid),
FOREIGN KEY (did) REFERENCES Driver_Races_for(did) ON DELETE CASCADE, FOREIGN KEY (rid) REFERENCES Race(rid) ON DELETE CASCADE,
FOREIGN KEY (rrid) REFERENCES Race_Result(rrid));

CREATE TABLE Pit_Stop (pid INTEGER, reason CHAR(100), duration REAL, PRIMARY KEY (pid));

CREATE TABLE makes (pid INTEGER, rid INTEGER NOT NULL, did INTEGER NOT NULL, PRIMARY KEY (pid,rid,did), FOREIGN KEY (did)
REFERENCES Driver_Races_for(did) ON DELETE CASCADE, FOREIGN KEY (rid) REFERENCES Race(rid) ON DELETE CASCADE, FOREIGN KEY (pid)
REFERENCES Pit_Stop(pid));

INSERT INTO Engine_Supplier (esid, ename, country) 
VALUES  
(1, 'Ferrari', 'Italy'), 
(2, 'Mercedes', 'Germany'), 
(3, 'Honda', 'Japan'), 
(4, 'Renault', 'France'), 
(5, 'Ford', 'France'), 
(6, 'Audi', 'German'), 
(7, 'Alpine', 'France'), 
(8, 'McLaren', 'Britain'), 
(9, 'Cosworth', 'Britain'), 
(10, 'BMW', 'Germany');

INSERT INTO Team_Supplies_Engine (tid, tname, principal, esid) 
VALUES 
(1, 'Mercedes', 'Totto Wolf', 2), 
(2, 'Red Bull', 'Christian Horner', 3), 
(3, 'Alfa Romeo', 'Alunni Bravi', 1), 
(4, 'Ferrari', 'Frederic Vasseur', 1), 
(5, 'McLaren', 'Andrea Stella', 2), 
(6, 'Alpine', 'Otmar Szafnauer', 1), 
(7, 'Alpha Tauri', 'Franz Tost', 3), 
(8, 'Aston Martin', 'Mike Krack', 5), 
(9, 'Williams', 'James Vowles', 9), 
(10, 'Haas', 'Günther Steiner', 10);

INSERT INTO Driver_Races_for (did, dname, nationality, tid) 
VALUES 
(1, 'Max Verstappen', 'Dutch', 2), 
(2, 'Lewis Hamilton', 'British', 1), 
(3, 'Charles Leclerc', 'Monacan', 4), 
(4, 'Nico Hülkenberg', 'German', 10), 
(5, 'Lando Norris', 'British', 5), 
(6, 'Fernando Alonso', 'Spanish', 8), 
(7, 'Valteri Bottas', 'Finnish', 3), 
(8, 'Yuki Tsunoda', 'Japanese', 7), 
(9, 'Alex Albon', 'Thai', 9), 
(10, 'Pierre Gasly', 'French', 6);

INSERT INTO Race (rid, circuit, LapCount) 
VALUES  
(1, 'Bahrain', 57), 
(2, 'Saudi Arabia', 50), 
(3, 'Australia', 58), 
(4, 'Azerbaijan', 51), 
(5, 'Miami', 57), 
(6, 'Emilia Romagna', 63), 
(7, 'Monaco', 78), 
(8, 'Spain', 66), 
(9, 'Canada', 70), 
(10, 'Austria', 71);

INSERT INTO Race_Result (rrid, position, FastestLapTime) 
VALUES 
(1, 2, 1.2), 
(2, 5, 1.3), 
(3, 7, 1.7), 
(4, 9, 1.5), 
(5, 3, 1.9), 
(6, 6, 2.1), 
(7, 11, 1.4), 
(8, 18, 1.7), 
(9, 1, 1.1), 
(10, 3, 1.8);

INSERT INTO Results_in (rrid, did, rid) 
VALUES  
(1, 8, 1), 
(2, 3, 2), 
(3, 6, 3), 
(4, 1, 4), 
(5, 10, 5), 
(6, 4, 6), 
(7, 2, 7), 
(8, 7, 8), 
(9, 9, 9), 
(10, 5, 10);

INSERT INTO Pit_Stop (pid, reason, duration) 
VALUES  
(1, 'Tire change', 0.18), 
(2, 'Refueling', 0.16), 
(3, 'Reparing Damage', 0.17), 
(4, 'Adjusting car setup', 0.11), 
(5, 'Tire pressure adjusment', 0.20), 
(6, 'Brake check', 0.26), 
(7, 'Clearing debris', 0.33), 
(8, 'Penalty', 0.10), 
(9, 'Cooling System Error', 0.14), 
(10, 'Windshield Cleaning', 0.19);

INSERT INTO makes (pid, rid, did) 
VALUES  
(1, 4, 1), 
(2, 7, 2), 
(3, 2, 3), 
(4, 6, 4), 
(5, 10, 5), 
(6, 3, 6), 
(7, 8, 7), 
(8, 1, 8), 
(9, 9, 9), 
(10, 5, 10);

DELIMITER //

CREATE PROCEDURE addEngineSupplier(
    IN new_esid INT, 
    IN new_ename CHAR(50), 
    IN new_country CHAR(50)
)
BEGIN
    -- Insert new engine supplier into Engine_Supplier table
    INSERT INTO Engine_Supplier (esid, ename, country)
    VALUES (new_esid, new_ename, new_country);
    
    -- Optional: Provide a success message
    SELECT 'Engine Supplier added successfully' AS Message;
    
END //
DELIMITER ;


DELIMITER //

CREATE PROCEDURE addPitStop(
    IN new_pid INT, 
    IN new_reason CHAR(100), 
    IN new_duration REAL
)
BEGIN
    -- Insert new pit stop into Pit_Stop table
    INSERT INTO Pit_Stop (pid, reason, duration)
    VALUES (new_pid, new_reason, new_duration);
    
    -- Optional: Provide a success message
    SELECT 'Pit Stop added successfully' AS Message;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER prevent_negative_duration
BEFORE INSERT ON Pit_Stop
FOR EACH ROW
BEGIN
    -- Check if the duration is negative
    IF NEW.duration < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duration cannot be negative';
    END IF;
END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER restrict_supplier_country
BEFORE INSERT ON Engine_Supplier
FOR EACH ROW
BEGIN
    -- Check if the country is not in the allowed list
    IF NEW.country NOT IN ('Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria', 
'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia', 
'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 
'Cameroon', 'Canada', 'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo (Congo-Brazzaville)', 
'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czechia (Czech Republic)', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 
'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Eswatini (fmr. "Swaziland")', 'Ethiopia', 'Fiji', 
'Finland', 'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau', 
'Guyana', 'Haiti', 'Holy See', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 
'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Korea (North)', 'Korea (South)', 'Kuwait', 'Kyrgyzstan', 
'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Madagascar', 'Malawi', 
'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 
'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar (formerly Burma)', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 
'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North Macedonia (formerly Macedonia)', 'Norway', 'Oman', 'Pakistan', 'Palau', 
'Palestine State', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 
'Russia', 'Rwanda', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino', 
'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 
'Solomon Islands', 'Somalia', 'South Africa', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Sweden', 'Switzerland', 
'Syria', 'Tajikistan', 'Tanzania', 'Thailand', 'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 
'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States of America', 'Uruguay', 
'Uzbekistan', 'Vanuatu', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe')
 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid country for engine supplier.';
    END IF;
END //

DELIMITER ;



