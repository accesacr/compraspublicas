


--ALTER TABLE [cleandata].[sicop_procedure_contract] ADD ContHasLocalProv INT NULL
--ALTER TABLE [cleandata].[sicop_procedure_contract] ADD ContHasSemiLocalProv INT NULL


----UPDATE p
----	SET p.ContHasLocalProv = 0
----FROM cleandata.sicop_procedure_contract AS p





--;WITH cte_cont_x_canton AS (
--	SELECT
--		DISTINCT 
--			pc.N�mero_procedimiento
--			,pc.[N�mero_contrato]
--			,CONVERT(INT, LEFT(prov.CodigoPostalDistrito_DesdeInferencias, 3)) AS ProveedorCantonId
--	FROM [cleandata].[sicop_procedure_contract] AS pc
--	INNER JOIN cleandata.sicop_provider AS prov ON pc.C�dula_adjudicatario = prov.Cedula
--	WHERE ISNUMERIC(LTRIM(RTRIM(CodigoPostalDistrito_DesdeInferencias))) = 1
--)
--UPDATE pc
----SELECT
--	--DISTINCT
--	--	p.N�mero_procedimiento
--	SET pc.ContHasLocalProv = 1
--FROM cleandata.[sicop_procedure_contract] AS pc
--INNER JOIN [rawdata].[sicop_institucion_canton] AS pin ON pc.Instituci�n = pin.Instituci�n
--INNER JOIN cte_cont_x_canton AS cte 
--	ON cte.N�mero_procedimiento = pc.N�mero_procedimiento 
--	AND cte.[N�mero_contrato] = pc.[N�mero_contrato] 
--	AND pin.CantonId = cte.ProveedorCantonId




---
--UPDATE p
--	SET p.ContHasSemiLocalProv = 0
--FROM cleandata.[sicop_procedure_contract] AS p


;WITH cte_cont_x_prov AS (
	SELECT
		DISTINCT 
			pc.N�mero_procedimiento
			,pc.[N�mero_contrato]
			,CONVERT(INT, LEFT(prov.CodigoPostalDistrito_DesdeInferencias, 1)) AS ProveedorProvinciaId
	FROM [cleandata].[sicop_procedure_contract] AS pc
	INNER JOIN cleandata.sicop_provider AS prov ON pc.C�dula_adjudicatario = prov.Cedula
	WHERE ISNUMERIC(LTRIM(RTRIM(CodigoPostalDistrito_DesdeInferencias))) = 1
)
UPDATE pc
	SET pc.ContHasSemiLocalProv = 1
--SELECT
--	DISTINCT
--		p.N�mero_procedimiento
	
FROM cleandata.[sicop_procedure_contract] AS pc
INNER JOIN [rawdata].[sicop_institucion_canton] AS pin ON pc.Instituci�n = pin.Instituci�n
INNER JOIN cte_cont_x_prov AS cte 
	ON cte.N�mero_procedimiento = pc.N�mero_procedimiento 
	AND cte.[N�mero_contrato] = pc.[N�mero_contrato]
	AND LEFT(pin.CantonId,1) = cte.ProveedorProvinciaId
