
--;WITH cte AS (
--	SELECT provider_id, procedure_num
--	FROM [ComprasPublicas].[rawdata].[sicop_participations_per_provider]
--	GROUP BY provider_id, procedure_num
--	HAVING count(*) > 1
--)
--SELECT 
--	d.*
--FROM [ComprasPublicas].[rawdata].[sicop_participations_per_provider] AS d
--INNER JOIN cte AS c ON d.provider_id = c.provider_id AND d.procedure_num = c.procedure_num
--ORDER BY d.provider_id ASC, d.procedure_num ASC

USE [ComprasPublicas]
GO

SELECT
	[provider_id]
	,[procedure_num]
	--,[opening_act_publication_date]
    ,MAX(CONVERT(DATETIME,REPLACE([opening_act_publication_date], 'T', ' ')+ ':00' , 120)) AS [max_opening_act_publication_date]
	--,[opening_act_date]
	,MAX(CONVERT(DATETIME,REPLACE([opening_act_date], 'T', ' ')+ ':00' , 120)) AS [max_opening_act_date]
INTO cleandata.sicop_procedure_participations_per_provider
FROM [rawdata].[sicop_participations_per_provider]
GROUP BY [provider_id], [procedure_num]



--SELECT
--	[provider_id]
--	,[procedure_num]
--	--,[opening_act_publication_date]
--    ,CONVERT(DATETIME,REPLACE([opening_act_publication_date], 'T', ' ')+ ':00' , 120) AS [max_opening_act_publication_date]
--	--,[opening_act_date]
--	,CONVERT(DATETIME,REPLACE([opening_act_date], 'T', ' ')+ ':00' , 120) AS [max_opening_act_date]

--FROM [rawdata].[sicop_participations_per_provider]
--WHERE [opening_act_date] IS NULL


--SELECT
--*
--FROM cleandata.[sicop_participations_per_provider]
--WHERE [max_opening_act_date] IS NULL


--SELECT CAST(GETDATE() AS VARCHAR(255))








--SELECT *
--INTO ACCESAONE.[ComprasPublicas].[rawdata].sicop_participations_per_provider
--FROM [rawdata].[sicop_participations_per_provider]


--SELECT *
--INTO accesaone.cleandata.sicop_participations_per_provider
--FROM cleandata.[sicop_participations_per_provider]

--SELECT [Cedula]
--      ,[Nacionalidad]
--      ,[Nombre del Proveedor]
--      ,[Tipo]
--      ,[Direccion]
--  FROM [ACCESAONE].[ComprasPublicas].[rawdata].[sicop_providers]
--GO

--INSERT INTO [ACCESAONE].[ComprasPublicas].[rawdata].[sicop_providers]
--           ([Cedula]
--           ,[Nacionalidad]
--           ,[Nombre del Proveedor]
--           ,[Tipo]
--           ,[Direccion])
--     VALUES
--           (<Cedula, nvarchar,>
--           ,<Nacionalidad, nvarchar,>
--           ,<Nombre del Proveedor, nvarchar,>
--           ,<Tipo, nvarchar,>
--           ,<Direccion, nvarchar,>)
--GO





SELECT TOP 10
    *
FROM [cleandata].[sicop_procedure_categorylevel4_map] AS p
GROUP BY category_id
HAVING COUNT(*) > 1






