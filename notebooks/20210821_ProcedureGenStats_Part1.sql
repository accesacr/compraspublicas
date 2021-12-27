


SELECT 
	COUNT(DISTINCT Número_procedimiento) AS numProc
FROM [cleandata].[sicop_procedure] AS p

;WITH cte_part AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
SELECT 
	YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
	,COUNT(DISTINCT Número_procedimiento) AS numProc
	,SUM(pp.NumPart) AS NumPart
FROM [cleandata].[sicop_procedure] AS p
LEFT OUTER JOIN cte_part AS pp ON p.Número_procedimiento = pp.procedure_num 
--WHERE Número_procedimiento = '2014LN-000004-0005300001'
GROUP BY YEAR(p.min_fecha_solicitud_contratacion)
ORDER BY YEAR(p.min_fecha_solicitud_contratacion) DESC


;WITH cte_part AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
,cte_month AS (
	SELECT 
		YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
		,MONTH(p.min_fecha_solicitud_contratacion) AS Month_Fecha
		,COUNT(DISTINCT Número_procedimiento) AS numProc
		,SUM(pp.NumPart) AS NumPart
	FROM [cleandata].[sicop_procedure] AS p
	LEFT OUTER JOIN cte_part AS pp ON p.Número_procedimiento = pp.procedure_num 
	--WHERE Número_procedimiento = '2014LN-000004-0005300001'
	WHERE YEAR(p.min_fecha_solicitud_contratacion) >= 2016
	GROUP BY YEAR(p.min_fecha_solicitud_contratacion), MONTH(p.min_fecha_solicitud_contratacion)
	--ORDER BY YEAR(p.min_fecha_solicitud_contratacion) DESC
)
SELECT 
	
	AVG(numProc) AS NumProc
	,AVG(numPart) AS NumPart
FROM cte_month



;WITH cte_part AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
,cte_month AS (
	SELECT 
		YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
		,MONTH(p.min_fecha_solicitud_contratacion) AS Month_Fecha
		,COUNT(DISTINCT Número_procedimiento) AS numProc
		,SUM(pp.NumPart) AS NumPart
	FROM [cleandata].[sicop_procedure] AS p
	LEFT OUTER JOIN cte_part AS pp ON p.Número_procedimiento = pp.procedure_num 
	--WHERE Número_procedimiento = '2014LN-000004-0005300001'
	WHERE YEAR(p.min_fecha_solicitud_contratacion) >= 2016
	GROUP BY YEAR(p.min_fecha_solicitud_contratacion), MONTH(p.min_fecha_solicitud_contratacion)
	--ORDER BY YEAR(p.min_fecha_solicitud_contratacion) DESC
)
SELECT 
	Year_Fecha
	,
	AVG(numProc) AS NumProc
	,AVG(numPart) AS NumPart
FROM cte_month
GROUP BY Year_Fecha
ORDER BY Year_Fecha DESC


WITH cte_part AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
,cte_day AS (
	SELECT 
		YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
		,MONTH(p.min_fecha_solicitud_contratacion) AS Month_Fecha
		,DAY(p.min_fecha_solicitud_contratacion) AS Day_Fecha
		,COUNT(DISTINCT Número_procedimiento) AS numProc
		,SUM(pp.NumPart) AS NumPart
	FROM [cleandata].[sicop_procedure] AS p
	LEFT OUTER JOIN cte_part AS pp ON p.Número_procedimiento = pp.procedure_num 
	--WHERE Número_procedimiento = '2014LN-000004-0005300001'
	WHERE YEAR(p.min_fecha_solicitud_contratacion) >= 2016
	GROUP BY YEAR(p.min_fecha_solicitud_contratacion), MONTH(p.min_fecha_solicitud_contratacion), DAY(p.min_fecha_solicitud_contratacion)
	--ORDER BY YEAR(p.min_fecha_solicitud_contratacion) DESC
)
SELECT 
	AVG(numProc) AS NumProc
	,AVG(numPart) AS NumPart
FROM cte_day



WITH cte_part AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
,cte_day AS (
	SELECT 
		YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
		,MONTH(p.min_fecha_solicitud_contratacion) AS Month_Fecha
		,DAY(p.min_fecha_solicitud_contratacion) AS Day_Fecha
		,COUNT(DISTINCT Número_procedimiento) AS numProc
		,SUM(pp.NumPart) AS NumPart
	FROM [cleandata].[sicop_procedure] AS p
	LEFT OUTER JOIN cte_part AS pp ON p.Número_procedimiento = pp.procedure_num 
	--WHERE Número_procedimiento = '2014LN-000004-0005300001'
	WHERE YEAR(p.min_fecha_solicitud_contratacion) >= 2016
	GROUP BY YEAR(p.min_fecha_solicitud_contratacion), MONTH(p.min_fecha_solicitud_contratacion), DAY(p.min_fecha_solicitud_contratacion)
	--ORDER BY YEAR(p.min_fecha_solicitud_contratacion) DESC
)
SELECT 
	Year_Fecha
	--,Month_Fecha
	--,
	,AVG(numProc) AS NumProc
	,AVG(numPart) AS NumPart
FROM cte_day
GROUP BY Year_Fecha--, Month_Fecha
ORDER BY Year_Fecha DESC
--ORDER BY Month_Fecha DESC




;WITH cte_day AS (
	SELECT 
		YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
		,MONTH(p.min_fecha_solicitud_contratacion) AS Month_Fecha
		,DAY(p.min_fecha_solicitud_contratacion) AS Day_Fecha
		,COUNT(DISTINCT Número_procedimiento) AS numProc
	FROM [cleandata].[sicop_procedure] AS p
	--WHERE Número_procedimiento = '2014LN-000004-0005300001'
	WHERE YEAR(p.min_fecha_solicitud_contratacion) = 2020
	GROUP BY YEAR(p.min_fecha_solicitud_contratacion), MONTH(p.min_fecha_solicitud_contratacion), DAY(p.min_fecha_solicitud_contratacion)
	--ORDER BY YEAR(p.min_fecha_solicitud_contratacion) DESC
)
SELECT 
	Year_Fecha
	,Month_Fecha
	,
	AVG(numProc) AS NumProc
FROM cte_day
GROUP BY Year_Fecha, Month_Fecha
ORDER BY Month_Fecha DESC



WITH cte AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
SELECT

SELECT 
		YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
		,MONTH(p.min_fecha_solicitud_contratacion) AS Month_Fecha
		,DAY(p.min_fecha_solicitud_contratacion) AS Day_Fecha
		,COUNT(DISTINCT Número_procedimiento) AS numProc
FROM [cleandata].[sicop_procedure] AS p


