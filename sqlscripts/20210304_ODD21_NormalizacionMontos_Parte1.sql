SELECT --top 10
--[Recursos_estimados_por_Organización]
IdRegistro
,
[Recursos_estimados_del_Inder]
--,[Recursos_ejecutados_del_Inder]
--,[Porcentaje_de_recursos_ejecutados_del_Inder]
,[Recursos_estimados_totales_de_Gobiernos_Locales]
--,[Recurso_estimado_por_Gobierno_Local]  
,[Recursos_estimados_totales_de_Instituciones]   
--,[Recurso_estimado_por_Institución] 
,[Recursos_estimados_totales_de_Organizaciones]  
,*
FROM Staging.[ProyectosCTDR]
WHERE [Cuáles_Instituciones] LIKE '%inder%'






SELECT --top 10
--[Recursos_estimados_por_Organización]
IdRegistro
,
[Recursos_estimados_del_Inder]
--,[Recursos_ejecutados_del_Inder]
--,[Porcentaje_de_recursos_ejecutados_del_Inder]
,[Recursos_estimados_totales_de_Gobiernos_Locales]
--,[Recurso_estimado_por_Gobierno_Local]  
,[Recursos_estimados_totales_de_Instituciones]   
--,[Recurso_estimado_por_Institución] 
,[Recursos_estimados_totales_de_Organizaciones]  
,*
FROM Staging.[ProyectosCTDR]
WHERE --[Recursos_estimados_del_Inder] > CAST(5000  AS DECIMAL)
--[Recursos_estimados_del_Inder] > CAST(1000  AS DECIMAL)

--AND
[Recursos_estimados_del_Inder] > CAST(500  AS DECIMAL)

AND [Recursos_estimados_del_Inder] < CAST(1000000  AS DECIMAL)


ORDER BY CAST([Recursos_estimados_del_Inder] AS DECIMAL) ASC



SELECT --top 10
--[Recursos_estimados_por_Organización]
IdRegistro
,
[Recursos_estimados_del_Inder]
--,[Recursos_ejecutados_del_Inder]
--,[Porcentaje_de_recursos_ejecutados_del_Inder]
,[Recursos_estimados_totales_de_Gobiernos_Locales]
--,[Recurso_estimado_por_Gobierno_Local]  
,[Recursos_estimados_totales_de_Instituciones]   
--,[Recurso_estimado_por_Institución] 
,[Recursos_estimados_totales_de_Organizaciones]  
,*
FROM Staging.[ProyectosCTDR]
WHERE --[Recursos_estimados_del_Inder] > CAST(5000  AS DECIMAL)
--[Recursos_estimados_del_Inder] > CAST(1000  AS DECIMAL)

--AND
[Recursos_estimados_totales_de_gobiernos_locales] > CAST(1000  AS DECIMAL)

AND [Recursos_estimados_totales_de_gobiernos_locales] < CAST(1000000  AS DECIMAL)




SELECT --top 10
--[Recursos_estimados_por_Organización]
IdRegistro
,
[Recursos_estimados_del_Inder]
--,[Recursos_ejecutados_del_Inder]
--,[Porcentaje_de_recursos_ejecutados_del_Inder]
,[Recursos_estimados_totales_de_Gobiernos_Locales]
--,[Recurso_estimado_por_Gobierno_Local]  
,[Recursos_estimados_totales_de_Instituciones]   
--,[Recurso_estimado_por_Institución] 
,[Recursos_estimados_totales_de_Organizaciones]  
,*
FROM Staging.[ProyectosCTDR]
WHERE --[Recursos_estimados_del_Inder] > CAST(5000  AS DECIMAL)
--[Recursos_estimados_del_Inder] > CAST(1000  AS DECIMAL)

--AND
[Recursos_estimados_totales_de_gobiernos_locales] > CAST(1000  AS DECIMAL)

AND [Recursos_estimados_totales_de_gobiernos_locales] < CAST(1000000  AS DECIMAL)





SELECT --top 10
--[Recursos_estimados_por_Organización]
IdRegistro
,
[Recursos_estimados_del_Inder]
--,[Recursos_ejecutados_del_Inder]
--,[Porcentaje_de_recursos_ejecutados_del_Inder]
,[Recursos_estimados_totales_de_Gobiernos_Locales]
--,[Recurso_estimado_por_Gobierno_Local]  
,[Recursos_estimados_totales_de_Instituciones]   
--,[Recurso_estimado_por_Institución] 
,[Recursos_estimados_totales_de_Organizaciones]  
,*
FROM Staging.[ProyectosCTDR]
WHERE --[Recursos_estimados_del_Inder] > CAST(5000  AS DECIMAL)
--[Recursos_estimados_del_Inder] > CAST(1000  AS DECIMAL)

--AND
 TRY_CAST([Recursos_estimados_totales_de_Instituciones] AS DECIMAL)  > CAST(1000  AS DECIMAL)

AND  TRY_CAST([Recursos_estimados_totales_de_Instituciones] AS DECIMAL)  < CAST(1000000  AS DECIMAL)



SELECT --top 10
--[Recursos_estimados_por_Organización]
IdRegistro
,
[Recursos_estimados_del_Inder]
--,[Recursos_ejecutados_del_Inder]
--,[Porcentaje_de_recursos_ejecutados_del_Inder]
,[Recursos_estimados_totales_de_Gobiernos_Locales]
--,[Recurso_estimado_por_Gobierno_Local]  
,[Recursos_estimados_totales_de_Instituciones]   
--,[Recurso_estimado_por_Institución] 
,[Recursos_estimados_totales_de_Organizaciones]  
,*
FROM Staging.[ProyectosCTDR]
WHERE --[Recursos_estimados_del_Inder] > CAST(5000  AS DECIMAL)
--[Recursos_estimados_del_Inder] > CAST(1000  AS DECIMAL)

--AND
[Recursos_estimados_totales_de_Organizaciones] > CAST(500  AS DECIMAL)

AND [Recursos_estimados_totales_de_Organizaciones] < CAST(1000000  AS DECIMAL)







--(
--[Recursos_estimados_del_Inder] > CAST(1000  AS DECIMAL)


--OR [Recursos_estimados_totales_de_Gobiernos_Locales] > CAST(1000  AS DECIMAL)

--OR TRY_CAST([Recursos_estimados_totales_de_Instituciones] AS DECIMAL)   > CAST(1000  AS DECIMAL)

--OR [Recursos_estimados_totales_de_Organizaciones]   > CAST(1000  AS DECIMAL)
--)
--AND [Recursos_estimados_totales_de_Instituciones] <> '20.171.497.6'
--WHERE TRY_CAST([Recursos_estimados_totales_de_Instituciones]   AS DECIMAL) IS NOT NULL




SELECT
	SUM(1) AS Total
	,SUM(CASE WHEN [Recursos_estimados_del_Inder] > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) AS [TieneInder]
	,SUM(CASE WHEN [Recursos_estimados_totales_de_Gobiernos_Locales] > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) AS [TieneGobiernos]
	,SUM(CASE WHEN TRY_CAST([Recursos_estimados_totales_de_Instituciones] AS DECIMAL)  > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) AS [TieneInstituciones]
	,SUM(CASE WHEN [Recursos_estimados_totales_de_Organizaciones]  > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) AS [TieneOrganizaciones]

	--,SUM(CASE WHEN [Recursos_estimados_del_Inder] > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) / 326 AS [TieneInder]
	--,SUM(CASE WHEN [Recursos_estimados_totales_de_Gobiernos_Locales] > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) / 326 AS [TieneGobiernos]
	--,SUM(CASE WHEN TRY_CAST([Recursos_estimados_totales_de_Instituciones] AS DECIMAL)  > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) /326 AS [TieneInstituciones]
	--,SUM(CASE WHEN [Recursos_estimados_totales_de_Organizaciones]  > CAST(1  AS DECIMAL) THEN 1 ELSE 0 END) / 326 AS [TieneOrganizaciones]
FROM Staging.[ProyectosCTDR]




SELECT
	IdRegistro
,
[Recursos_estimados_del_Inder]
--,[Recursos_ejecutados_del_Inder]
--,[Porcentaje_de_recursos_ejecutados_del_Inder]
,[Recursos_estimados_totales_de_Gobiernos_Locales]
--,[Recurso_estimado_por_Gobierno_Local]  
,[Recursos_estimados_totales_de_Instituciones]   
--,[Recurso_estimado_por_Institución] 
,[Recursos_estimados_totales_de_Organizaciones]  
,*
FROM Staging.[ProyectosCTDR]
WHERE
	 [Recursos_estimados_del_Inder] <CAST(1  AS DECIMAL)
	AND [Recursos_estimados_totales_de_Gobiernos_Locales] < CAST(1  AS DECIMAL)
	AND  TRY_CAST([Recursos_estimados_totales_de_Instituciones] AS DECIMAL)  < CAST(1  AS DECIMAL)
	AND  [Recursos_estimados_totales_de_Organizaciones]  < CAST(1  AS DECIMAL)
	ORDER BY Territorio DESC


SELECT
		[Porcentaje_de_recursos_ejecutados_del_Inder]
FROM Staging.[ProyectosCTDR]
