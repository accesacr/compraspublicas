
----;with cte AS (
----	SELECT 
----		procedure_num
----		,count(*) num
----	FROM cleandata.[sicop_procedure_categorylevel4_map]
----	WHERE procedure_num IS NOT NULL AND procedure_num <> ''
----	GROUP BY procedure_num
----	HAVING count(*) > 1
----	ORDER BY count(*) DESC
----)
----SELECT
----*
----FROM cleandata.[sicop_procedure_categorylevel4_map] AS m
----INNER JOIN cte AS c ON m.procedure_num = c.procedure_num
----ORDER BY num DESC , m.procedure_num DESC

-- 1 single proc has multiple categories

;WITH cte_part AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
SELECT 
	--YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
	--,
	c1.category_name AS CatName
	,COUNT(DISTINCT Número_procedimiento) AS numProc
	--,SUM(pp1.NumPart) AS NumPart1
	--,COUNT(DISTINCT pp2.provider_id) AS NumPart2
	,COUNT(DISTINCT pp2.provider_id + '|' + pp2.procedure_num) AS NumPart3
FROM [cleandata].[sicop_procedure] AS p
--LEFT OUTER JOIN cte_part AS pp1 ON p.Número_procedimiento = pp1.procedure_num 
LEFT OUTER JOIN cleandata.[sicop_procedure_categorylevel4_map] AS m ON p.Número_procedimiento = m.procedure_num
LEFT OUTER JOIN cleandata.sicop_categorylevel1 AS c1 ON LEFT(m.category_id, 2) = LEFT(c1.category_id, 2)
LEFT OUTER JOIN [cleandata].[sicop_procedure_participations_per_provider] AS pp2 ON p.Número_procedimiento = pp2.procedure_num 
WHERE c1.category_name IS NOT NULL AND c1.category_name <> '' --AND YEAR(p.min_fecha_solicitud_contratacion) = 2020
GROUP BY --YEAR(p.min_fecha_solicitud_contratacion),
	c1.category_name
ORDER BY --YEAR(p.min_fecha_solicitud_contratacion) DESC,
	c1.category_name ASC


;WITH cte_part AS (
	SELECT 
		procedure_num
		,COUNT(DISTINCT provider_id) AS NumPart
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS pp
	GROUP BY procedure_num
)
SELECT 
	--YEAR(p.min_fecha_solicitud_contratacion) AS Year_Fecha
	--,
	c1.category_name AS CatName
	,COUNT(DISTINCT Número_procedimiento) AS numProc
	,SUM(pp.NumPart) AS NumPart
FROM [cleandata].[sicop_procedure] AS p
LEFT OUTER JOIN cte_part AS pp ON p.Número_procedimiento = pp.procedure_num 
LEFT OUTER JOIN cleandata.[sicop_procedure_categorylevel4_map] AS m ON p.Número_procedimiento = m.procedure_num
LEFT OUTER JOIN cleandata.sicop_categorylevel1 AS c1 ON LEFT(m.category_id, 2) = LEFT(c1.category_id, 2)
WHERE c1.category_name IS NOT NULL AND c1.category_name <> '' --AND YEAR(p.min_fecha_solicitud_contratacion) = 2020
GROUP BY --YEAR(p.min_fecha_solicitud_contratacion),
	c1.category_name
ORDER BY --YEAR(p.min_fecha_solicitud_contratacion) DESC,
	c1.category_name ASC


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


