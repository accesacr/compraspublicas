
----------------------------------------
-- Cedula Meco
----------------------------------------	 

	SELECT TOP 10 * 
	FROM [cleandata].[sicop_provider] AS p
	WHERE [Nombre del Proveedor] LIKE '%meco%'
	-- Cedula 3101035078

----------------------------------------
-- Participaciones Meco con MOPT + CONAVI: 61
----------------------------------------	

	SELECT 
		DISTINCT procedure_num
		
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	WHERE provider_id = '3101035078'
	-- 761 participaciones totales




	 SELECT 
		[provider_id] AS ProveedorId
		,COUNT(DISTINCT [procedure_num]) AS Participaciones
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = [Número_procedimiento]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	AND provider_id = '3101035078'
	GROUP BY [provider_id]
	-- 61 participaciones para MOPT + CONAVI




----------------------------------------
-- Participaciones de otros proveedores en donde participo MECO con MOPT + CONAVI: 
----------------------------------------	

;WITH cte_procedimientos AS (
	 SELECT DISTINCT
		 ppp.[procedure_num]
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = [Número_procedimiento]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	AND provider_id = '3101035078'
	
) 
, cte_rank AS (
	SELECT
		[Cédula_adjudicatario] AS ProveedorId
		,SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) AS Monto
		,COUNT(DISTINCT [Número_procedimiento]) AS Procedimientos
		,COUNT(DISTINCT [Número_procedimiento] + '|' + [Número_contrato]) AS Contratos
		,RANK () OVER (ORDER BY SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) DESC) AS RankProveedor_x_MontoGlobal_Desc
	FROM [cleandata].[sicop_procedure_contract]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	GROUP BY Cédula_adjudicatario
)
SELECT 
	DISTINCT ppp.procedure_num
	--RANK () OVER (ORDER BY ppp.procedure_num) AS ProcedimientoWindowedId
	--,cr.RankProveedor_x_MontoGlobal_Desc
	--,ppp.*
FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
INNER JOIN (SELECT * FROM cte_rank WHERE RankProveedor_x_MontoGlobal_Desc <= 134) as cr ON ppp.provider_id = cr.ProveedorId
WHERE ppp.procedure_num IN (SELECT DISTINCT procedure_num FROM cte_procedimientos)
AND ppp.provider_id = '3101035078'
--ORDER BY procedure_num, provider_id DESC




;WITH cte_procedimientos AS (

	 SELECT DISTINCT
		 ppp.[procedure_num]
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = [Número_procedimiento]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	AND ppp.provider_id = '3101035078'
	
) 
, cte_montos_sub AS (

	SELECT
		[Cédula_adjudicatario] AS ProveedorId
		,SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) AS Monto
		,COUNT(DISTINCT [Número_procedimiento]) AS Procedimientos
		,COUNT(DISTINCT [Número_procedimiento] + '|' + [Número_contrato]) AS Contratos
		,RANK () OVER (ORDER BY SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) DESC) AS RankMontoDesc
	FROM [cleandata].[sicop_procedure_contract] AS pc
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	AND pc.Número_procedimiento IN (SELECT DISTINCT [procedure_num] FROM cte_procedimientos)
	GROUP BY Cédula_adjudicatario
) 
, cte_montos_global AS (

	SELECT
		[Cédula_adjudicatario] AS ProveedorId
		,SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) AS Monto
		,COUNT(DISTINCT [Número_procedimiento]) AS Procedimientos
		,COUNT(DISTINCT [Número_procedimiento] + '|' + [Número_contrato]) AS Contratos
		,RANK () OVER (ORDER BY SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) DESC) AS RankMontoDesc
	FROM [cleandata].[sicop_procedure_contract] AS pc
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	GROUP BY Cédula_adjudicatario

) 

	SELECT
		ms.ProveedorId AS ProveedorId
		,ms.Monto AS Monto_Sub
		,ms.Procedimientos AS Procedimientos_Sub
		,ms.Contratos AS Contratos_Sub
		,mg.RankMontoDesc AS RankMontoDesc_Global
		,mg.Procedimientos AS Procedimientos_Global
		,mg.Contratos AS Procedimientos_Global
		,mg.Monto AS MontoGanado_Global
	FROM cte_montos_sub AS ms
	LEFT OUTER JOIN cte_montos_global AS mg ON ms.ProveedorId = mg.ProveedorId
	ORDER BY ms.Monto DESC







	--- Solo participaciones MECO 

;WITH cte_montos AS (
	SELECT
		[Cédula_adjudicatario] AS ProveedorId
		,SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) AS Monto
		--,COUNT(DISTINCT [Número_procedimiento]) AS Procedimientos
		--,COUNT(DISTINCT [Número_procedimiento] + '|' + [Número_contrato]) AS Contratos
		,RANK () OVER (ORDER BY SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) DESC) AS RankMontoDesc
	FROM [cleandata].[sicop_procedure_contract]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	GROUP BY Cédula_adjudicatario

)
,cte_sublist AS (
	SELECT 
		[provider_id] AS ProveedorId
		,[procedure_num] AS ProcedimientoId 
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = pc.[Número_procedimiento]
	INNER JOIN cte_montos AS m ON ppp.[provider_id] = m.ProveedorId --AND RankMontoDesc >= 134
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
)
SELECT
	CAST('Agent' AS VARCHAR(255)) AS FromNodesetType
	,CAST('Proveedor' AS VARCHAR(255)) AS FromNodeset
	,CAST(a.ProveedorId AS VARCHAR(255)) AS FromProveedorId
	,CAST('Agent' AS VARCHAR(255)) AS ToNodesetType
	,CAST('Proveedor' AS VARCHAR(255)) AS ToNodeset
	,CAST(b.ProveedorId AS VARCHAR(255)) AS ToProveedorId
	,CAST(SUM(1) AS VARCHAR(255)) As LinkValue
	,CAST('Participaciones' AS VARCHAR(255)) AS NetworkId
	--,CAST(a.ProcedimientoId AS VARCHAR(255)) AS ProcedimientoId
FROM cte_sublist AS a 
LEFT OUTER JOIN cte_sublist AS b ON a.ProcedimientoId = b.ProcedimientoId
WHERE a.ProveedorId <> b.ProveedorId
AND a.ProveedorId = '3101035078'
GROUP BY a.ProveedorId, b.ProveedorId
ORDER BY SUM(1) DESC






CREATE TABLE #temp (ProviderID varchar(255), Val INT)
INSERT INTO #temp VALUES 
('3101138088',	43),
('3101316814',	28),
('3101213998',	27),
('3101172938',	26),
('3101408064',	24),
('3101063942',	21),
('3102008555',	20),
('3101125782',	18),
('3101163914',	13),
('3101142340',	11),
('3101079988',	8 ),
('3101125558',	8 ),
('3101031896',	7 ),
('3101080009',	7 ),
('3101008650',	6 ),
('3101379607',	6 ),
('3102038751',	6 ),
('3101091394',	3 ),
('3101018809',	1 ),
('3101389690',	1 ),
('3101144573',	1 ),
('3101659207',	1 )



SELECT
sub.val
,p.*
FROM cleandata.sicop_provider AS p
INNER JOIN #temp AS sub ON p.Cedula = sub.ProviderId
ORDER BY sub.Val DESC

