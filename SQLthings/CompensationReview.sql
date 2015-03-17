
USE PerfRep;

SELECT Fund.ShortCode
		, Fund.OurTeam
		, Fund.PrimaryObj
		, Fund.SectorLong
		, Perf.PeersNo1y
		, Perf.PeersNo3y
		, Perf.[PG1stQ_r1y] - Perf.[PG3stQ_r1y] AS [DispY]
		, Perf.[PG1stQ_ry-1] - Perf.[PG3stQ_ry-1] AS [DispY-1]
		, Perf.[PG1stQ_ry-2] - Perf.[PG3stQ_ry-2] AS [DispY-2]
		, Perf.[PG1stQ_ry-3] - Perf.[PG3stQ_ry-3] AS [DispY-3]
		, Perf.[PG1stQ_ry-4] - Perf.[PG3stQ_ry-4] AS [DispY-4]
		, Perf.[PG1stQ_ry-5] - Perf.[PG3stQ_ry-5] AS [DispY-5]
FROM	vw_AllProdsDets AS Fund LEFT JOIN
		vw_AllPerfDataset AS Perf ON
			(Fund.ShortCode = Perf.ShortCode)
WHERE	Perf.RefDate = '2014 Dec 31'
		AND Fund.OurTeam = 'DiscEq'
		AND Fund.PrimaryObj = 'Peer'