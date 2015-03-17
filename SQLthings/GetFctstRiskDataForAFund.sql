USE PRODUCT;

SELECT	V.FundCode
		, V.NaVDate
		, V.[PortFolio VaR]/100 AS PortVaR
		, V.[Benchmark VaR]/100 AS BenchVaR
		, V.[Gross Weight]/100 AS GrossExp
		, V.[Net Weight]/100 AS NetExp

FROM	dbo.vew_FSR_FacstetDailyRisk AS V 
WHERE V.FundCode = 'SKSTRATBND'

ORDER BY V.NaVDate 
		 