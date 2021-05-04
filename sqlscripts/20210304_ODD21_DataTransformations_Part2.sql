
USE ComprasPublicas
GO


--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_del_Inder__Normalizados] VARCHAR(MAX) NULL
--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados] VARCHAR(MAX) NULL
--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_totales_de_Instituciones__Normalizados] VARCHAR(MAX) NULL
--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_totales_de_Organizaciones__Normalizados] VARCHAR(MAX) NULL


--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_del_Inder__NormalizacionAplicada] VARCHAR(MAX) NULL
--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_totales_de_Gobiernos_Locales__NormalizacionAplicada] VARCHAR(MAX) NULL
--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_totales_de_Instituciones__NormalizacionAplicada] VARCHAR(MAX) NULL
--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_totales_de_Organizaciones__NormalizacionAplicada] VARCHAR(MAX) NULL

--ALTER TABLE Staging.[ProyectosCTDR] ADD [Recursos_estimados_totales__Normalizados] VARCHAR(MAX) NULL

------------------------------------
--- Recursos_estimados_del_Inder
------------------------------------

--UPDATE p
--	SET 
--		p.[Recursos_estimados_del_Inder__Normalizados] = CAST(CAST(CAST(p.[Recursos_estimados_del_Inder] AS DECIMAL(20,5)) * 1000000 AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_del_Inder__NormalizacionAplicada] = 'Si'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.[Recursos_estimados_del_Inder] AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.[Recursos_estimados_del_Inder] AS DECIMAL(20,2)) < CAST(2501  AS DECIMAL)



--UPDATE p
--	SET 
--		p.[Recursos_estimados_del_Inder__Normalizados] = CAST(CAST([Recursos_estimados_del_Inder] AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_del_Inder__NormalizacionAplicada] = 'No'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.[Recursos_estimados_del_Inder] AS DECIMAL(20,2)) = 0
--OR TRY_CAST(p.[Recursos_estimados_del_Inder] AS DECIMAL(20,2)) >= CAST(2501  AS DECIMAL)



--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) < CAST(2501  AS DECIMAL)
--ORDER BY TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) ASC



--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) = 0
--OR TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) >= CAST(2501  AS DECIMAL)
--ORDER BY TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) ASC


--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) IS NULL




------------------------------------
-- Recursos_estimados_totales_de_Gobiernos_Locales
------------------------------------

--UPDATE p
--	SET 
--		p.[Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados] = CAST(CAST(CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,5)) * 1000000 AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_totales_de_Gobiernos_Locales__NormalizacionAplicada] = 'Si'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) < CAST(2501  AS DECIMAL)



--UPDATE p
--	SET 
--		p.[Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados] = CAST(CAST(Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_totales_de_Gobiernos_Locales__NormalizacionAplicada] = 'No'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) = 0
--OR TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) >= CAST(2501  AS DECIMAL)


--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) < CAST(2501  AS DECIMAL)
--ORDER BY TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) ASC



--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) = 0
--OR TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) >= CAST(2501  AS DECIMAL)
--ORDER BY TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales AS DECIMAL(20,2)) ASC



--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_del_Inder AS DECIMAL(20,2)) IS NULL

------------------------------------
-- Recursos_estimados_totales_de_Instituciones
------------------------------------
--UPDATE p
--	SET 
--		p.[Recursos_estimados_totales_de_Instituciones__Normalizados] = CAST(CAST(CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,5)) * 1000000 AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_totales_de_Instituciones__NormalizacionAplicada] = 'Si'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) < CAST(3000  AS DECIMAL)



--UPDATE p
--	SET 
--		p.[Recursos_estimados_totales_de_Instituciones__Normalizados] = CAST(CAST(Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_totales_de_Instituciones__NormalizacionAplicada] = 'No'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) = 0
--OR (
--	TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) >= CAST(3000  AS DECIMAL)
--	AND TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) < CAST(1000000000  AS DECIMAL)
--)


--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) < CAST(3000  AS DECIMAL)
--ORDER BY TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) ASC




--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) = 0
--OR (
--	TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) >= CAST(3000  AS DECIMAL)
--	AND TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) < CAST(1000000000  AS DECIMAL)
--)
--ORDER BY TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) ASC


--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) IS NULL
--OR TRY_CAST(p.Recursos_estimados_totales_de_Instituciones AS DECIMAL(20,2)) > CAST(1000000000  AS DECIMAL)




------------------------------------
--Recursos_estimados_totales_de_Organizaciones
------------------------------------



--UPDATE p
--	SET 
--		p.[Recursos_estimados_totales_de_Organizaciones__Normalizados] = CAST(CAST(CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,5)) * 1000000 AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_totales_de_Organizaciones__NormalizacionAplicada] = 'Si'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) < CAST(3000  AS DECIMAL)



--UPDATE p
--	SET 
--		p.[Recursos_estimados_totales_de_Organizaciones__Normalizados] = CAST(CAST(Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,0)) AS VARCHAR(MAX))
--		,p.[Recursos_estimados_totales_de_Organizaciones__NormalizacionAplicada] = 'No'
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) = 0
--OR (
--	TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) >= CAST(3000  AS DECIMAL)
--	AND TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) < CAST(1000000000  AS DECIMAL)
--)


--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) > 0
--AND TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) < CAST(3000  AS DECIMAL)
--ORDER BY TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) ASC




--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) = 0
--OR (
--	TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) >= CAST(3000  AS DECIMAL)
--	AND TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) < CAST(1000000000  AS DECIMAL)
--)
--ORDER BY TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) ASC


--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) IS NULL
--OR TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones AS DECIMAL(20,2)) > CAST(1000000000  AS DECIMAL)





------------------------------------
--Recursos_estimados_totales
------------------------------------


--UPDATE p
--	SET 
--		p.[Recursos_estimados_totales__Normalizados] = CAST( 
--		CAST(
--			CAST(p.Recursos_estimados_del_Inder__Normalizados AS DECIMAL(20,2))
--			+ CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados AS DECIMAL(20,2))
--			+ CAST(p.Recursos_estimados_totales_de_Instituciones__Normalizados AS DECIMAL(20,2))
--			+ CAST(p.Recursos_estimados_totales_de_Organizaciones__Normalizados AS DECIMAL(20,2))
--			AS DECIMAL(20,0)
--		) AS VARCHAR(MAX)
--	)
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_del_Inder__Normalizados AS DECIMAL(20,2)) IS NOT NULL
--AND TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados AS DECIMAL(20,2)) IS NOT NULL
--AND TRY_CAST(p.Recursos_estimados_totales_de_Instituciones__Normalizados AS DECIMAL(20,2)) IS NOT NULL
--AND TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones__Normalizados AS DECIMAL(20,2)) IS NOT NULL



--SELECT
--	IdRegistro
--	,[Recursos_estimados_del_Inder]
--	,[Recursos_estimados_totales_de_Gobiernos_Locales]
--	,[Recursos_estimados_totales_de_Instituciones]   
--	,[Recursos_estimados_totales_de_Organizaciones]  
--	, 1 AS t
--	,CAST(p.Recursos_estimados_del_Inder__Normalizados AS DECIMAL(20,2)) AS Recursos_estimados_del_Inder__Normalizados
--	,CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados AS DECIMAL(20,2)) AS Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados
--	,CAST(p.Recursos_estimados_totales_de_Instituciones__Normalizados AS DECIMAL(20,2)) AS Recursos_estimados_totales_de_Instituciones__Normalizados
--	,CAST(p.Recursos_estimados_totales_de_Organizaciones__Normalizados AS DECIMAL(20,2)) AS Recursos_estimados_totales_de_Organizaciones__Normalizados
--	,CAST( 
--		CAST(
--			CAST(p.Recursos_estimados_del_Inder__Normalizados AS DECIMAL(20,2))
--			+ CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados AS DECIMAL(20,2))
--			+ CAST(p.Recursos_estimados_totales_de_Instituciones__Normalizados AS DECIMAL(20,2))
--			+ CAST(p.Recursos_estimados_totales_de_Organizaciones__Normalizados AS DECIMAL(20,2))
--			AS DECIMAL(20,0)
--		) AS VARCHAR(MAX)
--	)AS [Recursos_estimados_totales__Normalizados]
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Recursos_estimados_del_Inder__Normalizados AS DECIMAL(20,2)) IS NOT NULL
--AND TRY_CAST(p.Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados AS DECIMAL(20,2)) IS NOT NULL
--AND TRY_CAST(p.Recursos_estimados_totales_de_Instituciones__Normalizados AS DECIMAL(20,2)) IS NOT NULL
--AND TRY_CAST(p.Recursos_estimados_totales_de_Organizaciones__Normalizados AS DECIMAL(20,2)) IS NOT NULL





------------------------------------
--Familias Beneficiadas
------------------------------------


--SELECT
--	IdRegistro
--,Familias_Beneficiadas
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Familias_Beneficiadas AS DECIMAL(20,2)) IS NOT NULL

----WHERE TRY_CAST(p.Familias_Beneficiadas AS DECIMAL(20,2)) > 2000
--ORDER BY TRY_CAST(p.Familias_Beneficiadas AS DECIMAL(20,2)) ASC




------------------------------------
--Familias Beneficiadas
------------------------------------


--SELECT
--	IdRegistro
--,Familias_Beneficiadas
--	,*
--FROM Staging.[ProyectosCTDR] AS p
--WHERE TRY_CAST(p.Familias_Beneficiadas AS DECIMAL(20,2)) IS NOT NULL

----WHERE TRY_CAST(p.Familias_Beneficiadas AS DECIMAL(20,2)) > 2000
--ORDER BY TRY_CAST(p.Familias_Beneficiadas AS DECIMAL(20,2)) ASC
