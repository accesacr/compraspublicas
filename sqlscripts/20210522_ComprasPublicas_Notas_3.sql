USE ComprasPublicas
GO
--ALTER TABLE [cleandata].[sicop_provider] ADD CodigoPostalDistrito_InferidoDesdeCategorias NVARCHAR(50) NULL
--ALTER TABLE [cleandata].[sicop_provider] ADD CodigoPostalDistrito_DesdeInferencias NVARCHAR(50) NULL

;WITH cte AS ( 
	SELECT 
		  DISTINCT
			[provider_id]
			,LEFT(RIGHT([provider_location], LEN([provider_location]) - 2 ), 5) AS postal_code
	 FROM [ComprasPublicas].[cleandata].[sicop_provider_categorylevel4_map]
)


UPDATE p
	SET 
		CodigoPostalDistrito_InferidoDesdeCategorias = c.postal_code
FROM [cleandata].[sicop_provider] AS p
INNER JOIN cte AS c ON p.[Cedula] = c.[provider_id]


UPDATE p
	SET 
		CodigoPostalDistrito_DesdeInferencias = COALESCE([CodigoPostalDistrito_InferidoDeDireccion], CodigoPostalDistrito_InferidoDesdeCategorias)
FROM [cleandata].[sicop_provider] AS p



UPDATE p
	SET 
		CodigoPostalDistrito_DesdeInferencias = NULL
FROM [cleandata].[sicop_provider] AS p
WHERE CodigoPostalDistrito_DesdeInferencias LIKE '%[A-Z][a-z]%'





    SELECT DISTINCT
	   [Número_procedimiento]	
      ,[Institución]			
      ,[Tipo_modalidad]		
      ,[Tipo_Procedimiento]	
      ,[Descripción]				
	  INTO [cleandata].[sicop_procedure] 
  FROM [cleandata].[sicop_procedure_contract]


  




  SELECT * FROM [cleandata].[sicop_procedure] 




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
INTO cleandata.siac_procedure
  FROM [Export].[AdjudicacionesSIAC]






