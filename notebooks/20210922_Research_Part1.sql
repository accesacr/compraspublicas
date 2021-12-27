


;WITH cte_cl1_map AS (
	SELECT
		DISTINCT
			LEFT([category_id], 2) AS [category_id]
			,[procedure_num]
	FROM [cleandata].[sicop_procedure_categorylevel4_map]
)
--,cte_inst AS (

--	SELECT
--		DISTINCT 
--			[N�mero_procedimiento]
--			,[Instituci�n]
--	FROM [cleandata].[sicop_procedure_contract]
--)
SELECT
	*
FROM [cleandata].[sicop_categorylevel1] As cl1
LEFT OUTER JOIN cte_cl1_map AS cl1_map ON cl1.category_id = cl1_map.category_id
LEFT OUTER JOIN [cleandata].[sicop_procedure] AS p ON cl1_map.procedure_num = [N�mero_procedimiento]
--LEFT OUTER JOIN cte_inst AS inst ON cl1_map.procedure_num = inst.[N�mero_procedimiento]
LEFT OUTER JOIN [cleandata].[sicop_procedure_participations_per_provider] AS pp ON cl1_map.procedure_num = pp.[procedure_num]
WHERE cl1.[category_name] IN (
	'Accesorios, suministros y productos electr�nicos de consumo'
	,'Equipo de Laboratorio, Medida, Observaci�n y Comprobaci�n'
	,'Equipo y Suministros de limpieza'
	,'Equipo, Accesorios y Suministros M�dicos'
	,'Herramientas y Maquinaria en General'
	,'Muebles y mobiliario'
)
AND COALESCE(cl1_map.procedure_num, '') <> ''



SELECT
[N�mero_procedimiento]
FROM [cleandata].[sicop_procedure_contract]
GROUP BY [N�mero_procedimiento]
HAVING COUNT(DISTINCT [Instituci�n]) > 1