SELECT
 DISTINCT 
	CONVERT(VARCHAR(MAX), [procedure_num]) AS [procedure_num]
	,CONVERT(VARCHAR(MAX), [parsed_num_solicitud_contratacion]) AS [parsed_num_solicitud_contratacion]
	,CONVERT(VARCHAR(MAX), [parsed_num_cartel]) AS [parsed_num_cartel]
FROM [rawdata].[sicop_procedures_expedients]




SELECT 
	   CONVERT(VARCHAR(MAX), [procedure_num]                               ) AS [procedure_num]
      ,CONVERT(VARCHAR(MAX), [institution_name]						    ) AS [institution_name]
      ,CONVERT(VARCHAR(MAX), [description]							    ) AS [description]
      ,CONVERT(VARCHAR(MAX), [contract_request_num]					    ) AS [contract_request_num]
      ,CONVERT(VARCHAR(MAX), [request_datetime]						    ) AS [request_datetime]
      ,CONVERT(VARCHAR(MAX), [response_onclick_attribute]				    ) AS [response_onclick_attribute]
      ,CONVERT(VARCHAR(MAX), [parsed_num_solicitud_contratacion]		    ) AS [parsed_num_solicitud_contratacion]
      ,CONVERT(VARCHAR(MAX), [parsed_num_cartel]						    ) AS [parsed_num_cartel]
	  INTO cleandata.sicop_procedure_expedient
  FROM [rawdata].[sicop_procedures_expedients]
GO



