LOCAL lnImpOrgCal, lnIndErr, lnImpDeb, lnImpHab

SELE TmpSel
GO TOP
SCAN WHILE !EOF()
	*- Seleccionados
	IF !IndSel
		LOOP
	ENDIF
	*- Ubico
	IF !SEEK(TmpSel.NroSec,"LetCanCab","NroSec")
		AdiTmpErr("NO SE UBICO Canje de Letra")
		SELE TmpSel
		LOOP	
	ENDIF
	*- Bolqueo
	IF !RLOCK("LetCanCab")
		AdiTmpErr("NO SE PUDO BLOQUEAR DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Totalizo
	STORE 0.00 TO lnImpDeb,lnImpHab
	SELE LetCanDet
	SET ORDER TO NroSec
	SEEK LetCanCab.NroSec
	SCAN WHILE !EOF() AND LetCanDet.NroSec = LetCanCab.NroSec
		IF IndMov == "2"
			lnImpHab = lnImpHab + ImpHab
		ELSE
			lnImpDeb = lnImpDeb + ImpDeb
		ENDIF
	ENDSCAN
	lnIndErr = 0
	IF 	lnImpDeb <> lnImpHab
		lnIndErr = 1
	ENDIF
	IF 	LetCanCab.TotDeb <> LetCanCab.TotHab
		lnIndErr = 1
	ENDIF
	IF lnIndErr == 1
		AdiTmpErr("NO CUADRA")
		SELE TmpSel
		LOOP
	ENDIF
		
	*- No de Compbte
	IF EMPTY(LetCanCab.NroCom)
		AdiTmpErr("NO SE TIENE N� DE COMPROBANTE")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Documento
	IF EMPTY(LetCanCab.TipDoc)
		AdiTmpErr("NO SE TIENE TIPO DE DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de Documento
	IF EMPTY(LetCanCab.NroDoc)
		AdiTmpErr("NO SE TIENE N� DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Fecha Documento
	IF EMPTY(LetCanCab.FecDoc)
		AdiTmpErr("NO SE TIENE FECHA DEL DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Cambio
	IF EMPTY(LetCanCab.ImpCam)
		AdiTmpErr("NO SE TIENE TIPO DE CAMBIO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Moneda
	IF EMPTY(LetCanCab.TipMnd)
		AdiTmpErr("NO SE TIEN MONEDA")
		SELE TmpSel
		LOOP
	ENDIF
	*- Detalles
	SELE LetCanDet
	SET ORDER TO NroSec
	SEEK LetCanCab.NroSec
	SCAN WHILE !EOF() AND LetCanDet.NroSec = LetCanCab.NroSec
		IF !EMPTY(LetCanDet.ImpOrg)
			IF EMPTY(LetCanDet.CodCta)
				IF LetCanDet.TipDoc == "LT"
					IF !SEEK(LetCanDet.NroSecDoc,"LetCab","NroSec")
						AdiTmpErr("NO UBICO DOCUMENTO DETALLE EN LETRAS")
						SELE LetCanDet
						LOOP
					ENDIF
					IF EMPTY(LetCab.CodCta)
						AdiTmpErr("DOCUMENTO DETALLE NO TIENE CUENTA")
						SELE LetCanDet
						LOOP
					ENDIF
					REPLACE LetCanDet.CodCta WITH LetCab.CodCta
				ELSE
					IF !SEEK(LetCanDet.NroSecDoc,"DocCab","NroSec")
						AdiTmpErr("NO UBICO DOCUMENTO DETALLE EN DOCUMENTOS")
						SELE LetCanDet
						LOOP
					ENDIF
					IF EMPTY(DocCab.CodCta)
						AdiTmpErr("DOCUMENTO DETALLE NO TIENE CUENTA")
						SELE LetCanDet
						LOOP
					ENDIF
					REPLACE LetCanDet.CodCta WITH DocCab.CodCta
				ENDIF
			ENDIF
			IF !SEEK(PADR(LetCanDet.CodCta,8),"Cuentas","CodCta")
				AdiTmpErr("CUENTA DEL DOCUMENTO DET. NO REGISTRADA EN EL PLAN")
				SELE LetCanDet
				LOOP
			ENDIF
		ENDIF
	ENDSCAN
	*-
	*- Generar Asiento
	SELE TmpMovCab
	APPEN BLANK 
	REPLACE NroSec WITH LetCanCab.NroSec, ;
			Periodo WITH LetCanCab.Periodo, ;
			TipCom WITH LetCanCab.TipCom, ;
			NroCom WITH LetCanCab.NroCom, ;
			TipDoc WITH LetCanCab.TipDoc, ;
			NroDoc WITH LetCanCab.NroDoc, ;
			FecDoc WITH LetCanCab.FecDoc, ;
			FecVen WITH LetCanCab.FecDoc, ;
			TipMnd WITH LetCanCab.TipMnd, ;
			TipCam WITH LetCanCab.TipCam, ;
			CodMnd WITH LetCanCab.CodMnd, ;
			ImpCam WITH LetCanCab.ImpCam, ;
			TotDeb WITH LetCanCab.TotDeb, ;
			TotHab WITH LetCanCab.TotHab, ;
			IndSit WITH 1, ;
			FecSit WITH DATE(), ;
			CodUsu WITH gCodUsu, ;
			FecSis WITH DATETIME()
			
	*- DETALLE
	SELE LetCanDet
	SEEK LetCanCab.NroSec
	SCAN WHILE !EOF() AND LetCanDet.NroSec = LetCanCab.NroSec
		AddMovDet(LetCanDet.CodCta,LetCanDet.TipAux,LetCanDet.CodAux,LetCanDet.CenCos, ;
   				  LetCanDet.ImpOrg,LetCanDet.ImpSol,LetCanDet.ImpDol,IIF(LetCanDet.IndMov == "1","+","-"), ;
   				  "CANJE DE LETRAS",LetCanDet.TipDoc,LetCanDet.NroDoc)
		SELE LetCanDet
	ENDSCAN
	*-
	SELE TmpMovCab
	*-
	*- TOTALIZO Asiento
	STORE 0.00 TO lnTotDeb,lnTotHab,lnTotDebSol,lnTotHabSol,lnTotDebDol,lnTotHabDol
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