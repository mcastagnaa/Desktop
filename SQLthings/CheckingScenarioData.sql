USE Vivaldi;

SELECT	S.ReportDate
		, S.FundId
		, F.FundCode 
		, F.FundName
		, S.PortPerf
INTO	#BasicCheck
FROM	tbl_ScenReports AS S LEFT JOIN
		tbl_Funds AS F ON (S.FundId = F.Id) LEFT JOIN
		tbl_EnumScen AS SD ON (SD.ID = S.ReportId)
--WHERE	S.PortPerf = 0

SELECT	ReportDate
		, Count(FundId) AS ScenNumber
FROM	#BasicCheck
GROUP BY	ReportDate
ORDER BY	ReportDate DESC

SELECT	ReportDate
		, Count(FundId) AS ScenNumber
FROM	#BasicCheck
WHERE		NOT((PortPerf IS NULL) OR (PortPerf = ''))
GROUP BY	ReportDate

ORDER BY	ReportDate DESC



--SELECT	ReportDate
--		, FundCode
--		, COUNT(FundId) AS Instances
--FROM	#BasicCheck
--GROUP BY ReportDate, FundCode
--HAVING	COUNT(FundId) > 0 AND ReportDate = '2014/Jul/17'
--ORDER BY FundCode, ReportDate DESC

GO
DROP TABLE #BasicCheck
GO