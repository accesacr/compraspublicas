
----------------------------------------
-- Lista Procedimientos MOPT y CONAVI
----------------------------------------
SELECT
	[Número_procedimiento] AS ProcedimientoId
	,[Institución] AS Institucion
	,[Tipo_modalidad] AS TipoModalidad
	,[Tipo_Procedimiento] AS TipoProcedimiento
	,[Descripción] AS Descripcion

FROM [cleandata].[sicop_procedure]
WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')



----------------------------------------
-- Montos Procedimientos MOPT y CONAVI x Proveedor
----------------------------------------
SELECT
	[Número_procedimiento] AS ProcedimientoId
	,[Cédula_adjudicatario] AS ProveedorId
	,SUM(
		CASE 
			WHEN Moneda = 'CRC' THEN [Calc_Monto_Redondeado]
			WHEN Moneda = 'USD' THEN [Calc_Monto_Redondeado] * 610
			ELSE 0
		END
	) AS Monto
	,MIN(Fecha_notificación) AS MinFechaNotificacion
	,MAX(Fecha_notificación) AS MaxFechaNotificacion
FROM [cleandata].[sicop_procedure_contract]
WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
GROUP BY [Número_procedimiento], Cédula_adjudicatario


----------------------------------------
-- Lista Proveedores Participantes en Procedimientos MOPT y CONAVI
----------------------------------------


;WITH cte_proveedores AS (
	SELECT 
	   ppp.[provider_id] AS ProveedorId
  FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
  INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = [Número_procedimiento]
  WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
  GROUP BY [provider_id]
  UNION
  SELECT
	[Cédula_adjudicatario] AS ProveedorId
  FROM[cleandata].[sicop_procedure_contract] AS pc
  WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
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
	FROM [cleandata].[sicop_procedure_contract]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	GROUP BY Cédula_adjudicatario
)
,
 cte_participaciones AS (
	 SELECT 
		[provider_id] AS ProveedorId
		,COUNT(DISTINCT [procedure_num]) AS Participaciones
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = [Número_procedimiento]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	GROUP BY [provider_id]
 )
SELECT 
	[Nombre del Proveedor]
	,c.ProveedorId AS ProveedorId
	,COALESCE(part.Participaciones, 0) AS Participaciones
	,COALESCE(m.Procedimientos, 0) AS ProcedimientosGanados
	,COALESCE(m.Contratos, 0) AS ContratosGanados
	,COALESCE(m.Monto, 0) AS MontoGanado
	,COALESCE(m.Monto, 0) / 137237035691 AS PorcentajeTotal
	,COALESCE(m.RankMontoDesc, -1) AS RankMontoDesc
	,[Nacionalidad]
	,[Tipo]
	,[Direccion]
	,[CodigoPostalCanton_InferidoDeDireccion]
	,[Provincia_InferidoDeDireccion]
	,[Direccion2_InferidoDeDireccion]
	,[Canton_InferidoDeDireccion]
	,[Direccion3_InferidoDeDireccion]
	,[Distrito_InferidoDeDireccion]
	,[Direccion4_InferidoDeDireccion]
	,[FileName_Ingestion]
	,[CodigoPostalDistrito_InferidoDeDireccion]
	,[DistritoNombreAlterno_InferidoDeDireccion]
	,[CodigoPostalDistrito_InferidoDesdeCategorias]
	,[CodigoPostalDistrito_DesdeInferencias]
FROM cte_proveedores AS c 
LEFT OUTER JOIN [cleandata].[sicop_provider] As p ON c.ProveedorId = p.[Cedula]
LEFT OUTER JOIN cte_montos AS m ON c.ProveedorId = m.ProveedorId
LEFT OUTER JOIN cte_participaciones AS part ON c.ProveedorId = part.ProveedorId
WHERE COALESCE(m.Monto, 0) > 0
--WHERE c.ProveedorId = '1201600172'
ORDER BY COALESCE(m.Monto, 0) DESC



----------------------------------------
-- Participaciones de Proveedores en Procedimientos MOPT + CONAVI
----------------------------------------
SELECT 
	[provider_id] AS ProveedorId
    ,[procedure_num] AS ProcedimientoId 
    ,[max_opening_act_publication_date]
    ,[max_opening_act_date]
    ,[min_opening_act_publication_date]
    ,[min_opening_act_date]
FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = pc.[Número_procedimiento]
WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')


----------------------------------------
-- Prueba 1 Matrix -> VO
----------------------------------------
----WITH cte AS (
----	SELECT 
----		[provider_id] AS ProveedorId
----		,[procedure_num] AS ProcedimientoId 
----	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
----	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = pc.[Número_procedimiento]
----	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
----)
----SELECT
----	'Agent' AS FromNodesetType
----	,'Proveedor' AS FromNodeset
----	,a.ProveedorId AS FromProveedorId
----	,'Agent' AS ToNodesetType
----	,'Proveedor' AS ToNodeset
----	,b.ProveedorId AS ToProveedorId
----	,1 As LinkValue
----	,'Participaciones' AS NetworkId
----	,a.ProcedimientoId AS ProcedimientoId
----FROM cte AS a 
----LEFT OUTER JOIN cte AS b ON a.ProcedimientoId = b.ProcedimientoId
----WHERE a.ProveedorId <> b.ProveedorId



WITH cte AS (
	SELECT 
		[provider_id] AS ProveedorId
		,[procedure_num] AS ProcedimientoId 
	FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = pc.[Número_procedimiento]
	WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
)
SELECT
	CAST('Agent' AS VARCHAR(255)) AS FromNodesetType
	,CAST('Proveedor' AS VARCHAR(255)) AS FromNodeset
	,CAST(a.ProveedorId AS VARCHAR(255)) AS FromProveedorId
	,CAST('Agent' AS VARCHAR(255)) AS ToNodesetType
	,CAST('Proveedor' AS VARCHAR(255)) AS ToNodeset
	,CAST(b.ProveedorId AS VARCHAR(255)) AS ToProveedorId
	,CAST(1 AS VARCHAR(255)) As LinkValue
	,CAST('Participaciones' AS VARCHAR(255)) AS NetworkId
	,CAST(a.ProcedimientoId AS VARCHAR(255)) AS ProcedimientoId
FROM cte AS a 
LEFT OUTER JOIN cte AS b ON a.ProcedimientoId = b.ProcedimientoId
WHERE a.ProveedorId <> b.ProveedorId



	----SELECT 
	----	[provider_id] AS ProveedorId
	----	,[procedure_num] AS ProcedimientoId 
	----FROM [cleandata].[sicop_procedure_participations_per_provider] AS ppp
	----INNER JOIN [cleandata].[sicop_procedure_contract] AS pc ON ppp.[procedure_num] = pc.[Número_procedimiento]
	----WHERE [Institución] IN ('MINISTERIO DE OBRAS PUBLICAS Y TRANSPORTES', 'Consejo Nacional de Vialidad')
	----AND procedure_num = '2016CD-000001-0006000001'