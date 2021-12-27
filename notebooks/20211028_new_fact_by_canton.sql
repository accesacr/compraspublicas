
--CREATE SCHEMA aggdata AUTHORIZATION dbo;

;WITH cte_can_x_catn2 AS (
	SELECT
		[Código] AS CantonId
		,[Cantón] AS [Nombre Cantón]
		,[IDS_2017] AS [Nota IDS 2017]
		,c2.[category_id] AS CategoriaN2Id
	INTO aggdata.can_x_catn2
	FROM [rawdata].[cantones_ids17] AS can
	CROSS JOIN [cleandata].[sicop_categorylevel2] AS c2
)
,cte_reg_x_can_x_catn2 AS (
	SELECT
		LEFT(p.CodigoPostalDistrito_DesdeInferencias, 3) AS CantonId
		,LEFT(c4.[category_id], 4) AS CategoriaN2Id
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Grande' THEN p.Cedula ELSE NULL END) AS NumProvGrandes
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Mediana' THEN p.Cedula ELSE NULL END) AS NumProvMedianos
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Pequena' THEN p.Cedula ELSE NULL END) AS NumProvPequeños
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Micro Emprendor' THEN p.Cedula ELSE NULL END) AS NumProvMicro
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = '(desconocido)' THEN p.Cedula ELSE NULL END) AS NumProvDesconocidos
		,COUNT(DISTINCT p.Cedula) AS NumProvTotales
	INTO aggdata.reg_x_can_x_catn2
	FROM [cleandata].[sicop_provider] AS p
	INNER JOIN [cleandata].[sicop_provider_categorylevel4_map] AS c4 ON p.Cedula = c4.provider_id
	WHERE ISNUMERIC(LTRIM(RTRIM(p.CodigoPostalDistrito_DesdeInferencias))) = 1
	GROUP BY LEFT(p.CodigoPostalDistrito_DesdeInferencias, 3), LEFT(c4.[category_id], 4)
)
,cte_cont_x_can_x_catn2 AS (
	SELECT
		ic.CantonId
		,LEFT(c4.category_id, 4) AS CategoriaN2Id
		,COUNT(DISTINCT pc.Número_procedimiento) AS NumProcTotales
		
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Grande' THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumContProvGrandes
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Mediana' THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumContProvMedianos
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Pequena' THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumContProvPequeños
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Micro Emprendor' THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumContProvMicro
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = '(desconocido)' THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumContProvDesconocidos
		,COUNT(DISTINCT pc.Número_procedimiento + '|' + pc.Número_contrato) AS NumContTotales
		
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Grande' AND pc.[ContHasLocalProv] = 1 THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumLocalContProvGrandes
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Mediana' AND pc.[ContHasLocalProv] = 1 THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumLocalContProvMedianos
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Pequena' AND pc.[ContHasLocalProv] = 1 THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumLocalContProvPequeños
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = 'Micro Emprendor' AND pc.[ContHasLocalProv] = 1 THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumLocalContProvMicro
		,COUNT(DISTINCT CASE WHEN p.[Tipo] = '(desconocido)' AND pc.[ContHasLocalProv] = 1 THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumLocalContProvDesconocidos
		,COUNT(DISTINCT CASE WHEN pc.[ContHasLocalProv] = 1 THEN pc.Número_procedimiento + '|' + pc.Número_contrato ELSE NULL END) AS NumLocalContTotales
	INTO aggdata.cont_x_can_x_catn2
	FROM [cleandata].[sicop_procedure_contract] AS pc
	INNER JOIN [cleandata].[sicop_provider] AS p ON pc.Cédula_adjudicatario = p.Cedula
	INNER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS c4 ON pc.Número_procedimiento = c4.procedure_num
	INNER JOIN [rawdata].[sicop_institucion_canton] AS ic ON pc.Institución = ic.Institución
	GROUP BY ic.CantonId, LEFT(c4.category_id, 4)
)
,cte_part_x_can_x_catn2 AS (
	SELECT
		ic.CantonId
		,LEFT(c4.category_id, 4) AS CategoriaN2Id

		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Grande' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartProvGrandes
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Mediana' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartProvMedianos
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Pequena' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartProvPequeños
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Micro Emprendor' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartProvMicro
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = '(desconocido)' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartProvDesconocidos
		,COUNT(DISTINCT pa.[procedure_num] + '|' + pa.[provider_id]) AS NumPartTotales
		
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Grande' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartProvGrandes
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Mediana' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartProvMedianos
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Pequena' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartProvPequeños
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = 'Micro Emprendor' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartProvMicro
		,COUNT(DISTINCT CASE WHEN pv.[Tipo] = '(desconocido)' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartDesconocidos
		,COUNT(DISTINCT CASE WHEN pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartTotales


		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Grande' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartHasContGtE1ProvGrandes
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Mediana' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartHasContGtE1ProvMedianos
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Pequena' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartHasContGtE1ProvPequeños
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Micro Emprendor' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartHasContGtE1ProvMicro
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = '(desconocido)' THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartHasContGtE1ProvDesconocidos
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumPartHasContGtE1Totales
		
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Grande' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartHasContGtE1ProvGrandes
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Mediana' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartHasContGtE1ProvMedianos
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Pequena' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartHasContGtE1ProvPequeños
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = 'Micro Emprendor' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartHasContGtE1ProvMicro
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pv.[Tipo] = '(desconocido)' AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartHasContGtE1Desconocidos
		,COUNT(DISTINCT CASE WHEN pa.PartHasContGtE1 = 1 AND pa.[PartFromLocalProv] = 1 THEN pa.[procedure_num] + '|' + pa.[provider_id] ELSE NULL END) AS NumLocalPartHasContGtE1Totales


	INTO aggdata.part_x_can_x_catn2	
	FROM [cleandata].[sicop_procedure] AS po
	INNER JOIN [cleandata].[sicop_procedure_participations_per_provider] AS pa ON po.Número_procedimiento = pa.procedure_num
	INNER JOIN [cleandata].[sicop_provider] AS pv ON pa.provider_id = pv.Cedula
	INNER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS c4 ON po.Número_procedimiento = c4.procedure_num
	INNER JOIN [rawdata].[sicop_institucion_canton] AS ic ON po.Institución = ic.Institución
	GROUP BY ic.CantonId, LEFT(c4.category_id, 4)
)
SELECT
	can_c2.CantonId
	,can_c2.CategoriaN2Id
	,can_c2.[Nombre Cantón]
	,can_c2.[Nota IDS 2017]

	,reg.NumProvGrandes
	,reg.NumProvMedianos
	,reg.NumProvPequeños
	,reg.NumProvMicro
	,reg.NumProvDesconocidos
	,reg.NumProvTotales

	,cont.NumProcTotales
	,cont.NumContProvGrandes
	,cont.NumContProvMedianos
	,cont.NumContProvPequeños
	,cont.NumContProvMicro
	,cont.NumContProvDesconocidos
	,cont.NumContTotales
	,cont.NumLocalContProvGrandes
	,cont.NumLocalContProvMedianos
	,cont.NumLocalContProvPequeños
	,cont.NumLocalContProvMicro
	,cont.NumLocalContProvDesconocidos
	,cont.NumLocalContTotales
		
	,part.NumPartProvGrandes
	,part.NumPartProvMedianos
	,part.NumPartProvPequeños
	,part.NumPartProvMicro
	,part.NumPartProvDesconocidos
	,part.NumPartTotales
	,part.NumLocalPartProvGrandes
	,part.NumLocalPartProvMedianos
	,part.NumLocalPartProvPequeños
	,part.NumLocalPartProvMicro
	,part.NumLocalPartDesconocidos
	,part.NumLocalPartTotales

	,part.NumPartHasContGtE1ProvGrandes
	,part.NumPartHasContGtE1ProvMedianos
	,part.NumPartHasContGtE1ProvPequeños
	,part.NumPartHasContGtE1ProvMicro
	,part.NumPartHasContGtE1ProvDesconocidos
	,part.NumPartHasContGtE1Totales
	,part.NumLocalPartHasContGtE1ProvGrandes
	,part.NumLocalPartHasContGtE1ProvMedianos
	,part.NumLocalPartHasContGtE1ProvPequeños
	,part.NumLocalPartHasContGtE1ProvMicro
	,part.NumLocalPartHasContGtE1Desconocidos
	,part.NumLocalPartHasContGtE1Totales
INTO aggdata.fct_can_x_catn2
FROM aggdata.can_x_catn2 AS can_c2
LEFT OUTER JOIN aggdata.reg_x_can_x_catn2 AS reg ON can_c2.CantonId = reg.CantonId AND can_c2.CategoriaN2Id = reg.CategoriaN2Id
LEFT OUTER JOIN aggdata.cont_x_can_x_catn2 AS cont ON can_c2.CantonId = cont.CantonId AND can_c2.CategoriaN2Id = cont.CategoriaN2Id
LEFT OUTER JOIN aggdata.part_x_can_x_catn2 AS part ON can_c2.CantonId = part.CantonId AND can_c2.CategoriaN2Id = part.CategoriaN2Id





SELECT
	 CAST(CantonId								AS VARCHAR(MAX)) AS CantonId								
	,CAST(CategoriaN2Id							AS VARCHAR(MAX)) AS CategoriaN2Id							
	,CAST([Nombre Cantón]						AS VARCHAR(MAX)) AS [Nombre Cantón]						
	,CAST([Nota IDS 2017]						AS VARCHAR(MAX)) AS [Nota IDS 2017]						
	,CAST(COALESCE(NumProvGrandes						, 0) AS VARCHAR(MAX)) AS NumProvGrandes						
	,CAST(COALESCE(NumProvMedianos						, 0) AS VARCHAR(MAX)) AS NumProvMedianos						
	,CAST(COALESCE(NumProvPequeños						, 0) AS VARCHAR(MAX)) AS NumProvPequeños						
	,CAST(COALESCE(NumProvMicro							, 0) AS VARCHAR(MAX)) AS NumProvMicro							
	,CAST(COALESCE(NumProvDesconocidos					, 0) AS VARCHAR(MAX)) AS NumProvDesconocidos					
	,CAST(COALESCE(NumProvTotales						, 0) AS VARCHAR(MAX)) AS NumProvTotales						
	,CAST(COALESCE(NumProcTotales						, 0) AS VARCHAR(MAX)) AS NumProcTotales						
	,CAST(COALESCE(NumContProvGrandes					, 0) AS VARCHAR(MAX)) AS NumContProvGrandes					
	,CAST(COALESCE(NumContProvMedianos					, 0) AS VARCHAR(MAX)) AS NumContProvMedianos					
	,CAST(COALESCE(NumContProvPequeños					, 0) AS VARCHAR(MAX)) AS NumContProvPequeños					
	,CAST(COALESCE(NumContProvMicro						, 0) AS VARCHAR(MAX)) AS NumContProvMicro						
	,CAST(COALESCE(NumContProvDesconocidos				, 0) AS VARCHAR(MAX)) AS NumContProvDesconocidos				
	,CAST(COALESCE(NumContTotales						, 0) AS VARCHAR(MAX)) AS NumContTotales						
	,CAST(COALESCE(NumLocalContProvGrandes				, 0) AS VARCHAR(MAX)) AS NumLocalContProvGrandes				
	,CAST(COALESCE(NumLocalContProvMedianos				, 0) AS VARCHAR(MAX)) AS NumLocalContProvMedianos				
	,CAST(COALESCE(NumLocalContProvPequeños				, 0) AS VARCHAR(MAX)) AS NumLocalContProvPequeños				
	,CAST(COALESCE(NumLocalContProvMicro				, 0) 	AS VARCHAR(MAX)) AS NumLocalContProvMicro					
	,CAST(COALESCE(NumLocalContProvDesconocidos			, 0) AS VARCHAR(MAX)) AS NumLocalContProvDesconocidos			
	,CAST(COALESCE(NumLocalContTotales					, 0) AS VARCHAR(MAX)) AS NumLocalContTotales					
	,CAST(COALESCE(NumPartProvGrandes					, 0) AS VARCHAR(MAX)) AS NumPartProvGrandes					
	,CAST(COALESCE(NumPartProvMedianos					, 0) AS VARCHAR(MAX)) AS NumPartProvMedianos					
	,CAST(COALESCE(NumPartProvPequeños					, 0) AS VARCHAR(MAX)) AS NumPartProvPequeños					
	,CAST(COALESCE(NumPartProvMicro						, 0) AS VARCHAR(MAX)) AS NumPartProvMicro						
	,CAST(COALESCE(NumPartProvDesconocidos				, 0) AS VARCHAR(MAX)) AS NumPartProvDesconocidos				
	,CAST(COALESCE(NumPartTotales						, 0) AS VARCHAR(MAX)) AS NumPartTotales						
	,CAST(COALESCE(NumLocalPartProvGrandes				, 0) AS VARCHAR(MAX)) AS NumLocalPartProvGrandes				
	,CAST(COALESCE(NumLocalPartProvMedianos				, 0) AS VARCHAR(MAX)) AS NumLocalPartProvMedianos				
	,CAST(COALESCE(NumLocalPartProvPequeños				, 0) AS VARCHAR(MAX)) AS NumLocalPartProvPequeños				
	,CAST(COALESCE(NumLocalPartProvMicro				, 0) 	AS VARCHAR(MAX)) AS NumLocalPartProvMicro					
	,CAST(COALESCE(NumLocalPartDesconocidos				, 0) AS VARCHAR(MAX)) AS NumLocalPartDesconocidos				
	,CAST(COALESCE(NumLocalPartTotales					, 0) AS VARCHAR(MAX)) AS NumLocalPartTotales					
	,CAST(COALESCE(NumPartHasContGtE1ProvGrandes		, 0) 	AS VARCHAR(MAX)) AS NumPartHasContGtE1ProvGrandes			
	,CAST(COALESCE(NumPartHasContGtE1ProvMedianos		, 0) AS VARCHAR(MAX)) AS NumPartHasContGtE1ProvMedianos		
	,CAST(COALESCE(NumPartHasContGtE1ProvPequeños		, 0) AS VARCHAR(MAX)) AS NumPartHasContGtE1ProvPequeños		
	,CAST(COALESCE(NumPartHasContGtE1ProvMicro			, 0) AS VARCHAR(MAX)) AS NumPartHasContGtE1ProvMicro			
	,CAST(COALESCE(NumPartHasContGtE1ProvDesconocidos	, 0) AS VARCHAR(MAX)) AS NumPartHasContGtE1ProvDesconocidos	
	,CAST(COALESCE(NumPartHasContGtE1Totales			, 0) 	AS VARCHAR(MAX)) AS NumPartHasContGtE1Totales				
	,CAST(COALESCE(NumLocalPartHasContGtE1ProvGrandes	, 0) AS VARCHAR(MAX)) AS NumLocalPartHasContGtE1ProvGrandes	
	,CAST(COALESCE(NumLocalPartHasContGtE1ProvMedianos	, 0) AS VARCHAR(MAX)) AS NumLocalPartHasContGtE1ProvMedianos	
	,CAST(COALESCE(NumLocalPartHasContGtE1ProvPequeños	, 0) AS VARCHAR(MAX)) AS NumLocalPartHasContGtE1ProvPequeños	
	,CAST(COALESCE(NumLocalPartHasContGtE1ProvMicro		, 0) AS VARCHAR(MAX)) AS NumLocalPartHasContGtE1ProvMicro		
	,CAST(COALESCE(NumLocalPartHasContGtE1Desconocidos	, 0) AS VARCHAR(MAX)) AS NumLocalPartHasContGtE1Desconocidos	
	,CAST(COALESCE(NumLocalPartHasContGtE1Totales		, 0) AS VARCHAR(MAX)) AS NumLocalPartHasContGtE1Totales		
FROM aggdata.fct_can_x_catn2



--SELECT DISTINCT
--	 CantonId								
--	,CategoriaN2Id	
--FROM aggdata.fct_can_x_catn2