USE PerfRep;

SELECT	ShortCode
		, SoldAs
		, OurTeam
		, OurPM
FROM tbl_Products
WHERE	InceptionDate < getdate() 
		AND (CloseDate IS NULL Or CloseDate > getdate())
		AND ShortCode NOT IN ('AS17', 'GSAFLX', 'GSAFMN', 'GSAFLF',
			'OMTSY', 'U3', 'U7')
		AND OurTeam NOT IN ('MultiAsset', 'ExtSStrat')
ORDER BY OurTeam, OurPM, ShortCode
