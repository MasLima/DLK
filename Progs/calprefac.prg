LOCAL lnOldSele, lnOldRecno, lnImpAfeCal, lnImpBtoCal, lnImpTotCal, lnImpInaCal, lnTotArtCal

lnOldSele = SELECT()
STORE 0 TO lnTotArtCal,lnImpBtoCal,lnImpAfeCal,lnImpTotCal,lnImpInaCal,lnImpIgvCal

SELE DocDet
SEEK DocCab.NroSec
SCAN WHILE !EOF() AND DocDet.NroSec = DocCab.NroSec
	REPLACE ImpDes WITH ROUND(ImpPre*(PcjDes/100),6), ;
			ImpArt WITH (ImpPre - ImpDes), ;
			TotArt WITH ROUND(CanArt*ImpArt,2)

	DO 	CASE 
	CASE DocCab.IndIgv == 1 OR EMPTY(DocCab.IndIgv)
	&& PRECIOS SIN IGV
		IF IndIna == 1  && INAFECTOS AL IGV
			REPLACE ImpAfe WITH 0.00, ;
					ImpIgv WITH 0.00, ;
					ImpIna WITH TotArt, ;
					ImpAfeDol WITH 0.00, ;
					ImpIgvDol WITH 0.00, ;
					ImpInaDol WITH IIF(DocCab.TipMnd = "U",ImpIna,IIF(DocCab.ImpCam > 0,ROUND(ImpIna/DocCab.ImpCam,2),0.00)), ;
					ImpAfeSol WITH 0.00, ;
					ImpIgvSol WITH 0.00, ;
					ImpInaSol WITH IIF(DocCab.TipMnd = "P",ImpIna,ROUND(ImpIna*DocCab.ImpCam,2))
		ELSE && AFECTOS AL IGV
			REPLACE ImpAfe WITH TotArt, ;
					ImpIgv WITH ROUND(ImpAfe*(DocCab.PcjIgv/100),2), ;
					ImpIna WITH 0.00, ;
					ImpAfeDol WITH IIF(DocCab.TipMnd = "U",ImpAfe,IIF(DocCab.ImpCam > 0,ROUND(ImpAfe/DocCab.ImpCam,2),0.00)), ;
					ImpIgvDol WITH ROUND(ImpAfeDol*(DocCab.PcjIgv/100),2), ;
					ImpInaDol WITH 0.00, ;
					ImpAfeSol WITH IIF(DocCab.TipMnd = "P",ImpAfe,ROUND(ImpAfe*DocCab.ImpCam,2)), ;
					ImpIgvSol WITH ROUND(ImpAfeSol*(DocCab.PcjIgv/100),2), ;
					ImpInaSol WITH 0.00
		ENDIF		
		REPLACE ImpTot WITH (ImpAfe + ImpIgv + ImpIna), ;
				ImpTotDol WITH (ImpAfeDol + ImpIgvDol + ImpInaDol), ;
				ImpTotSol WITH (ImpAfeSol + ImpIgvSol + ImpInaSol)
	CASE DocCab.IndIgv == 2
	&& PRECIOS INCLUYEN IGV
		IF IndIna == 1  && INAFECTOS AL IGV
			REPLACE	ImpTot WITH TotArt, ;
					ImpIna WITH ImpTot, ;
					ImpAfe WITH 0.00, ;
					ImpIgv WITH 0.00, ;
					ImpTotDol WITH IIF(DocCab.TipMnd = "U",ImpTot,IIF(DocCab.ImpCam > 0,ROUND(ImpTot/DocCab.ImpCam,2),0.00)), ;
					ImpInaDol WITH ImpTotDol, ;
		 			ImpAfeDol WITH 0.00, ;
					ImpIgvDol WITH 0.00, ;
					ImpTotSol WITH IIF(DocCab.TipMnd = "P",ImpTot,ROUND(ImpTot*DocCab.ImpCam,2)), ;
					ImpInaSol WITH ImpTotSol, ;
					ImpAfeSol WITH 0.00, ;
					ImpIgvSol WITH 0.00
		ELSE  && AFECTOS AL IGV
			REPLACE	ImpTot WITH TotArt, ;
					ImpAfe WITH ROUND((ImpTot)/((100 + DocCab.PcjIgv)/100),2), ;
					ImpIgv WITH (ImpTot - ImpAfe), ;
					ImpIna WITH 0.00, ;
					ImpTotDol WITH IIF(DocCab.TipMnd = "U",ImpTot,IIF(DocCab.ImpCam > 0,ROUND(ImpTot/DocCab.ImpCam,2),0.00)), ;
		 			ImpAfeDol WITH ROUND((ImpTotDol)/((100 + DocCab.PcjIgv)/100),2), ;
					ImpIgvDol WITH (ImpTotDol - ImpAfeDol), ;
					ImpInaDol WITH 0.00, ;
					ImpTotSol WITH IIF(DocCab.TipMnd = "P",ImpTot,ROUND(ImpTot*DocCab.ImpCam,2)), ;
					ImpAfeSol WITH ROUND((ImpTotSol)/((100 + DocCab.PcjIgv)/100),2), ;
					ImpIgvSol WITH (ImpTotSol - ImpAfeSol), ;
					ImpInaSol WITH 0.00
		ENDIF
	CASE DocCab.IndIgv == 3
	&& IGV MODIFICABLE
		IF IndIna == 1  && INAFECTOS AL IGV
			REPLACE ImpAfe WITH 0.00, ;
					ImpIgv WITH 0.00, ;
					ImpIna WITH TotArt, ;
					ImpAfeDol WITH 0.00, ;
					ImpIgvDol WITH 0.00, ;
					ImpInaDol WITH IIF(DocCab.TipMnd = "U",ImpIna,IIF(DocCab.ImpCam > 0,ROUND(ImpIna/DocCab.ImpCam,2),0.00)), ;
					ImpAfeSol WITH 0.00, ;
					ImpIgvSol WITH 0.00, ;
					ImpInaSol WITH IIF(DocCab.TipMnd = "P",ImpIna,ROUND(ImpIna*DocCab.ImpCam,2))
		ELSE && AFECTOS AL IGV
			REPLACE ImpAfe WITH TotArt, ;
					ImpIgv WITH ROUND(ImpAfe*(DocCab.PcjIgv/100),2), ;
					ImpIna WITH 0.00, ;
					ImpAfeDol WITH IIF(DocCab.TipMnd = "U",ImpAfe,IIF(DocCab.ImpCam > 0,ROUND(ImpAfe/DocCab.ImpCam,2),0.00)), ;
					ImpIgvDol WITH ROUND(ImpAfeDol*(DocCab.PcjIgv/100),2), ;
					ImpInaDol WITH 0.00, ;
					ImpAfeSol WITH IIF(DocCab.TipMnd = "P",ImpAfe,ROUND(ImpAfe*DocCab.ImpCam,2)), ;
					ImpIgvSol WITH ROUND(ImpAfeSol*(DocCab.PcjIgv/100),2), ;
					ImpInaSol WITH 0.00
		ENDIF		
		REPLACE ImpTot WITH (ImpAfe + ImpIgv + ImpIna), ;
				ImpTotDol WITH (ImpAfeDol + ImpIgvDol + ImpInaDol), ;
				ImpTotSol WITH (ImpAfeSol + ImpIgvSol + ImpInaSol)
	ENDCASE	
	lnTotArtCal	= lnTotArtCal + TotArt
	lnImpBtoCal = lnImpBtoCal + ROUND(CanArt*ImpPre,2)
	lnImpTotCal = lnImpTotCal + ImpTot
	lnImpAfeCal = lnImpAfeCal + ImpAfe
	lnImpInaCal = lnImpInaCal + ImpIna
	lnImpIgvCal = lnImpIgvCal + ImpIgv
ENDSCAN

SELE DocCab
DO 	CASE 
CASE IndIgv == 1 OR EMPTY(IndIgv)
&& PRECIOS SIN IGV
REPLACE ImpBto    WITH lnImpBtoCal, ;
		ImpAfe    WITH lnImpAfeCal, ;
		ImpIna    WITH lnImpInaCal, ;
		ImpDes    WITH (ImpBto - lnTotArtCal), ;
		ImpIgv 	  WITH ROUND(ImpAfe*(PcjIgv/100),2), ;
		ImpTot 	  WITH ImpAfe + ImpIgv + ImpIna, ;
		ImpAfeDol WITH IIF(TipMnd = "U",ImpAfe,IIF(ImpCam > 0,ROUND(ImpAfe/ImpCam,2),0.00)), ;
		ImpIgvDol WITH ROUND(ImpAfeDol*(PcjIgv/100),2), ;
		ImpInaDol WITH IIF(TipMnd = "U",ImpIna,IIF(ImpCam > 0,ROUND(ImpIna/ImpCam,2),0.00)), ;
		ImpTotDol WITH (ImpAfeDol + ImpIgvDol + ImpInaDol), ;
		ImpAfeSol WITH IIF(TipMnd = "P",ImpAfe,ROUND(ImpAfe*ImpCam,2)), ;
		ImpIgvSol WITH ROUND(ImpAfeSol*(PcjIgv/100),2), ;
		ImpInaSol WITH IIF(TipMnd = "P",ImpIna,ROUND(ImpIna*ImpCam,2)), ;
		ImpTotSol WITH (ImpAfeSol + ImpIgvSol + ImpInaSol)
CASE IndIgv == 2
&& PRECIOS INCLUYEN IGV
REPLACE ImpBto    WITH lnImpBtoCal, ;
		ImpTot 	  WITH lnImpTotCal, ;
		ImpIna    WITH lnImpInaCal, ;
		ImpAfe 	  WITH ROUND((ImpTot - ImpIna)/((100 + PcjIgv)/100),2), ;
		ImpIgv 	  WITH (ImpTot - ImpIna - ImpAfe), ;
		ImpDes    WITH (ImpBto - lnTotArtCal), ;
		ImpTotDol WITH IIF(TipMnd = "U",ImpTot,IIF(ImpCam > 0,ROUND(ImpTot/ImpCam,2),0.00)), ;
		ImpTotSol WITH IIF(TipMnd = "P",ImpTot,ROUND(ImpTot*ImpCam,2)), ;
		ImpInaDol WITH IIF(TipMnd = "U",ImpIna,IIF(ImpCam > 0,ROUND(ImpIna/ImpCam,2),0.00)), ;
		ImpInaSol WITH IIF(TipMnd = "P",ImpIna,ROUND(ImpIna*ImpCam,2)), ;
		ImpAfeDol WITH ROUND((ImpTotDol - ImpInaDol)/((100 + PcjIgv)/100),2), ;
		ImpIgvDol WITH (ImpTotDol - ImpInaDol - ImpAfeDol), ;
		ImpAfeSol WITH ROUND((ImpTotSol - ImpInaSol)/((100 + PcjIgv)/100),2), ;
		ImpIgvSol WITH (ImpTotSol - ImpInaSol - ImpAfeSol)
CASE IndIgv == 3		
&& IGV MODIFICABLE
REPLACE ImpBto    WITH lnImpBtoCal, ;
		ImpAfe    WITH lnImpAfeCal, ;
		ImpIna    WITH lnImpInaCal, ;
		ImpDes    WITH (ImpBto - lnTotArtCal), ;
		ImpTot 	  WITH ImpAfe + ImpIgv + ImpIna, ;
		ImpAfeDol WITH IIF(TipMnd = "U",ImpAfe,IIF(ImpCam > 0,ROUND(ImpAfe/ImpCam,2),0.00)), ;
		ImpIgvDol WITH IIF(TipMnd = "U",ImpIgv,IIF(ImpCam > 0,ROUND(ImpIgv/ImpCam,2),0.00)), ;
		ImpInaDol WITH IIF(TipMnd = "U",ImpIna,IIF(ImpCam > 0,ROUND(ImpIna/ImpCam,2),0.00)), ;
		ImpTotDol WITH (ImpAfeDol + ImpIgvDol + ImpInaDol), ;
		ImpAfeSol WITH IIF(TipMnd = "P",ImpAfe,ROUND(ImpAfe*ImpCam,2)), ;
		ImpIgvSol WITH IIF(TipMnd = "P",ImpIgv,ROUND(ImpIgv*ImpCam,2)), ;
		ImpInaSol WITH IIF(TipMnd = "P",ImpIna,ROUND(ImpIna*ImpCam,2)), ;
		ImpTotSol WITH (ImpAfeSol + ImpIgvSol + ImpInaSol)
ENDCASE	
ThisForm.Refresh
SELE (lnOldSele)
RETURN