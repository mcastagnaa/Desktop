USE PerfRep;

SELECT ShortCode
		, RefDate
		, PrimaryObj
		, BenCode
		, PeerGroup
		, ProdTER
		, NP5y_a
		, Ben5y_a
		, PGmed_r5y_a
		, CAST(ProdRank5y AS Float)/PeersNo5y AS PeerPerc
		, (CASE WHEN (CAST(ProdRank5y AS Float)/PeersNo5y < 0.5)
			AND (NP5y_a-Ben5y_a > 0) THEN 1 
				WHEN (ProdRank5y IS NULL) OR (Ben5y IS NULL) THEN NULL
			ELSE 0 END) AS Test
		, (PGmed_r5y_a-Ben5y_a) AS MedianPeerVsBench

INTO #RawSet
FROM vw_AllPerfDataset
WHERE	PrimaryObj in ('Peer', 'Index')
		AND NP5y_a IS NOT NULL
		AND (PGmed_r5y_a-Ben5y_a) IS NOT NULL
		AND ABS(PGmed_r5y_a-Ben5y_a) < 10

SELECT ShortCode
, COUNT(ShortCode) AS Funds
FROM #RawSet
GROUP BY ShortCode

SELECT RefDate
, COUNT(RefDate) AS Funds
FROM #RawSet
GROUP BY RefDate
ORDER BY RefDate

SELECT PeerGroup
, COUNT(PeerGroup) AS Funds
FROM #RawSet
GROUP BY PeerGroup



SELECT Avg(MedianPeerVsBench) AS Avg
		, StDev(MedianPeerVsBench) AS StDev
		, MAX(MedianPeerVsBench) AS MAX
		, MIN(MedianPeerVsBench) AS MIN
		, Count(MedianPeerVsBench) AS COUNT

FROM #RawSet
DROP TABLE #RawSet
