
;WITH cte_control AS (
	SELECT DISTINCT 
		Número_procedimiento AS procedure_num
	FROM cleandata.sicop_procedure AS p
)
,
cte_evaluated AS (
	SELECT DISTINCT
		p.[param_sch_instNo] AS procedure_num
	FROM cleandata.sicop_procedure_expedient_contract_request AS p
)
SELECT
 procedure_num
FROM cte_control
EXCEPT
SELECT
 procedure_num
FROM cte_evaluated



SELECT *
		
	FROM cleandata.sicop_procedure AS p
WHERE Número_procedimiento = '2015CD-000030-0005800001'


SELECT *
		
	FROM cleandata.sicop_procedure_contract AS p
WHERE Número_procedimiento = '2015CD-000030-0005800001'

	SELECT *
		
	FROM cleandata.sicop_procedure_expedient_contract AS p
	WHERE p.procedure_num = '2015CD-000030-0005800001'


	SELECT *
		
	FROM cleandata.sicop_procedure_expedient_contract_request AS p
	WHERE p.procedure_num = '2015CD-000030-0005800001'


	------------
SELECT *
		
	FROM cleandata.sicop_procedure AS p
WHERE Número_procedimiento = '2014CD-000051-0005400001'


SELECT *
		
	FROM cleandata.sicop_procedure_contract AS p
WHERE Número_procedimiento = '2014CD-000051-0005400001'

	SELECT *
		
	FROM cleandata.sicop_procedure_expedient_contract AS p
	WHERE p.procedure_num = '2014CD-000051-0005400001'


	SELECT *
		
	FROM cleandata.sicop_procedure_expedient_contract_request AS p
	WHERE p.procedure_num = '2014CD-000051-0005400001'




	'2015CD-000030-0005800001'




		SELECT 
		top 10000 
		 *
	FROM cleandata.sicop_procedure_expedient_contract_request AS p



	ALTER TABLE cleandata.sicop_procedure_expedient_contract ADD calc_moneda_contrato VARCHAR(MAX) NULL
	ALTER TABLE cleandata.sicop_procedure_expedient_contract ADD calc_monto VARCHAR(MAX) NULL

	 UPDATE p
	 SET calc_moneda_contrato = COALESCE(LEFT(monto_contrato, 3), ('Desconocido'))
	 FROM cleandata.sicop_procedure_expedient_contract AS p


	  UPDATE p
	 SET calc_monto = REPLACE(RIGHT(monto_contrato, LEN(monto_contrato) -4), '.','')
	 FROM cleandata.sicop_procedure_expedient_contract AS p
