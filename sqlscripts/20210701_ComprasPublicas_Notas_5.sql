--------SELECT
-------- DISTINCT 
--------	CONVERT(VARCHAR(MAX), [procedure_num]) AS [procedure_num]
--------	,CONVERT(VARCHAR(MAX), [parsed_num_solicitud_contratacion]) AS [parsed_num_solicitud_contratacion]
--------	,CONVERT(VARCHAR(MAX), [parsed_num_cartel]) AS [parsed_num_cartel]
--------FROM [rawdata].[sicop_procedures_expedients]




--------SELECT 
--------	   CONVERT(VARCHAR(MAX), [procedure_num]                               ) AS [procedure_num]
--------      ,CONVERT(VARCHAR(MAX), [institution_name]						    ) AS [institution_name]
--------      ,CONVERT(VARCHAR(MAX), [description]							    ) AS [description]
--------      ,CONVERT(VARCHAR(MAX), [contract_request_num]					    ) AS [contract_request_num]
--------      ,CONVERT(VARCHAR(MAX), [request_datetime]						    ) AS [request_datetime]
--------      ,CONVERT(VARCHAR(MAX), [response_onclick_attribute]				    ) AS [response_onclick_attribute]
--------      ,CONVERT(VARCHAR(MAX), [parsed_num_solicitud_contratacion]		    ) AS [parsed_num_solicitud_contratacion]
--------      ,CONVERT(VARCHAR(MAX), [parsed_num_cartel]						    ) AS [parsed_num_cartel]
--------	  INTO cleandata.sicop_procedure_expedient
--------  FROM [rawdata].[sicop_procedures_expedients]
--------GO


--------SELECT 
--------	   CONVERT(VARCHAR(MAX), [procedure_num]                               ) AS [procedure_num]
--------      ,CONVERT(VARCHAR(MAX), [institution_name]						    ) AS [institution_name]
--------      ,CONVERT(VARCHAR(MAX), [description]							    ) AS [description]
--------      ,CONVERT(VARCHAR(MAX), [contract_request_num]					    ) AS [contract_request_num]
--------      ,CONVERT(VARCHAR(MAX), [request_datetime]						    ) AS [request_datetime]
--------      ,CONVERT(VARCHAR(MAX), [response_onclick_attribute]				    ) AS [response_onclick_attribute]
--------      ,CONVERT(VARCHAR(MAX), [parsed_num_solicitud_contratacion]		    ) AS [parsed_num_solicitud_contratacion]
--------      ,CONVERT(VARCHAR(MAX), [parsed_num_cartel]						    ) AS [parsed_num_cartel]
--------	  INTO cleandata.sicop_procedure_expedient
--------  FROM [rawdata].[sicop_procedure_expedient]


  USE [ComprasPublicas]
GO

SELECT DISTINCT
       CONVERT(VARCHAR(MAX), [param_sch_instNo]             ) AS         [param_sch_instNo]
      ,CONVERT(VARCHAR(MAX), [param_reqNo]					) AS 	  [param_reqNo]
      ,CONVERT(VARCHAR(MAX), [param_cartelNo]				) AS 	  [param_cartelNo]
      ,CONVERT(VARCHAR(MAX), [num_solicitud_contratacion_v1]) AS 	  [num_solicitud_contratacion_v1]
      ,CONVERT(VARCHAR(MAX), [num_solicitud_contratacion_v2]) AS 	  [num_solicitud_contratacion_v2]
      ,CONVERT(VARCHAR(MAX), [descripcion]					) AS 	  [descripcion]
      ,CONVERT(VARCHAR(MAX), [identificacion_institucion]	) AS 	  [identificacion_institucion]
      ,CONVERT(VARCHAR(MAX), [fecha_solicitud_contratacion]	) AS 	  [fecha_solicitud_contratacion]
	   INTO cleandata.sicop_procedure_expedient_contract_request
  FROM [rawdata].[sicop_procedure_expedient_contract_request]
GO



USE [ComprasPublicas]
GO

SELECT DISTINCT
       CONVERT(VARCHAR(MAX),[param_sch_instNo]          ) AS   [param_sch_instNo]
      ,CONVERT(VARCHAR(MAX),[param_reqNo]				) AS   [param_reqNo]
      ,CONVERT(VARCHAR(MAX),[param_cartelNo]			) AS   [param_cartelNo]
      ,CONVERT(VARCHAR(MAX),[num_contrato]				) AS   [num_contrato]
      ,CONVERT(VARCHAR(MAX),[ids_detalle_contrato]		) AS   [ids_detalle_contrato]
      ,CONVERT(VARCHAR(MAX),[monto_contrato]			) AS   [monto_contrato]
      ,CONVERT(VARCHAR(MAX),[fecha_contrato]			) AS   [fecha_contrato]
      ,CONVERT(VARCHAR(MAX),[vigencia_contrato]			) AS   [vigencia_contrato]
      ,CONVERT(VARCHAR(MAX),[estado_contrato]			) AS   [estado_contrato]
      ,CONVERT(VARCHAR(MAX),[onclick_detalle_contrato]	) AS   [onclick_detalle_contrato]
	  INTO [cleandata].[sicop_procedure_expedient_contract]
  FROM [rawdata].[sicop_procedure_expedient_contract]
GO



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


	SELECT top 10000 *
	FROM cleandata.sicop_procedure_contract AS p

