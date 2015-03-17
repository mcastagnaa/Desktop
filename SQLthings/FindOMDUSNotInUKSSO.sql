USE Vivaldi;


SELECT * 
INTO #OMDUS
FROM tbl_Positions
WHERE FundShortName = 'OMDUS'
AND PositionDate > '31 Jan 2014'
AND SecurityType NOT IN ('Cash', 'FX')


SELECT * 
INTO #UKSSO
FROM tbl_Positions
WHERE FundShortName = 'UKSSO'
AND PositionDate > '31 Jan 2014'
AND SecurityType NOT IN ('Cash', 'FX')

--SELECT COUNT(PositionDate) FROM SELECT DISTINCT PositionDate FROM #OMDUS

SELECT	OMDUS.PositionDate
		, OMDUS.SecurityType
		, OMDUS.PositionID
		, ASSET.Description
		, OMDUS.Units AS OMDUSPosition
		, UKSSO.Units AS UKSSOPosition
INTO	#SSOnull
FROM	#OMDUS AS OMDUS LEFT JOIN
		#UKSSO AS UKSSO ON (
			OMDUS.PositionDate = UKSSO.PositionDate
			AND OMDUS.PositionId = UKSSO.PositionId
			) LEFT JOIN
		tbl_AssetPrices AS ASSET ON (
			OMDUS.PositionDate = ASSET.PriceDate
			AND OMDUS.SecurityType = ASSET.SecurityType
			AND OMDUS.PositionID = ASSET.SecurityID)

WHERE	UKSSO.Units IS NULL
		
SELECT * FROM #SSOnull
ORDER BY PositionDate

SELECT	PositionId
		, Description
		, COUNT(PositionId) AS COUNTById
FROM #SSOnull
GROUP BY PositionId, Description
ORDER BY COUNT(PositionId) DESC

SELECT	PositionDate
		, COUNT(OMDUSPosition) AS COUNTByDate
FROM #SSOnull
GROUP BY PositionDate
ORDER BY PositionDate



DROP TABLE #UKSSO, #OMDUS, #SSOnull