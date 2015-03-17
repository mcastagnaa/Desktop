SELECT * INTO #CubeData 
FROM dbo.fn_GetCubeDataTable('26 Mar 2014', null)

ALTER TABLE #CubeData
ADD
AllExpWeights decimal (15,10)

UPDATE cd
set cd.AllExpWeights =	CASE WHEN    cd.LongShort <> 'CashBaseCCY'
				THEN    cd.BaseCCYExposure / NaVs.CostNaV
				ELSE 0
			END
FROM #Cubedata cd
    LEFT JOIN tbl_FundsNaVsAndPLs AS NaVs 
	    ON (cd.FundId = NaVs.FundId AND cd.PositionDate = NaVs.NaVPLDate)    		   

SELECT  DISTINCT cub.FundCode
	, cub.FundClass
	, ROUND(SUM(tt.AllExpWeights)*100,2) AS Total
	, ROUND(SUM(bf.AllExpWeights)*100,2) AS BondFut
	, ROUND(SUM(bd.AllExpWeights)*100,2) AS Bonds
	, ROUND(SUM(ch.AllExpWeights)*100,2) AS Cash
	, ROUND(SUM(co.AllExpWeights)*100,2) AS CashOft
	, ROUND(SUM(cd.AllExpWeights)*100,2) AS CD
	, ROUND(SUM(cfd.AllExpWeights)*100,2) AS CFD
	, ROUND(SUM(cfdi.AllExpWeights)*100,2) AS CFDi
	, ROUND(SUM(eqo.AllExpWeights)*100,2) AS EqOpt
	, ROUND(SUM(eq.AllExpWeights)*100,2) AS Equities
	, ROUND(SUM(fo.AllExpWeights)*100,2) AS FutOft
	, ROUND(SUM(fx.AllExpWeights)*100,2) AS FX
	, ROUND(SUM(inf.AllExpWeights)*100,2) AS IndexFut
	, ROUND(SUM(ino.AllExpWeights)*100,2) AS IndexOpt
	, ROUND(SUM(oth.AllExpWeights)*100,2) AS Others
	, ROUND(SUM(pla.AllExpWeights)*100,2) AS Placing	
FROM	#CubeData AS cub
	LEFT JOIN #CubeData tt ON (cub.FundCode = tt.FundCode and cub.BMISCode = tt.BMISCode and tt.SecurityType not in ('Cash','CashOft','FX','FutOft') )
	LEFT JOIN #CubeData bf ON (cub.FundCode = bf.FundCode and cub.BMISCode = bf.BMISCode and cub.SecurityType = bf.SecurityType and bf.SecurityType = 'BondFut')
	LEFT JOIN #CubeData bd ON (cub.FundCode = bd.FundCode and cub.BMISCode = bd.BMISCode and cub.SecurityType = bd.SecurityType and bd.SecurityType = 'Bonds')
	LEFT JOIN #CubeData ch ON (cub.FundCode = ch.FundCode and cub.BMISCode = ch.BMISCode and cub.SecurityType = ch.SecurityType and ch.SecurityType = 'Cash')
	LEFT JOIN #CubeData co ON (cub.FundCode = co.FundCode and cub.BMISCode = co.BMISCode and cub.SecurityType = co.SecurityType and co.SecurityType = 'CashOft')
	LEFT JOIN #CubeData cd ON (cub.FundCode = cd.FundCode and cub.BMISCode = cd.BMISCode and cub.SecurityType = cd.SecurityType and cd.SecurityType = 'CD')
	LEFT JOIN #CubeData cfd ON (cub.FundCode = cfd.FundCode and cub.BMISCode = cfd.BMISCode and cub.SecurityType = cfd.SecurityType and cfd.SecurityType = 'CFD')
	LEFT JOIN #CubeData cfdi ON (cub.FundCode = cfdi.FundCode and cub.BMISCode = cfdi.BMISCode and cub.SecurityType = cfdi.SecurityType and cfdi.SecurityType = 'CFDi')
	LEFT JOIN #CubeData eqo ON (cub.FundCode = eqo.FundCode and cub.BMISCode = eqo.BMISCode and cub.SecurityType = eqo.SecurityType and eqo.SecurityType = 'EqOpt')
	LEFT JOIN #CubeData eq ON (cub.FundCode = eq.FundCode and cub.BMISCode = eq.BMISCode and cub.SecurityType = eq.SecurityType and eq.SecurityType = 'Equities')
	LEFT JOIN #CubeData fo ON (cub.FundCode = fo.FundCode and cub.BMISCode = fo.BMISCode and cub.SecurityType = fo.SecurityType and fo.SecurityType = 'FutOft')
	LEFT JOIN #CubeData fx ON (cub.FundCode = fx.FundCode and cub.BMISCode = fx.BMISCode and cub.SecurityType = fx.SecurityType and fx.SecurityType = 'FX')
	LEFT JOIN #CubeData inf ON (cub.FundCode = inf.FundCode and cub.BMISCode = inf.BMISCode and cub.SecurityType = inf.SecurityType and inf.SecurityType = 'IndexFut')
	LEFT JOIN #CubeData ino ON (cub.FundCode = ino.FundCode and cub.BMISCode = ino.BMISCode and cub.SecurityType = ino.SecurityType and ino.SecurityType = 'IndexOpt')
	LEFT JOIN #CubeData oth ON (cub.FundCode = oth.FundCode and cub.BMISCode = oth.BMISCode and cub.SecurityType = oth.SecurityType and oth.SecurityType = 'Others')
	LEFT JOIN #CubeData pla ON (cub.FundCode = pla.FundCode and cub.BMISCode = pla.BMISCode and cub.SecurityType = pla.SecurityType and pla.SecurityType = 'Placing')
WHERE cub.AllExpWeights <> 0
GROUP BY cub.FundCode, cub.FundClass
ORDER BY cub.FundCode

DROP TABLE #CubeData