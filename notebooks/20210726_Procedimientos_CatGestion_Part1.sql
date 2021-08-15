

----------------------------------------
-- Codigo Categoria Gestion
----------------------------------------

SELECT TOP (1000) [category_id]
      ,[category_name]
  FROM [cleandata].[sicop_categorylevel1]
  WHERE category_name LIKE '%gesti%'
  --'Servicios de Gestión, Profesionales de Empresa y Administrativos'
  -- Category_Id = 80

----------------------------------------
-- Monto Total Categoria Gestion: 199462652580
----------------------------------------
  

;WITH cte_procedimientos_cat4 AS (
	SELECT
		procedure_num
	FROM [cleandata].[sicop_procedure_categorylevel4_map] AS c
	WHERE CAST(c.category_id AS VARCHAR(255)) LIKE '80%'
	GROUP BY procedure_num
)
	SELECT

		SUM(
			CASE 
				WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
				WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
				ELSE 0
			END
		) AS Monto
	
	FROM [cleandata].[sicop_procedure_contract] AS pc
	INNER JOIN cte_procedimientos_cat4 AS p4 ON pc.[Número_procedimiento] = p4.procedure_num


----------------------------------------
-- Lista Proveedores Participantes en Procedimientos Cat Servicios de Gestion
----------------------------------------

;WITH cte_procedimientos_cat4 AS (
	SELECT
		procedure_num
	FROM [cleandata].[sicop_procedure_categorylevel4_map] AS c
	WHERE CAST(c.category_id AS VARCHAR(255)) LIKE '80%'
	GROUP BY procedure_num
)
,
cte_proveedores AS (
	SELECT 
	   ppp.[provider_id] AS ProveedorId
  FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
  INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = [Número_procedimiento]
  INNER JOIN cte_procedimientos_cat4 AS p4 ON ppp.procedure_num = p4.procedure_num
  GROUP BY [provider_id]
  UNION
  SELECT
	[Cédula_adjudicatario] AS ProveedorId
  FROM[cleandata].[sicop_procedure_contract] AS pc
  INNER JOIN cte_procedimientos_cat4 AS p4 ON pc.[Número_procedimiento] = p4.procedure_num
  GROUP BY [Cédula_adjudicatario]
)
,cte_montos AS (
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
	INNER JOIN cte_procedimientos_cat4 AS p4 ON pc.[Número_procedimiento] = p4.procedure_num
	GROUP BY Cédula_adjudicatario
)
,
 cte_participaciones AS (
	 SELECT 
		[provider_id] AS ProveedorId
		,COUNT(DISTINCT ppp.[procedure_num]) AS Participaciones
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = [Número_procedimiento]
	INNER JOIN cte_procedimientos_cat4 AS p4 ON pc.[Número_procedimiento] = p4.procedure_num
	GROUP BY [provider_id]
 )
SELECT 
	CAST([Nombre del Proveedor] AS VARCHAR(255)) AS [Nombre del Proveedor]
	,CAST(c.ProveedorId AS VARCHAR(255)) AS ProveedorId
	,CAST(COALESCE(part.Participaciones, 0) AS VARCHAR(255)) AS Participaciones
	,CAST(COALESCE(m.Procedimientos, 0) AS VARCHAR(255)) AS ProcedimientosGanados
	,CAST(COALESCE(m.Contratos, 0) AS VARCHAR(255)) AS ContratosGanados
	,CAST(COALESCE(m.Monto, 0) AS VARCHAR(255)) AS MontoGanado
	,CAST(COALESCE(m.Monto, 0) / 199462652580 AS VARCHAR(255)) AS PorcentajeTotal
	,CAST(COALESCE(m.RankMontoDesc, -1) AS VARCHAR(255)) AS RankMontoDesc
	,CAST([Nacionalidad] AS VARCHAR(255)) AS [Nacionalidad]
	,CAST([Tipo] AS VARCHAR(255)) AS [Tipo]
	--,[Direccion]
	--,[CodigoPostalCanton_InferidoDeDireccion]
	,CAST([Provincia_InferidoDeDireccion] AS VARCHAR(255)) AS [Provincia_InferidoDeDireccion]
	--,[Direccion2_InferidoDeDireccion]
	,CAST([Canton_InferidoDeDireccion] AS VARCHAR(255)) AS [Canton_InferidoDeDireccion]
	--,[Direccion3_InferidoDeDireccion]
	,CAST([Distrito_InferidoDeDireccion] AS VARCHAR(255)) AS [Distrito_InferidoDeDireccion]
	--,[Direccion4_InferidoDeDireccion]
	--,[FileName_Ingestion]
	--,[CodigoPostalDistrito_InferidoDeDireccion]
	--,[DistritoNombreAlterno_InferidoDeDireccion]
	--,[CodigoPostalDistrito_InferidoDesdeCategorias]
	,CAST([CodigoPostalDistrito_DesdeInferencias] AS VARCHAR(255)) AS [CodigoPostalDistrito_DesdeInferencias]
FROM cte_proveedores AS c 
LEFT OUTER JOIN [cleandata].[sicop_provider] As p ON c.ProveedorId = p.[Cedula]
LEFT OUTER JOIN cte_montos AS m ON c.ProveedorId = m.ProveedorId
LEFT OUTER JOIN cte_participaciones AS part ON c.ProveedorId = part.ProveedorId
WHERE COALESCE(m.Monto, 0) > 0
--WHERE c.ProveedorId = '1201600172'
ORDER BY COALESCE(m.Monto, 0) DESC






----------------------------------------
-- Prueba 2 Matrix -> V2
----------------------------------------

;WITH cte_procedimientos_cat4 AS (
	SELECT
		procedure_num
	FROM [cleandata].[sicop_procedure_categorylevel4_map] AS c
	WHERE CAST(c.category_id AS VARCHAR(255)) LIKE '80%'
	GROUP BY procedure_num
)
, cte_montos AS (
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
	FROM [cleandata].[sicop_procedure_contract] AS pc
	INNER JOIN cte_procedimientos_cat4 AS p4 ON pc.[Número_procedimiento] = p4.procedure_num
	GROUP BY Cédula_adjudicatario

)
,cte_sublist AS (
	SELECT 
		[provider_id] AS ProveedorId
		,ppp.[procedure_num] AS ProcedimientoId 
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = pc.[Número_procedimiento]
	INNER JOIN cte_montos AS m ON ppp.[provider_id] = m.ProveedorId --AND RankMontoDesc >= 134
	INNER JOIN cte_procedimientos_cat4 AS p4 ON ppp.procedure_num = p4.procedure_num
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

