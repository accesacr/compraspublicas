USE [ComprasPublicas]
GO

SELECT 
	CAST([category_id] AS VARCHAR(MAX) ) AS [ID Categoría Nivel 1]
    ,CAST([category_name] AS VARCHAR(MAX)) AS [Nombre Categoría Nivel 1]
  FROM [cleandata].[sicop_categorylevel1]
GO
-- SICOP Categoría Nivel 1
SELECT 
	MAX(LEN([category_id]))
	,MAX(LEN([category_name]))
  
  FROM [cleandata].[sicop_categorylevel1]



  SELECT 
	CAST([category_id] AS VARCHAR(MAX) ) AS [ID Categoría Nivel 2]
	,CAST(LEFT([category_id], 2) AS VARCHAR(MAX) ) AS [ID Categoría Nivel 1]
    ,CAST([category_name] AS VARCHAR(MAX)) AS [Nombre Categoría Nivel 2]
  FROM [cleandata].[sicop_categorylevel2]
GO

SELECT 
	MAX(LEN([category_id]))
	,MAX(LEN([category_name]))
  
  FROM [cleandata].[sicop_categorylevel2]


    SELECT 
	CAST([category_id] AS VARCHAR(MAX) ) AS [ID Categoría Nivel 3]
    ,CAST(LEFT([category_id], 4) AS VARCHAR(MAX)) AS [ID Categoría Nivel 2]
	,CAST([category_name] AS VARCHAR(MAX)) AS [Nombre Categoría Nivel 3]
  FROM [cleandata].[sicop_categorylevel3]
GO

SELECT 
	MAX(LEN([category_id])) AS [category_id]
	,MAX(LEN([category_name])) AS [category_name]
  
  FROM [cleandata].[sicop_categorylevel3]



 SELECT 
	CAST([category_id] AS VARCHAR(MAX) ) AS [ID Categoría Nivel 4]
	,CAST(LEFT([category_id], 6) AS VARCHAR(MAX) ) AS [ID Categoría Nivel 3]
    ,CAST([category_name] AS VARCHAR(MAX)) AS [Nombre Categoría Nivel 4]
  FROM [cleandata].[sicop_categorylevel4]
GO

SELECT 
	MAX(LEN([category_id]))
	,MAX(LEN([category_name]))
  
  FROM [cleandata].[sicop_categorylevel4]





  USE [ComprasPublicas]
GO

SELECT 
	CAST([category_id] AS VARCHAR(MAX) ) AS [ID Categoría Nivel 4]
	,CAST([procedure_num] AS VARCHAR(MAX) ) AS [Número Procedimiento]
  
  FROM [cleandata].[sicop_procedure_categorylevel4_map]


  
SELECT 
	MAX(LEN([category_id] ) )
	,MAX(LEN([procedure_num]) )
  
  FROM [cleandata].[sicop_procedure_categorylevel4_map]


  USE [ComprasPublicas]
GO

SELECT
	   CAST([Número_procedimiento]		 AS VARCHAR(MAX) ) AS [Número_procedimiento]
      ,CAST([Número_contrato]			 AS VARCHAR(MAX) ) AS [Número_contrato]
      ,CAST([Cédula_adjudicatario]		 AS VARCHAR(MAX) ) AS [Cédula_adjudicatario]
      ,CAST([Institución]				 AS VARCHAR(MAX) ) AS [Institución]
      ,CAST([Fecha_notificación]		 AS VARCHAR(MAX) ) AS [Fecha_notificación]
      ,CAST([Firma_Contrato]			 AS VARCHAR(MAX) ) AS [Firma_Contrato]
      ,CAST([Tipo_modalidad]			 AS VARCHAR(MAX) ) AS [Tipo_modalidad]
      ,CAST([Tipo_Procedimiento]		 AS VARCHAR(MAX) ) AS [Tipo_Procedimiento]
      ,CAST([Descripción]				 AS VARCHAR(MAX) ) AS [Descripción]
      ,CAST([Adjudicatario]				 AS VARCHAR(MAX) ) AS [Adjudicatario]
      ,CAST([Moneda]					 AS VARCHAR(MAX) ) AS [Moneda]
      ,CAST([Monto]						 AS VARCHAR(MAX) ) AS [Monto]
      ,CAST([Modificaciones]			 AS VARCHAR(MAX) ) AS [Modificaciones]
      ,CAST([Vigencia_contrato]			 AS VARCHAR(MAX) ) AS [Vigencia_contrato]
      ,CAST([Clasificación_objeto]		 AS VARCHAR(MAX) ) AS [Clasificación_objeto]
      ,CAST([Calc_Monto_Redondeado]		 AS VARCHAR(MAX) ) AS [Calc_Monto_Redondeado]
  FROM [cleandata].[sicop_procedure_contract]
GO



SELECT
	   MAX(LEN([Número_procedimiento]	))
      ,MAX(LEN([Número_contrato]		))
      ,MAX(LEN([Cédula_adjudicatario]	))
      ,MAX(LEN([Institución]			))
      ,MAX(LEN([Fecha_notificación]		))
      ,MAX(LEN([Firma_Contrato]			))
      ,MAX(LEN([Tipo_modalidad]			))
      ,MAX(LEN([Tipo_Procedimiento]		))
      ,MAX(LEN([Descripción]			))
      ,MAX(LEN([Adjudicatario]			))
      ,MAX(LEN([Moneda]					))
      ,MAX(LEN([Monto]					))
      ,MAX(LEN([Modificaciones]			))
      ,MAX(LEN([Vigencia_contrato]		))
      ,MAX(LEN([Clasificación_objeto]	))
      ,MAX(LEN([Calc_Monto_Redondeado]	))
  FROM [cleandata].[sicop_procedure_contract]





  SELECT
	   COUNT(DISTINCT [Número_procedimiento]	 )
      ,COUNT(DISTINCT [Número_contrato]			 )
      ,COUNT(DISTINCT [Cédula_adjudicatario]	 )
      ,COUNT(DISTINCT [Institución]				 )
      ,COUNT(DISTINCT [Fecha_notificación]		 )
      ,COUNT(DISTINCT [Firma_Contrato]			 )
      ,COUNT(DISTINCT [Tipo_modalidad]			 )
      ,COUNT(DISTINCT [Tipo_Procedimiento]		 )
      ,COUNT(DISTINCT [Descripción]				 )
      ,COUNT(DISTINCT [Adjudicatario]			 )
      ,COUNT(DISTINCT [Moneda]					 )
      ,COUNT(DISTINCT [Monto]					 )
      ,COUNT(DISTINCT [Modificaciones]			 )
      ,COUNT(DISTINCT [Vigencia_contrato]		 )
      ,COUNT(DISTINCT [Clasificación_objeto]	 )
      ,COUNT(DISTINCT [Calc_Monto_Redondeado]	 )
  FROM [cleandata].[sicop_procedure_contract]



SELECT 
	   CAST([Número_procedimiento]	AS VARCHAR(MAX) ) AS [Número_procedimiento]
      ,CAST([Institución]			AS VARCHAR(MAX) ) AS [Institución]		
      ,CAST([Tipo_modalidad]		AS VARCHAR(MAX) ) AS [Tipo_modalidad]
      ,CAST([Tipo_Procedimiento]	AS VARCHAR(MAX) ) AS [Tipo_Procedimiento]
      ,CAST([Descripción]			AS VARCHAR(MAX) ) AS [Descripción]	
FROM [cleandata].[sicop_procedure]
  --123 881
  -- 89 950



  USE [ComprasPublicas]
GO

USE [ComprasPublicas]
GO

SELECT
	   CAST([provider_id]						 AS VARCHAR(MAX) ) AS [provider_id]
      ,CAST([procedure_num]						 AS VARCHAR(MAX) ) AS [procedure_num]
      ,CAST([max_opening_act_publication_date]	 AS VARCHAR(MAX) ) AS [max_opening_act_publication_date]
      ,CAST([max_opening_act_date]				 AS VARCHAR(MAX) ) AS [max_opening_act_date]
      ,CAST([min_opening_act_publication_date]	 AS VARCHAR(MAX) ) AS [min_opening_act_publication_date]
      ,CAST([min_opening_act_date]				 AS VARCHAR(MAX) ) AS [min_opening_act_date]
  FROM [cleandata].[sicop_procedure_participations_per_provider]
GO


GO



USE [ComprasPublicas]
GO

SELECT 
	   CAST([Cedula]										    AS VARCHAR(MAX) ) AS [Cedula]
      ,CAST([Nacionalidad]									    AS VARCHAR(MAX) ) AS [Nacionalidad]
      ,CAST([Nombre del Proveedor]							    AS VARCHAR(MAX) ) AS [Nombre del Proveedor]
      ,CAST([Tipo]											    AS VARCHAR(MAX) ) AS [Tipo]
      ,CAST([Direccion]										    AS VARCHAR(MAX) ) AS [Direccion]
      ,CAST([CodigoPostalCanton_InferidoDeDireccion]		    AS VARCHAR(MAX) ) AS [CodigoPostalCanton_InferidoDeDireccion]
      ,CAST([Provincia_InferidoDeDireccion]					    AS VARCHAR(MAX) ) AS [Provincia_InferidoDeDireccion]
      ,CAST([Direccion2_InferidoDeDireccion]				    AS VARCHAR(MAX) ) AS [Direccion2_InferidoDeDireccion]
      ,CAST([Canton_InferidoDeDireccion]					    AS VARCHAR(MAX) ) AS [Canton_InferidoDeDireccion]
      ,CAST([Direccion3_InferidoDeDireccion]				    AS VARCHAR(MAX) ) AS [Direccion3_InferidoDeDireccion]
      ,CAST([Distrito_InferidoDeDireccion]					    AS VARCHAR(MAX) ) AS [Distrito_InferidoDeDireccion]
      ,CAST([Direccion4_InferidoDeDireccion]				    AS VARCHAR(MAX) ) AS [Direccion4_InferidoDeDireccion]
      ,CAST([FileName_Ingestion]							    AS VARCHAR(MAX) ) AS [FileName_Ingestion]
      ,CAST([CodigoPostalDistrito_InferidoDeDireccion]		    AS VARCHAR(MAX) ) AS [CodigoPostalDistrito_InferidoDeDireccion]
      ,CAST([DistritoNombreAlterno_InferidoDeDireccion]		    AS VARCHAR(MAX) ) AS [DistritoNombreAlterno_InferidoDeDireccion]
      ,CAST([CodigoPostalDistrito_InferidoDesdeCategorias]	    AS VARCHAR(MAX) ) AS [CodigoPostalDistrito_InferidoDesdeCategorias]
      ,CAST([CodigoPostalDistrito_DesdeInferencias]			    AS VARCHAR(MAX) ) AS [CodigoPostalDistrito_DesdeInferencias]
  FROM [cleandata].[sicop_provider]
GO



USE [ComprasPublicas]
GO

SELECT MAX(LEN([Cedula]											 ))
      ,MAX(LEN([Nacionalidad]									 ))
      ,MAX(LEN([Nombre del Proveedor]							 ))
      ,MAX(LEN([Tipo]											 ))
      ,MAX(LEN([Direccion]										 ))
      ,MAX(LEN([CodigoPostalCanton_InferidoDeDireccion]			 ))
      ,MAX(LEN([Provincia_InferidoDeDireccion]					 ))
      ,MAX(LEN([Direccion2_InferidoDeDireccion]					 ))
      ,MAX(LEN([Canton_InferidoDeDireccion]						 ))
      ,MAX(LEN([Direccion3_InferidoDeDireccion]					 ))
      ,MAX(LEN([Distrito_InferidoDeDireccion]					 ))
      ,MAX(LEN([Direccion4_InferidoDeDireccion]					 ))
      ,MAX(LEN([FileName_Ingestion]								 ))
      ,MAX(LEN([CodigoPostalDistrito_InferidoDeDireccion]		 ))
      ,MAX(LEN([DistritoNombreAlterno_InferidoDeDireccion]		 ))
      ,MAX(LEN([CodigoPostalDistrito_InferidoDesdeCategorias]	 ))
      ,MAX(LEN([CodigoPostalDistrito_DesdeInferencias]			 ))
  FROM [cleandata].[sicop_provider]
GO




USE [ComprasPublicas]
GO

SELECT
	   CAST([category_id] AS VARCHAR(MAX) ) AS [category_id]
      ,CAST([provider_id] AS VARCHAR(MAX) ) AS [provider_id]
      ,CAST([provider_name] AS VARCHAR(MAX) ) AS [provider_name]
      ,CAST([provider_location] AS VARCHAR(MAX) ) AS [provider_location]
  FROM [cleandata].[sicop_provider_categorylevel4_map]
GO


USE [ComprasPublicas]
GO

SELECT
	   MAX(LEN([category_id]		   )	)
      ,MAX(LEN([provider_id]		   )	)
      ,MAX(LEN([provider_name]		   )	)
      ,MAX(LEN([provider_location]	   )	)
  FROM [cleandata].[sicop_provider_categorylevel4_map]
GO


USE [ComprasPublicas]
GO

SELECT 
--[INSTITUCION_LICITANTE]
--      ,[Ver_más]
--      ,[AÑO_DE_APERTURA_CONCURSO]
--      ,
DISTINCT [NUMERO_PROCEDIMIENTO]
   --   ,[OBJETO_CONTRACTUAL_DEL_PROCEDIMIENTO]
    --  ,[FECHA_DE_APERTURA_DE_OFERTAS]
--      ,[FECHA_DEINVITACION_A_CONCURSAR]
--      ,[FECHA_ACTO_DE_ADJUDICACION]
--      ,[FECHA_QUE_SE_COMUNICOADJUDICACION]
   --   ,[LIMITE_LEGAL_APLICADO]
   --   ,[MODALIDAD_DE_CONTRATACION]
   --   ,[PRESUPUESTO_ESTIMADO_PARA_ELPROCEDIMIENTO]
--      ,[EXCEPCION_CONTRATACION_DIRECTA]
--      --,[LINEA]
--      --,[ESTADO_LINEA]
--      ,[BIEN_O_SERVICIO]
--      --,[CEDULA_OFERENTE_ADJUDICADO]
--      --,[OFERENTE_ADJUDICADO]
--      --,[CANTIDAD_REQUERIDA]
--      --,[CANTIDAD_ADJUDICADA]
--      --,[CUANTIA_INESTIMBLE]
--      --,[ADJUDICADO_EN_COLONES]
--      ,[SUBPARTIDA_DE_GASTO]
  FROM [Export].[AdjudicacionesSIAC]
  -- 220 524





    SELECT 
--[INSTITUCION_LICITANTE]
--      ,[Ver_más]
--      ,[AÑO_DE_APERTURA_CONCURSO]
--      ,
 CAST([NUMERO_PROCEDIMIENTO] AS VARCHAR(MAX)) AS [NUMERO_PROCEDIMIENTO]
   --   ,[OBJETO_CONTRACTUAL_DEL_PROCEDIMIENTO]
    --  ,[FECHA_DE_APERTURA_DE_OFERTAS]
--      ,[FECHA_DEINVITACION_A_CONCURSAR]
--      ,[FECHA_ACTO_DE_ADJUDICACION]
--      ,[FECHA_QUE_SE_COMUNICOADJUDICACION]
   --   ,[LIMITE_LEGAL_APLICADO]
   --   ,[MODALIDAD_DE_CONTRATACION]
   --   ,[PRESUPUESTO_ESTIMADO_PARA_ELPROCEDIMIENTO]
--      ,[EXCEPCION_CONTRATACION_DIRECTA]
--      --,[LINEA]
--      --,[ESTADO_LINEA]
--      ,[BIEN_O_SERVICIO]
--      --,[CEDULA_OFERENTE_ADJUDICADO]
--      --,[OFERENTE_ADJUDICADO]
--      --,[CANTIDAD_REQUERIDA]
--      --,[CANTIDAD_ADJUDICADA]
--      --,[CUANTIA_INESTIMBLE]
--      --,[ADJUDICADO_EN_COLONES]
--      ,[SUBPARTIDA_DE_GASTO]

  FROM cleandata.siac_procedure