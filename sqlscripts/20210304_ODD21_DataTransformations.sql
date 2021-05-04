

USE ComprasPublicas
GO

--CREATE SCHEMA Export AUTHORIZATION dbo;

--CREATE SCHEMA Staging AUTHORIZATION dbo;


SELECT
	ROW_NUMBER() OVER (ORDER BY [Nombre_del_proyecto] ASC) AS IdRegistro
	--,'Id' + CAST(ROW_NUMBER() OVER (ORDER BY [Nombre_del_proyecto] ASC) AS VARCHAR(MAX)) AS IdRegistroString
	,*

INTO Staging.[ProyectosCTDR]
FROM [dbo].[ProyectosCTDR]

SELECT
	CAST(IdRegistro AS VARCHAR(MAX)) AS IdRegistro
	,CAST('UniqueId|' + CAST(IdRegistro AS VARCHAR(MAX)) AS VARCHAR(MAX)) AS IdRegistroString
	,CAST([Nombre_del_proyecto] AS VARCHAR(MAX)) AS [Nombre_del_proyecto]
	,CAST([Eje] AS VARCHAR(MAX)) AS [Eje]
	,CAST([Área] AS VARCHAR(MAX)) AS [Área]
	,CAST([Territorio] AS VARCHAR(MAX)) AS [Territorio]
	,CAST([Distrito] AS VARCHAR(MAX)) AS [Distrito]
	,CAST([Acciones_Formales] AS VARCHAR(MAX)) AS [Acciones_Formales]
	,CAST([Entidades_involucradas_con_las_acciones_formales] AS VARCHAR(MAX)) AS [Entidades_involucradas_con_las_acciones_formales]
	,CAST([Descripción_del_proyecto] AS VARCHAR(MAX)) AS [Descripción_del_proyecto]
	,CAST([Meta_del_proyecto] AS VARCHAR(MAX)) AS [Meta_del_proyecto]
	,CAST([Etapa_del_proyecto] AS VARCHAR(MAX)) AS [Etapa_del_proyecto]
	,CAST([Periodo_de_implementación] AS VARCHAR(MAX)) AS [Periodo_de_implementación]
	,CAST([Familias_beneficiadas] AS VARCHAR(MAX)) AS [Familias_beneficiadas]
	,CAST([En_que_POI_se_encuentra] AS VARCHAR(MAX)) AS [En_que_POI_se_encuentra]
	,CAST([Recursos_estimados_del_Inder] AS VARCHAR(MAX)) AS [Recursos_estimados_del_Inder]
	,CAST([Recursos_ejecutados_del_Inder] AS VARCHAR(MAX)) AS [Recursos_ejecutados_del_Inder]
	,CAST([Cuenta_con_recursos_del_Inder] AS VARCHAR(MAX)) AS [Cuenta_con_recursos_del_Inder]
	,CAST([Porcentaje_de_recursos_ejecutados_del_Inder] AS VARCHAR(MAX)) AS [Porcentaje_de_recursos_ejecutados_del_Inder]
	,CAST([Quién_presentó_el_proyecto] AS VARCHAR(MAX)) AS [Quién_presentó_el_proyecto]
	,CAST(CASE 
		WHEN  LOWER([Quién_presentó_el_proyecto]) LIKE '%civil%'
		OR LOWER([Quién_presentó_el_proyecto]) = 'Otros' 
		THEN 'Si' ELSE 'No' 
	END AS VARCHAR(MAX)) AS [Participo Soc Civil en Presentación]
	,CAST([Especifique_quien_lo_presentó] AS VARCHAR(MAX)) AS [Especifique_quien_lo_presentó]
	,CAST([Pertenece_al_PDRT] AS VARCHAR(MAX)) AS [Pertenece_al_PDRT]
	,CAST([Se_encuentra_en_algún_Programa] AS VARCHAR(MAX)) AS [Se_encuentra_en_algún_Programa]
	,CAST([Nombre_del_Programa] AS VARCHAR(MAX)) AS [Nombre_del_Programa]
	,CAST([Indicador] AS VARCHAR(MAX)) AS [Indicador]
	,CAST([Indicador_ejecutado] AS VARCHAR(MAX)) AS [Indicador_ejecutado]
	,CAST([Indicador_unidad_de_medida] AS VARCHAR(MAX)) AS [Indicador_unidad_de_medida]
	,CAST(CAST(CASE WHEN CAST(Indicador AS DECIMAL(20,2)) = 0 THEN NULL ELSE CAST(Indicador_Ejecutado AS DECIMAL(20,2)) / CAST(Indicador AS DECIMAL(20,2)) END AS DECIMAL(20,2))  AS VARCHAR(MAX)) AS [% Progreso para Indicador]
	,CAST([Es_priorizado_el_proyecto] AS VARCHAR(MAX)) AS [Es_priorizado_el_proyecto]
	,CAST([Pertenece_el_proyecto_al_PNDRT] AS VARCHAR(MAX)) AS [Pertenece_el_proyecto_al_PNDRT]
	,CAST([Cantidad_de_Gobiernos_Locales] AS VARCHAR(MAX)) AS [Cantidad_de_Gobiernos_Locales]
	,CAST([Recursos_estimados_totales_de_Gobiernos_Locales] AS VARCHAR(MAX)) AS [Recursos_estimados_totales_de_Gobiernos_Locales]
	,CAST([Cuáles_Gobiernos_locales] AS VARCHAR(MAX)) AS [Cuáles_Gobiernos_locales]
	,CAST([Recurso_estimado_por_Gobierno_Local] AS VARCHAR(MAX)) AS [Recurso_estimado_por_Gobierno_Local]
	,CAST([Otros_aportes_por_Gobierno_Local] AS VARCHAR(MAX)) AS [Otros_aportes_por_Gobierno_Local]
	,CAST([Cantidad_de_Instituciones] AS VARCHAR(MAX)) AS [Cantidad_de_Instituciones]
	,CAST([Recursos_estimados_totales_de_Instituciones] AS VARCHAR(MAX)) AS [Recursos_estimados_totales_de_Instituciones]
	,CAST([Cuáles_Instituciones] AS VARCHAR(MAX)) AS [Cuáles_Instituciones]
	,CAST([Recurso_estimado_por_Institución] AS VARCHAR(MAX)) AS [Recurso_estimado_por_Institución]
	,CAST([Otros_aportes_por_Institución] AS VARCHAR(MAX)) AS [Otros_aportes_por_Institución]
	,CAST([Cantidad_de_Organizaciones] AS VARCHAR(MAX)) AS [Cantidad_de_Organizaciones]
	,CAST([Recursos_estimados_totales_de_Organizaciones] AS VARCHAR(MAX)) AS [Recursos_estimados_totales_de_Organizaciones]
	,CAST([Cuáles_Organizaciones] AS VARCHAR(MAX)) AS [Cuáles_Organizaciones]
	,CAST([Recursos_estimados_por_Organización] AS VARCHAR(MAX)) AS [Recursos_estimados_por_Organización]
	,CAST([Otros_aportes_por_Organización] AS VARCHAR(MAX)) AS [Otros_aportes_por_Organización]
	,CAST([Responsable_de_seguimiento_de_la_accion_o_proyecto_por_el_Inder] AS VARCHAR(MAX)) AS [Responsable_de_seguimiento_de_la_accion_o_proyecto_por_el_Inder]
	,CAST([Avance] AS VARCHAR(MAX)) AS [Avance]
	,CAST([Avance1] AS VARCHAR(MAX)) AS [Avance2]
	,CAST([Ejecucion] AS VARCHAR(MAX)) AS [Ejecucion]
	,CAST([Eficacia] AS VARCHAR(MAX)) AS [Eficacia]
	,CAST([Dimensión_de_la_política] AS VARCHAR(MAX)) AS [Dimensión_de_la_política]
	,CAST([Mes_de_aprobación_del_proyecto_en_el_Comité_Directivo] AS VARCHAR(MAX)) AS [Mes_de_aprobación_del_proyecto_en_el_Comité_Directivo]
	,CAST([Año_de_aprobación_del_proyecto_en_el_Comité_Directivo] AS VARCHAR(MAX)) AS [Año_de_aprobación_del_proyecto_en_el_Comité_Directivo]
	,CAST([Causa_de_la_eliminación] AS VARCHAR(MAX)) AS [Causa_de_la_eliminación]
	,CAST([Justificación_de_eliminación] AS VARCHAR(MAX)) AS [Justificación_de_eliminación]
	,CAST(m.CodigoPostal AS VARCHAR(MAX)) AS CodigoPostalDistrito

	,CAST([Recursos_estimados_del_Inder__Normalizados] AS VARCHAR(MAX)) AS [Recursos_estimados_Inder_Normalizados]
	,CAST([Recursos_estimados_totales_de_Gobiernos_Locales__Normalizados] AS VARCHAR(MAX)) AS [Recursos_estimados_Gobiernos_Locales_Normalizados]
	,CAST([Recursos_estimados_totales_de_Instituciones__Normalizados] AS VARCHAR(MAX)) AS [Recursos_estimados_Instituciones_Normalizados]
	,CAST([Recursos_estimados_totales_de_Organizaciones__Normalizados] AS VARCHAR(MAX)) AS [Recursos_estimados_Organizaciones_Normalizados]
	,CAST([Recursos_estimados_del_Inder__NormalizacionAplicada] AS VARCHAR(MAX)) AS [Recursos_estimados_Inder_NormAplicada]
	,CAST([Recursos_estimados_totales_de_Gobiernos_Locales__NormalizacionAplicada] AS VARCHAR(MAX)) AS [Recursos_estimados_tot_Gobiernos_Locales_NormAplicada]
	,CAST([Recursos_estimados_totales_de_Instituciones__NormalizacionAplicada] AS VARCHAR(MAX)) AS [Recursos_estimados_tot_Instituciones_NormAplicada]
	,CAST([Recursos_estimados_totales_de_Organizaciones__NormalizacionAplicada] AS VARCHAR(MAX)) AS [Recursos_estimados_tot_Organizaciones_NormAplicada]
	,CAST([Recursos_estimados_totales__Normalizados] AS VARCHAR(MAX)) AS [Recursos_estimados_totales_Normalizados]

INTO Export.[ProyectosCTDR2021]
FROM Staging.[ProyectosCTDR] AS p
INNER JOIN [dbo].[MapeoDistritosInderACodigoPostal] AS m ON p.Distrito = m.DistritoInder








SELECT 

	CAST('Costa Rica' AS VARCHAR(MAX)) AS [País]
	,CAST(LEFT(d2.[PC],1) AS VARCHAR(MAX)) AS [Código Postal Provincia]

	,CAST(
		CASE LEFT(d2.[PC],1)  
		WHEN '1' THEN 'San José' 
		WHEN '2' THEN 'Alajuela' 
		WHEN '3' THEN 'Cartago' 
		WHEN '4' THEN 'Heredia' 
		WHEN '5' THEN 'Guanacaste' 
		WHEN '6' THEN 'Puntarenas' 
		WHEN '7' THEN 'Limón' 
		ELSE '(Desconocido)' 
	END 
		
		AS VARCHAR(MAX)
	
	
	) AS [Nombre Provincia]


	,CAST(d2.[PC] AS VARCHAR(MAX)) AS [Código Postal Cantón]
	,CAST(d2.[Cantón] AS VARCHAR(MAX)) AS [Nombre Cantón]
	 ,CAST(d1.[Código] AS VARCHAR(MAX)) AS [Codigo Postal Distrito]
	,CAST(d1.[Distrito] AS VARCHAR(MAX)) AS [Nombre Distrito]
	,CAST(d1.[IDS] AS VARCHAR(MAX)) AS [Calificación IDS General]
	,CAST(d1.[Posición] AS VARCHAR(MAX)) AS [Posición IDS General]
	,CAST(d1.[Población_2016] AS VARCHAR(MAX)) AS [Población 2016]
	,CAST(d1.[Extensión] AS VARCHAR(MAX)) AS [Extensión Territorial km2]
	,CAST(d1.[Densidad] AS VARCHAR(MAX)) AS [Densidad km2]



	,CAST(d2.[Económica] AS VARCHAR(MAX)) AS [Calificación IDS Economía]
	,CAST(d2.[Salud] AS VARCHAR(MAX)) AS [Calificación IDS Salud]
	,CAST(d2.[Seguridad] AS VARCHAR(MAX)) AS [Calificación IDS Educación]
	,CAST(d2.[Económica] AS VARCHAR(MAX)) AS [Calificación IDS Seguridad]

INTO Export.DistritosIDS2017
FROM [ComprasPublicas].[dbo].[DistritosIDS2017] AS d1
INNER JOIN [ComprasPublicas].[dbo].[DimDesarrolloDistritosIDS2017] AS d2 ON d1.[Código] = d2.[PCD]



UPDATE c
	SET Territorio = 'Puntarenas-Montes de Oro'
--SELECT *
FROM [ComprasPublicas].[dbo].[MiembrosDeComitesDirectivosCTDR] AS c
WHERE Territorio = 'Punatrenas-Montes de Oro'
	

	
UPDATE c
	SET Territorio = 'Turrialba-Jiménez'
--SELECT *
FROM [ComprasPublicas].[dbo].[MiembrosDeComitesDirectivosCTDR] AS c
WHERE Territorio = 'Turrilaba - Jiménez'




SELECT
 CAST([Puesto de representación] AS varchar(max)) AS [Puesto de representación]
,CAST([Representante legal propietario] AS varchar(max)) AS [Representante legal propietario]
,CAST([Territorio] AS varchar(max)) AS [Territorio]
,CAST([Sexo] AS varchar(max)) AS [Genero propietario]
,CAST([Composición ] AS varchar(max)) AS [Composición propietario]
,CAST([Grupo prioritario al que representa] AS varchar(max)) AS [Grupo prioritario al que representa propietario]
,CAST([Nombre de la institución, Gobierno Local u Organización] AS varchar(max)) AS [Nombre de la institución, Gobierno Local u Organización propietario]
--,CAST([Correo] AS varchar(max)) AS 
,CAST([Representante legal suplente] AS varchar(max)) AS [Representante legal suplente]
,CAST([Sexo1] AS varchar(max)) AS [Genero suplente]
,CAST([Composición 1] AS varchar(max)) AS [Composición suplente]
,CAST([Grupo prioritario al que representa1] AS varchar(max)) AS [Grupo prioritario al que representa suplente]
,CAST([Nombre de la institución, Gobierno Local u Organización1] AS varchar(max)) AS [Nombre de la institución, Gobierno Local u Organización suplente]
--,CAST([Correo1] AS varchar(max)) AS 
INTO Export.ComitesDirectivosCTDR2021
FROM [dbo].[MiembrosDeComitesDirectivosCTDR]
GO







--;WITH cte_proy AS (
--	SELECT DISTINCT Territorio FROM [dbo].[ProyectosCTDRConCodigoPostal] --ORDER BY Territorio DESC
--)
--, cte_com AS (
--	SELECT DISTINCT [Territorio] FROM [ComprasPublicas].[dbo].[MiembrosDeComitesDirectivosCTDR] --ORDER BY Territorio DESC
--)
--SELECT * FROM cte_proy EXCEPT SELECT * FROM cte_com


--;WITH cte_proy AS (
--	SELECT DISTINCT Territorio FROM [dbo].[ProyectosCTDRConCodigoPostal] --ORDER BY Territorio DESC
--)
--, cte_com AS (
--	SELECT DISTINCT [Territorio] FROM [ComprasPublicas].[dbo].[MiembrosDeComitesDirectivosCTDR] --ORDER BY Territorio DESC
--)
--SELECT * FROM cte_com EXCEPT SELECT * FROM cte_proy
   


