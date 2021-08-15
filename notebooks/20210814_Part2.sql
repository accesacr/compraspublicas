



SELECT
*
FROM cleandata.sicop_procedure AS p
WHERE Número_procedimiento = '2019CD-000045-0015700001'




SELECT
*
FROM cleandata.sicop_procedure_contract
WHERE Número_procedimiento = '2019CD-000045-0015700001'

SELECT
*
FROM [cleandata].[sicop_procedure_expedient_contract] AS pec
WHERE procedure_num = '2019CD-000045-0015700001'


SELECT
*
FROM [cleandata].[sicop_procedure_expedient_contract_request] AS pecr
WHERE procedure_num = '2019CD-000045-0015700001'