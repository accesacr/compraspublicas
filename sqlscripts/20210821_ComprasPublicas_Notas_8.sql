SELECT TOP 10
*
FROM [cleandata].[sicop_procedure]



--ALTER TABLE [cleandata].[sicop_procedure] ADD min_fecha_solicitud_contratacion DATETIME NULL
--ALTER TABLE [cleandata].[sicop_procedure] ADD max_fecha_solicitud_contratacion DATETIME NULL
--ALTER TABLE [cleandata].[sicop_procedure] ADD diff_sec_min_max_fecha_solicitud_contratacion INT NULL

-- BEGIN TRAN

;WITH cte AS (
	SELECT
		procedure_num
		,MIN([fecha_solicitud_contratacion]) AS min_fecha_solicitud_contratacion
		,MAX([fecha_solicitud_contratacion]) AS max_fecha_solicitud_contratacion
		,DATEDIFF(ss, MIN([fecha_solicitud_contratacion]), MAX([fecha_solicitud_contratacion])) AS diff_sec_min_max_fecha_solicitud_contratacion
	FROM [cleandata].[sicop_procedure_expedient_contract_request]
	GROUP BY procedure_num
)
UPDATE p
	SET
		 p.min_fecha_solicitud_contratacion = 				c.min_fecha_solicitud_contratacion
		,p.max_fecha_solicitud_contratacion = 			    c.max_fecha_solicitud_contratacion
		,p.diff_sec_min_max_fecha_solicitud_contratacion =	c.diff_sec_min_max_fecha_solicitud_contratacion
FROM [cleandata].[sicop_procedure] p
INNER JOIN cte AS c ON p.N�mero_procedimiento = c.procedure_num


-- COMMIT





-- RAW DATA EXPORT
SELECT 
	   CAST([N�mero_procedimiento]	AS VARCHAR(MAX) ) AS [N�mero_procedimiento]
      ,CAST([Instituci�n]			AS VARCHAR(MAX) ) AS [Instituci�n]		
      ,CAST([Tipo_modalidad]		AS VARCHAR(MAX) ) AS [Tipo_modalidad]
      ,CAST([Tipo_Procedimiento]	AS VARCHAR(MAX) ) AS [Tipo_Procedimiento]
      ,CAST([Descripci�n]			AS VARCHAR(MAX) ) AS [Descripci�n]	
	  ,CONVERT(VARCHAR(MAX), min_fecha_solicitud_contratacion, 21) AS min_fecha_solicitud_contratacion
	  ,CONVERT(VARCHAR(MAX), max_fecha_solicitud_contratacion, 21) AS max_fecha_solicitud_contratacion
	  ,CONVERT(VARCHAR(MAX), diff_sec_min_max_fecha_solicitud_contratacion, 21) AS diff_sec_min_max_fecha_solicitud_contratacion
FROM [cleandata].[sicop_procedure]