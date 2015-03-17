Use PerfRep;

Select TOP 5 AuM.RefDate
		, P.ShortCode
		, LEFT(P.FundName, 50) AS FundName
		, AuM.AuMGBP

FROM	tbl_Products AS P LEFT JOIN
		tbl_FinanceAuM AS AuM On (
			P.ShortCode = AuM.ShortCode
			)
WHERE AuM.RefDate = '2013 dec 31'
		
ORDER BY	AuM.AuMGBP DESC