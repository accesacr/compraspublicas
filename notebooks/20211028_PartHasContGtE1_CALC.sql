

-- ALTER TABLE [cleandata].[sicop_procedure_participations_per_provider] ADD PartHasContGtE1 INT

--UPDATE p
--	SET p.PartHasContGtE1 = 0
--FROM [cleandata].[sicop_procedure_participations_per_provider] AS p

;WITH cte_cont AS (
	SELECT
		DISTINCT 
			[Número_procedimiento] AS procedure_num
			,[Cédula_adjudicatario] AS provider_id
	FROM [cleandata].[sicop_procedure_contract]
)

UPDATE part
	SET part.PartHasContGtE1 = 1
FROM [cleandata].[sicop_procedure_participations_per_provider] AS part
INNER JOIN cte_cont AS c ON part.procedure_num = c.procedure_num AND part.provider_id = c.provider_id
