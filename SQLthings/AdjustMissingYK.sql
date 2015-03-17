USE Vivaldi;

--DECLARE @RefDate datetime
--SET @RefDate = (SELECT MAX(PositionDate) FROM tbl_Positions)
--
--SELECT @RefDate
--------------------------------------------------

Select	[ID ISIN]
		, Security
FROM	tbl_Vivaldi_StageIn
WHERE	Security IN ('IntRateOpt')
		AND dataSourceCode = 'CITI'
GROUP BY [ID ISIN], Security

UPDATE	tbl_Vivaldi_StageIn
SET		Security = 'IndexOpt'
WHERE	Security IN ('IntRateOpt')
		AND dataSourceCode = 'CITI'

Select	[ID ISIN], Security
FROM	tbl_Vivaldi_StageIn
WHERE	Security IN ('IndexOpt', 'EqOpt')
		AND dataSourceCode = 'CITI'
GROUP BY  [ID ISIN], Security

UPDATE	tbl_Vivaldi_StageIn
SET		[ID ISIN] = RTRIM([ID ISIN]) + ' Equity'
WHERE	Security IN ('EqOpt')
		AND dataSourceCode = 'CITI'

UPDATE	tbl_Vivaldi_StageIn
SET		[ID ISIN] = RTRIM([ID ISIN]) + ' Index'
WHERE	Security IN ('IndexOpt')
		AND dataSourceCode = 'CITI'

Select	[ID ISIN], Security
FROM	tbl_Vivaldi_StageIn
WHERE	Security IN ('IndexOpt', 'EqOpt')
		AND dataSourceCode = 'CITI'
GROUP BY  [ID ISIN], Security

UPDATE	tbl_Vivaldi_StageIn
SET		Security = 'IndexOpt'
		, [ID ISIN] = 'UKX 3/15 C7000 Index'
WHERE	[ID ISIN] IN ('UKX3 C7000 Index', 'UKX3 C7000 Index Index')

Select	[ID ISIN], Security
FROM	tbl_Vivaldi_StageIn
WHERE	Security IN ('IndexOpt', 'EqOpt')


--UPDATE	tbl_Vivaldi_StageIn
--SET		[ID ISIN] = 'BW0BGZ3'
--WHERE	[ID ISIN] = 'B41C3S1'


--------------------------------------------------

--Select	PositionId
--		, SecurityType 
--FROM	tbl_Positions
--WHERE	PositionDate = @RefDate
--		AND SecurityType IN ('IndexOpt', 'EqOpt')
--		AND BOShortName = 'CITI'
--GROUP BY PositionId, SecurityType
-------------------------------------------------------------------
--UPDATE	tbl_Positions
--SET		PositionId = PositionId + ' Equity'
--WHERE	PositionDate = @RefDate
--		AND SecurityType IN ('EqOpt')
--		AND BOShortName = 'CITI'
--
--UPDATE	tbl_Positions
--SET		PositionId = PositionId + ' Index'
--WHERE	PositionDate = @RefDate
--		AND SecurityType IN ('IndexOpt')
--		AND BOShortName = 'CITI'
-------------------------------------------------------------------
--Select	PositionId
--		, SecurityType 
--FROM	tbl_Positions
--WHERE	PositionDate = @RefDate
--		AND SecurityType IN ('IndexOpt', 'EqOpt')
--		AND BOShortName = 'CITI'
--GROUP BY PositionId, SecurityType
--
----SELECT * FROM tbl_Vivaldi_stagein

--
--SELECT	[ID ISIN]
--		, StartPrice
--INTO	#RightCCY
--FROM	tbl_Vivaldi_StageIn
--WHERE	PortfolioCode = 'GEAR'
--		AND Security IN ('FX', 'FOA', 'Cash')
--GROUP BY	[ID ISIN], StartPrice
--
--
--SELECT	S.ID
--		, S.[ID ISIN]
--		, S.StartPrice AS WrongPrice
--		, G.StartPrice AS GoodPrice
--INTO	#IDs
--FROM	tbl_Vivaldi_StageIn AS S JOIN
--		#RightCCY AS G ON (
--			S.[ID ISIN] = G.[ID ISIN]
--			)
--WHERE	S.PortfolioCode = 'MIHYB'
--
--SELECT * FROM #IDs
--
--UPDATE tbl_Vivaldi_StageIn
--SET		StartPrice = IDs.GoodPrice
--FROM	tbl_Vivaldi_StageIn As StI JOIN 
--		#IDs AS IDs ON (StI.ID = IDs.ID)
--
--SELECT	S.ID
--		, S.[ID ISIN]
--		, S.StartPrice AS WrongPrice
--		, G.StartPrice AS GoodPrice
--FROM	tbl_Vivaldi_StageIn AS S JOIN
--		#RightCCY AS G ON (
--			S.[ID ISIN] = G.[ID ISIN]
--			)
--WHERE	S.PortfolioCode = 'MIHYB'
--
--DROP TABLE #RightCCY
--DROP TABLE #IDs

--------------------------------------------------------------
Select	*
FROM	tbl_Vivaldi_StageIn
WHERE	Security LIKE 'CDS%'

UPDATE	tbl_Vivaldi_StageIn
SET		Units = ABS(Units)
WHERE	Security LIKE ('CDS%')

Select	*
FROM	tbl_Vivaldi_StageIn
WHERE	Security LIKE 'CDS%'
--------------------------------------------------------------

Select	*
FROM	tbl_Vivaldi_StageIn
WHERE	[ID ISIN] IN('KMR LN')
		OR [ID ISIN] LIKE 'BP__ Curncy'
		OR [ID ISIN] LIKE 'CD__ Curncy'
		OR [ID ISIN] LIKE 'AD__ Curncy'
		OR [ID ISIN] LIKE 'JY__ Curncy'


UPDATE	tbl_Vivaldi_StageIn
SET		[MarketPrice] = [MarketPrice] * 100
		, [StartPrice] = [StartPrice] * 100
WHERE	[ID ISIN] IN('KMR LN')
		OR [ID ISIN] LIKE 'BP__ Curncy'
		OR [ID ISIN] LIKE 'CD__ Curncy'
		OR [ID ISIN] LIKE 'AD__ Curncy'
		OR [ID ISIN] LIKE 'JY__ Curncy'

Select	*
FROM	tbl_Vivaldi_StageIn
WHERE	[ID ISIN] IN('KMR LN')
		OR [ID ISIN] LIKE 'BP__ Curncy'
		OR [ID ISIN] LIKE 'CD__ Curncy'
		OR [ID ISIN] LIKE 'AD__ Curncy'
		OR [ID ISIN] LIKE 'JY__ Curncy'


--UPDATE	tbl_Vivaldi_StageIn
--SET		[ID ISIN] = 'BVFCRP1'
--WHERE	[ID ISIN] = 'BJ357L4'

--SELECT * FROM tbl_Vivaldi_StageIn where [ID ISIN] = 'UKX3 C7000 Index'