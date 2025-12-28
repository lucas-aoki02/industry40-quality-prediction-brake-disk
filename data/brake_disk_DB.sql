CREATE TABLE Operators (
	Id_Operator SERIAL PRIMARY KEY,
	Name_ VARCHAR(100),
	Shift VARCHAR(20)
);

CREATE TABLE sensor_data (
    Id_Lote SERIAL PRIMARY KEY, 
	Id_Operator INTEGER NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Temperature_C DECIMAL(10,2) CHECK (Temperature_C > 0),
    Vibration_RMS DECIMAL(10,2) CHECK (Vibration_RMS >= 0),
    Hidraulic_Pressure DECIMAL(10,2) CHECK (Hidraulic_Pressure > 0),
	Cycletime_S DECIMAL(10,2) CHECK (Cycletime_S > 0),
    Quality_Status INTEGER NOT NULL,
	CONSTRAINT fk_operator
		FOREIGN KEY (Id_Operator)
		REFERENCES Operators (Id_Operator)	
);

INSERT INTO Operators (Name_, Shift) VALUES
('James Cameron', 'morning shift'),
('Steve Spielberg', 'afternoon shift'),
('James Gun', 'night shift');