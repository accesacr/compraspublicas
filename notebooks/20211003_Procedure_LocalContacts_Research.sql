


--ALTER TABLE [cleandata].[sicop_procedure] ADD ProcHasLocalContGtE1 INT NULL
--ALTER TABLE [cleandata].[sicop_procedure] ADD ProcHasSemiLocalContGtE1 INT NULL



------UPDATE p
------	SET p.ProcHasLocalContGtE1 = 0
------FROM cleandata.sicop_procedure AS p


------;WITH cte_cont_x_canton AS (
------	SELECT
------		DISTINCT 
------			pc.Número_procedimiento
------			,CONVERT(INT, LEFT(prov.CodigoPostalDistrito_DesdeInferencias, 3)) AS ProveedorCantonId
------	FROM [cleandata].[sicop_procedure_contract] AS pc
------	INNER JOIN cleandata.sicop_provider AS prov ON pc.Cédula_adjudicatario = prov.Cedula
------	WHERE ISNUMERIC(LTRIM(RTRIM(CodigoPostalDistrito_DesdeInferencias))) = 1
------)
------UPDATE p
--------SELECT
------	--DISTINCT
------	--	p.Número_procedimiento
------	SET p.ProcHasLocalContGtE1 = 1
------FROM cleandata.sicop_procedure AS p
------INNER JOIN [rawdata].[sicop_institucion_canton] AS pin ON p.Institución = pin.Institución
------INNER JOIN cte_cont_x_canton AS cte ON cte.Número_procedimiento = p.Número_procedimiento AND pin.CantonId = cte.ProveedorCantonId




---------
------UPDATE p
------	SET p.ProcHasSemiLocalContGtE1 = 0
------FROM cleandata.sicop_procedure AS p


------;WITH cte_cont_x_prov AS (
------	SELECT
------		DISTINCT 
------			pc.Número_procedimiento
------			,CONVERT(INT, LEFT(prov.CodigoPostalDistrito_DesdeInferencias, 1)) AS ProveedorProvinciaId
------	FROM [cleandata].[sicop_procedure_contract] AS pc
------	INNER JOIN cleandata.sicop_provider AS prov ON pc.Cédula_adjudicatario = prov.Cedula
------	WHERE ISNUMERIC(LTRIM(RTRIM(CodigoPostalDistrito_DesdeInferencias))) = 1
------)
------UPDATE p
------	SET p.ProcHasSemiLocalContGtE1 = 1
--------SELECT
--------	DISTINCT
--------		p.Número_procedimiento
	
------FROM cleandata.sicop_procedure AS p
------INNER JOIN [rawdata].[sicop_institucion_canton] AS pin ON p.Institución = pin.Institución
------INNER JOIN cte_cont_x_prov AS cte ON cte.Número_procedimiento = p.Número_procedimiento AND LEFT(pin.CantonId,1) = cte.ProveedorProvinciaId




;WITH cte AS (
	SELECT
		DISTINCT 
			p.[Número_procedimiento]
			,p.[Institución]
			,p.[Tipo_modalidad]
			,p.[Tipo_Procedimiento]
			,p.[Descripción]
			
			,pc.[Número_contrato]
			,pc.[Cédula_adjudicatario]
			,pc.[Moneda]
			,pc.[Monto]
			,pc.[Calc_Monto_Redondeado]

			,pv.[Nacionalidad]
			,pv.[Nombre del Proveedor]
			,pv.[Tipo]
			,pv.[Direccion]
			,pv.[CodigoPostalDistrito_DesdeInferencias]
			,pv.[Distrito_InferidoDeDireccion]
			,pv.[Canton_InferidoDeDireccion]
			,pv.[Provincia_InferidoDeDireccion]


			,LEFT(pcm.category_id, 4) As cat_id_n2
		
	FROM [cleandata].[sicop_procedure] AS p
	LEFT OUTER JOIN [cleandata].[sicop_procedure_contract] AS pc ON p.Número_procedimiento = pc.Número_procedimiento
	LEFT OUTER JOIN [cleandata].[sicop_provider] AS pv ON pc.Cédula_adjudicatario = pv.Cedula -- 123 881
	LEFT OUTER JOIN [cleandata].[sicop_procedure_categorylevel4_map] AS pcm ON p.Número_procedimiento = pcm.procedure_num -- 615 541
	--LEFT OUTER JOIN [cleandata].[sicop_categorylevel4] AS c4 ON pcm.category_id = c4.category_id
	--LEFT OUTER JOIN [cleandata].[sicop_categorylevel3] AS c3 ON LEFT(pcm.category_id, 6) = c3.category_id
	--LEFT OUTER JOIN [cleandata].[sicop_categorylevel2] AS c2 ON LEFT(pcm.category_id, 4) = c2.category_id
	--LEFT OUTER JOIN [cleandata].[sicop_categorylevel1] AS c1 ON LEFT(pcm.category_id, 2) = c1.category_id
)
SELECT *
FROM cte
--LEFT OUTER JOIN [cleandata].[sicop_categorylevel3] AS c3 ON cte.cat_id_n3 = c3.category_id
LEFT OUTER JOIN [cleandata].[sicop_categorylevel2] AS c2 ON LEFT(cte.cat_id_n2, 4) = c2.category_id
LEFT OUTER JOIN [cleandata].[sicop_categorylevel1] AS c1 ON LEFT(cte.cat_id_n2, 2) = c1.category_id


--INNER JOIN [rawdata].[sicop_institucion_canton] AS pin ON p.Institución = pin.Institución
--INNER JOIN [dbo].[DistritosIDS2017_Consolidados] AS d ON pin.CantonId = CONVERT(INT, d.[Código Postal Cantón])


-- ProcNum, CatNum
ProcN1, Cont1, Cat1, 100, 1
ProcN1, Cont2, Cat1, 100, 1
ProcN1, Cont1, Cat2, 100, 1
ProcN1, Cont2, Cat2, 100, 1
ProcN1, Cont1, Cat3, 100, 1
ProcN1, Cont2, Cat3, 100, 1





