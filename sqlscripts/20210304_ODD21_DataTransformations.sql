

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
	,CAST([�rea] AS VARCHAR(MAX)) AS [�rea]
	,CAST([Territorio] AS VARCHAR(MAX)) AS [Territorio]
	,CAST([Distrito] AS VARCHAR(MAX)) AS [Distrito]
	,CAST([Acciones_Formales] AS VARCHAR(MAX)) AS [Acciones_Formales]
	,CAST([Entidades_involucradas_con_las_acciones_formales] AS VARCHAR(MAX)) AS [Entidades_involucradas_con_las_acciones_formales]
	,CAST([Descripci�n_del_proyecto] AS VARCHAR(MAX)) AS [Descripci�n_del_proyecto]
	,CAST([Meta_del_proyecto] AS VARCHAR(MAX)) AS [Meta_del_proyecto]
	,CAST([Etapa_del_proyecto] AS VARCHAR(MAX)) AS [Etapa_del_proyecto]
	,CAST([Periodo_de_implementaci�n] AS VARCHAR(MAX)) AS [Periodo_de_implementaci�n]
	,CAST([Familias_beneficiadas] AS VARCHAR(MAX)) AS [Familias_beneficiadas]
	,CAST([En_que_POI_se_encuentra] AS VARCHAR(MAX)) AS [En_que_POI_se_encuentra]
	,CAST([Recursos_estimados_del_Inder] AS VARCHAR(MAX)) AS [Recursos_estimados_del_Inder]
	,CAST([Recursos_ejecutados_del_Inder] AS VARCHAR(MAX)) AS [Recursos_ejecutados_del_Inder]
	,CAST([Cuenta_con_recursos_del_Inder] AS VARCHAR(MAX)) AS [Cuenta_con_recursos_del_Inder]
	,CAST([Porcentaje_de_recursos_ejecutados_del_Inder] AS VARCHAR(MAX)) AS [Porcentaje_de_recursos_ejecutados_del_Inder]
	,CAST([Qui�n_present�_el_proyecto] AS VARCHAR(MAX)) AS [Qui�n_present�_el_proyecto]
	,CAST(CASE 
		WHEN  LOWER([Qui�n_present�_el_proyecto]) LIKE '%civil%'
		OR LOWER([Qui�n_present�_el_proyecto]) = 'Otros' 
		THEN 'Si' ELSE 'No' 
	END AS VARCHAR(MAX)) AS [Participo Soc Civil en Presentaci�n]
	,CAST([Especifique_quien_lo_present�] AS VARCHAR(MAX)) AS [Especifique_quien_lo_present�]
	,CAST([Pertenece_al_PDRT] AS VARCHAR(MAX)) AS [Pertenece_al_PDRT]
	,CAST([Se_encuentra_en_alg�n_Programa] AS VARCHAR(MAX)) AS [Se_encuentra_en_alg�n_Programa]
	,CAST([Nombre_del_Programa] AS VARCHAR(MAX)) AS [Nombre_del_Programa]
	,CAST([Indicador] AS VARCHAR(MAX)) AS [Indicador]
	,CAST([Indicador_ejecutado] AS VARCHAR(MAX)) AS [Indicador_ejecutado]
	,CAST([Indicador_unidad_de_medida] AS VARCHAR(MAX)) AS [Indicador_unidad_de_medida]
	,CAST(CAST(CASE WHEN CAST(Indicador AS DECIMAL(20,2)) = 0 THEN NULL ELSE CAST(Indicador_Ejecutado AS DECIMAL(20,2)) / CAST(Indicador AS DECIMAL(20,2)) END AS DECIMAL(20,2))  AS VARCHAR(MAX)) AS [% Progreso para Indicador]
	,CAST([Es_priorizado_el_proyecto] AS VARCHAR(MAX)) AS [Es_priorizado_el_proyecto]
	,CAST([Pertenece_el_proyecto_al_PNDRT] AS VARCHAR(MAX)) AS [Pertenece_el_proyecto_al_PNDRT]
	,CAST([Cantidad_de_Gobiernos_Locales] AS VARCHAR(MAX)) AS [Cantidad_de_Gobiernos_Locales]
	,CAST([Recursos_estimados_totales_de_Gobiernos_Locales] AS VARCHAR(MAX)) AS [Recursos_estimados_totales_de_Gobiernos_Locales]
	,CAST([Cu�les_Gobiernos_locales] AS VARCHAR(MAX)) AS [Cu�les_Gobiernos_locales]
	,CAST([Recurso_estimado_por_Gobierno_Local] AS VARCHAR(MAX)) AS [Recurso_estimado_por_Gobierno_Local]
	,CAST([Otros_aportes_por_Gobierno_Local] AS VARCHAR(MAX)) AS [Otros_aportes_por_Gobierno_Local]
	,CAST([Cantidad_de_Instituciones] AS VARCHAR(MAX)) AS [Cantidad_de_Instituciones]
	,CAST([Recursos_estimados_totales_de_Instituciones] AS VARCHAR(MAX)) AS [Recursos_estimados_totales_de_Instituciones]
	,CAST([Cu�les_Instituciones] AS VARCHAR(MAX)) AS [Cu�les_Instituciones]
	,CAST([Recurso_estimado_por_Instituci�n] AS VARCHAR(MAX)) AS [Recurso_estimado_por_Instituci�n]
	,CAST([Otros_aportes_por_Instituci�n] AS VARCHAR(MAX)) AS [Otros_aportes_por_Instituci�n]
	,CAST([Cantidad_de_Organizaciones] AS VARCHAR(MAX)) AS [Cantidad_de_Organizaciones]
	,CAST([Recursos_estimados_totales_de_Organizaciones] AS VARCHAR(MAX)) AS [Recursos_estimados_totales_de_Organizaciones]
	,CAST([Cu�les_Organizaciones] AS VARCHAR(MAX)) AS [Cu�les_Organizaciones]
	,CAST([Recursos_estimados_por_Organizaci�n] AS VARCHAR(MAX)) AS [Recursos_estimados_por_Organizaci�n]
	,CAST([Otros_aportes_por_Organizaci�n] AS VARCHAR(MAX)) AS [Otros_aportes_por_Organizaci�n]
	,CAST([Responsable_de_seguimiento_de_la_accion_o_proyecto_por_el_Inder] AS VARCHAR(MAX)) AS [Responsable_de_seguimiento_de_la_accion_o_proyecto_por_el_Inder]
	,CAST([Avance] AS VARCHAR(MAX)) AS [Avance]
	,CAST([Avance1] AS VARCHAR(MAX)) AS [Avance2]
	,CAST([Ejecucion] AS VARCHAR(MAX)) AS [Ejecucion]
	,CAST([Eficacia] AS VARCHAR(MAX)) AS [Eficacia]
	,CAST([Dimensi�n_de_la_pol�tica] AS VARCHAR(MAX)) AS [Dimensi�n_de_la_pol�tica]
	,CAST([Mes_de_aprobaci�n_del_proyecto_en_el_Comit�_Directivo] AS VARCHAR(MAX)) AS [Mes_de_aprobaci�n_del_proyecto_en_el_Comit�_Directivo]
	,CAST([A�o_de_aprobaci�n_del_proyecto_en_el_Comit�_Directivo] AS VARCHAR(MAX)) AS [A�o_de_aprobaci�n_del_proyecto_en_el_Comit�_Directivo]
	,CAST([Causa_de_la_eliminaci�n] AS VARCHAR(MAX)) AS [Causa_de_la_eliminaci�n]
	,CAST([Justificaci�n_de_eliminaci�n] AS VARCHAR(MAX)) AS [Justificaci�n_de_eliminaci�n]
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

	CAST('Costa Rica' AS VARCHAR(MAX)) AS [Pa�s]
	,CAST(LEFT(d2.[PC],1) AS VARCHAR(MAX)) AS [C�digo Postal Provincia]

	,CAST(
		CASE LEFT(d2.[PC],1)  
		WHEN '1' THEN 'San Jos�' 
		WHEN '2' THEN 'Alajuela' 
		WHEN '3' THEN 'Cartago' 
		WHEN '4' THEN 'Heredia' 
		WHEN '5' THEN 'Guanacaste' 
		WHEN '6' THEN 'Puntarenas' 
		WHEN '7' THEN 'Lim�n' 
		ELSE '(Desconocido)' 
	END 
		
		AS VARCHAR(MAX)
	
	
	) AS [Nombre Provincia]


	,CAST(d2.[PC] AS VARCHAR(MAX)) AS [C�digo Postal Cant�n]
	,CAST(d2.[Cant�n] AS VARCHAR(MAX)) AS [Nombre Cant�n]
	 ,CAST(d1.[C�digo] AS VARCHAR(MAX)) AS [Codigo Postal Distrito]
	,CAST(d1.[Distrito] AS VARCHAR(MAX)) AS [Nombre Distrito]
	,CAST(d1.[IDS] AS VARCHAR(MAX)) AS [Calificaci�n IDS General]
	,CAST(d1.[Posici�n] AS VARCHAR(MAX)) AS [Posici�n IDS General]
	,CAST(d1.[Poblaci�n_2016] AS VARCHAR(MAX)) AS [Poblaci�n 2016]
	,CAST(d1.[Extensi�n] AS VARCHAR(MAX)) AS [Extensi�n Territorial km2]
	,CAST(d1.[Densidad] AS VARCHAR(MAX)) AS [Densidad km2]



	,CAST(d2.[Econ�mica] AS VARCHAR(MAX)) AS [Calificaci�n IDS Econom�a]
	,CAST(d2.[Salud] AS VARCHAR(MAX)) AS [Calificaci�n IDS Salud]
	,CAST(d2.[Seguridad] AS VARCHAR(MAX)) AS [Calificaci�n IDS Educaci�n]
	,CAST(d2.[Econ�mica] AS VARCHAR(MAX)) AS [Calificaci�n IDS Seguridad]

INTO Export.DistritosIDS2017
FROM [ComprasPublicas].[dbo].[DistritosIDS2017] AS d1
INNER JOIN [ComprasPublicas].[dbo].[DimDesarrolloDistritosIDS2017] AS d2 ON d1.[C�digo] = d2.[PCD]



UPDATE c
	SET Territorio = 'Puntarenas-Montes de Oro'
--SELECT *
FROM [ComprasPublicas].[dbo].[MiembrosDeComitesDirectivosCTDR] AS c
WHERE Territorio = 'Punatrenas-Montes de Oro'
	

	
UPDATE c
	SET Territorio = 'Turrialba-Jim�nez'
--SELECT *
FROM [ComprasPublicas].[dbo].[MiembrosDeComitesDirectivosCTDR] AS c
WHERE Territorio = 'Turrilaba - Jim�nez'




SELECT
 CAST([Puesto de representaci�n] AS varchar(max)) AS [Puesto de representaci�n]
,CAST([Representante legal propietario] AS varchar(max)) AS [Representante legal propietario]
,CAST([Territorio] AS varchar(max)) AS [Territorio]
,CAST([Sexo] AS varchar(max)) AS [Genero propietario]
,CAST([Composici�n ] AS varchar(max)) AS [Composici�n propietario]
,CAST([Grupo prioritario al que representa] AS varchar(max)) AS [Grupo prioritario al que representa propietario]
,CAST([Nombre de la instituci�n, Gobierno Local u Organizaci�n] AS varchar(max)) AS [Nombre de la instituci�n, Gobierno Local u Organizaci�n propietario]
--,CAST([Correo] AS varchar(max)) AS 
,CAST([Representante legal suplente] AS varchar(max)) AS [Representante legal suplente]
,CAST([Sexo1] AS varchar(max)) AS [Genero suplente]
,CAST([Composici�n 1] AS varchar(max)) AS [Composici�n suplente]
,CAST([Grupo prioritario al que representa1] AS varchar(max)) AS [Grupo prioritario al que representa suplente]
,CAST([Nombre de la instituci�n, Gobierno Local u Organizaci�n1] AS varchar(max)) AS [Nombre de la instituci�n, Gobierno Local u Organizaci�n suplente]
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
   


