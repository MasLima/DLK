LOCAL lnImpOrgCal, lnIndErr, lcCodCta
*set step on
SELE TmpSel
GO TOP
SCAN WHILE !EOF()
	*- Seleccionados
	IF !IndSel
		LOOP
	ENDIF
	*- Ubico
	IF !SEEK(TmpSel.NroSec,"BcoCab","NroSec")
		AdiTmpErr("NO SE UBICO DOCUMENTO")
		SELE TmpSel
		LOOP	
	ENDIF
	*- Bolqueo
	IF !RLOCK("BcoCab")
		AdiTmpErr("NO SE PUDO BLOQUEAR DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Totalizo
	lnImpOrgCal = 0
	SELE BcoDet
	SET ORDER TO NroSec
	SEEK BcoCab.NroSec
	SCAN WHILE !EOF() AND BcoDet.NroSec = BcoCab.NroSec
		lnImpOrgCal = lnImpOrgCal + IIF(BcoDet.IndSig == "-",-1*BcoDet.ImpOrg,BcoDet.ImpOrg)
	ENDSCAN
	lnIndErr = 0
	IF 	BcoCab.ImpOrg <> lnImpOrgCal
		lnIndErr = 1
	ENDIF
	IF lnIndErr == 1
		AdiTmpErr("NO CUADRA")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de Compbte
	IF EMPTY(BcoCab.NroCom)
		AdiTmpErr("NO SE TIENE N� DE COMPROBANTE")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Documento
	IF EMPTY(BcoCab.TipDoc)
		AdiTmpErr("NO SE TIENE TIPO DE DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de Documento
	IF EMPTY(BcoCab.NroDoc)
		AdiTmpErr("NO SE TIENE N� DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Fecha Documento
	IF EMPTY(BcoCab.FecDoc)
		AdiTmpErr("NO SE TIENE FECHA DEL DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Cambio
	IF EMPTY(BcoCab.ImpCam)
		AdiTmpErr("NO SE TIENE TIPO DE CAMBIO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Moneda
	IF EMPTY(BcoCab.TipMnd)
		AdiTmpErr("NO SE TIEN MONEDA")
		SELE TmpSel
		LOOP
	ENDIF
	*- Cuenta
	SELE BcoCab
	IF EMPTY(BcoCab.CodCta)
		*- Ubicar Cuenta en BcoCtaCte
		IF !SEEK(BcoCab.CodBco+BcoCab.NroCta,"BcoCtaCte","NroCta")
			AdiTmpErr("NO SE UBICO CUENTA EN BANCO")
			SELE TmpSel
			LOOP
		ELSE
			IF EMPTY(BcoCtaCte.CodCta)
				AdiTmpErr("NO SE TIENE CUENTA CONTABLE PARA EL BANCO")
				SELE TmpSel
				LOOP
			ENDIF
		ENDIF
		REPLACE BcoCab.CodCta WITH BcoCtaCte.CodCta
	ELSE
		*- Ubicar Cuenta en BcoCtaCte
		IF !SEEK(BcoCab.CodBco+BcoCab.NroCta,"BcoCtaCte","NroCta")
			AdiTmpErr("NO SE UBICO CUENTA EN BANCO")
			SELE TmpSel
			LOOP
		ELSE
			IF EMPTY(BcoCtaCte.CodCta)
				AdiTmpErr("NO SE TIENE CUENTA CONTABLE PARA EL BANCO")
				SELE TmpSel
				LOOP
			ENDIF
		ENDIF
		REPLACE BcoCab.CodCta WITH BcoCtaCte.CodCta
	ENDIF
	IF !SEEK(PADR(BcoCab.CodCta,8),"Cuentas","CodCta")
		AdiTmpErr("CUENTA DEL DOCUMENTO NO REGISTRADA EN EL PLAN")
		SELE TmpSel
		LOOP
	ENDIF
	
	*- Detalles
	SELE BcoDet
	SET ORDER TO NroSec
	SEEK BcoCab.NroSec
	SCAN WHILE !EOF() AND BcoDet.NroSec = BcoCab.NroSec
		IF !EMPTY(BcoDet.ImpOrg)
			IF EMPTY(BcoDet.CodCta)
				IF BcoDet.IndPvs == 1
					AdiTmpErr("NO SE TIENE CUENTA EN EL DETALLE")
					LOOP
				ELSE
					IF EMPTY(BcoDet.CodCto)
						AdiTmpErr("NO SE TIENE CONCEPTO EN EL DETALLE")
						SELE BcoDet
						LOOP
					ENDIF		
					IF !SEEK(BcoDet.TipCto+BcoDet.CodCto,"TabCto","CodCto")
						AdiTmpErr("NO SE TIENE CONCEPTO EN TABLA")
						SELE BcoDet
						LOOP
					ELSE
						IF EMPTY(TabCto.CodCta)
							AdiTmpErr("NO SE TIENE CUENTA PARA EL CONCEPTO EN Tabla")
							SELE BcoDet
							LOOP
						ENDIF	
					ENDIF
					REPLACE BcoDet.CodCta WITH TabCto.CodCta
				ENDIF
			ELSE
				IF BcoDet.IndPvs == 1
					DO CASE 
					CASE BcoDet.TipDoc == "RI" OR BcoDet.TipDoc == "RE"
						IF !SEEK(BcoDet.TipAux+BcoDet.CodAux+BcoDet.TipDoc+PADR(BcoDet.NroDoc,10),"RcbCab","CodAux")
							AdiTmpErr("DOCUMENTO DETALLE NO PROVISIONADO")
							SELE BcoDet
							LOOP
						ENDIF
						IF !SEEK(RcbCab.TipCto+RcbCab.CodCto,"TabCto","CodCto")
							AdiTmpErr("NO SE TIENE CONCEPTO EN TABLA PARA EL RECIBO")
							SELE BcoDet
							LOOP
						ELSE
							IF EMPTY(TabCto.CodCta)
								AdiTmpErr("NO SE TIENE CUENTA PARA EL CONCEPTO EN Tabla")
								SELE BcoDet
								LOOP
							ENDIF	
						ENDIF
						REPLACE BcoDet.CodCta WITH RcbCab.CodCta
					CASE BcoDet.TipDoc == "LT"
						IF !SEEK(BcoDet.TipAux+BcoDet.CodAux+BcoDet.TipDoc+PADR(BcoDet.NroDoc,20),"LetCab","CodAux")
							AdiTmpErr("DOCUMENTO DETALLE NO PROVISIONADO")
							LOOP
						ENDIF
						REPLACE BcoDet.CodCta WITH LetCab.CodCta
					OTHER
						IF !SEEK(BcoDet.TipAux+BcoDet.CodAux+BcoDet.TipDoc+PADR(BcoDet.NroDoc,20),"DocCab","CodAux")
							AdiTmpErr("DOCUMENTO DETALLE NO PROVISIONADO")
							LOOP
						ENDIF
						IF !SEEK(BcoCab.TipOpe+BcoDet.TipDoc,"TabOpeDoc","TipDoc")
							AdiTmpErr("NO SE UBICO EL TIPO DE DOCUMENTO DETALLE EN TABLAS")
							LOOP
						ELSE
							IF EMPTY(TabOpeDoc.CodCta)
								AdiTmpErr("NO SE TIENE CUENTA PARA EL DOCUMENTO DETALLE en Tabla")
								LOOP
							ENDIF
						ENDIF
						REPLACE BcoDet.CodCta WITH TabOpeDoc.CodCta
					ENDCASE
				ELSE
					IF EMPTY(BcoDet.CodCto)
						AdiTmpErr("NO SE TIENE CONCEPTO EN EL DETALLE")
						LOOP
					ENDIF		
					IF !SEEK(BcoDet.TipCto+BcoDet.CodCto,"TabCto","CodCto")
						AdiTmpErr("NO SE TIENE CONCEPTO EN TABLA")
						LOOP
					ELSE
						IF EMPTY(TabCto.CodCta)
							AdiTmpErr("NO SE TIENE CUENTA PARA EL CONCEPTO EN Tabla")
						ENDIF	
					ENDIF
					REPLACE BcoDet.CodCta WITH TabCto.CodCta
				ENDIF
			ENDIF
			IF !SEEK(PADR(BcoDet.CodCta,8),"Cuentas","CodCta")
				AdiTmpErr("CUENTA DEL DETALLE NO REGISTRADA EN EL PLAN")
				SELE TmpSel
				LOOP
			ENDIF
		ENDIF
	ENDSCAN
	*-
	*- Generar Asiento
	SELE TmpMovCab
	APPEN BLANK 
	REPLACE NroSec WITH BcoCab.NroSec, ;
			Periodo WITH BcoCab.Periodo, ;
			TipCom WITH BcoCab.TipCom, ;
			NroCom WITH BcoCab.NroCom, ;
			TipDoc WITH BcoCab.TipDoc, ;
			NroDoc WITH BcoCab.NroDoc, ;
			FecDoc WITH BcoCab.FecDoc, ;
			FecVen WITH BcoCab.FecVen, ;
			TipMnd WITH BcoCab.TipMnd, ;
			TipCam WITH BcoCab.TipCam, ;
			CodMnd WITH BcoCab.CodMnd, ;
			ImpCam WITH BcoCab.ImpCam, ;
			CodOpe WITH BcoCab.CodOpe, ;
			CodPgo WITH BcoCab.CodPgo, ;
			TotDeb WITH BcoCab.ImpOrg, ;
			TotHab WITH BcoCab.ImpOrg, ;
			TotDebSol WITH BcoCab.ImpSol, ;
			TotHabSol WITH BcoCab.ImpSol, ;
			TotDebDol WITH BcoCab.ImpDol, ;
			TotHabDol WITH BcoCab.ImpDol, ;
			IndSit WITH 1, ;
			FecSit WITH DATE(), ;
			CodUsu WITH gCodUsu, ;
			FecSis WITH DATETIME()

	*- CABECERA
	IF BcoCab.TipOpe == "1"
	AddMovDet(BcoCab.CodCta,BcoCab.TipAux,BcoCab.CodAux,SPACE(01), ;
    	      BcoCab.ImpOrg,BcoCab.ImpSol,BcoCab.ImpDol, ;
        	  IIF(BcoCab.TipOpe=='1','+','-'),BcoCab.NomAux, ;
        	  BcoCab.TipDoc,BcoCab.NroDoc)
    ENDIF      
	*- DETALLE
	SELE BcoDet
	SEEK BcoCab.NroSec
	SCAN WHILE !EOF() AND BcoDet.NroSec = BcoCab.NroSec
		AddMovDet(BcoDet.CodCta,BcoDet.TipAux,BcoDet.CodAux,BcoDet.CenCos, ;
   				  BcoDet.ImpOrg,BcoDet.ImpSol,BcoDet.ImpDol, ;
   				  IIF(BcoCab.TipOpe=='1',IIF(BcoDet.IndSig=='-','+','-'),IIF(BcoDet.IndSig=='-','-','+')), ;
   				  IIF(SEEK(BcoDet.TipCto+BcoDet.CodCto,"TabCto","CodCto"),PADR(TabCto.DesCto,40),SPACE(01)), ;
   				  BcoDet.TipDoc,BcoDet.NroDoc)
		SELE BcoDet
	ENDSCAN
	*-
	SELE TmpMovCab
	IF BcoCab.TipOpe == "2"
		AddMovDet(BcoCab.CodCta,BcoCab.TipAux,BcoCab.CodAux,SPACE(01), ;
    	   		  BcoCab.ImpOrg,BcoCab.ImpSol,BcoCab.ImpDol, ;
          		  IIF(BcoCab.TipOpe=='1','+','-'),BcoCab.NomAux, ;
          		  BcoCab.TipDoc,BcoCab.NroDoc)
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