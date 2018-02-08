Parameters lcPeriodo 
LOCAL lcTipOpe

SELE 0
IF !FILE_USE("DocCab","E")
	RETURN
ENDIF

SELE 0
IF !FILE_USE("DocDet","E")
	USE IN DocCab
	UNLOCK ALL
	RETURN
ENDIF

SELE DocCab
SET ORDER TO PERIODO

SELE DocDet
SET ORDER TO NroSec

*- Ventas
WAIT WINDOW "Recalculando Tipo de Cambio en VENTAS" NOWAIT
lcTipOpe = "1"
SELE DocCab
SEEK lcTipOpe+lcPeriodo
DO WHILE !EOF() AND DocCab.TipOpe = lcTipOpe AND DocCab.Periodo = lcPeriodo

	IF !SEEK("U"+DTOS(DocCab.FecDoc),"Cambio","TipMnd")
		MESSAGEBOX("Tipo de Cambio No Registrado para la Fecha "+CTOD(DocCab.FecDoc),0+64,"Valiadcion")
		USE IN DocCab
		USE IN DocDet
		UNLOCK ALL
		RETURN
	ENDIF
	IF EMPTY(Cambio.ImpVta)
		MESSAGEBOX("Tipo de Cambio No Registrado para la Fecha "+CTOD(DocCab.FecDoc),0+64,"Valiadcion")
		USE IN DocCab
		USE IN DocDet
		UNLOCK ALL
		RETURN
	ENDIF
	
	SELE DocCab
	REPLACE ImpCam WITH Cambio.ImpVta
	
	REPLACE ImpAfeDol WITH IIF(TipMnd = "U",ImpAfe,ROUND(ImpAfe/ImpCam,2)), ;
			ImpIgvDol WITH IIF(TipMnd = "U",ImpIgv,ROUND(ImpAfeDol*(PcjIgv/100),2)), ;
			ImpInaDol WITH IIF(TipMnd = "U",ImpIna,ROUND(ImpIna/ImpCam,2)), ;
			ImpTotDol WITH IIF(TipMnd = "U",ImpTot,(ImpAfeDol + ImpIgvDol + ImpInaDol)), ;
			ImpAfeSol WITH IIF(TipMnd = "U",ROUND(ImpAfe*ImpCam,2),ImpAfe), ;
			ImpIgvSol WITH IIF(TipMnd = "U",ROUND(ImpAfeSol*(PcjIgv/100),2),ImpIgv), ;
			ImpInaSol WITH IIF(TipMnd = "U",ROUND(ImpIna*ImpCam,2),ImpIna), ;
			ImpTotSol WITH IIF(TipMnd = "U",(ImpAfeSol + ImpIgvSol + ImpInaSol),ImpTot)
			
	SELE DocDet
	SEEK DocCab.NroSec
	SCAN WHILE !EOF() AND DocDet.NroSec = DocCab.NroSec
		REPLACE ImpAfeDol WITH IIF(DocCab.TipMnd = "U",ImpAfe,ROUND(ImpAfe/DocCab.ImpCam,2)), ;
				ImpIgvDol WITH IIF(DocCab.TipMnd = "U",ImpIgv,ROUND(ImpAfeDol*(DocCab.PcjIgv/100),2)), ;
				ImpInaDol WITH IIF(DocCab.TipMnd = "U",ImpIna,ROUND(ImpIna/DocCab.ImpCam,2)), ;
				ImpTotDol WITH IIF(DocCab.TipMnd = "U",ImpTot,(ImpAfeDol + ImpIgvDol + ImpInaDol)), ;
				ImpAfeSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpAfe*DocCab.ImpCam,2),ImpAfe), ;
				ImpIgvSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpAfeSol*(DocCab.PcjIgv/100),2),ImpIgv), ;
				ImpInaSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpIna*DocCab.ImpCam,2),ImpIna), ;
				ImpTotSol WITH IIF(DocCab.TipMnd = "U",(ImpAfeSol + ImpIgvSol + ImpInaSol),ImpTot)
	ENDSCAN
			
	SELE DocCab
	SKIP
ENDDO
		

*- Compras
WAIT WINDOW "Recalculando Tipo de Vambio en COMPRAS" NOWAIT
lcTipOpe = "2"
SELE DocCab
SEEK lcTipOpe+lcPeriodo
DO WHILE !EOF() AND DocCab.TipOpe = lcTipOpe AND DocCab.Periodo = lcPeriodo
	IF !SEEK("U"+DTOS(DocCab.FecDoc),"Cambio","TipMnd")
		MESSAGEBOX("Tipo de Cambio No Registrado para la Fecha "+CTOD(DocCab.FecDoc),0+64,"Valiadcion")
		USE IN DocCab
		USE IN DocDet
		UNLOCK ALL
		RETURN
	ENDIF
	IF EMPTY(Cambio.ImpVta)
		MESSAGEBOX("Tipo de Cambio No Registrado para la Fecha "+CTOD(DocCab.FecDoc),0+64,"Valiadcion")
		USE IN DocCab
		USE IN DocDet
		UNLOCK ALL
		RETURN
	ENDIF
	SELE DocCab
	REPLACE ImpCam WITH Cambio.ImpVta
	IF DocCab.TipDoc == '02'
		REPLACE	ImpAfeDol WITH IIF(TipMnd = "U",ImpAfe,ROUND(ImpAfe/ImpCam,2)), ;
				ImpIgvDol WITH IIF(TipMnd = "U",ImpIgv,ROUND(ImpIgv/ImpCam,2)), ;
				ImpInaDol WITH IIF(TipMnd = "U",ImpIna,ROUND(ImpIna/ImpCam,2)), ;
				ImpTotDol WITH IIF(TipMnd = "U",ImpTot,(ImpAfeDol - ImpIgvDol - ImpInaDol)), ;
				ImpAfeSol WITH IIF(TipMnd = "U",ROUND(ImpAfe*ImpCam,2),ImpAfe), ;
				ImpIgvSol WITH IIF(TipMnd = "U",ROUND(ImpIgv*ImpCam,2),ImpIgv), ;
				ImpInaSol WITH IIF(TipMnd = "U",ROUND(ImpIna*ImpCam,2),ImpIna), ;
				ImpTotSol WITH IIF(TipMnd = "U",(ImpAfeSol - ImpIgvSol - ImpInaSol),ImpTot)
	ELSE
		REPLACE ImpAfeDol WITH IIF(TipMnd = "U",ImpAfe,ROUND(ImpAfe/ImpCam,2)), ;
				ImpIgvDol WITH IIF(TipMnd = "U",ImpIgv,ROUND(ImpIgv/ImpCam,2)), ;
				ImpInaDol WITH IIF(TipMnd = "U",ImpIna,ROUND(ImpIna/ImpCam,2)), ;
				ImpOttDol WITH IIF(TipMnd = "U",ImpOtt,ROUND(ImpOtt/ImpCam,2)), ;
				ImpTotDol WITH IIF(TipMnd = "U",ImpTot,(ImpAfeDol + ImpIgvDol + ImpInaDol + ImpOttDol)), ;
				ImpAfeSol WITH IIF(TipMnd = "U",ROUND(ImpAfe*ImpCam,2),ImpAfe), ;
				ImpIgvSol WITH IIF(TipMnd = "U",ROUND(ImpIgv*ImpCam,2),ImpIgv), ;
				ImpInaSol WITH IIF(TipMnd = "U",ROUND(ImpIna*ImpCam,2),ImpIna), ;
				ImpOttSol WITH IIF(TipMnd = "U",ROUND(ImpOtt*ImpCam,2),ImpOtt), ;
				ImpTotSol WITH IIF(TipMnd = "U",(ImpAfeSol + ImpIgvSol + ImpInaSol + ImpOttSol),ImpTot)
	ENDIF
		
	SELE DocDet
	SEEK DocCab.NroSec
	SCAN WHILE !EOF() AND DocDet.NroSec = DocCab.NroSec
		IF DocCab.TipDoc == '02'
		REPLACE ImpAfeDol WITH IIF(DocCab.TipMnd = "U",ImpAfe,ROUND(ImpAfe/DocCab.ImpCam,2)), ;
				ImpIgvDol WITH IIF(DocCab.TipMnd = "U",ImpIgv,ROUND(ImpIgv/DocCab.ImpCam,2)), ;
				ImpInaDol WITH IIF(DocCab.TipMnd = "U",ImpIna,ROUND(ImpIna/DocCab.ImpCam,2)), ;
				ImpTotDol WITH IIF(DocCab.TipMnd = "U",ImpTot,(ImpAfeDol - ImpIgvDol - ImpInaDol)), ;
				ImpAfeSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpAfe*DocCab.ImpCam,2),ImpAfe), ;
				ImpIgvSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpIgv*DocCab.ImpCam,2),ImpIgv), ;
				ImpInaSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpIna*DocCab.ImpCam,2),ImpIna), ;
				ImpTotSol WITH IIF(DocCab.TipMnd = "U",(ImpAfeSol - ImpIgvSol - ImpInaSol),ImpTot)
		ELSE
		REPLACE ImpAfeDol WITH IIF(DocCab.TipMnd = "U",ImpAfe,ROUND(ImpAfe/DocCab.ImpCam,2)), ;
				ImpIgvDol WITH IIF(DocCab.TipMnd = "U",ImpIgv,ROUND(ImpIgv/DocCab.ImpCam,2)), ;
				ImpInaDol WITH IIF(DocCab.TipMnd = "U",ImpIna,ROUND(ImpIna/DocCab.ImpCam,2)), ;
				ImpOttDol WITH IIF(DocCab.TipMnd = "U",ImpOtt,ROUND(ImpOtt/DocCab.ImpCam,2)), ;
				ImpTotDol WITH IIF(DocCab.TipMnd = "U",ImpTot,(ImpAfeDol + ImpIgvDol + ImpInaDol + ImpOttDol)), ;
				ImpAfeSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpAfe*DocCab.ImpCam,2),ImpAfe), ;
				ImpIgvSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpIgv*DocCab.ImpCam,2),ImpIgv), ;
				ImpInaSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpIna*DocCab.ImpCam,2),ImpIna), ;
				ImpOttSol WITH IIF(DocCab.TipMnd = "U",ROUND(ImpOtt*DocCab.ImpCam,2),ImpOtt), ;
				ImpTotSol WITH IIF(DocCab.TipMnd = "U",(ImpAfeSol + ImpIgvSol + ImpInaSol + ImpOttSol),ImpTot)
		ENDIF
	ENDSCAN
	
	SELE DocCab
	SKIP
ENDDO
USE IN DocCab
USE IN DocDet

MESSAGEBOX("Proceso Termino Correctamente",0+64,"Recalculo del Tipo de Cambio")
RETURN