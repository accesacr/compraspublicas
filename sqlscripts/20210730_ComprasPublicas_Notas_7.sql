;WITH cte_pre AS (
	SELECT
		COUNT(DISTINCT p.Tipo) AS NumTipoProveedor
		,1 AS NumTotal
		,CASE WHEN SUM(CASE WHEN p.Tipo LIKE '%micro%' THEN 1 ELSE 0 END) > 0 THEN 1 ELSE 0 END AS Si_NumMicro
		,CASE WHEN SUM(CASE WHEN p.Tipo LIKE '%micro%' THEN 1 ELSE 0 END) = 0 AND COUNT(DISTINCT p.Tipo) > 0 THEN 1 ELSE 0 END AS No_NumMicro
		,CASE WHEN  COUNT(DISTINCT p.Tipo) = 0 THEN 1 ELSE 0 END AS Null_NumMicro
		,pc.Número_procedimiento
	FROM [cleandata].[sicop_procedure_contract] AS pc
	LEFT OUTER JOIN cleandata.sicop_provider AS p ON pc.Cédula_adjudicatario = p.Cedula
	WHERE Institución = 'B N SOCIEDAD ADMINISTRADORA DE FONDOS DE INVERSION SOCIEDAD ANONIMA'
	GROUP BY pc.Número_procedimiento
)
SELECT
	*
FROM cte_pre AS c
LEFT OUTER JOIN cleandata.sicop_procedure_contract AS pc ON c.Número_procedimiento = pc.Número_procedimiento
LEFT OUTER JOIN cleandata.sicop_provider AS p ON pc.Cédula_adjudicatario = p.Cedula
WHERE c.Número_procedimiento = '2019CD-000007-0016500001'
--AND Null_NumMicro > 0

SELECT DISTINCT Cedula FROM cleandata.sicop_provider ORDER BY Cedula ASC
'3101079786'
--SELECTcleandata.sicop_procedure_contract AS pc ON c.Número_procedimiento = pc.Número_procedimiento
--LEFT OUTER JOIN cleandata.sicop_provider AS p ON pc.Cédula_adjudicatario = p.Cedula
--WHERE Null_NumMicro > 0
--2018CD-000022-0016500001
-- 2019CD-000007-0016500001

--SELECT
--	SUM(NumTotal) AS NumTotal
--	,SUM(Si_NumMicro) AS Si_NumMicro
--	,SUM(No_NumMicro) AS No_NumMicro
--	,SUM(Null_NumMicro) AS Null_NumMicro
--FROM cte_pre

	--COUNT(DISTINCT pc.Número_procedimiento) AS numTotal
	--,COUNT(DISTINCT 
	--	CASE WHEN p.Tipo LIKE '%micro%' THEN pc.Número_procedimiento ELSE NULL END
	--) AS numMicro
	--,COUNT(DISTINCT 
	--	CASE WHEN p.Tipo IS NOT NULL AND p.Tipo NOT LIKE '%micro%'THEN pc.Número_procedimiento ELSE NULL END
	--) AS numNonNull