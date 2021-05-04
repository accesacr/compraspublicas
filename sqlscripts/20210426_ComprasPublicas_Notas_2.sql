SELECT
	DISTINCT 
		[Número_procedimiento]
		,[Número_contrato]
		,[Cédula_adjudicatario]
		,[Institución]
		,[Fecha_notificación]
		,[Firma_Contrato]
		,[Tipo_modalidad]
		,[Tipo_Procedimiento]
		,[Descripción]
     
		 
      
		 ,[Adjudicatario]
      
      ,[Moneda]
      ,[Monto]
      ,[Modificaciones]
      ,[Vigencia_contrato]
      ,[Clasificación_objeto]
      
      
      --,[Moneda_monto_estimado]
      --,[Monto_estimado]
      ,[Calc_Monto_Redondeado]
      --,[Calc_Monto_Estimado_Redondeado]
	   INTO cleandata.sicop_procedure_contract
  FROM [Export].[AdjudicacionesSICOP]






--SELECT 
--	count(*) as num
--	,count(distinct procedure_num) as proce
--	,count(distinct CONCAT(procedure_num ,'|', category_id)) as proce_cat
--	,count(distinct CONCAT(procedure_num ,'|',  institution_name)) as proce_inst
--	,count(distinct CONCAT(procedure_num ,'|', category_id, '|',  institution_name)) as proce_cat_inst
--	,count(distinct CONCAT(procedure_num ,'|', category_id, '|', num_contract_request)) as proce_cat_req
--	,count(distinct CONCAT(procedure_num ,'|', category_id, '|', num_contract_request, '|', request_date_time)) as proce_cat_req_dat
--	,count(distinct CONCAT(procedure_num ,'|', category_id, '|', num_contract_request, '|', request_date_time, '|', [description])) as proce_cat_req_dat_desc
--FROM [rawdata].[sicop_procedures_per_wgscategory_level4]




SELECT 
	DISTINCT
	--REPLACE(REPLACE(category_id,':', ''), '.', '') AS category_id
	category_id
	,procedure_num
INTO cleandata.sicop_procedure_categorylevel4_map
FROM [rawdata].[sicop_procedures_per_wgscategory_level4]



    SELECT
  DISTINCT *
  INTO cleandata.sicop_provider_categorylevel4_map
    FROM [ComprasPublicas].[rawdata].[sicop_providers_per_wgscategorylevel4]


	  SELECT DISTINCT * 
  INTO cleandata.sicop_provider
  FROM  [Export].[ProveedoresSICOP]


  SELECT DISTINCT * 
  INTO cleandata.sicop_categorylevel4
  FROM [rawdata].[sicop_wgscategories_level4]


    SELECT DISTINCT * 
  INTO cleandata.sicop_categorylevel3
  FROM [rawdata].[sicop_wgscategories_level3]


    SELECT DISTINCT * 
  INTO cleandata.sicop_categorylevel2
  FROM [rawdata].[sicop_wgscategories_level2]


    SELECT DISTINCT * 
  INTO cleandata.sicop_categorylevel1
  FROM [rawdata].[sicop_wgscategories_level1]


