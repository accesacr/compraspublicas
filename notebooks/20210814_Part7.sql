SELECT 
 estado_contrato, count(distinct procedure_num) AS num
FROM [cleandata].[sicop_procedure_expedient_contract] 
--WHERE estado_contrato LIKE '%modificaci�n%'
GROUP BY estado_contrato
ORDER BY count(*) DESC

SELECT 
 count(distinct procedure_num) AS num
FROM [cleandata].[sicop_procedure_expedient_contract] 

