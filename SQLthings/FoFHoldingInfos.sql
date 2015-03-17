USE Vivaldi;


DECLARE @RefDate datetime
SET @RefDate = '2013 Sep 27'

SELECT	FoF.FundCode
		, FoFPos.PositionId
		, FoFPos.SecurityType
		, FoFPos.Units
		, FoFPos.StartPrice
		, Under.FundCode
		, UnderNaV.CostNav As UnderNaV
		, UnderPos.SecurityType
		, UnderPos.PositionId
		, UnderPos.Units
		, UnderPos.StartPrice

FROM	tbl_Funds AS FoF LEFT JOIN
		tbl_Positions AS FoFPos ON
			(FoF.FundCode = FoFPos.FundShortName) LEFT JOIN
		tbl_Funds AS Under ON 
			(FoFPos.PositionId = Under.BBGCode) LEFT JOIN
		tbl_Positions AS UnderPos ON (
			UnderPos.FundShortName = Under.FundCode
			AND UnderPos.PositionDate = FoFPos.PositionDate
			) LEFT JOIN
		tbl_FundsNaVsAndPLs AS UnderNaV ON 
			(UnderNaV.NaVPlDate = UnderPos.PositionDate
				AND UnderNaV.FundId = Under.Id)


WHERE	FoFPos.PositionDate = @refDate
		AND FoF.FundClassId = 3
		--AND FoFPos.SecurityType = 'Others'
		--AND Under.FundCode IS NULL

ORDER BY FOF.Id

/*





SELECT	FOFList.Id
		, FoFList.FundCode
		, FoFNaV.NaVPLDate As RefDate
		

FROM	tbl_Funds AS FoFList LEFT JOIN 
		tbl_FundsNaVsAndPLs AS FoFNaV ON 
			(FoFlist.Id = FoFNaV.FundId) LEFT JOIN

WHERE	FoFList.FundClassId = 3	-- FoF
		AND FoFNaV
*/