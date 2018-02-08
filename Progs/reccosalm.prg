Parameters lcPeriodo 
LOCAL lcCodArt,lnCanIng,lnCanSal,lnCanAct,lnImpCos,lcPeriodoAnt
LOCAL lnCanSal,lnCanIng,lnCanMed,lnImpMed,lnSaldo,llTieneIngresos,lcTipRef,lcNroRef

*-
IF SUBS(lcPeriodo,5,2) == "01"
	lcPeriodoAnt = ALLTRIM(STR(VAL(SUBS(lcPeriodo,1,4))-1))+"11"
ELSE
	lcPeriodoAnt = SUBS(lcPeriodo,1,4)+PADL(ALLTRIM(STR(VAL(SUBS(lcPeriodo,5,2))-1)),2,"0")
ENDIF

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
IF !FILE_USE("ArtMovCos","E")
	USE IN ArtMovCab
	USE IN ArtMovDet
	RETURN
ENDIF

*lcFile = gCodUsu+"ArtMovCos"
*SELE ArtMovCos
*COPY STRUCTURE TO &gRuta\Temp\&lcFile
*SELE 0
*USE &gRuta\Temp\&lcFile IN 0 ALIAS TmpCos EXCLUSIVE

*- Elimina Movimiento del Periodo
SELE ArtMovCos
SET ORDER TO Periodo
SEEK lcPeriodo
SCAN WHILE !EOF() AND Periodo = lcPeriodo
	DELETE 
ENDSCAN 
PACK 

*- CARGA PENDIENTES
*-
*- Selecciono Movimiento del Periodo Anterior
SELECT C.* ;
FROM ArtMovCos C ;
WHERE C.Periodo = lcPeriodoAnt ;
ORDER BY C.CodArt,C.FecDoc,C.TipDoc,C.NroDoc ;
INTO CURSOR TmpMovAnt

IF _TALLY > 0
*- Selecciono Ingresos del Movimiento Anterior
SELECT C.* ;
FROM TmpMovAnt C ;
WHERE C.TipMov = "I" ;
ORDER BY C.CodArt,C.FecDoc,C.TipDoc,C.NroDoc ;
INTO CURSOR TmpIngAnt

*- Selecciono Salidas del Movimiento Anterior
SELECT C.* ;
FROM TmpMovAnt C ;
WHERE C.TipMov = "S" ;
ORDER BY C.CodArt,C.TipRef,C.NroRef ;
INTO CURSOR TmpSalAnt
USE IN TmpMovAnt

*- Adiciono Ingresos Pendientes Al Costo
SELE TmpIngAnt
GO TOP
DO WHILE !EOF()
	lnCanSal = 0
	SELECT SUM(CanMed) As CanSal ;
	FROM TmpSalAnt ;
	WHERE CodArt = TmpIngAnt.CodArt AND TipRef = TmpIngAnt.TipDoc AND NroRef = TmpIngAnt.NroDoc ;
	INTO CURSOR Tmp
	IF _TALLY > 0
		lnCanSal = Tmp.CanSal
	ENDIF
	USE IN Tmp
	IF (TmpIngAnt.CanMed - lnCanSal) > 0.000
	SELE ArtMovCos
	APPEN BLANK
	REPLACE CodAlm  WITH TmpIngAnt.CodAlm, ;
			Periodo WITH lcPeriodo, ;
			CodArt	WITH TmpIngAnt.CodArt, ;
			FecDoc	WITH TmpIngAnt.FecDoc, ;
			TipDoc	WITH TmpIngAnt.TipDoc, ;
			NroDoc	WITH TmpIngAnt.NroDoc, ;
			TipRef	WITH TmpIngAnt.TipDoc, ;
			NroRef	WITH TmpIngAnt.NroDoc, ;
			UndMed	WITH TmpIngAnt.UndMed, ;
			CanMed	WITH (TmpIngAnt.CanMed - lnCanSal), ;
			ImpMed	WITH TmpIngAnt.ImpMed, ;
			CodUnd	WITH TmpIngAnt.CodUnd, ;
			CanArt	WITH TmpIngAnt.CanArt, ;
			ImpArt	WITH TmpIngAnt.ImpArt, ;
			TipMov  WITH TmpIngAnt.TipMov, ;
			TipTsc  WITH TmpIngAnt.TipTsc, ;
			TipMnd  WITH TmpIngAnt.TipMnd, ;
			ImpCam  WITH TmpIngAnt.ImpCam, ;
			ImpMedDol WITH TmpIngAnt.ImpMedDol, ;
			ImpMedSol WITH TmpIngAnt.ImpMedSol
	ENDIF
	SELE TmpIngAnt
	SKIP
ENDDO
ENDIF
*-
*- CARGA MOVIMIENTO DEL PERIODO
*-
*- Selecciono Movimiento del Periodo
SELECT C.CodAlm, C.Periodo, D.CodArt, TTOD(C.FecDoc) As FecDoc, C.TipDoc, C.NroDoc, ;
	   D.CodUnd, D.CanArt,  D.ImpArt, D.UndMed, D.CanMed, D.ImpMed, ;
	   C.TipMov, C.TipTsc, C.TipMnd, C.ImpCam ;
FROM ArtMovCab C INNER JOIN ArtMovDet D ON C.NroSec = D.NroSec ;
WHERE C.Periodo = lcPeriodo AND TipTsc = "01" AND !EMPTY(D.CodArt) ;
ORDER BY D.CodArt,C.FecDoc,C.TipDoc,C.NroDoc ;
INTO CURSOR TmpMov

*- Selecciono Ingresos del Periodo
SELECT C.* ;
FROM TmpMov C ;
WHERE C.TipMov = "I" ;
ORDER BY C.CodArt,C.FecDoc,C.TipDoc,C.NroDoc ;
INTO CURSOR TmpIng

*- Adiciono Ingresos Al Costo
SELE TmpIng
GO TOP
SCAN WHILE !EOF()
	SELE ArtMovCos
	APPEN BLANK
	REPLACE CodAlm  WITH TmpIng.CodAlm, ;
			Periodo WITH TmpIng.Periodo, ;
			CodArt	WITH TmpIng.CodArt, ;
			FecDoc	WITH TmpIng.FecDoc, ;
			TipDoc	WITH TmpIng.TipDoc, ;
			NroDoc	WITH TmpIng.NroDoc, ;
			TipRef	WITH TmpIng.TipDoc, ;
			NroRef	WITH TmpIng.NroDoc, ;
			UndMed	WITH TmpIng.UndMed, ;
			CanMed	WITH TmpIng.CanMed, ;
			ImpMed	WITH TmpIng.ImpMed, ;
			CodUnd	WITH TmpIng.CodUnd, ;
			CanArt	WITH TmpIng.CanArt, ;
			ImpArt	WITH TmpIng.ImpArt, ;
			TipMov  WITH TmpIng.TipMov, ;
			TipTsc  WITH TmpIng.TipTsc, ;
			TipMnd  WITH TmpIng.TipMnd, ;
			ImpCam  WITH TmpIng.ImpCam, ;
			ImpMedDol WITH IIF(TipMnd=="U",ImpMed,IIF(ImpCam > 0,ROUND(ImpMed/ImpCam,2),0.00)), ;
			ImpMedSol WITH IIF(TipMnd=="U",ROUND(ImpMed*ImpCam,2),ImpMed)
	SELE TmpIng
ENDSCAN
USE IN TmpIng

*- Selecciono Salidas del Periodo
SELECT C.* ;
FROM TmpMov C ;
WHERE C.TipMov = "S" ;
ORDER BY C.CodArt,C.FecDoc,C.TipDoc,C.NroDoc ;
INTO CURSOR TmpSal
USE IN TmpMov

*- Adiciono Salidas Al Costo
SELE TmpSal
GO TOP
DO WHILE !EOF()
SELE TmpSal
lcCodArt = TmpSal.CodArt
llTieneIngresos = .T.

*- Selecciono Ingresos del Articulo
SELECT C.CodArt, C.FecDoc, C.TipDoc, C.NroDoc, ;
	   C.UndMed, C.CanMed, C.ImpMed, C.ImpMedDol, C.ImpMedSol, C.TipMnd, C.ImpCam ;
FROM ArtMovCos C ;
WHERE C.CodArt = lcCodArt AND C.TipMov = "I" ;
ORDER BY C.CodArt,C.FecDoc,C.TipDoc,C.NroDoc ;
INTO CURSOR TmpIng
IF _TALLY < 1
	USE IN TmpIng
	llTieneIngresos = .F.
ENDIF

lnCanSal = 0
lnCanIng = 0
SELE TmpSal
DO WHILE !EOF() AND CodArt = lcCodArt
		
	SELE ArtMovCos
	APPEN BLANK
	REPLACE CodAlm  WITH TmpSal.CodAlm, ;
			Periodo WITH TmpSal.Periodo, ;
			CodArt	WITH lcCodArt, ;
			FecDoc	WITH TmpSal.FecDoc, ;
			TipDoc	WITH TmpSal.TipDoc, ;
			NroDoc	WITH TmpSal.NroDoc, ;
			UndMed	WITH TmpSal.UndMed, ;
			CodUnd	WITH TmpSal.CodUnd, ;
			ImpArt	WITH TmpSal.ImpArt, ;
			TipMov  WITH TmpSal.TipMov, ;
			TipTsc  WITH TmpSal.TipTsc, ;
			TipMnd  WITH TmpSal.TipMnd, ;
			ImpCam  WITH TmpSal.ImpCam

	IF !llTieneIngresos
		SELE ArtMovCos
		REPLACE CanMed	WITH TmpSal.CanMed
		SELE TmpSal
		SKIP
		LOOP
	ENDIF
	
	lcTipRef = SPACE(01)
	lcNroRef = SPACE(01)
	lnImpMed = 0
	lnCanMed = 0
	lnSaldo  = 0

	SELE TmpIng
	DO WHILE !EOF()
		lcTipRef = TmpIng.TipDoc
		lcNroRef = TmpIng.NroDoc
		IF (TmpIng.CanMed - lnCanIng) >= (TmpSal.CanMed - lnCanSal)
			lnCanMed = (TmpSal.CanMed - lnCanSal)
		ELSE
			lnCanMed = (TmpIng.CanMed - lnCanIng)
		ENDIF
		lnSaldo = (TmpSal.CanMed - lnCanSal) - lnCanMed
		IF TmpIng.TipMnd == TmpSal.TipMnd
			lnImpMed = TmpIng.ImpMed
		ELSE
			lnImpMed = IIF(TmpSal.TipMnd == "U",TmpIng.ImpMedDol,TmpIng.ImpMedSol)
		ENDIF
		lnCanIng = lnCanIng + lnCanMed
		
		SELE TmpIng
		IF lnSaldo > 0
			lnCanIng = 0
			SKIP		
		ENDIF
		EXIT
	ENDDO
	
	IF lnCanMed = 0
		SELE ArtMovCos
		REPLACE CanMed	WITH (TmpSal.CanMed - lnCanSal)
		lnCanSal = 0
		SELE TmpSal
		SKIP
		LOOP
	ENDIF
	
	SELE ArtMovCos
	REPLACE TipRef	WITH lcTipRef, ;
			NroRef	WITH lcNroRef, ;
			CanMed	WITH lnCanMed, ;
			ImpMed	WITH lnImpMed, ;
			ImpMedDol WITH IIF(TipMnd=="U",ImpMed,IIF(ImpCam > 0,ROUND(ImpMed/ImpCam,2),0.00)), ;
			ImpMedSol WITH IIF(TipMnd=="U",ROUND(ImpMed*ImpCam,2),ImpMed)
	
	lnCanSal = lnCanSal + lnCanMed
	
	SELE TmpSal
	IF lnSaldo > 0
	ELSE
		lnCanSal = 0
		SKIP
		LOOP
	ENDIF	
ENDDO
IF USED("TmpIng")
	USE IN TmpIng
ENDIF
ENDDO
USE IN TmpSal
*-

*- Indexa
SELE ArtMovCos
WAIT WINDOW "Indexado ArtMovCos " NOWAIT
PACK
INDEX ON periodo+codart+DTOS(fecdoc)+tipdoc+nrodoc TAG periodo
USE
*-
SELE ArtMovDet
USE
*-
SELE ArtMovCab
USE

*- Fin
MESSAGEBOX("Proceso Termino Correctamente",0)
RETURN