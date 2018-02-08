FUNCTION ActualizaSaldos(pTipo)
LOCAL lnOldSele, lcTipo, lcCodCta, lcTipAux, lcCodAux, lnImpDebSol, lnImpDebDol, lnImpHabSol, lnImpHabDol

*- Verifica que exista cabecera
IF !SEEK(MovDet.NroSec,"MovCab","NroSec")
	MESSAGEBOX("ERROR FATAL! Detalle No Tiene Cabecera ",0+48,"Validacion")
	RETURN .F.
ENDIF
IF MovCab.periodo <> MovDet.periodo
	MESSAGEBOX("ERROR FATAL! No Coincide Periodo",0+48,"Validacion")
	RETURN .F.
ENDIF
IF MovCab.TipCom+STR(MovCab.NroCom,6) <> MovDet.TipCom+STR(MovDet.NroCom,6)
	MESSAGEBOX("ERROR FATAL! No Coincide No de Comprobante",0+48,"Validacion")
	RETURN .F.
ENDIF

lnOldSele = SELECT()
lcTipo = pTipo
IF lcTipo=="M"
	IF  OLDVAL("CodCta","MovDet") == MovDet.CodCta AND ;
		OLDVAL("TipAux","MovDet") == MovDet.TipAux AND ;
		OLDVAL("CodAux","MovDet") == MovDet.CodAux AND ;
		OLDVAL("ImpOrg","MovDet") == MovDet.ImpOrg AND ;
   		OLDVAL("ImpSol","MovDet") == MovDet.ImpSol AND ;
   		OLDVAL("ImpDol","MovDet") == MovDet.ImpDol AND ;
   		OLDVAL("IndSig","MovDet") == MovDet.IndSig
		RETURN
	ENDIF
	IF	OLDVAL("IndSig","MovDet") == MovDet.IndSig AND ;
		OLDVAL("CodCta","MovDet") == MovDet.CodCta AND ;
		OLDVAL("TipAux","MovDet") == MovDet.TipAux AND ;
		OLDVAL("CodAux","MovDet") == MovDet.CodAux
		lnImpDebSol = IIF(MovDet.IndSig == "+",MovDet.ImpSol - OLDVAL("ImpSol","MovDet"),0)
		lnImpDebDol = IIF(MovDet.IndSig == "+",MovDet.ImpDol - OLDVAL("ImpDol","MovDet"),0)
		lnImpHabSol = IIF(MovDet.IndSig == "-",MovDet.ImpSol - OLDVAL("ImpSol","MovDet"),0)
		lnImpHabDol = IIF(MovDet.IndSig == "-",MovDet.ImpDol - OLDVAL("ImpDol","MovDet"),0)
	ELSE
		lcCodCta  = OLDVAL("CodCta","MovDet")
		lcTipAux  = OLDVAL("TipAux","MovDet")
		lcCodAux  = OLDVAL("CodAux","MovDet")
		lcPeriodo = MovDet.Periodo
		lnImpDebSol = IIF(OLDVAL("IndSig","MovDet") == "+",-1*OLDVAL("ImpSol","MovDet"),0)
		lnImpDebDol = IIF(OLDVAL("IndSig","MovDet") == "+",-1*OLDVAL("ImpDol","MovDet"),0)
		lnImpHabSol = IIF(OLDVAL("IndSig","MovDet") == "-",-1*OLDVAL("ImpSol","MovDet"),0)
		lnImpHabDol = IIF(OLDVAL("IndSig","MovDet") == "-",-1*OLDVAL("ImpDol","MovDet"),0)
		lcTipo = "E"
		SELE Saldos
		SET ORDER TO CodCta
		*- Nivel 5
		IF !EMPTY(lcCodAux)
		IF !AcumulaSaldos("5",lcCodCta,lcTipAux,lcCodAux,lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
			SELE (lnOldSele)
			RETURN .F.
		ENDIF
		ENDIF
		*- Nivel 4
		IF !EMPTY(lcCodAux)
		IF !AcumulaSaldos("4",lcCodCta,SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
			SELE (lnOldSele)
			RETURN .F.
		ENDIF
		ENDIF
		*- Nivel 3
		IF !AcumulaSaldos("3",PADR(SUBS(lcCodCta,1,4),8),SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
			SELE (lnOldSele)
			RETURN .F.
		ENDIF
		*- Nivel 2
		IF !AcumulaSaldos("2",PADR(SUBS(lcCodCta,1,3),8),SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
			SELE (lnOldSele)
			RETURN .F.
		ENDIF
		*- Nivel 1
		IF !AcumulaSaldos("1",PADR(SUBS(lcCodCta,1,2),8),SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
			SELE (lnOldSele)
			RETURN .F.
		ENDIF
		lnImpDebSol = IIF(MovDet.IndSig == "+",MovDet.ImpSol,0)
		lnImpDebDol = IIF(MovDet.IndSig == "+",MovDet.ImpDol,0)
		lnImpHabSol = IIF(MovDet.IndSig == "-",MovDet.ImpSol,0)
		lnImpHabDol = IIF(MovDet.IndSig == "-",MovDet.ImpDol,0)
		lcTipo = "A"
	ENDIF
ELSE
	IF lcTipo=="E"
		lnImpDebSol = IIF(MovDet.IndSig == "+",-1*MovDet.ImpSol,0)
		lnImpDebDol = IIF(MovDet.IndSig == "+",-1*MovDet.ImpDol,0)
		lnImpHabSol = IIF(MovDet.IndSig == "-",-1*MovDet.ImpSol,0)
		lnImpHabDol = IIF(MovDet.IndSig == "-",-1*MovDet.ImpDol,0)
	ELSE
		lnImpDebSol = IIF(MovDet.IndSig == "+",MovDet.ImpSol,0)
		lnImpDebDol = IIF(MovDet.IndSig == "+",MovDet.ImpDol,0)
		lnImpHabSol = IIF(MovDet.IndSig == "-",MovDet.ImpSol,0)
		lnImpHabDol = IIF(MovDet.IndSig == "-",MovDet.ImpDol,0)
	ENDIF
ENDIF
lcCodCta  = MovDet.CodCta
lcTipAux  = MovDet.TipAux
lcCodAux  = MovDet.CodAux
lcPeriodo = MovDet.Periodo

SELE Saldos
SET ORDER TO CodCta
*- Nivel 5
IF !EMPTY(lcCodAux)
IF !AcumulaSaldos("5",lcCodCta,lcTipAux,lcCodAux,lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
	SELE (lnOldSele)
	RETURN .F.
ENDIF
ENDIF
*- Nivel 4
IF !AcumulaSaldos("4",lcCodCta,SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
	SELE (lnOldSele)
	RETURN .F.
ENDIF
*- Nivel 3
IF !AcumulaSaldos("3",PADR(SUBS(lcCodCta,1,4),8),SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
	SELE (lnOldSele)
	RETURN .F.
ENDIF
*- Nivel 2
IF !AcumulaSaldos("2",PADR(SUBS(lcCodCta,1,3),8),SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
	SELE (lnOldSele)
	RETURN .F.
ENDIF
*- Nivel 1
IF !AcumulaSaldos("1",PADR(SUBS(lcCodCta,1,2),8),SPACE(02),SPACE(04),lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
	SELE (lnOldSele)
	RETURN .F.
ENDIF
*-
SELE (lnOldSele)
RETURN .T.
ENDFUNC

FUNCTION AcumulaSaldos(lcIndNiv,lcCodCta,lcTipAux,lcCodAux,lcPeriodo,lnImpDebSol,lnImpDebDol,lnImpHabSol,lnImpHabDol,lcTipo)
SEEK lcIndNiv+lcCodCta+lcTipAux+lcCodAux+lcPeriodo
IF EOF()
	IF lcTipo == "A"
		APPEND BLANK 
		REPLACE Saldos.IndNiv WITH lcIndNiv, ;
				Saldos.CodCta WITH lcCodCta, ;
				Saldos.TipAux WITH lcTipAux, ;
				Saldos.CodAux WITH lcCodAux, ;
				Saldos.Periodo WITH lcPeriodo
		UNLOCK
	ELSE
		MESSAGEBOX("ERROR FATAL! Cuenta No Tiene Saldos RECALCULE SALDOS",0+48,"Validacion")
		RETURN .F.
	ENDIF
ENDIF
DO WHILE !RLOCK()
*	SET STEP ON
ENDDO
REPLACE Saldos.ImpHabSol WITH Saldos.ImpHabSol + lnImpHabSol, ;
		Saldos.ImpHabDol WITH Saldos.ImpHabDol + lnImpHabDol, ;
		Saldos.ImpDebSol WITH Saldos.ImpDebSol + lnImpDebSol, ;
		Saldos.ImpDebDol WITH Saldos.ImpDebDol + lnImpDebDol
UNLOCK
RETURN .T.
ENDFUNC

FUNCTION ActualizaSaldosBco(pTipo)
LOCAL lnOldSele
lnOldSele = SELECT()

*- Actualizas Saldos del Mes
SELE BcoSld
SET ORDER TO CodBco
SEEK BcoCab.CodBco+BcoCab.NroCta+BcoCab.Periodo
IF EOF()
	APPEND BLANK
	REPLACE CodBco  WITH BcoCab.CodBco, ;
			NroCta  WITH BcoCab.NroCta, ;
			Periodo WITH BcoCab.Periodo
ENDIF
IF BcoCab.TipOpe == "1"
	REPLACE ImpCgoOrg WITH ImpCgoOrg + IIF(pTipo == "+",BcoCab.ImpOrg,-1*BcoCab.ImpOrg), ;
			ImpCgoSol WITH ImpCgoSol + IIF(pTipo == "+",BcoCab.ImpSol,-1*BcoCab.ImpSol), ;
			ImpCgoDol WITH ImpCgoDol + IIF(pTipo == "+",BcoCab.ImpDol,-1*BcoCab.ImpDol)
ELSE
	REPLACE ImpAboOrg WITH ImpAboOrg + IIF(pTipo == "+",BcoCab.ImpOrg,-1*BcoCab.ImpOrg), ;
			ImpAboSol WITH ImpAboSol + IIF(pTipo == "+",BcoCab.ImpSol,-1*BcoCab.ImpSol), ;
			ImpAboDol WITH ImpAboDol + IIF(pTipo == "+",BcoCab.ImpDol,-1*BcoCab.ImpDol)
ENDIF

SELE (lnOldSele)
RETURN .T.
ENDFUNC

FUNCTION ModificaSaldosBco()
LOCAL lnOldSele

IF OLDVAL("ImpOrg","BcoCab") == BcoCab.ImpOrg AND ;
	OLDVAL("ImpSol","BcoCab") == BcoCab.ImpSol AND ;
	OLDVAL("ImpDol","BcoCab") == BcoCab.ImpDol
	RETURN
ENDIF
lnOldSele = SELECT()

SELE BcoSld
SET ORDER TO CodBco
SEEK BcoCab.CodBco+BcoCab.NroCta+BcoCab.Periodo
IF EOF()
	MESSAGEBOX("ERROR FATAL No Tiene Saldos",0+48,"Validacion")
	SELE (lnOldSele)
	RETURN .F.
ENDIF
IF BcoCab.TipOpe == "1"
	REPLACE ImpCgoOrg WITH ImpCgoOrg - OLDVAL("ImpOrg","BcoCab") + BcoCab.ImpOrg, ;
			ImpCgoSol WITH ImpCgoSol - OLDVAL("ImpSol","BcoCab") + BcoCab.ImpSol, ;
			ImpCgoDol WITH ImpCgoDol - OLDVAL("ImpDol","BcoCab") + BcoCab.ImpDol
ELSE
	REPLACE ImpAboOrg WITH ImpAboOrg - OLDVAL("ImpOrg","BcoCab") + BcoCab.ImpOrg, ;
			ImpAboSol WITH ImpAboSol - OLDVAL("ImpSol","BcoCab") + BcoCab.ImpSol, ;
			ImpAboDol WITH ImpAboDol - OLDVAL("ImpDol","BcoCab") + BcoCab.ImpDol
ENDIF

SELE (lnOldSele)
RETURN .T.
ENDFUNC

FUNCTION ActSldArt(lcTipo)
*- Parameters lcTipo
*- lcTipo = "I"  INSERTAR
*- lcTipo = "A"  ACTUALIZAR
*- lcTipo = "E"  ELIMINAR

LOCAL lnOldSele,lnNroSec,lcCodAlm,lcPeriodo,lcTipMov,lcTipTsc,ldFecDoc, ;
      lcCodArt,lnCanArt,lnCanArtOld,lnImpArt,lnCanAct,lnCanIng,lnCanSal, ;
	  lcTipMnd,lcSimbol,lnImpCam,lnPreCom,lnPreComDol,lnPreComSol, ;
	  ldFecIni,ldFecFin,llIndActUPC,ldFecCom,lnIndIgv,lnPcjIgv

lnOldSele = SELECT()
ldFecIni = DATE() - 100
ldFecFin = DATE()
llIndActUPC = .F.  && NO ACTUALIZA ULTIMO PRECIO DE COMPRA

*- Verificar Registro
IF EOF("ArtMovDet") OR BOF("ArtMovDet")
	MESSAGEBOX("ERROR FATAL! No se Tiene Detalle del Registro",0+48,"Validacion")
	RETURN .F.
ENDIF

*- Obtengo Datos del Registro
lnNroSec = ArtMovDet.NroSec
lcCodArt = ArtMovDet.CodArt
lnCanArt = ArtMovDet.CanArt
lnPreCom = ArtMovDet.ImpMed
lnIndIgv = ArtMovDet.IndIgv

lnCanArt = ArtMovDet.CanMed
lnCanArtOld = OLDVAL("CanMed","ArtMovDet")
lnImpArt = ArtMovDet.ImpMed

*- Verifica si se cambio la cantidad y Precio para actualizar
IF lcTipo == "A"
	IF OLDVAL("CanArt","ArtMovDet") == ArtMovDet.CanArt AND OLDVAL("ImpArt","ArtMovDet") == ArtMovDet.ImpArt
		RETURN .T.
	ENDIF
ENDIF

*- Verifico que exista cabecera
SELECT M.NroSec, M.CodAlm, M.Periodo, M.TipMov, M.TipTsc, M.FecDoc, ;
	   M.TipMnd, M.Simbol, M.ImpCam, M.PcjIgv ;
FROM ArtMovCab M ;
WHERE M.NroSec == lnNroSec ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("ERROR FATAL! Detalle No Tiene Cabecera en ArtMovCab",0+48,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
lcTipMov = Tmp.TipMov
lcTipTsc = Tmp.TipTsc
lcCodAlm = Tmp.CodAlm
lcPeriodo = Tmp.Periodo
ldFecDoc = TTOD(Tmp.FecDoc)
lcTipMnd = Tmp.TipMnd
lcSimbol = Tmp.Simbol
lnImpCam = Tmp.ImpCam
lnPcjIgv = Tmp.PcjIgv
lnPreComDol = 0.00
lnPreComSol = 0.00
USE IN Tmp

*- Selecciono Saldo Para el Articulo
SELECT M.CodAlm, M.CodArt ;
FROM ArtSld M ;
WHERE M.CodAlm+M.CodArt == lcCodAlm+lcCodArt ;
INTO CURSOR TmpSld
IF _TALLY < 1
	IF lcTipo == "I"
		BEGIN TRANSACTION
			INSERT INTO ArtSld (CodAlm,CodArt) ;
				VALUES(lcCodAlm,lcCodArt)
			SELECT M.CodAlm, M.CodArt ;
			FROM ArtSld M ;
			WHERE M.CodAlm+M.CodArt == lcCodAlm+lcCodArt ;
			INTO CURSOR Tmp
			IF _TALLY <> 1
				MESSAGEBOX("Problemas al Adicionar Articulo en ArtSld",0+48,"Validacion")
				USE IN Tmp
				USE IN TmpSld
				ROLLBACK
				RETURN .F.
			ENDIF
		END TRANSACTION
	ELSE
		MESSAGEBOX("ERROR Articulo No se Encuentra Registrado en Saldos Reprocese Saldos",0+64,"Validacion")
		SELE (lnOldSele)
		USE IN TmpSld
		RETURN .F.
	ENDIF	
ENDIF
USE IN TmpSld

*- Saldos Mes
SELECT M.CodAlm, M.CodArt, M.Periodo ;
FROM ArtSldMes M ;
WHERE M.CodAlm+M.CodArt+M.Periodo == lcCodAlm+lcCodArt+lcPeriodo ;
INTO CURSOR TmpSld
IF _TALLY < 1
	IF lcTipo == "I"
		BEGIN TRANSACTION
			INSERT INTO ArtSldMes (CodAlm,CodArt,Periodo) ;
				VALUES(lcCodAlm,lcCodArt,lcPeriodo)
			SELECT M.CodAlm, M.CodArt, M.Periodo ;
			FROM ArtSldMes M ;
			WHERE M.CodAlm+M.CodArt+M.Periodo == lcCodAlm+lcCodArt+lcPeriodo ;
			INTO CURSOR Tmp
			IF _TALLY <> 1
				MESSAGEBOX("Problemas al Adicionar Articulo en ArtSldMes",0+48,"Validacion")
				USE IN Tmp
				USE IN TmpSld
				ROLLBACK
				RETURN .F.
			ENDIF
		END TRANSACTION
	ELSE
		MESSAGEBOX("ERROR Articulo No se Encuentra Registrado en Saldos Reprocese Saldos",0+64,"Validacion")
		SELE (lnOldSele)
		USE IN TmpSld
		RETURN .F.
	ENDIF	
ENDIF
USE IN TmpSld

*- Obtengo Cantidad
STORE 0.00 TO lnCanIng,lnCanSal,lnCanAct
DO CASE
	CASE lcTipo == "I"  && INSERTAR
		lnCanIng = IIF(lcTipMov == "I",lnCanArt,0)
		lnCanSal = IIF(lcTipMov == "I",0,lnCanArt)
		lnCanAct = IIF(lcTipMov == "I",lnCanArt,-1*lnCanArt)
	CASE lcTipo == "E"  && ELIMINAR
		lnCanIng = IIF(lcTipMov == "I",-1*lnCanArt,0)
		lnCanSal = IIF(lcTipMov == "I",0,-1*lnCanArt)
		lnCanAct = IIF(lcTipMov == "I",-1*lnCanArt,lnCanArt)
	CASE lcTipo == "A"  && ACTUALIZAR
		lnCanIng = IIF(lcTipMov == "I",(-1*lnCanArtOld + lnCanArt),0)
		lnCanSal = IIF(lcTipMov == "I",0,(-1*lnCanArtOld + lnCanArt))
		lnCanAct = IIF(lcTipMov == "I",(-1*lnCanArtOld + lnCanArt),(lnCanArtOld - lnCanArt))
ENDCASE

*- Obtengo Ultimo precio de Compra
IF lcTipMov == "I" AND lcTipTsc == "01"  && INGRESO && COMPRAS
	IF lcTipo == "E"    && ELIMINACION
		ldFecDoc = CTOD("")
		STORE "" TO lcSimbol,lcTipMnd
		STORE 0.00 TO lnImpCam,lnPreCom
		llIndActUPC = .T.
		SELECT M.FecDoc, M.TipMnd, M.Simbol, M.ImpCam, M.PcjIgv, D.ImpArt, D.ImpMed, D.IndIgv ;
		FROM DocCab M INNER JOIN DocDet D ON M.NroSec = D.NroSec AND D.CodArt = lcCodArt ;
		WHERE BETWEEN(M.FecDoc,ldFecIni,ldFecFin) AND M.TipOpe = '2' AND M.IndSig == '+' AND M.IndSit <> 9 ;
		ORDER BY M.FecDoc DESC ;
		INTO CURSOR Tmp
		IF _TALLY > 0
			SELE Tmp
			GO TOP
			DO WHILE !EOF()
				ldFecDoc = Tmp.FecDoc
				lcTipMnd = Tmp.TipMnd
				lcSimbol = Tmp.Simbol
				lnImpCam = Tmp.ImpCam
				lnPreCom = Tmp.ImpArt
				lnPcjIgv = Tmp.PcjIgv
				lnIndIgv = Tmp.IndIgv
				EXIT
			ENDDO
		ENDIF
		USE IN Tmp
	ELSE
		*- Obtengo Fecha de ultima compra en Articulo
		SELECT M.CodArt, M.FecCom, M.PreCom, M.MndCom, M.SblCom, M.ImpCamCom ;
		FROM ArtArt M ;
		WHERE M.CodArt == lcCodArt ;
		INTO CURSOR Tmp
		IF _TALLY < 1
			MESSAGEBOX("ERROR ! Articulo No Registrado",0+48,"Validacion")
			USE IN Tmp
			RETURN .F.
		ENDIF
		ldFecCom = Tmp.FecCom
		USE IN Tmp
		IF ldFecDoc >= ldFecCom
			llIndActUPC = .T.
		ENDIF
	ENDIF
	lnPreCom = IIF(lnIndIgv == 1,ROUND((lnPreCom)/((100 + lnPcjIgv)/100),2),lnPreCom)
	lnPreComDol = IIF(lcTipMnd == "U",lnPreCom,IIF(lnImpCam > 0,lnPreCom/lnImpCam,0.00))
	lnPreComSol = IIF(lcTipMnd == "P",lnPreCom,lnPreCom*lnImpCam)
ENDIF

*- Actualizo
BEGIN TRANSACTION
	*- Saldos Por Periodo
	UPDATE ArtSldMes ;
		SET CanIng = CanIng + lnCanIng, ;
			CanSal = CanSal + lnCanSal ;
		WHERE CodAlm+CodArt+Periodo == lcCodAlm+lcCodArt+lcPeriodo
	IF _TALLY <> 1
		MESSAGEBOX("Problemas al Actualizar Saldo de Articulo en ArtSldMes",0+64,"Validacion")
		ROLLBACK
		SELE (lnOldSele)
		RETURN .F.
	ENDIF

	*- Saldo Actual por Almacen
	UPDATE ArtSld ;
		SET CanArt = CanArt + lnCanAct ;
		WHERE CodAlm+CodArt == lcCodAlm+lcCodArt
	IF _TALLY <> 1
		MESSAGEBOX("Problemas al Actualizar Saldo de Articulo en ArtSld",0+64,"Validacion")
		ROLLBACK
		SELE (lnOldSele)
		RETURN .F.
	ENDIF
	
	*- Saldo Actual por Articulo
	UPDATE ArtArt ;
		SET CanArt = CanArt + lnCanAct ;
		WHERE CodArt == lcCodArt
	IF _TALLY <> 1
		MESSAGEBOX("Problemas al Actualizar Saldo de Articulo en ArtArt",0+64,"Validacion")
		ROLLBACK
		SELE (lnOldSele)
		RETURN .F.
	ENDIF
	
	*- Actualiza Ultimo Precio de Compra
	IF llIndActUPC
		UPDATE ArtArt ;
			SET FecCom = ldFecDoc, ;
				MndCom = lcTipMnd, ;
				SblCom = lcSimbol, ;
				ImpCamCom = lnImpCam, ;
				PreCom = lnPreCom, ;
				PreComDol = lnPreComDol, ;
				PreComSol = lnPreComSol ;
		WHERE CodArt == lcCodArt
		IF _TALLY <> 1
			MESSAGEBOX("Problemas al Actulizar Ultimo Precio de Compra",0+64,"Validacion")
		*	ROLLBACK
			SELE (lnOldSele)
			RETURN .F.
		ENDIF
	ENDIF
END TRANSACTION

SELE (lnOldSele)
RETURN .T.
ENDFUNC