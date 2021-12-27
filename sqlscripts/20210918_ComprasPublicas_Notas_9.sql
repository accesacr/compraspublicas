
  --segmentar mercados a nivel 4 
  --sacar participacion
  --sacar gane por participacion



--USE ComprasPublicas
--GO

--ALTER TABLE [cleandata].[sicop_categorylevel4]
--	ADD NumProcedimientos INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel4]
--	ADD NumProcGtE100 INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel4]
--	ADD NumProcGtE1000 INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel3]
--	ADD NumProcedimientos INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel3]
--	ADD NumProcGtE100 INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel3]
--	ADD NumProcGtE1000 INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel2]
--	ADD NumProcedimientos INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel2]
--	ADD NumProcGtE100 INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel2]
--	ADD NumProcGtE1000 INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel1]
--	ADD NumProcedimientos INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel1]
--	ADD NumProcGtE100 INT NULL

--ALTER TABLE [cleandata].[sicop_categorylevel1]
--	ADD NumProcGtE1000 INT NULL

--------------------------------
-- CAT N 4
--------------------------------
--SELECT
--*
--FROM [cleandata].[sicop_categorylevel4] AS c4
------WHERE category_id = '2711'
--ORDER BY NumProcedimientos DESC

----;WITH cte AS (
----	SELECT
----		n4m.category_id
----		,count(DISTINCT p.Número_procedimiento) AS NumProc
----	FROM [cleandata].[sicop_procedure] AS p
----	INNER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS n4m ON p.Número_procedimiento = n4m.procedure_num
----	GROUP BY n4m.category_id
----)
----UPDATE c4n
----	SET 
----		c4n.NumProcedimientos = COALESCE(numproc.NumProc, 0)
----FROM [cleandata].[sicop_categorylevel4] AS c4n
----LEFT JOIN cte AS numproc ON c4n.category_id = numproc.category_id



--UPDATE c4
--	SET 
--		c4.NumProcGtE100 = 
--			CASE WHEN c4.NumProcedimientos > 99 THEN 1 ELSE 0 END
--FROM [cleandata].[sicop_categorylevel4] AS c4

--UPDATE c4
--	SET 
--		c4.NumProcGtE1000 = 
--			CASE WHEN c4.NumProcedimientos > 999 THEN 1 ELSE 0 END
--FROM [cleandata].[sicop_categorylevel4] AS c4




--------------------------------
-- CAT N 3
--------------------------------

--SELECT
--*
--FROM [cleandata].[sicop_categorylevel3] AS c3
------WHERE category_id = '2711'
--ORDER BY NumProcedimientos DESC

--;WITH cte AS (
--	SELECT
--		LEFT(c4.category_id, 6) AS category_id
--		,SUM(c4.NumProcedimientos) AS NumProc
--	FROM [cleandata].[sicop_categorylevel4] AS c4
--	GROUP BY LEFT(c4.category_id, 6)
--)
--UPDATE c3
--	SET 
--		c3.NumProcedimientos = COALESCE(numproc.NumProc, 0)
--		,c3.NumProcGtE100 = 
--			CASE WHEN COALESCE(numproc.NumProc, 0) > 99 THEN 1 ELSE 0 END
--		,c3.NumProcGtE1000 = 
--			CASE WHEN c3.NumProcedimientos > 999 THEN 1 ELSE 0 END
--FROM [cleandata].[sicop_categorylevel3] AS c3
--LEFT JOIN cte AS numproc ON c3.category_id = numproc.category_id





--------------------------------
-- CAT N 2
--------------------------------


--SELECT
--*
--FROM [cleandata].[sicop_categorylevel2] AS c2
------WHERE category_id = '2711'
--ORDER BY NumProcedimientos DESC

----;WITH cte AS (
----	SELECT
----		LEFT(c3.category_id, 4) AS category_id
----		,SUM(c3.NumProcedimientos) AS NumProc
----	FROM [cleandata].[sicop_categorylevel3] AS c3
----	GROUP BY LEFT(c3.category_id, 4)
----)
----UPDATE c2
----	SET 
----		c2.NumProcedimientos = COALESCE(numproc.NumProc, 0)
----		,c2.NumProcGtE100 = 
----			CASE WHEN COALESCE(numproc.NumProc, 0) > 99 THEN 1 ELSE 0 END
----		,c2.NumProcGtE1000 = 
----			CASE WHEN COALESCE(numproc.NumProc, 0) > 999 THEN 1 ELSE 0 END
----FROM [cleandata].[sicop_categorylevel2] AS c2
----LEFT JOIN cte AS numproc ON c2.category_id = numproc.category_id

--------------------------------
-- CAT N 1
--------------------------------
--SELECT
--*
--FROM [cleandata].[sicop_categorylevel1] AS c1
------WHERE category_id = '2711'
--ORDER BY NumProcedimientos DESC


--;WITH cte AS (
--	SELECT
--		LEFT(c2.category_id, 2) AS category_id
--		,SUM(c2.NumProcedimientos) AS NumProc
--	FROM [cleandata].[sicop_categorylevel2] AS c2
--	GROUP BY LEFT(c2.category_id, 2)
--)
--UPDATE c1
--	SET 
--		c1.NumProcedimientos = COALESCE(numproc.NumProc, 0)
--		,c1.NumProcGtE100 = 
--			CASE WHEN COALESCE(numproc.NumProc, 0) > 99 THEN 1 ELSE 0 END
--		,c1.NumProcGtE1000 = 
--			CASE WHEN COALESCE(numproc.NumProc, 0) > 999 THEN 1 ELSE 0 END
--FROM [cleandata].[sicop_categorylevel1] AS c1
--LEFT JOIN cte AS numproc ON c1.category_id = numproc.category_id


--------------------------------
-- UNIFIED CAT
--------------------------------


--------------------------------
-- QUERIES CAT N4
--------------------------------

----SELECT 
----	CAST(c1.category_id AS VARCHAR(MAX)) + ' | ' + c1.category_name AS category_name_c1
----	,CAST(c2.category_id AS VARCHAR(MAX)) + ' | ' + c2.category_name AS category_name_c2
----	,CAST(c3.category_id AS VARCHAR(MAX)) + ' | ' + c3.category_name AS category_name_c3
----	,CAST(c4.category_id AS VARCHAR(MAX)) + ' | ' + c4.category_name AS category_name_c4
----FROM [cleandata].[sicop_categorylevel4] AS c4
----LEFT OUTER JOIN [cleandata].[sicop_categorylevel3] AS c3 ON LEFT(c4.category_id, 6) = c3.category_id
----LEFT OUTER JOIN [cleandata].[sicop_categorylevel2] AS c2 ON LEFT(c4.category_id, 4) = c2.category_id
----LEFT OUTER JOIN [cleandata].[sicop_categorylevel1] AS c1 ON LEFT(c4.category_id, 2) = c1.category_id
----WHERE c4.NumProcedimientos >= 500
----ORDER BY c1.category_id ASC, c2.category_id ASC, c3.category_id ASC, c4.category_id ASC

----- categories stats

DROP TABLE IF EXISTS ##c4_stats
SELECT
	c4.category_id
	,COUNT(DISTINCT p.[Número_procedimiento]) AS num_proc_x_catn4
	,COUNT(DISTINCT pp.provider_id) AS num_prov_x_catn4
	,COUNT(DISTINCT pp.provider_id + '|' + pp.procedure_num) AS num_part_x_catn4
INTO ##c4_stats
FROM [cleandata].[sicop_categorylevel4] AS c4 
LEFT OUTER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS cm ON c4.[category_id] = cm.[category_id]
LEFT OUTER JOIN [cleandata].[sicop_procedure] AS p ON cm.[procedure_num] = p.[Número_procedimiento]
LEFT OUTER JOIN [cleandata].[sicop_procedure_participations_per_provider] AS pp ON p.[Número_procedimiento] = pp.[procedure_num]
GROUP BY c4.category_id

DROP TABLE IF EXISTS ##c3_stats
SELECT
	c3.category_id
	,COUNT(DISTINCT p.[Número_procedimiento]) AS num_proc_x_catn3
	,COUNT(DISTINCT pp.provider_id) AS num_prov_x_catn3
	,COUNT(DISTINCT pp.provider_id + '|' + pp.procedure_num) AS num_part_x_catn3
INTO ##c3_stats
FROM [cleandata].[sicop_categorylevel3] AS c3 
LEFT OUTER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS cm ON c3.[category_id] = LEFT(cm.[category_id], 6)
LEFT OUTER JOIN [cleandata].[sicop_procedure] AS p ON cm.[procedure_num] = p.[Número_procedimiento]
LEFT OUTER JOIN [cleandata].[sicop_procedure_participations_per_provider] AS pp ON p.[Número_procedimiento] = pp.[procedure_num]
GROUP BY c3.category_id


DROP TABLE IF EXISTS ##c2_stats
SELECT
	c2.category_id
	,COUNT(DISTINCT p.[Número_procedimiento]) AS num_proc_x_catn2
	,COUNT(DISTINCT pp.provider_id) AS num_prov_x_catn2
	,COUNT(DISTINCT pp.provider_id + '|' + pp.procedure_num) AS num_part_x_catn2
INTO ##c2_stats
FROM [cleandata].[sicop_categorylevel2] AS c2 
LEFT OUTER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS cm ON c2.[category_id] = LEFT(cm.[category_id], 4)
LEFT OUTER JOIN [cleandata].[sicop_procedure] AS p ON cm.[procedure_num] = p.[Número_procedimiento]
LEFT OUTER JOIN [cleandata].[sicop_procedure_participations_per_provider] AS pp ON p.[Número_procedimiento] = pp.[procedure_num]
GROUP BY c2.category_id



DROP TABLE IF EXISTS ##c1_stats
SELECT
	c1.category_id
	,COUNT(DISTINCT p.[Número_procedimiento]) AS num_proc_x_catn1
	,COUNT(DISTINCT pp.provider_id) AS num_prov_x_catn1
	,COUNT(DISTINCT pp.provider_id + '|' + pp.procedure_num) AS num_part_x_catn1
INTO ##c1_stats
FROM [cleandata].[sicop_categorylevel1] AS c1 
LEFT OUTER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS cm ON c1.[category_id] = LEFT(cm.[category_id], 2)
LEFT OUTER JOIN [cleandata].[sicop_procedure] AS p ON cm.[procedure_num] = p.[Número_procedimiento]
LEFT OUTER JOIN [cleandata].[sicop_procedure_participations_per_provider] AS pp ON p.[Número_procedimiento] = pp.[procedure_num]
GROUP BY c1.category_id



-- 


SELECT 
	CAST(c1.category_id AS VARCHAR(MAX)) + ' | ' + c1.category_name + ' | ' + CAST(c1_stats.num_proc_x_catn1 AS VARCHAR(MAX)) AS category_name_c1
	,CAST(c2.category_id AS VARCHAR(MAX)) + ' | ' + c2.category_name + ' | ' + CAST(c2_stats.num_proc_x_catn2 AS VARCHAR(MAX)) AS category_name_c2
	,CAST(c3.category_id AS VARCHAR(MAX)) + ' | ' + c3.category_name + ' | ' + CAST(c3_stats.num_proc_x_catn3 AS VARCHAR(MAX)) AS category_name_c3
	,CAST(c4.category_id AS VARCHAR(MAX)) + ' | ' + c4.category_name + ' | ' + CAST(c4_stats.num_proc_x_catn4 AS VARCHAR(MAX)) AS category_name_c4
	,CASE WHEN c3_stats.num_prov_x_catn3 = 0 THEN 0 ELSE CAST((CAST(c4_stats.num_prov_x_catn4 AS DECIMAL(10,2)) / CAST(c3_stats.num_prov_x_catn3 AS DECIMAL(10,2))) AS DECIMAL(3,2)) END  AS [# prov c4 / # prov c3]
	--,c4_stats.num_prov_x_catn4
	--,c3_stats.num_prov_x_catn3
FROM [cleandata].[sicop_categorylevel4] AS c4
LEFT OUTER JOIN [cleandata].[sicop_categorylevel3] AS c3 ON LEFT(c4.category_id, 6) = c3.category_id
LEFT OUTER JOIN [cleandata].[sicop_categorylevel2] AS c2 ON LEFT(c4.category_id, 4) = c2.category_id
LEFT OUTER JOIN [cleandata].[sicop_categorylevel1] AS c1 ON LEFT(c4.category_id, 2) = c1.category_id
LEFT OUTER JOIN ##c4_stats AS c4_stats ON c4.category_id = c4_stats.category_id
LEFT OUTER JOIN ##c3_stats AS c3_stats ON c3.category_id = c3_stats.category_id
LEFT OUTER JOIN ##c2_stats AS c2_stats ON c2.category_id = c2_stats.category_id
LEFT OUTER JOIN ##c1_stats AS c1_stats ON c1.category_id = c1_stats.category_id
--WHERE c4.NumProcedimientos >= 10
--WHERE c3.category_id = 432115 AND c4.NumProcedimientos >= 10 
WHERE c3.NumProcedimientos >= 500 ANd c4.NumProcedimientos >= 10 
--AND CASE WHEN c3_stats.num_prov_x_catn3 = 0 THEN 0 ELSE CAST((CAST(c4_stats.num_prov_x_catn4 AS DECIMAL(10,2)) / CAST(c3_stats.num_prov_x_catn3 AS DECIMAL(10,2))) AS DECIMAL(3,2)) END > 0.2
ORDER BY c1.category_id ASC, c2.category_id ASC, c3.category_id ASC, c4.category_id ASC

--------------------------------
-- QUERIES CAT N3
--------------------------------

--;WITH cte_c3 AS (
--	SELECT
--		c3.category_id
--		,1 AS TotalNumCat3
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE100) > 1 THEN 1 ELSE 0 END AS MixGtE100
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE100) > 1 THEN 0 ELSE 1 END AS NotMixGtE100
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE100) <= 1 
--				AND SUM(c4.NumProcGtE100) = 0
--			THEN 1 ELSE 0
--		END AS NotMixGtE100AndOnlyNotGtE100
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE100) <= 1 
--				AND SUM(c4.NumProcGtE100) > 1
--			THEN 1 ELSE 0
--		END AS NotMixGtE100AndOnlyGtE100
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE1000) > 1 THEN 1 ELSE 0 END AS MixGtE1000
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE1000) > 1 THEN 0 ELSE 1 END AS NotMixGtE1000
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE1000) <= 1 
--				AND SUM(c4.NumProcGtE1000) = 0
--			THEN 1 ELSE 0
--		END AS NotMixGtE1000AndOnlyNotGtE1000
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE1000) <= 1 
--				AND SUM(c4.NumProcGtE1000) > 1
--			THEN 1 ELSE 0
--		END AS NotMixGtE1000AndOnlyGtE1000
--	FROM [cleandata].[sicop_categorylevel3] AS c3
--	INNER JOIN [cleandata].[sicop_categorylevel4] AS c4 ON c3.category_id = LEFT(c4.category_id, 6)
--	WHERE c4.NumProcedimientos > 0
--	GROUP BY c3.category_id
--)
--SELECT
--	SUM(TotalNumCat3) AS TotalNumCat3
--	,SUM(MixGtE100) AS MixGtE100
--	,SUM(NotMixGtE100) AS NotMixGtE100
--	,SUM(NotMixGtE100AndOnlyNotGtE100) AS NotMixGtE100AndOnlyNotGtE100
--	,SUM(NotMixGtE100AndOnlyGtE100) AS NotMixGtE100AndOnlyGtE100
--	,SUM(MixGtE1000) AS MixGtE1000
--	,SUM(NotMixGtE1000) AS NotMixGtE1000
--	,SUM(NotMixGtE1000AndOnlyNotGtE1000) AS NotMixGtE1000AndOnlyNotGtE1000
--	,SUM(NotMixGtE1000AndOnlyGtE1000) AS NotMixGtE1000AndOnlyGtE1000
--FROM  cte_c3




--------------------------------
-- QUERIES CAT N2
--------------------------------

--SELECT
--*
--FROM [cleandata].[sicop_categorylevel1] AS c1
----WHERE category_id = '2711'
--ORDER BY NumProcedimientos DESC

--SELECT
--*
--FROM [cleandata].[sicop_categorylevel2] AS c2
--WHERE category_id = '2711'
--ORDER BY NumProcedimientos DESC

--SELECT
--*
--FROM [cleandata].[sicop_categorylevel3] AS c3
--WHERE LEFT(category_id,4) = '2711'
--ORDER BY NumProcedimientos DESC

--;WITH cte_c3 AS (
--	SELECT
--		c3.category_id
--		,1 AS TotalNumCat3
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE100) > 1 THEN 1 ELSE 0 END AS MixGtE100
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE100) > 1 THEN 0 ELSE 1 END AS NotMixGtE100
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE100) <= 1 
--				AND SUM(c4.NumProcGtE100) = 0
--			THEN 1 ELSE 0
--		END AS NotMixGtE100AndOnlyNotGtE100
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE100) <= 1 
--				AND SUM(c4.NumProcGtE100) > 1
--			THEN 1 ELSE 0
--		END AS NotMixGtE100AndOnlyGtE100
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE1000) > 1 THEN 1 ELSE 0 END AS MixGtE1000
--		,CASE WHEN COUNT(DISTINCT c4.NumProcGtE1000) > 1 THEN 0 ELSE 1 END AS NotMixGtE1000
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE1000) <= 1 
--				AND SUM(c4.NumProcGtE1000) = 0
--			THEN 1 ELSE 0
--		END AS NotMixGtE1000AndOnlyNotGtE1000
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c4.NumProcGtE1000) <= 1 
--				AND SUM(c4.NumProcGtE1000) > 1
--			THEN 1 ELSE 0
--		END AS NotMixGtE1000AndOnlyGtE1000
--	FROM [cleandata].[sicop_categorylevel3] AS c3
--	INNER JOIN [cleandata].[sicop_categorylevel4] AS c4 ON c3.category_id = LEFT(c4.category_id, 6)
--	WHERE c4.NumProcedimientos > 0
--	GROUP BY c3.category_id
--)
--,cte_c2 AS (
--	SELECT
--		c2.category_id
--		,1 AS TotalNumCat2
--		,CASE WHEN COUNT(DISTINCT c3.NumProcGtE100) > 1 THEN 1 ELSE 0 END AS MixGtE100
--		,CASE WHEN COUNT(DISTINCT c3.NumProcGtE100) > 1 THEN 0 ELSE 1 END AS NotMixGtE100
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c3.NumProcGtE100) <= 1 
--				AND SUM(c3.NumProcGtE100) = 0
--			THEN 1 ELSE 0
--		END AS NotMixGtE100AndOnlyNotGtE100
--			,CASE 
--					WHEN 
--						COUNT(DISTINCT c3.NumProcGtE100) <= 1 
--						AND SUM(c3.NumProcGtE100) > 1
--					THEN 1 ELSE 0
--				END AS NotMixGtE100AndOnlyGtE100
--		,CASE WHEN COUNT(DISTINCT c3.NumProcGtE1000) > 1 THEN 1 ELSE 0 END AS MixGtE1000
--		,CASE WHEN COUNT(DISTINCT c3.NumProcGtE1000) > 1 THEN 0 ELSE 1 END AS NotMixGtE1000
--		,CASE 
--			WHEN 
--				COUNT(DISTINCT c3.NumProcGtE1000) <= 1 
--				AND SUM(c3.NumProcGtE1000) = 0
--			THEN 1 ELSE 0
--		END AS NotMixGtE1000AndOnlyNotGtE1000
--			,CASE 
--					WHEN 
--						COUNT(DISTINCT c3.NumProcGtE1000) <= 1 
--						AND SUM(c3.NumProcGtE1000) > 1
--					THEN 1 ELSE 0
--				END AS NotMixGtE1000AndOnlyGtE1000
--		--,SUM(c2.NumProcedimientos) AS NumProcedimientosN2
--		,SUM(c3.NumProcedimientos) AS NumProcedimientosN3
--	FROM [cleandata].[sicop_categorylevel2] AS c2
--	INNER JOIN [cleandata].[sicop_categorylevel3] AS c3 ON c2.category_id = LEFT(c3.category_id, 4)
--	WHERE c3.NumProcedimientos > 0
--	GROUP BY c2.category_id
--	--ORDER BY SUM(c3.NumProcedimientos) DESC
--)
--SELECT
--	SUM(TotalNumCat2) AS TotalNumCat2
--	,SUM(MixGtE100) AS MixGtE100
--	,SUM(NotMixGtE100) AS NotMixGtE100
--	,SUM(NotMixGtE100AndOnlyNotGtE100) AS NotMixGtE100AndOnlyNotGtE100
--	,SUM(NotMixGtE100AndOnlyGtE100) AS NotMixGtE100AndOnlyNotGtE100

--	,SUM(MixGtE1000) AS MixGtE1000
--	,SUM(NotMixGtE1000) AS NotMixGtE1000
--	,SUM(NotMixGtE1000AndOnlyNotGtE1000) AS NotMixGtE1000AndOnlyNotGtE1000
--	,SUM(NotMixGtE1000AndOnlyGtE1000) AS NotMixGtE1000AndOnlyGtE1000
--FROM  cte_c2



