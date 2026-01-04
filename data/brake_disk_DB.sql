CREATE TABLE Operators (
	Id_Operator SERIAL PRIMARY KEY,
	Name_ VARCHAR(100),
	Shift VARCHAR(20)
);

CREATE TABLE sensor_data (
    id_lote SERIAL PRIMARY KEY, 
	id_operator INTEGER NOT NULL,
    current_time_register TIMESTAMP,
    temperature_c DECIMAL(10,2) CHECK (temperature_c > 0),
    vibration_rms DECIMAL(10,2) CHECK (vibration_rms >= 0),
    hidraulic_pressure DECIMAL(10,2) CHECK (hidraulic_pressure > 0),
	cycletime_s DECIMAL(10,2) CHECK (cycletime_s > 0),
    quality_status INTEGER NOT NULL,
	CONSTRAINT fk_operator
		FOREIGN KEY (Id_Operator)
		REFERENCES Operators (Id_Operator)	
);

INSERT INTO Operators (Name_, Shift) VALUES
('James Cameron', 'morning shift'),
('Steve Spielberg', 'afternoon shift'),
('James Gun', 'night shift');