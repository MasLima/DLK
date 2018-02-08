LOCAL lnImpOrgCal, lnIndErr, lcTipOpe
lcTipOpe = "1"
SELE TmpSel
GO TOP
SCAN WHILE !EOF()
	*- Seleccionados
	IF !IndSel
		LOOP
	ENDIF
	*- Ubico
	IF !SEEK(TmpSel.NroSec,"RetCab","NroSec")
		AdiTmpErr("NO SE UBICO DOCUMENTO")
		SELE TmpSel
		LOOP	
	ENDIF
	*- Bolqueo
	IF !RLOCK("RetCab")
		AdiTmpErr("NO SE PUDO BLOQUEAR DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Totalizo
	lnImpOrgCal = 0
	SELE RetDet
	SET ORDER TO NroSec
	SEEK RetCab.NroSec
	SCAN WHILE !EOF() AND RetDet.NroSec = RetCab.NroSec
		lnImpOrgCal = lnImpOrgCal + IIF(RetDet.IndSig == "-",-1*RetDet.ImpOrg,RetDet.ImpOrg)
	ENDSCAN
	lnIndErr = 0
	IF 	RetCab.ImpOrg <> lnImpOrgCal
		lnIndErr = 1
	ENDIF
	IF lnIndErr == 1
		AdiTmpErr("NO CUADRA")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de Compbte
	IF EMPTY(RetCab.NroCom)
		AdiTmpErr("NO SE TIENE Nº DE COMPROBANTE")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Documento
	IF EMPTY(RetCab.TipDoc)
		AdiTmpErr("NO SE TIENE TIPO DE DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de Documento
	IF EMPTY(RetCab.NroDoc)
		AdiTmpErr("NO SE TIENE Nº DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Fecha Documento
	IF EMPTY(RetCab.FecDoc)
		AdiTmpErr("NO SE TIENE FECHA DEL DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Cambio
	IF EMPTY(RetCab.ImpCam)
		AdiTmpErr("NO SE TIENE TIPO DE CAMBIO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Moneda
	IF EMPTY(RetCab.TipMnd)
		AdiTmpErr("NO SE TIEN MONEDA")
		SELE TmpSel
		LOOP
	ENDIF
	*- Cuenta
	SELE RetCab
	IF EMPTY(RetCab.CodCta)
		*- Ubicar Cuenta en TabOpeDoc
		IF !SEEK(lcTipOpe+RetCab.TipDoc,"TabOpeDoc","TipDoc")
			AdiTmpErr("NO SE UBICO TIPO DEL DOCUMENTO EN TABLA")
			SELE TmpSel
			LOOP
		ELSE
			IF EMPTY(TabOpeDoc.CodCta)
				AdiTmpErr("NO SE TIENE CUENTA PARA EL TIPO DE DOCUMENTO EN TABLA")
				SELE TmpSel
				LOOP
			ENDIF
		ENDIF
		REPLACE RetCab.CodCta WITH TabOpeDoc.CodCta
	ELSE
		*- Ubicar Cuenta en TabOpeDoc
		IF !SEEK(lcTipOpe+RetCab.TipDoc,"TabOpeDoc","TipDoc")
			AdiTmpErr("NO SE UBICO TIPO DEL DOCUMENTO EN TABLA")
			SELE TmpSel
			LOOP
		ELSE
			IF EMPTY(TabOpeDoc.CodCta)
				AdiTmpErr("NO SE TIENE CUENTA PARA EL TIPO DE DOCUMENTO EN TABLA")
				SELE TmpSel
				LOOP
			ENDIF
		ENDIF
		REPLACE RetCab.CodCta WITH TabOpeDoc.CodCta
	ENDIF
	IF !SEEK(PADR(RetCab.CodCta,8),"Cuentas","CodCta")
		AdiTmpErr("CUENTA DEL COMPROBANTE NO REGISTRADA EN EL PLAN")
		SELE TmpSel
		LOOP
	ENDIF
	
	*- Detalles
	SELE RetDet
	SET ORDER TO NroSec
	SEEK RetCab.NroSec
	SCAN WHILE !EOF() AND RetDet.NroSec = RetCab.NroSec
		IF !EMPTY(RetDet.ImpOrg)
*			IF EMPTY(RetDet.CodCta)
				IF !SEEK("1"+RetDet.TipRef+RetDet.NroRef,"DocCab","NroDoc")
					AdiTmpErr("NO UBICO DOCUMENTO DETALLE EN DOCUMENTOS")
					SELE RetDet
					LOOP
				ENDIF
*				IF EMPTY(DocCab.CodCta)
					*- Ubicar Cuenta en TabOpeDoc
					IF !SEEK(DocCab.TipOpe+DocCab.TipDoc,"TabOpeDoc","TipDoc")
						AdiTmpErr("NO SE UBICO TIPO DEL DOCUMENTO DETALLE EN TABLA")
						SELE RetDet
						LOOP
					ELSE
						IF EMPTY(TabOpeDoc.CodCta)
							AdiTmpErr("NO SE TIENE CUENTA PARA EL TIPO DE DOCUMENTO DET. EN TABLA")
							SELE RetDet
							LOOP
						ENDIF
					ENDIF
					REPLACE RetDet.CodCta WITH TabOpeDoc.CodCta
*				ENDIF
*			ENDIF
			IF !SEEK(PADR(RetDet.CodCta,8),"Cuentas","CodCta")
				AdiTmpErr("CUENTA DEL DOCUMENTO DET. NO REGISTRADA EN EL PLAN")
				SELE RetDet
				LOOP
			ENDIF
		ENDIF
		SELE RetDet
	ENDSCAN
	*-
	*- Generar Asiento
	SELE TmpMovCab
	APPEN BLANK 
	REPLACE NroSec WITH RetCab.NroSec, ;
			Periodo WITH RetCab.Periodo, ;
			TipCom WITH RetCab.TipCom, ;
			NroCom WITH RetCab.NroCom, ;
			TipDoc WITH RetCab.TipDoc, ;
			NroDoc WITH RetCab.NroDoc, ;
			FecDoc WITH RetCab.FecDoc, ;
			FecVen WITH RetCab.FecVen, ;
			TipMnd WITH RetCab.TipMnd, ;
			TipCam WITH RetCab.TipCam, ;
			CodMnd WITH RetCab.CodMnd, ;
			ImpCam WITH RetCab.ImpCam, ;
			TotDeb WITH RetCab.ImpOrg, ;
			TotHab WITH RetCab.ImpOrg, ;
			TotDebSol WITH RetCab.ImpSol, ;
			TotHabSol WITH RetCab.ImpSol, ;
			TotDebDol WITH RetCab.ImpDol, ;
			TotHabDol WITH RetCab.ImpDol, ;
			IndSit WITH 1, ;
			FecSit WITH DATE(), ;
			CodUsu WITH gCodUsu, ;
			FecSis WITH DATETIME()
			
	*- CABECERA
	IF lcTipOpe == "1"
	AddMovDet(RetCab.CodCta,RetCab.TipAux,RetCab.CodAux,SPACE(01), ;
    	      RetCab.ImpOrg,RetCab.ImpSol,RetCab.ImpDol,'+',RetCab.NomAux, ;
        	  RetCab.TipDoc,RetCab.NroDoc)
    ENDIF      
	*- DETALLE
	SELE RetDet
	SEEK RetCab.NroSec
	SCAN WHILE !EOF() AND RetDet.NroSec = RetCab.NroSec
		AddMovDet(RetDet.CodCta,RetDet.TipAux,RetDet.CodAux,RetDet.CodCenCos, ;
   				  RetDet.ImpOrg,RetDet.ImpSol,RetDet.ImpDol, ;
   				  IIF(lcTipOpe=='1',IIF(RetDet.IndSig=='-','+','-'),IIF(RetDet.IndSig=='-','-','+')), ;
   				  RetCab.NomAux,RetDet.TipRef,RetDet.NroRef)
		SELE RetDet
	ENDSCAN
	*-
	SELE TmpMovCab
	IF lcTipOpe == "2"
		AddMovDet(RetCab.CodCta,RetCab.TipAux,RetCab.CodAux,SPACE(01), ;
    	   		  RetCab.ImpOrg,RetCab.ImpSol,RetCab.ImpDol,'-',RetCab.NomAux, ;
          		  RetCab.TipDoc,RetCab.NroDoc)
    ENDIF      
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
SELE (lnOldSele)
RETURN .T.
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