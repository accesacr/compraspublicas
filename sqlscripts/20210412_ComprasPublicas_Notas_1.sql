

SELECT 
	COUNT(*) AS Num
	,LEFT(AÑO_DE_APERTURA_CONCURSO,4) AS yearAd
FROM [ComprasPublicas].[dbo].[siac_masivo_x_lineas]
GROUP BY LEFT(AÑO_DE_APERTURA_CONCURSO,4) --= '2020'
ORDER BY LEFT(AÑO_DE_APERTURA_CONCURSO,4)



SELECT 
	top 10 *
FROM [ComprasPublicas].[dbo].[siac_masivo_x_lineas]
GROUP BY LEFT(AÑO_DE_APERTURA_CONCURSO,4) --= '2020'
ORDER BY LEFT(AÑO_DE_APERTURA_CONCURSO,4)
--GROUP BY LEFT(FECHA_ACTO_DE_ADJUDICACION,4) --= '2020'
--ORDER BY LEFT(FECHA_ACTO_DE_ADJUDICACION,4)

;WITH cte AS (
SELECT 
*
FROM [ComprasPublicas].[dbo].[siac_masivo_x_lineas]
UNION ALL
SELECT 
*
FROM [ComprasPublicas].[dbo].[siac_masivo_x_lineas_2020]
)
SELECT * INTO [ComprasPublicas].[Export].[AdjudicacionesSIAC] FROM cte

1165560





SELECT 
	LEFT(AÑO_DE_APERTURA_CONCURSO,4) AS yearAd
	,COUNT(*) AS Num
	,COUNT(DISTINCT NUMERO_PROCEDIMIENTO) AS NumDistinctProcedimientos	
FROM [ComprasPublicas].[Export].[AdjudicacionesSIAC]
GROUP BY LEFT(AÑO_DE_APERTURA_CONCURSO,4) --= '2020'
ORDER BY LEFT(AÑO_DE_APERTURA_CONCURSO,4) DESC

SELECT 
    
    NUMERO_PROCEDIMIENTO AS CodigoProcedimiento
FROM [Export].[AdjudicacionesSIAC] AS siac
LEFT OUTER JOIN [Export].[AdjudicacionesSICOP] AS sicop ON siac.NUMERO_PROCEDIMIENTO = sicop.Número_procedimiento



SELECT 
	count(*)
	,count(DISTINCT Número_procedimiento) AS numProc
FROM [Export].[AdjudicacionesSICOP] AS a
INNER JOIN [Export].[ProveedoresSICOP] AS p ON a.Cédula_adjudicatario = p.[Cedula]



SELECT 
	Cédula_adjudicatario
	,COUNT(*) AS Num
	,COUNT(DISTINCT Tipo) AS NumTipo	
FROM [Export].[AdjudicacionesSIAC] AS a
LEFT OUTER JOIN [Export].[ProveedoresSICOP] AS p ON a.Cédula_adjudicatario = p.[Cedula]
GROUP BY Cédula_adjudicatario
HAVING COUNT(DISTINCT Tipo)  > 1



SELECT 
	count(*) AS Num
	,count(DISTINCT Numero_procedimiento) AS numProc
FROM [Export].[AdjudicacionesSIAC] AS a
INNER JOIN [Export].[ProveedoresSICOP] AS p ON a.CEDULA_OFERENTE_ADJUDICADO = p.[Cedula]


SELECT 
	CEDULA_OFERENTE_ADJUDICADO
	,COUNT(*) AS Num
	,COUNT(DISTINCT Tipo) AS NumTipo	
FROM [Export].[AdjudicacionesSIAC] AS a
LEFT OUTER JOIN [Export].[ProveedoresSICOP] AS p ON a.CEDULA_OFERENTE_ADJUDICADO = p.[Cedula]
GROUP BY CEDULA_OFERENTE_ADJUDICADO
HAVING COUNT(DISTINCT Tipo)  > 1



SELECT  CAST(Cedula AS BIGINT) AS c FROM [Export].[ProveedoresSICOP] --GROUP BY Cedula
SELECT 
	CAST(CEDULA_OFERENTE_ADJUDICADO	AS BIGINT) AS c
FROM [Export].[AdjudicacionesSIAC] AS a


SELECT top 10 *
FROM [Export].[AdjudicacionesSIAC] WHERE 



SELECT * FROM [Export].[ProveedoresSICOP] WHERE Cedula = '1201700589'
SELECT 
	*
FROM [Export].[AdjudicacionesSIAC] WHERE CEDULA_OFERENTE_ADJUDICADO = '1201700589'


1201700589


'3101117902'
'3101657318'

SELECT
	SUBPARTIDA_DE_GASTO
	,COUNT(*) AS num
FROM [Export].[AdjudicacionesSIAC]
WHERE SUBPARTIDA_DE_GASTO LIKE '%no encontrada%'
GROUP BY SUBPARTIDA_DE_GASTO
ORDER BY COUNT(*) DESC

CREATE SCHEMA pj AUTHORIZATION dbo;





SELECT 
	DISTINCT a.CEDULA_OFERENTE_ADJUDICADO	
FROM [Export].[AdjudicacionesSIAC] AS a
LEFT OUTER JOIN [Export].[ProveedoresSICOP] AS p ON a.CEDULA_OFERENTE_ADJUDICADO = p.[Cedula]
WHERE p.[Cedula] IS NULL




;WITH cte AS (
	SELECT * FROM [pj].[Adj_Proveedores_2016$]
	UNION   
	SELECT * FROM [pj].[Adj_Proveedores_2017$]
	UNION   
	SELECT * FROM [pj].[Adj_Proveedores_2018$]
	UNION   
	SELECT * FROM [pj].[Adj_Proveedores_2019$]
	UNION   
	SELECT * FROM [pj].[Adj_Proveedores_2020$]
)
SELECT *
INTO [Export].[ProveedoresPJ]
FROM cte 

USE [ComprasPublicas]
GO

SELECT [ocid]
      ,[ID de Entrega]
      ,[Adjudicaciones:ID de Adjudicación]
      ,[Open Contracting ID]
      ,[Adjudicaciones:Proveedores:ID de Organización]
      ,[Adjudicaciones:Proveedores:Nombre de la Organización]
  FROM [pj].[Adj_Proveedores_2016$]
GO


SELECT DISTINCT [Adjudicaciones:Proveedores:ID de Organización] FROM
[Export].[ProveedoresPJ]



CREATE SCHEMA pj AUTHORIZATION dbo;

[pj].

_2020


SELECT top 10 * FROM [pj].[Adj_Proveedores_2016$] ORDER BY CAST([Adjudicaciones:Proveedores:ID de Organización] AS BIGINT) DESC

--SELECT top 10 * FROM [pj].[Adj_Proveedores_2017$] ORDER BY CAST([Adjudicaciones:Proveedores:ID de Organización] AS BIGINT) DESC

--SELECT top 10 * FROM [pj].[Adj_Proveedores_2018$] ORDER BY CAST([Adjudicaciones:Proveedores:ID de Organización] AS BIGINT) DESC
--SELECT top 10 * FROM [pj].[Adj_Proveedores_2019$] ORDER BY CAST([Adjudicaciones:Proveedores:ID de Organización] AS BIGINT) DESC
SELECT top 10 * FROM [pj].[Adj_Proveedores_2020$] ORDER BY CAST([Adjudicaciones:Proveedores:ID de Organización] AS BIGINT) DESC

SELECT * FROM [pj].[Adj_Proveedores_2016$] ORDER BY 
UNION
SELECT * FROM [pj].[Adj_Proveedores_2017$]


SELECT DISTINCT [Adjudicaciones:Proveedores:ID de Organización] FROM [pj].[Adj_Proveedores_2016$]
UNION
SELECT DISTINCT [Adjudicaciones:Proveedores:ID de Organización] FROM [pj].[Adj_Proveedores_2017$]
UNION
SELECT DISTINCT [Adjudicaciones:Proveedores:ID de Organización] FROM [pj].[Adj_Proveedores_2018$]
UNION
SELECT DISTINCT [Adjudicaciones:Proveedores:ID de Organización] FROM [pj].[Adj_Proveedores_2019$]
UNION
SELECT DISTINCT [Adjudicaciones:Proveedores:ID de Organización] FROM [pj].[Adj_Proveedores_2020$]





;WITH cte AS (
	SELECT 
		[NUMERO_PROCEDIMIENTO] 
		,COUNT(*) AS Num
	FROM [Export].[AdjudicacionesSIAC] 
	GROUP BY [NUMERO_PROCEDIMIENTO] 
	HAVING COUNT(*) > 1
)
SELECT TOP 1514
	c.Num AS NumRegistrosProc
	,a.*
FROM [Export].[AdjudicacionesSIAC] AS a
INNER JOIN cte AS c ON a.[NUMERO_PROCEDIMIENTO] = c.[NUMERO_PROCEDIMIENTO]
ORDER BY c.num DESC, CAST(LINEA AS INT) ASC

https://github.com/accesacr/compraspublicas