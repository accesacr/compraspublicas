


--ALTER TABLE [cleandata].[sicop_procedure_participations_per_provider] ADD PartFromLocalProv INT NULL
--ALTER TABLE [cleandata].[sicop_procedure_participations_per_provider] ADD PartFromSemiLocalProv INT NULL


--UPDATE p
--	SET p.PartFromLocalProv = 0
--FROM cleandata.sicop_procedure_participations_per_provider AS p


--UPDATE p
--	SET p.PartFromSemiLocalProv = 0
--FROM cleandata.[sicop_procedure_participations_per_provider] AS p




;WITH cte_part_x_canton AS (
	SELECT
		DISTINCT 
			p.Número_procedimiento
			,part.provider_id
			,CONVERT(INT, LEFT(prov.CodigoPostalDistrito_DesdeInferencias, 3)) AS ProveedorCantonId
	FROM [cleandata].[sicop_procedure] AS p
	INNER JOIN [cleandata].sicop_procedure_participations_per_provider AS part ON p.Número_procedimiento = part.procedure_num
	INNER JOIN cleandata.sicop_provider AS prov ON part.provider_id = prov.Cedula
	WHERE ISNUMERIC(LTRIM(RTRIM(CodigoPostalDistrito_DesdeInferencias))) = 1
)
UPDATE part
--SELECT
	--DISTINCT
	--	p.Número_procedimiento
	SET part.PartFromLocalProv = 1
FROM [cleandata].sicop_procedure_participations_per_provider AS part
INNER JOIN [cleandata].[sicop_procedure] AS p ON part.procedure_num = p.Número_procedimiento
INNER JOIN [rawdata].[sicop_institucion_canton] AS pin ON p.Institución = pin.Institución
INNER JOIN cte_part_x_canton AS cte 
	ON cte.Número_procedimiento = p.Número_procedimiento 
	AND cte.provider_id = part.provider_id 
	AND pin.CantonId = cte.ProveedorCantonId







;WITH cte_part_x_canton AS (
	SELECT
		DISTINCT 
			p.Número_procedimiento
			,part.provider_id
			,CONVERT(INT, LEFT(prov.CodigoPostalDistrito_DesdeInferencias, 1)) AS ProveedorProvinciaId
	FROM [cleandata].[sicop_procedure] AS p
	INNER JOIN [cleandata].sicop_procedure_participations_per_provider AS part ON p.Número_procedimiento = part.procedure_num
	INNER JOIN cleandata.sicop_provider AS prov ON part.provider_id = prov.Cedula
	WHERE ISNUMERIC(LTRIM(RTRIM(CodigoPostalDistrito_DesdeInferencias))) = 1
)
UPDATE part
--SELECT
	--DISTINCT
	--	p.Número_procedimiento
	SET part.PartFromSemiLocalProv = 1
FROM [cleandata].sicop_procedure_participations_per_provider AS part
INNER JOIN [cleandata].[sicop_procedure] AS p ON part.procedure_num = p.Número_procedimiento
INNER JOIN [rawdata].[sicop_institucion_canton] AS pin ON p.Institución = pin.Institución
INNER JOIN cte_part_x_canton AS cte 
	ON cte.Número_procedimiento = p.Número_procedimiento 
	AND cte.provider_id = part.provider_id 
	AND LEFT(pin.CantonId,1) = cte.ProveedorProvinciaId

