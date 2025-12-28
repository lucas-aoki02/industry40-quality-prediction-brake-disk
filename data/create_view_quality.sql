CREATE VIEW vw_quality_analysis AS
SELECT  s.id_operator,
		o.name_ AS "Operator Name",
		s.temperature_c AS "Temperature (C°)", 
		s.vibration_rms AS "Vibration (RMS)", 
		s.hidraulic_pressure AS "Pressure (BAR)", 
		s.cycletime_s AS "Cycletime (seconds)", 
		s.quality_status AS "Status",
	CASE 
		WHEN quality_status = 0 THEN 'aproved'
		ELSE 'reproved'
	END AS "quality label",
	CASE
		WHEN temperature_c BETWEEN 60 AND 75 THEN 'optmized'
		WHEN temperature_c BETWEEN 75 AND 85 THEN 'alert'
		ELSE 'critical'
	END AS "temp category",
	CASE
		WHEN vibration_rms BETWEEN 0.5 AND 3.0 THEN 'optmized'
		WHEN vibration_rms BETWEEN 3.0 AND 4.8 THEN 'alert'
		ELSE 'critical'
	END AS "vibra category",
	CASE
		WHEN hidraulic_pressure > 110 THEN 'optmized'
		WHEN hidraulic_pressure BETWEEN 90 AND 110 THEN 'alert'
		ELSE 'critical'
	END AS "press category"
		
FROM sensor_data AS s
LEFT JOIN operators AS o ON s.id_operator = o.id_operator;
	