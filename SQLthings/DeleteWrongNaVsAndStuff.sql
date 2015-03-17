USE VIVALDI;
--DELETE FROM tbl_Positions WHERE PositionDate = '2014 Dec 3' AND BOShortName = 'CT' 
--DELETE FROM tbl_FundsStatistics WHERE StatsDate = '2014 Dec 16'
--	AND FundId in (115, 18, 19, 114, --arbea, gsaf/lf, SKGEQ
--				221, 224, 227, 229, 232, --cirilium
--				132, 133, 134, 135, --generation
--				35, 26, 114, 117) --SMFO, NAEO, SKUSCAPGR, 
--				 --126, 127, 128, 129, 130, 131) --spectrum
--DELETE FROM tbl_FundsNaVsAndPLs WHERE NaVPLDate = '2014 Dec 16'
--	AND FundId in (115, 18, 19, 114, --arbea, gsaf/lf, SKGEQ
--				221, 224, 227, 229, 232, --cirilium
--				132, 133, 134, 135, --generation
--				35, 26, 114, 117) --SMFO, NAEO, SKUSCAPGR, 
--				 --126, 127, 128, 129, 130, 131) --spectrum
--DELETE FROM tbl_FundsFactorsLoads WHERE StatDate = '2014 Dec 16'
--	AND FundId in (115, 18, 19, 114, --arbea, gsaf/lf, SKGEQ
--				221, 224, 227, 229, 232, --cirilium
--				132, 133, 134, 135, --generation
--				35, 26, 114, 117) --SMFO, NAEO, SKUSCAPGR, 
--				 --126, 127, 128, 129, 130, 131) --spectrum
--
--DELETE FROM tbl_scenReports
--WHERE ReportDate = '2014 Dec 11' AND FundId IN (152, 153, 154)

DECLARE @datetogo AS datetime
		, @fundId as integer
SET @datetogo = '2014 Dec 18'
SET @fundid = 135


DELETE FROM tbl_FundsStatistics WHERE StatsDate = @datetogo
	AND FundId = @fundId

DELETE FROM tbl_FundsNaVsAndPLs WHERE NaVPLDate = @datetogo
	AND FundId = @fundId

DELETE FROM tbl_FundsFactorsLoads WHERE StatDate = @datetogo
	AND FundId = @fundId
