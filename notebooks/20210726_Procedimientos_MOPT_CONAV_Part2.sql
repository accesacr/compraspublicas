
----------------------------------------
-- Prueba 2 Matrix -> V1
----------------------------------------

------ NUEVA MATRIX
------ SOLO Proveedores en el TOP 134
------ Representan el 97% del monto global para MOPT Y CONAVI

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
	INNER JOIN cte_montos AS m ON ppp.[provider_id] = m.ProveedorId AND RankMontoDesc >= 134
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
GROUP BY a.ProveedorId, b.ProveedorId




----------------------------------------
-- Prueba 2 Matrix -> V2
----------------------------------------


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
GROUP BY a.ProveedorId, b.ProveedorId

