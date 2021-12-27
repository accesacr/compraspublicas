SELECT 
 top 10 * 
FROM [cleandata].[sicop_procedure_expedient_contract] 


SELECT 
 estado_contrato, count(distinct num_contrato) AS num
FROM [cleandata].[sicop_procedure_expedient_contract] 
--WHERE estado_contrato LIKE '%modificación%'
GROUP BY estado_contrato
ORDER BY count(*) DESC


SELECT 
 count(distinct num_contrato) AS num
FROM [cleandata].[sicop_procedure_expedient_contract] 

-- 112358

SELECT 
 num_contrato
FROM [cleandata].[sicop_procedure_expedient_contract] 
GROUP BY num_contrato
HAVING count(*) > 1
15567


;WITH cte AS (
	SELECT 
	 num_contrato
	FROM [cleandata].[sicop_procedure_expedient_contract] 
	GROUP BY num_contrato
	HAVING count(*) > 1
)
SELECT 
	  estado_contrato, count(*) AS numCon
	FROM [cleandata].[sicop_procedure_expedient_contract] AS ec
	WHERE ec.num_contrato IN (SELECT num_contrato FROM cte)
	GROUP BY estado_contrato
	--ORDER BY num_contrato




SELECT 
 count(distinct num_contrato) AS numContrato,
 count(*) AS num
FROM [cleandata].[sicop_procedure_expedient_contract] 
WHERE estado_contrato = 'Solicitud de modificación de contrato notificado'



11612

;WITH cte AS (
	SELECT 
	 procedure_num
	 --, num_contrato
	FROM [cleandata].[sicop_procedure_expedient_contract] 
	WHERE estado_contrato = 'Solicitud de modificación de contrato notificado'
	GROUP BY procedure_num
	--HAVING count(*) > 1
)
SELECT 
	  *
	FROM [cleandata].[sicop_procedure_expedient_contract] AS ec
	WHERE ec.procedure_num IN (SELECT procedure_num FROM cte)
	--AND ec.num_contrato IN (SELECT num_contrato FROM cte)
ORDER BY procedure_num, num_contrato



;WITH cte AS (
	SELECT 
	 procedure_num, num_contrato
	FROM [cleandata].[sicop_procedure_expedient_contract] 
	WHERE estado_contrato = 'Solicitud de modificación de contrato notificado'
	GROUP BY procedure_num, num_contrato
	HAVING count(*) > 1
)
SELECT 
	  *
	FROM [cleandata].[sicop_procedure_expedient_contract] AS ec
	WHERE ec.procedure_num IN (SELECT procedure_num FROM cte)
	AND ec.num_contrato IN (SELECT num_contrato FROM cte)
ORDER BY procedure_num, num_contrato


SELECT 
 count(distinct num_contrato) AS numContrato,
 count(*) AS num
FROM [cleandata].[sicop_procedure_expedient_contract] 
WHERE estado_contrato = 'Solicitud de modificación de contrato notificado'