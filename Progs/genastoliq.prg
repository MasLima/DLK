LOCAL lnImpOrgCal, lnIndErr, lnImpDeb, lnImpHab

SELE TmpSel
GO TOP
SCAN WHILE !EOF()
	*- Seleccionados
	IF !IndSel
		LOOP
	ENDIF
	*- Ubico
	IF !SEEK(TmpSel.NroSec,"LiqCab","NroSec")
		AdiTmpErr("NO SE UBICO LIQUIDACION")
		SELE TmpSel
		LOOP	
	ENDIF
	*- Bolqueo
	IF !RLOCK("LiqCab")
		AdiTmpErr("NO SE PUDO BLOQUEAR DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Totalizo
	lnImpDeb = 0
	lnImpHab = 0
	SELE LiqDet
	SET ORDER TO NroSec
	SEEK LiqCab.NroSec
	SCAN WHILE !EOF() AND LiqDet.NroSec = LiqCab.NroSec
		IF IndSig == "-"
			lnImpHab = lnImpHab + ImpHab
		ELSE
			lnImpDeb = lnImpDeb + ImpDeb
		ENDIF
	ENDSCAN
	lnIndErr = 0
	IF 	lnImpDeb <> lnImpHab
		lnIndErr = 1
	ENDIF
	IF 	LiqCab.ImpDeb <> LiqCab.ImpHab
		lnIndErr = 1
	ENDIF
	IF lnIndErr == 1
		AdiTmpErr("NO CUADRA")
		SELE TmpSel
		LOOP
	ENDIF
		
	*- No de Compbte
	IF EMPTY(LiqCab.NroCom)
		AdiTmpErr("NO SE TIENE Nº DE COMPROBANTE")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Documento
	IF EMPTY(LiqCab.TipDoc)
		AdiTmpErr("NO SE TIENE TIPO DE DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de Documento
	IF EMPTY(LiqCab.NroDoc)
		AdiTmpErr("NO SE TIENE Nº DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Fecha Documento
	IF EMPTY(LiqCab.FecDoc)
		AdiTmpErr("NO SE TIENE FECHA DEL DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Cambio
	IF EMPTY(LiqCab.ImpCam)
		AdiTmpErr("NO SE TIENE TIPO DE CAMBIO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Moneda
	IF EMPTY(LiqCab.TipMnd)
		AdiTmpErr("NO SE TIEN MONEDA")
		SELE TmpSel
		LOOP
	ENDIF
	*- Detalles
	SELE LiqDet
	SET ORDER TO NroSec
	SEEK LiqCab.NroSec
	SCAN WHILE !EOF() AND LiqDet.NroSec = LiqCab.NroSec
		IF !EMPTY(LiqDet.ImpOrg)
			IF EMPTY(LiqDet.CodCta)
				IF LiqDet.IndPvs == 1
					AdiTmpErr("NO SE TIENE CUENTA EN EL DETALLE")
					LOOP
				ELSE
					IF EMPTY(LiqDet.CodCto)
						AdiTmpErr("NO SE TIENE CONCEPTO EN EL DETALLE")
						LOOP
					ENDIF		
					IF !SEEK(LiqDet.TipCto+LiqDet.CodCto,"TabCto","CodCto")
						AdiTmpErr("NO SE TIENE CUENTA PARA EL CONCEPTO EN EL DETALLE")
						LOOP
					ELSE
						IF EMPTY(TabCto.CodCta)
							AdiTmpErr("NO SE TIENE CUENTA PARA EL CONCEPTO EN Tabla")
						ENDIF	
					ENDIF
					REPLACE LiqDet.CodCta WITH TabCto.CodCta
				ENDIF
			ELSE
				IF LiqDet.IndPvs == 1
					DO CASE 
					CASE LiqDet.TipDoc == "RI" OR LiqDet.TipDoc == "RE"
						IF !SEEK(LiqDet.TipAux+LiqDet.CodAux+LiqDet.TipDoc+PADR(ALLTRIM(LiqDet.NroDoc),10),"RcbCab","CodAux")
							AdiTmpErr("DOCUMENTO DETALLE NO PROVISIONADO")
							SELE LiqDet
							LOOP
						ENDIF
						REPLACE LiqDet.CodCta WITH RcbCab.CodCta
					CASE LiqDet.TipDoc == "LT"
						IF !SEEK(LiqDet.TipAux+LiqDet.CodAux+LiqDet.TipDoc+PADR(LiqDet.NroDoc,20),"LetCab","CodAux")
							AdiTmpErr("DOCUMENTO DETALLE NO PROVISIONADO")
							SELE LiqDet
							LOOP
						ENDIF
						REPLACE LiqDet.CodCta WITH LetCab.CodCta
					OTHER
						IF !SEEK(LiqDet.TipAux+LiqDet.CodAux+LiqDet.TipDoc+PADR(LiqDet.NroDoc,20),"DocCab","CodAux")
							AdiTmpErr("DOCUMENTO DETALLE NO PROVISIONADO")
							SELE LiqDet
							LOOP
						ENDIF
						REPLACE LiqDet.CodCta WITH DocCab.CodCta
						*IF !SEEK("1"+LiqDet.TipDoc,"TabOpeDoc","TipDoc")
						*	AdiTmpErr("NO SE UBICO EL TIPO DE DOCUMENTO DETALLE EN TABLAS")
						*	LOOP
						*ELSE
						*	IF EMPTY(TabOpeDoc.CodCta)
						*		AdiTmpErr("NO SE TIENE CUENTA PARA EL DOCUMENTO DETALLE en Tabla")
						*		LOOP
						*	ENDIF
						*ENDIF
						*REPLACE LiqDet.CodCta WITH TabOpeDoc.CodCta
					ENDCASE
					IF EMPTY(LiqDet.CodCta)
						AdiTmpErr("PROVISION NO TIENE CUENTA")
						SELE LiqDet
						LOOP
					ENDIF		
				ELSE
					IF EMPTY(LiqDet.CodCto)
						AdiTmpErr("NO SE TIENE CONCEPTO EN EL DETALLE")
						SELE LiqDet
						LOOP
					ENDIF		
					IF !SEEK(LiqDet.TipCto+LiqDet.CodCto,"TabCto","CodCto")
						AdiTmpErr("NO SE TIENE CONCEPTO EN TABLA")
						SELE LiqDet
						LOOP
					ELSE
						IF EMPTY(TabCto.CodCta)
							AdiTmpErr("NO SE TIENE CUENTA PARA EL CONCEPTO EN Tabla")
							SELE LiqDet
							LOOP
						ENDIF	
					ENDIF
					REPLACE LiqDet.CodCta WITH TabCto.CodCta
				ENDIF				
			ENDIF		
		ENDIF
	ENDSCAN
	*-
	*- Generar Asiento
	SELE TmpMovCab
	APPEN BLANK 
	REPLACE NroSec WITH LiqCab.NroSec, ;
			Periodo WITH LiqCab.Periodo, ;
			TipCom WITH LiqCab.TipCom, ;
			NroCom WITH LiqCab.NroCom, ;
			TipDoc WITH LiqCab.TipDoc, ;
			NroDoc WITH LiqCab.NroDoc, ;
			FecDoc WITH LiqCab.FecDoc, ;
			FecVen WITH LiqCab.FecDoc, ;
			TipMnd WITH LiqCab.TipMnd, ;
			TipCam WITH LiqCab.TipCam, ;
			CodMnd WITH LiqCab.CodMnd, ;
			ImpCam WITH LiqCab.ImpCam, ;
			TotDeb WITH LiqCab.ImpDeb, ;
			TotHab WITH LiqCab.ImpHab, ;
			IndSit WITH 1, ;
			FecSit WITH DATE(), ;
			CodUsu WITH gCodUsu, ;
			FecSis WITH DATETIME()
			
	*- DETALLE
	SELE LiqDet
	SEEK LiqCab.NroSec
	SCAN WHILE !EOF() AND LiqDet.NroSec = LiqCab.NroSec
		AddMovDet(LiqDet.CodCta,LiqDet.TipAux,LiqDet.CodAux,LiqDet.CenCos, ;
   				  LiqDet.ImpOrg,LiqDet.ImpSol,LiqDet.ImpDol,LiqDet.IndSig, ;
   				  IIF(SEEK(LiqDet.TipCto+LiqDet.CodCto,"TabCto","CodCto"),PADR(TabCto.DesCto,40),SPACE(01)), ;
   				  LiqDet.TipDoc,LiqDet.NroDoc)
		SELE LiqDet
	ENDSCAN
	*-
	SELE TmpMovCab
	*-
	*- TOTALIZO Asiento
	lnTotDeb = 0
	lnTotHab = 0
	lnTotDebSol = 0
	lnTotHabSol = 0
	lnTotDebDol = 0
	lnTotHabDol = 0
	SELE TmpMovDet
	SEEK TmpMovCab.NroSec
	SCAN WHILE !EOF() AND TmpMovDet.NroSec = TmpMovCab.NroSec
		IF IndReg <> 1
			IF IndSig == "+"
				lnTotDeb = lnTotDeb + ImpOrg
				lnTotDebSol = lnTotDebSol + ImpSol
				lnTotDebDol = lnTotDebDol + ImpDol
			ELSE
				lnTotHab = lnTotHab + ImpOrg
				lnTotHabSol = lnTotHabSol + ImpSol
				lnTotHabDol = lnTotHabDol + ImpDol
			ENDIF
		ENDIF
	ENDSCAN
	SELE TmpMovCab
	REPLACE TotDeb    WITH ROUND(lnTotDeb,2), ;
			TotHab    WITH ROUND(lnTotHab,2), ;
			TotDebSol WITH ROUND(lnTotDebSol,2), ;
			TotHabSol WITH ROUND(lnTotHabSol,2), ;
			TotDebDol WITH ROUND(lnTotDebDol,2), ;
			TotHabDol WITH ROUND(lnTotHabDol,2)
		
	*- Genera Asientos por Redondeo
	IF TmpMovcab.TotDeb <> TmpMovcab.TotHab
		SELE TmpMovDet
		SEEK TmpMovCab.NroSec
		SCAN WHILE !EOF() AND TmpMovDet.NroSec = TmpMovCab.NroSec
			DELETE
		ENDSCAN
		SELE TmpMovCab
		DELETE
		
		AdiTmpErr("ASIENTO GENERADO NO CUADRA")
		SELE TmpSel
		LOOP
	ENDIF

	*- Calculo de Asientos por Redondeo
	SELE TmpMovCab
	DO &gRuta\Progs\GenAju

	*- Calculo de Asientos Automaticos
	SELE TmpMovCab
	DO &gRuta\Progs\GenAuto

	*-
	SELE TmpSel
	REPLACE IndGen WITH .T.
ENDSCAN
RETURN
*-
*- Adiciona Detalle del Asiento 
FUNCTION AddMovDet(lcCodCta,lcTipAux,lcCodAux,lcCenCos,lnImpTot,lnImpTotSol,lnImpTotDol,lcIndSig,lcGlosa,lcTipRef,lcNroRef)
LOCAL lnOldSele
lnOldSele = SELECT()
SELE TmpMovCab
REPLACE NroSecDet WITH NroSecDet + 1
SELE TmpMovDet
APPEN BLANK 
REPLACE NroSec WITH TmpMovCab.NroSec, ;
		NroSecDet WITH TmpMovCab.NroSecDet, ;
		Periodo WITH TmpMovCab.Periodo, ;
		TipCom WITH TmpMovCab.TipCom, ;
		NroCom WITH TmpMovCab.NroCom, ;
		TipDoc WITH TmpMovCab.TipDoc, ;
		NroDoc WITH TmpMovCab.NroDoc, ;
		FecDoc WITH TmpMovCab.FecDoc, ;
		FecVen WITH TmpMovCab.FecVen, ;
		TipMnd WITH TmpMovCab.TipMnd, ;
		TipCam WITH TmpMovCab.TipCam, ;
		CodMnd WITH TmpMovCab.CodMnd, ;
		ImpCam WITH TmpMovCab.ImpCam, ;
		CodCta WITH lcCodCta, ;
		ImpOrg WITH lnImpTot, ;
		ImpSol WITH lnImpTotSol, ;
		ImpDol WITH lnImpTotDol, ;
		IndSig WITH lcIndSig, ;
		Glosa  WITH lcGlosa
*- Carga Indicadores para la cuenta		
IF SEEK(CodCta,"Cuentas","CodCta")
	REPLACE	IndAut WITH Cuentas.IndAut, ;
			IndAux WITH Cuentas.IndAux, ;
			IndCenCos WITH Cuentas.IndCenCos, ;
			IndCtaCte WITH Cuentas.IndCtaCte, ;
			IndRef WITH Cuentas.IndRef
	IF IndAut == 1
		REPLACE	TipAut WITH "0"
	ENDIF
	IF IndAux == 1
		REPLACE	TipAux WITH lcTipAux, ;
				CodAux WITH lcCodAux
		IF SEEK(lcTipAux+lcCodAux,"TabAux","CodAux")
				REPLACE NomAux WITH TabAux.NomAux, ;
						NroRuc WITH TabAux.NroRuc
		ENDIF
	ENDIF
	IF IndCenCos == 1
		REPLACE CodCenCos WITH lcCenCos
	ENDIF
	IF IndRef == 1
		REPLACE	TipRef WITH lcTipRef, ;
				NroRef WITH lcNroRef
	ENDIF
ENDIF
*- Genera Automaticos
IF IndAut == 1
*	GenAstoAuto(MovDet.CodCta,MovDet.TipAut,MovDet.ImpOrg,MovDet.ImpSol,MovDet.ImpDol,MovDet.IndSig,MovDet.IndIna,MovDet.Glosa)
ENDIF
SELE (lnOldSele)
RETURN .T.
ENDFUNC

FUNCTION GenAstoAuto(lcCodCta,lcTipAut,lnOrg,lnSol,lnDol,lcIndSig,lcIndIna,lcGlosa)
LOCAL lcFile, llAuto, lnAut, lnRec, lnImpOrg, lnImpSol, lnImpDol, lnTotOrg, lnTotSol, lnTotDol
lnAut = 0
SELE TabAut
SET ORDER TO TipAut
SEEK lcCodCta+lcTipAut
	SCAN WHILE !EOF() AND TabAut.CodCta+TabAut.TipAut = lcCodCta+lcTipAut
		lnAut = lnAut + 1
	ENDSCAN
	IF lnAut > 0
		lnRec = 0
		STORE 0 TO lnImpOrg, lnImpSol, lnImpDol
		STORE 0 TO lnTotOrg, lnTotSol, lnTotDol
		SEEK lcCodCta+lcTipAut
		SCAN WHILE !EOF() AND TabAut.CodCta+TabAut.TipAut = lcCodCta+lcTipAut
			lnRec = lnRec + 1
			IF lnAut == lnRec
				lnImpOrg = lnOrg - lnTotOrg
				lnImpSol = lnSol - lnTotSol
				lnImpDol = lnDol - lnTotDol
			ELSE
				lnImpOrg = ROUND((lnOrg*TabAut.Porctje)/100,2)
				lnImpSol = ROUND((lnSol*TabAut.Porctje)/100,2)
				lnImpDol = ROUND((lnDol*TabAut.Porctje)/100,2)
			ENDIF
			AdiDetAut(TabAut.CodCtaDeb,lnImpOrg,lnImpSol,lnImpDol,lcIndSig)
			AdiDetAut(TabAut.CodCtaHab,lnImpOrg,lnImpSol,lnImpDol,IIF(lcIndSig=="+","-","+"))
			lnTotOrg = lnTotOrg + lnImpOrg
			lnTotSol = lnTotSol + lnImpSol
			lnTotDol = lnTotDol + lnImpDol
		ENDSCAN
	ENDIF
RETURN	
ENDFUNC	

FUNCTION AdiDetAut(lcCodCta,lnImpOrg,lnImpSol,lnImpDol,lcIndSig)
REPLACE MovCab.NroSecDet WITH MovCab.NroSecDet + 1
SELE MovDet
APPEND BLANK
REPLACE NroSec    WITH MovCab.NroSec, ;
		NroSecDet WITH MovCab.NroSecDet, ;
		Periodo   WITH MovCab.Periodo, ;
		TipCom WITH MovCab.TipCom, ;
		NroCom WITH MovCab.NroCom, ;
		IndReg WITH 1, ;
		CodCta WITH lcCodCta, ;
		TipDoc WITH MovCab.TipDoc, ;
		NroDoc WITH MovCab.NroDoc, ;
		FecDoc WITH MovCab.FecDoc, ;
		FecVen WITH MovCab.FecVen, ;
		TipMnd WITH MovCab.TipMnd, ;
		Tipcam WITH MovCab.TipCam, ;
		CodMnd WITH MovCab.CodMnd, ;
		Impcam WITH MovCab.ImpCam, ;
		ImpOrg WITH lnImpOrg, ;
		ImpSol WITH lnImpSol, ;
		ImpDol WITH lnImpDol, ;
		IndSig WITH lcIndSig, ;
		IndIna WITH lcIndIna, ;
		Glosa  WITH lcGlosa
IF SEEK(lcCodCta,"Cuentas","CodCta")		
	IF Cuentas.IndAut == 1
		REPLACE	IndAut WITH Cuentas.IndAut, ;
				TipAut WITH "0"
	ENDIF
	IF Cuentas.IndAux == 1
		REPLACE	IndAux WITH Cuentas.IndAux, ;
				TipAux WITH Tmp.TipAux, ;
				CodAux WITH Tmp.CodAux
	ENDIF
	IF Cuentas.IndCenCos == 1
		REPLACE	IndCenCos WITH Cuentas.IndCenCos, ;
				CodCenCos WITH Tmp.CodCenCos
	ENDIF
	IF Cuentas.IndCtaCte == 1
		REPLACE	IndCtaCte WITH Cuentas.IndCtaCte
	ENDIF
	IF Cuentas.IndRef == 1
		REPLACE	IndRef WITH Cuentas.IndRef, ;
				TipRef WITH Tmp.TipDoc, ;
				NroRef WITH Tmp.NroDoc
	ENDIF
ENDIF
ENDFUNC


*- Carga Error
FUNCTION AdiTmpErr(lcDesErr)
LOCAL lnOldSele
lnOldSele = SELECT()

SELE TmpErr
APPEND BLANK
REPLACE NroSec WITH TmpSel.NroSec, ;
		TipOpe WITH TmpSel.TipOpe, ;
		Periodo WITH TmpSel.Periodo, ;
		TipCom WITH TmpSel.TipCom, ;
		NroCom WITH TmpSel.NroCom, ;
		TipDoc WITH TmpSel.TipDoc, ;
		NroDoc WITH TmpSel.NroDoc, ;
		FecDoc WITH TmpSel.FecDoc, ;
		TipMnd WITH TmpSel.TipMnd, ;
		ImpTot WITH TmpSel.ImpTot, ;
		Simbol WITH TmpSel.Simbol, ;
		DesErr WITH lcDesErr
		
SELE (lnOldSele)
RETURN .T.
ENDFUNC