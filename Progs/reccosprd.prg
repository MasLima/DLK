Parameters lcCodAlm,lcPeriodo 
LOCAL lcTipDoc,lcNroDoc,lcCodAlmMP,lcCodAlmPT
LOCAL lnImpMPSol,lnImpMPDol,lnTotImpMpSol,lnTotImpMpDol,lnTotRegMP
LOCAL lnCanArt,lnCanPrd,lnTotCanPrd,lnTotReg
LOCAL lnImpArtSol,lnImpArtDol,lnImpVtaSol,lnImpVtaDol,lnImpTotVtaSol,lnImpTotVtaDol,lnImpLinVtaSol,lnImpLinVtaDol
*-
lcCodAlmMP = "001"
lcCodAlmPT = "002"

*-
SELE 0
IF !FILE_USE("ArtMovCab","E")
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("ArtMovDet","E")
	USE IN ArtMovCab
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("ArtSld","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("ArtSldMes","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	USE IN ArtSld
	RETURN
ENDIF
*-
*-
SELE 0
IF !FILE_USE("PrdCab","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	USE IN ArtSld
	USE IN ArtSldMes
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("PrdDet","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	USE IN ArtSld
	USE IN ArtSldMes
	USE IN PrdCab
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("PrdPer","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	USE IN ArtSld
	USE IN ArtSldMes
	USE IN PrdCab
	USE IN PrdDet
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("PrdPerLin","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	USE IN ArtSld
	USE IN ArtSldMes
	USE IN PrdCab
	USE IN PrdDet
	USE IN PrdPer
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("PrdPerCos","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	USE IN ArtSld
	USE IN ArtSldMes
	USE IN PrdCab
	USE IN PrdDet
	USE IN PrdPer
	USE IN PrdPerLin
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("ArtCos","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	USE IN ArtSld
	USE IN ArtSldMes
	USE IN PrdCab
	USE IN PrdDet
	USE IN PrdPer
	USE IN PrdPerLin
	USE IN PrdPerCos
	RETURN
ENDIF
*-

*- Consistencias
*- Que se tenga el Costo Promedio de MP para el Periodo
SELE ArtCos
SET ORDER TO CodArt
SEEK lcCodAlmMP+lcPeriodo
IF EOF()
	MESSAGEBOX("No Existe Costo Promedio para las Materia Primas",0+64,"Validacion")
	SAL_RecCosPrd()
	RETURN
ENDIF
*- Que Existan Parametros para el Periodo
SELE PrdPer
SET ORDER TO Periodo
SEEK lcPeriodo
IF EOF()
	MESSAGEBOX("No Existen Parametros para el Periodo",0+64,"Validacion")
	SAL_RecCosPrd()
	RETURN
ENDIF
*- Que Tenga Gastos de Fabricacion
IF EMPTY(PrdPer.TotGF)
	MESSAGEBOX("No se Tiene Gastos de Fabricacion",0+64,"Validacion")
	SAL_RecCosPrd()
	RETURN
ENDIF
*- Que Tenga Mano de Obra
IF EMPTY(PrdPer.TotMO)
	MESSAGEBOX("No se Tiene Mano de Obra",0+64,"Validacion")
	SAL_RecCosPrd()
	RETURN
ENDIF

*- Que Existan Parametros por Linea
SELE PrdPerLin
SET ORDER TO Periodo
SEEK lcPeriodo
IF EOF()
	MESSAGEBOX("No Existen Parametros por Linea para el Periodo",0+64,"Validacion")
	SAL_RecCosPrd()
	RETURN
ENDIF

*- Selecciono Ordenes de Produccion del Periodo
SELECT P.Periodo, P.TipDoc, P.NroDoc, P.FecDoc ;
FROM PrdCab P ;
WHERE P.Periodo = lcPeriodo AND IndSit <> 9 AND !EMPTY(P.CodLin) ;
INTO CURSOR TmpPrd
IF _TALLY < 1
	USE IN TmpPrd
	MESSAGEBOX("No Existen Ordenes de Produccion para el Periodo",0+64,"Validacion")
	SAL_RecCosPrd()
	RETURN
ENDIF

*- Elimina Movimiento del Periodo
SELE PrdPerCos
SET ORDER TO Periodo

DELETE FROM PrdPerCos ;
WHERE Periodo = lcPeriodo
PACK 

*- Indicador de Proceso
SELE PrdPer
REPLACE IndPcs WITH 0
*set step on
*- Obtengo Materia Prima y Cantidad Producida
SELE TmpPrd
GO TOP
DO WHILE !EOF()
	SELE TmpPrd
	lcTipDoc = TmpPrd.TipDoc
	lcNroDoc = TmpPrd.NroDoc
			
	*- Obtengo Movimiento desde Almacen
	SELEC C.TipDocRef, C.NroDocRef, C.CodAlm, C.Periodo, C.TipMov, C.TipTsc, C.NroSec, ;
		  C.TipDoc, C.NroDoc, C.FecDoc ;
	FROM ArtMovCab C ;
	WHERE C.TipDocRef+C.NroDocRef = lcTipDoc+PADR(lcNroDoc,20) ;
	ORDER BY C.CodAlm, C.Periodo, C.TipMov, C.TipTsc ;
	INTO CURSOR TmpMov
	IF _TALLY < 1
		*- No se Tiene Movimientos Materia Prima / Cantidad Producida
		USE IN TmpMov
		*INSERT INTO PrdPerCos (Periodo, TipDoc, NroDoc) ;
    	*       VALUES (lcPeriodo, lcTipDoc, lcNroDoc)
		*IF _TALLY < 1
		*	MESSAGEBOX("ERROR al INSERTAR",0+64,"Validacion")
		*ENDIF
		SELE PrdPerCos
		APPEND BLANK
		REPLACE Periodo WITH lcPeriodo, ;
				TipDoc  WITH lcTipDoc, ;
				NroDoc  WITH lcNroDoc
		SELE TmpPrd
		SKIP	
		LOOP
	ENDIF
	
	*- Obtengo Materia Prima
	SELEC C.CodAlm, C.Periodo, C.TipMov, C.TipTsc, ;
		  D.CodArt, D.CanArt, D.CodUnd, D.CanMed, D.UndMed ;
	FROM TmpMov C INNER JOIN ArtMovDet D ON C.NroSec = D.NroSec ;
	WHERE C.CodAlm = lcCodAlmMP ;
	INTO CURSOR TmpMP
	IF _TALLY < 1
		*- No se Tiene Materia Prima
		USE IN TmpMP
		USE IN TmpMov
		*INSERT INTO PrdPerCos (Periodo, TipDoc, NroDoc) ;
	  	*       VALUES (lcPeriodo, lcTipDoc, lcNroDoc)
		*IF _TALLY < 1
		*	MESSAGEBOX("ERROR al INSERTAR",0+64,"Validacion")
		*ENDIF
		SELE PrdPerCos
		APPEND BLANK
		REPLACE Periodo WITH lcPeriodo, ;
				TipDoc  WITH lcTipDoc, ;
				NroDoc  WITH lcNroDoc
		SELE TmpPrd
		SKIP	
		LOOP
	ENDIF
	STORE 0.00 TO lnImpMPSol,lnImpMPDol
	SELE TmpMP
	GO TOP
	SCAN WHILE !EOF()
		IF TmpMP.TipMov == "S"
			IF TmpMP.TipTsc == "08" 
				IF SEEK(TmpMP.CodAlm+TmpMP.Periodo+TmpMP.CodArt,"ArtCos","CodArt")
					lnImpMPSol = lnImpMPSol + ROUND(TmpMP.CanMed*ArtCos.ImpSld,2)
					lnImpMPDol = lnImpMPDol + ROUND(TmpMP.CanMed*ArtCos.ImpSldDol,2)
				ENDIF
			ENDIF
		ELSE
			IF TmpMP.TipTsc == "02" 
				IF SEEK(TmpMP.CodAlm+TmpMP.Periodo+TmpMP.CodArt,"ArtCos","CodArt")
					lnImpMPSol = lnImpMPSol - ROUND(TmpMP.CanMed*ArtCos.ImpSld,2)
					lnImpMPDol = lnImpMPDol - ROUND(TmpMP.CanMed*ArtCos.ImpSldDol,2)
				ENDIF
			ENDIF
		ENDIF
	ENDSCAN
	USE IN TmpMP
	
	*- Obtengo Cantidad Producida
	SELEC C.CodAlm, C.Periodo, C.TipMov, C.TipTsc, ;
		  D.CodArt, D.CanArt, D.CodUnd, D.CanMed, D.UndMed ;
	FROM TmpMov C INNER JOIN ArtMovDet D ON C.NroSec = D.NroSec ;
	WHERE C.CodAlm = lcCodAlmPT AND ((C.TipMov == "I" AND C.TipTsc == "08") OR (C.TipMov == "S" AND C.TipTsc == "02")) ;
	ORDER BY D.CodArt ;
	INTO CURSOR TmpPT
	IF _TALLY < 1
		*- No se Tiene Cantidad Producida
		USE IN TmpPT
		USE IN TmpMov
		*INSERT INTO PrdPerCos (Periodo, TipDoc, NroDoc, ImpMP, ImpMPDol) ;
	  	*       VALUES (lcPeriodo, lcTipDoc, lcNroDoc, lnImpMPSol, lnImpMPDol)
		*IF _TALLY < 1
		*	MESSAGEBOX("ERROR al INSERTAR",0+64,"Validacion")
		*ENDIF
		SELE PrdPerCos
		APPEND BLANK
		REPLACE Periodo WITH lcPeriodo, ;
				TipDoc  WITH lcTipDoc, ;
				NroDoc  WITH lcNroDoc, ;
				ImpMP WITH lnImpMPSol, ;
				ImpMPDol WITH lnImpMPDol
		SELE TmpPrd
		SKIP	
		LOOP
	ENDIF
	SELEC C.CodArt, C.CodUnd, SUM(IIF(C.TipMov == "I",C.CanArt,-1*C.CanArt)) As CanArt ;
	FROM TmpPT C ;
	ORDER BY C.CodArt, C.CodUnd ;
	GROUP BY C.CodArt, C.CodUnd ;
	INTO CURSOR TmpCanPrd
	*- Total Cantidad Producida por Und de Produccion
	STORE 0 TO lnCanArt,lnCanPrd,lnTotCanPrd,lnTotReg
	SELE TmpCanPrd
	GO TOP
	SCAN WHILE !EOF()
		IF SEEK(PADR(TmpCanPrd.CodArt,20),"ArtArt","CodArt")
			lnTotCanPrd = lnTotCanPrd + ROUND(TmpCanPrd.CanArt*ArtArt.FacPrd,3)
		ENDIF
		lnTotReg = lnTotReg + 1
	ENDSCAN
	*- DisTribucion de Materia Prima
	STORE 0 TO lnTotImpMpSol,lnTotImpMpDol,lnTotRegMP
	SELE TmpCanPrd
	GO TOP
	SCAN WHILE !EOF()
		lnTotRegMP =  lnTotRegMP + 1
		SELE PrdPerCos
		APPEND BLANK
		REPLACE Periodo WITH lcPeriodo, ;
				TipDoc  WITH lcTipDoc, ;
				NroDoc  WITH lcNroDoc, ;
				CodArt  WITH TmpCanPrd.CodArt, ;
				CodUnd  WITH TmpCanPrd.CodUnd, ;
				CanArt  WITH TmpCanPrd.CanArt
			
		IF SEEK(PADR(codArt,20),"ArtArt","CodArt")
		REPLACE UndPrd  WITH ArtArt.UndPrd, ;
				FacPrd  WITH ArtArt.FacPrd, ;
				CanPrd  WITH ROUND(CanArt*FacPrd,3), ;
				CodLin  WITH ArtArt.CodLin
		ENDIF
			
		IF lnTotRegMP =  lnTotReg
			REPLACE ImpMP WITH lnImpMPSol - lnTotImpMpSol, ;
					ImpMPDol WITH lnImpMPDol - lnTotImpMpDol
		ELSE
			IF lnTotCanPrd > 0.000000
				REPLACE ImpMP WITH ROUN((lnImpMPSol*CanPrd)/lnTotCanPrd,2), ;
						ImpMPDol WITH ROUN((lnImpMPDol*CanPrd)/lnTotCanPrd,2)
			ENDIF
		ENDIF
		lnTotImpMpSol = lnTotImpMpSol + ImpMP
		lnTotImpMpDol = lnTotImpMpDol + ImpMPDol
		
		SELE TmpCanPrd
	ENDSCAN
	USE IN TmpCanPrd
	USE IN TmpPT
	USE IN TmpMov
	
	SELE TmpPrd
	SKIP
ENDDO
USE IN TmpPrd
*-
*- Obtengo Cantidad Producida y Importe Materia Prima por Linea
SELEC C.Periodo, C.CodLin, SUM(C.CanPrd) As CanPrd, COUNT(C.CodLin) As CanReg, ;
	  SUM(C.ImpMP) As ImpMP, SUM(C.ImpMPDol) As ImpMPDol ;
FROM PrdPerCos C ;
WHERE C.Periodo = lcPeriodo ;
ORDER BY C.Periodo, C.CodLin ;
GROUP BY C.Periodo, C.CodLin ;
INTO CURSOR TmpLin

*- Actualizo Parametros por Linea
SELE TmpLin
GO TOP
SCAN WHILE !EOF()
	IF SEEK(TmpLin.Periodo+TmpLin.CodLin,"PrdPerLin","Periodo")
		SELE PrdPerLin
		REPLACE ImpMP  WITH TmpLin.ImpMP, ;
				CanPrd WITH TmpLin.CanPrd, ;
				CanReg WITH TmpLin.CanReg, ;
				ImpMPDol  WITH TmpLin.ImpMPDol, ;
 				ImpTot WITH (ImpMP + ImpMO + ImpGF), ;
				ImpCos WITH IIF(CanPrd > 0,ROUND(ImpTot/CanPrd,6),0.00), ;
				ImpTotDol WITH (ImpMPDol + ImpMODol + ImpGFDol), ;
				ImpCosDol WITH IIF(CanPrd > 0,ROUND(ImpTotDol/CanPrd,6),0.00)
	ENDIF
	SELE TmpLin
ENDSCAN

*- Actualizo Costo de Produccion por Articulo
SELE PrdPerLin
SET ORDER TO Periodo
SELE PrdPerCos
SET Order TO Periodo

SELE PrdPerLin
SEEK lcPeriodo
DO WHILE !EOF() AND Periodo = lcPeriodo
	lcCodLin = PrdPerLin.CodLin
	STORE 0 TO lnTotImpMOSol,lnTotImpMODol,lnTotImpGFSol,lnTotImpGFDol,lnCanReg
	SELE PrdPerCos
	SEEK lcPeriodo+lcCodLin
	DO WHILE !EOF() AND Periodo+CodLin = lcPeriodo+lcCodLin
		lnCanReg = lnCanReg + 1
		IF lnCanReg == PrdPerLin.CanReg
			REPLACE ImpMO    WITH PrdPerLin.ImpMO - lnTotImpMOSol, ;
					ImpGF    WITH PrdPerLin.ImpGF - lnTotImpGFSol, ;
					ImpMODol WITH PrdPerLin.ImpMODol - lnTotImpMODol, ;					
					ImpGFDol WITH PrdPerLin.ImpGFDol - lnTotImpGFDol
		ELSE
			IF PrdPerLin.CanPrd > 0
			REPLACE ImpMO    WITH ROUND(PrdPerLin.ImpMO*(CanPrd/PrdPerLin.CanPrd),2), ;
					ImpGF    WITH ROUND(PrdPerLin.ImpGF*(CanPrd/PrdPerLin.CanPrd),2), ;
					ImpMODol WITH ROUND(PrdPerLin.ImpMODol*(CanPrd/PrdPerLin.CanPrd),2), ;
					ImpGFDol WITH ROUND(PrdPerLin.ImpGFDol*(CanPrd/PrdPerLin.CanPrd),2)
			ENDIF
		ENDIF
		REPLACE ImpTot 	  WITH (ImpMP + ImpMO + ImpGF), ;
				ImpCos 	  WITH IIF(CanArt > 0,ROUND(ImpTot/CanArt,6),0.00), ;
				ImpTotDol WITH (ImpMPDol + ImpMODol + ImpGFDol), ;
				ImpCosDol WITH IIF(CanArt > 0,ROUND(ImpTotDol/CanArt,6),0.00)
		
		lnTotImpMOSol = lnTotImpMOSol + ImpMO
		lnTotImpMODol = lnTotImpMODol + ImpMODol
		lnTotImpGFSol = lnTotImpGFSol + ImpGF
		lnTotImpGFDol = lnTotImpGFDol + ImpGFDol
		
		SKIP
	ENDDO
	SELE PrdPerLin
	SKIP
ENDDO
*-
*-
*- Obtengo Importe de Venta y Utilidad por Articulo
STORE 0.00 TO lnImpTotVtaSol,lnImpTotVtaDol
SELE PrdPerLin
SEEK lcPeriodo
DO WHILE !EOF() AND Periodo = lcPeriodo
	lcCodLin = PrdPerLin.CodLin
	STORE 0.00 TO lnImpLinVtaSol,lnImpLinVtaDol
	SELE PrdPerCos
	SEEK lcPeriodo+lcCodLin
	DO WHILE !EOF() AND Periodo+CodLin = lcPeriodo+lcCodLin
		*- Obtengo Movimientos de Almacen para Almacen de Productos Termindados 
		*- Salidas por Ventas o Ingresos por Devolucion 
		*- Segun Orden de Produccion
		SELEC C.TipDocRef, C.NroDocRef, C.CodAlm, C.Periodo, C.TipMov, C.TipTsc, C.NroSec, ;
		  	  C.TipDoc, C.NroDoc, C.FecDoc, C.TipMnd, C.ImpCam ;
		FROM ArtMovCab C ;
		WHERE C.TipDocRef+C.NroDocRef = PrdPerCos.TipDoc+PADR(PrdPerCos.NroDoc,20) ;
		ORDER BY C.CodAlm, C.Periodo, C.TipMov, C.TipTsc ;
		INTO CURSOR TmpMov
		IF _TALLY < 1
			*- No se Tiene Venta
			USE IN TmpMov
			SELE PrdPerCos
			SKIP	
			LOOP
		ENDIF
		*- Almacen de Productos Terminados y Salidas por Venta o Ingreso por Devolucion
		SELEC C.CodAlm, C.Periodo, C.TipMov, C.TipTsc, C.TipMnd, C.ImpCam, ;
		 	  D.CodArt, D.CanArt, D.CodUnd, D.ImpArt ;
		FROM TmpMov C INNER JOIN ArtMovDet D ON C.NroSec = D.NroSec ;
		WHERE C.CodAlm = lcCodAlmPT AND ((C.TipMov == "I" AND C.TipTsc == "02") OR (C.TipMov == "S" AND C.TipTsc == "01")) ;
		ORDER BY D.CodArt ;
		INTO CURSOR TmpVta
		IF _TALLY < 1
			*- No se Tiene Venta
			USE IN TmpMov
			USE IN TmpVta
			SELE PrdPerCos
			SKIP	
			LOOP
		ENDIF
		USE IN TmpMov
		*- Solo los Articulos
		SELEC C.CodAlm, C.Periodo, C.TipMov, C.TipTsc, C.TipMnd, C.ImpCam, ;
		 	  C.CodArt, C.CanArt, C.CodUnd, C.ImpArt ;
		FROM TmpVta C ;
		WHERE C.CodArt = PrdPerCos.CodArt ;
		ORDER BY C.CodArt ;
		INTO CURSOR TmpArt
		IF _TALLY < 1
			*- No se Tiene Venta
			USE IN TmpArt
			USE IN TmpVta
			SELE PrdPerCos
			SKIP	
			LOOP
		ENDIF
		USE IN TmpVta
		
		*- Calculo Importe de Venta en Soles y Dolares
		STORE 0 TO lnImpArtSol,lnImpArtDol,lnImpVtaSol,lnImpVtaDol
		SELE TmpArt
		GO TOP
		SCAN WHILE !EOF()
			lnImpArtSol = IIF(TipMnd == "P",ImpArt,ROUND(ImpArt*ImpCam,6))
			lnImpArtDol = IIF(TipMnd == "U",ImpArt,IIF(ImpCam > 0,ROUND(ImpArt/ImpCam,6),0.00))
			lnImpVtaSol = lnImpVtaSol + IIF(TipMov == "S",1,-1)*ROUND(CanArt*lnImpArtSol,6)
			lnImpVtaDol = lnImpVtaDol + IIF(TipMov == "S",1,-1)*ROUND(CanArt*lnImpArtDol,6)
			SELE TmpArt		
		ENDSCAN
		USE IN TmpArt
		
		SELE PrdPerCos
		REPLACE ImpVta WITH lnImpVtaSol, ;
				ImpUti WITH (ImpVta - ImpTot), ;
				ImpVtaDol WITH lnImpVtaDol, ;
				ImpUtiDol WITH (ImpVtaDol - ImpTotDol)
		lnImpLinVtaSol = lnImpLinVtaSol + ImpVta
		lnImpLinVtaDol = lnImpLinVtaDol + ImpVtaDol
		SKIP
	ENDDO
	SELE PrdPerLin
	REPLACE ImpVta WITH lnImpLinVtaSol, ;
			ImpUti WITH (ImpVta - ImpTot), ;
			ImpVtaDol WITH lnImpLinVtaDol, ;
			ImpUtiDol WITH (ImpVtaDol - ImpTotDol)
	lnImpTotVtaSol = lnImpTotVtaSol + ImpVta
	lnImpTotVtaDol = lnImpTotVtaDol + ImpVtaDol		
	SKIP
ENDDO
*-
SELE PrdPer
REPLACE TotVta WITH lnImpTotVtaSol, ;
		TotUti WITH (TotVta - TotTot), ;
		TotVtaDol WITH lnImpTotVtaDol, ;
		TotUtiDol WITH (TotVtaDol - TotTotDol), ;
		FecPcs WITH DATE()
*		IndPcs WITH 1, ;		
*-

*- Indexa
*-
SELE PrdPerCos
WAIT WINDOW "Indexado PrdPerCos" NOWAIT
PACK
INDEX ON Periodo+CodLin+CodArt TAG Periodo
USE
*-
SELE PrdPerLin
WAIT WINDOW "Indexado PrdPerLin" NOWAIT
PACK
INDEX ON Periodo+CodLin TAG Periodo
USE
*-
SELE PrdCab
USE
*-
SELE PrdDet
USE
*-
SELE PrdPer
USE
*
SELE ArtSldMes
USE
*-
SELE ArtMovDet
USE
*-
SELE ArtMovCab
USE
*-
SELE ArtCos
USE

*- Fin
MESSAGEBOX("Proceso Termino Correctamente",0)
RETURN

PROCEDURE SAL_RecCosPrd
USE IN ArtMovCab
USE IN ArtMovDet
USE IN ArtSld
USE IN ArtSldMes
USE IN PrdCab
USE IN PrdDet
USE IN PrdPer
USE IN PrdPerLin
USE IN PrdPerCos
USE IN ArtCos
RETURN