Use Vivaldi;

DECLARE	@RefDate datetime
		, @USDGBPrate float
		, @FundCode nvarchar(25)
		, @Threshold float

SET	@RefDate = '2015 Feb 2'
SET	@USDGBPRate = 1.534
SET @FundCode = 'OMDUS'
SET @Threshold = 0.07


CREATE TABLE #Holdings (
		PositionDate		datetime
		, PositionId		nvarchar(20)
		, Description 		nvarchar(200)
		, Instrument		nvarchar(20)
		, Desk				nvarchar(25)
		, FundCode			nvarchar(25)
		, Side				nvarchar(20)
		, TotalShares 		Float
		, TotalValue 		Float
		, PercMarketCap 	Float
		, PercADV3m			Float
		, PercADV1m			Float
		, MktCapUSDmn		Float
		)
----------------------------------------------------------------------------------
INSERT INTO #Holdings
EXEC spS_GetOMGIEqExp @RefDate, null
----------------------------------------------------------------------------------

SELECT DISTINCT PositionId
INTO	#FundHoldings
FROM	#Holdings
WHERE	FundCode = @FundCode



SELECT	H.PositionId
		, H.Description
		, AVG(H.MktCapUSDmn)/@USDGBPrate*1000000 AS MktCapGBP
		--, FH.PositionId AS TESTING
		, SUM(H.PercMarketCap) AS PercMarketCap
		, SUM(H.TotalShares) AS TotalShares
		, SUM(H.PercADV3m) AS PercADV3m
		, SUM(H.PercADV1m) AS PercADV1m

FROM	#Holdings AS H LEFT JOIN
		#FundHoldings AS FH ON (H.PositionId = FH.PositionId)
WHERE	FH.PositionId IS NOT NULL
GROUP BY	H.PositionId
			, H.Description
			, FH.PositionId
HAVING	SUM(H.PercMarketCap) > @Threshold
ORDER BY	SUM(H.PercMarketCap) DESC

----------------------------------------------------------------------------------

DROP TABLE #Holdings, #FundHoldings

