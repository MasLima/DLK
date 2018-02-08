LOCAL lnImpAfeCal, lnImpAfeDol, lnImpAfeSol, lnImpTotCal, lnIndErr

SELE TmpSel
GO TOP
SCAN WHILE !EOF()
	*- Seleccionados
	IF !IndSel
		LOOP
	ENDIF
	*- Ubico
	IF !SEEK(TmpSel.NroSec,"DocCab","NroSec")
		AdiTmpErr("NO SE UBICO DOCUMENTO")
		SELE TmpSel
		LOOP	
	ENDIF
	*- Bolqueo
	IF !RLOCK("DocCab")
		AdiTmpErr("NO SE PUDO BLOQUEAR DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Totalizo
	IF DocCab.IndSit <> 9
	*lnImpAfeCal = 0
	*lnImpIgvCal = 0
	*lnImpInaCal = 0
	*lnImpTotCal = 0
	*SELE DocDetVta
	*SET ORDER TO NroSec
	*SEEK DocCab.NroSec
	*SCAN WHILE !EOF() AND DocDetVta.NroSec = DocCab.NroSec
	*	lnImpAfeCal = lnImpAfeCal + DocDetVta.ImpAfe
	*ENDSCAN
	*lnIndErr = 0
	*IF 	DocCab.ImpAfe <> lnImpAfeCal
	*	lnIndErr = 1
	*ENDIF
	*IF lnIndErr == 1
	*	AdiTmpErr("NO CUADRA")
	*	SELE TmpSel
	*	LOOP
	*ENDIF
	ENDIF
	*- No de Compbte
	IF EMPTY(DocCab.NroCom)
		AdiTmpErr("NO SE TIENE N� DE COMPROBANTE")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Documento
	IF EMPTY(DocCab.TipDoc)
		AdiTmpErr("NO SE TIENE TIPO DE DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de Documento
	IF EMPTY(DocCab.NroDoc)
		AdiTmpErr("NO SE TIENE N� DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Fecha Documento
	IF EMPTY(DocCab.FecDoc)
		AdiTmpErr("NO SE TIENE FECHA DEL DOCUMENTO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Cambio
	IF EMPTY(DocCab.ImpCam)
		AdiTmpErr("NO SE TIENE TIPO DE CAMBIO")
		SELE TmpSel
		LOOP
	ENDIF
	*- Moneda
	IF EMPTY(DocCab.TipMnd)
		AdiTmpErr("NO SE TIEN MONEDA")
		SELE TmpSel
		LOOP
	ENDIF
	*- Cuenta
	IF EMPTY(DocCab.CodCta)
		*- Ubicar Cuenta en TabOpeDoc
		IF !SEEK(DocCab.TipOpe+DocCab.TipDoc,"TabOpeDoc","TipDoc")
			AdiTmpErr("NO SE TIENE TIPO DE DOCUMENTO EN TABLA")
			SELE TmpSel
			LOOP
		ELSE
			IF EMPTY(TabOpeDoc.CodCta)
				AdiTmpErr("NO SE TIENE CUENTA PARA EL DOCUMENTO en Tabla")
				SELE TmpSel
				LOOP
			ENDIF
		ENDIF
		REPLACE DocCab.CodCta WITH TabOpeDoc.CodCta
	ELSE
		*- Ubicar Cuenta en TabOpeDoc
		IF !SEEK(DocCab.TipOpe+DocCab.TipDoc,"TabOpeDoc","TipDoc")
			AdiTmpErr("NO SE TIENE TIPO DE DOCUMENTO EN TABLA")
			SELE TmpSel
			LOOP
		ELSE
			IF EMPTY(TabOpeDoc.CodCta)
				AdiTmpErr("NO SE TIENE CUENTA PARA EL DOCUMENTO en Tabla")
				SELE TmpSel
				LOOP
			ENDIF
		ENDIF
		REPLACE DocCab.CodCta WITH TabOpeDoc.CodCta
	ENDIF
	IF !SEEK(PADR(DocCab.CodCta,8),"Cuentas","CodCta")
		AdiTmpErr("CUENTA DEL DOCUMENTO NO REGISTRADA EN EL PLAN")
		SELE TmpSel
		LOOP
	ENDIF
	*- Tipo de Auxiliar
	IF EMPTY(DocCab.TipAux)
		AdiTmpErr("NO SE TIENE TIPO DE AUXILIAR")
		SELE TmpSel
		LOOP
	ENDIF
	*- Codgio de Auxiliar
	IF EMPTY(DocCab.CodAux)
		AdiTmpErr("NO SE TIENE CODIGO DE AUXILIAR")
		SELE TmpSel
		LOOP
	ENDIF
	*- No de RUC
	IF EMPTY(DocCab.NroRuc)
		AdiTmpErr("NO SE TIENE RUC")
		SELE TmpSel
		LOOP
	ENDIF
	*- Detalles
	IF DocCab.IndSit <> 9
	SELE DocDet
	SET ORDER TO NroSec
	SEEK DocCab.NroSec
	SCAN WHILE !EOF() AND DocDet.NroSec = DocCab.NroSec
		IF !EMPTY(DocDet.ImpTot)
			*IF EMPTY(DocDet.CodCta)
				IF EMPTY(DocDet.CodArt)
					IF EMPTY(DocDet.TipVta)
						*- considerar cuenta de adelanto
						*REPLACE DocDet.CodCta WITH "12201"
						AdiTmpErr("NO SE TIENE CUENTA EN EL DETALLE")
						LOOP
					ELSE
						IF !SEEK(DocDet.TipVta,"TipVta","TipVta")
							AdiTmpErr("TIPO DE VENTA NO REGISTRADO EN TABLAS")
							LOOP
						ENDIF
						IF EMPTY(TipVta.CodCta)
							AdiTmpErr("NO SE TIENE CUENTA PARA EL TIPO DE VENTA EN TABLA")
							LOOP
						ENDIF	
						IF !SEEK(PADR(TipVta.CodCta,8),"Cuentas","CodCta")
							AdiTmpErr("CUENTA DEL TIPO DE VENTA NO REGISTRADA EN EL PLAN")
							LOOP
						ENDIF
						REPLACE DocDet.CodCta WITH TipVta.CodCta
					ENDIF
				ELSE
					IF !SEEK(DocDet.CodArt,"ArtArt","CodArt")
						AdiTmpErr("NO SE UBICO Articulo en ArtArt")
						LOOP
					ENDIF
					IF EMPTY(IIF(DocCab.TipOpe == "1",ArtArt.CtaVta,ArtArt.CtaCpa))
						AdiTmpErr("NO SE TIENE CUENTA de" + IIF(DocCab.TipOpe == "1","Venta","Compra") + "PARA EL Articulo EN ArtArt")
						LOOP
					ENDIF	
					REPLACE DocDet.CodCta WITH IIF(DocCab.TipOpe == "1",ArtArt.CtaVta,ArtArt.CtaCpa)
				ENDIF		
			*ENDIF
			IF !SEEK(PADR(DocDet.CodCta,8),"Cuentas","CodCta")
				AdiTmpErr("CUENTA DEL DETALLE NO REGISTRADA EN EL PLAN")
				LOOP
			ENDIF
		ENDIF
	ENDSCAN
	ENDIF
	*-
	*- Generar Asiento
	SELE TmpMovCab
	APPEN BLANK 
	REPLACE NroSec WITH DocCab.NroSec, ;
			Periodo WITH DocCab.Periodo, ;
			TipCom WITH DocCab.TipCom, ;
			NroCom WITH DocCab.NroCom, ;
			TipDoc WITH DocCab.TipDoc, ;
			NroDoc WITH DocCab.NroDoc, ;	
			FecDoc WITH DocCab.FecDoc, ;
			FecVen WITH DocCab.FecVen, ;
			TipMnd WITH DocCab.TipMnd, ;
			TipCam WITH DocCab.TipCam, ;
			CodMnd WITH DocCab.CodMnd, ;
			ImpCam WITH DocCab.ImpCam, ;
			IndSit WITH 1, ;
			FecSit WITH DATE(), ;
			CodUsu WITH gCodUsu, ;
			FecSis WITH DATETIME(), ;
			TipRef WITH DocCab.TipRef, ;
			NroRef WITH DocCab.NroRef
			
*			NroDoc WITH ALLTRIM(DocCab.SerDoc)+"-"+ALLTRIM(DocCab.SecDoc), ;
*			NroDoc WITH DocCab.NroDoc, ;	
	
	*- ANULADO
	IF DocCab.IndSit == 9
		AddMovDet(DocCab.CodCta,DocCab.TipAux,DocCab.CodAux,DocCab.NomAux,DocCab.NroRuc,DocCab.CenCos,;
    	      	  0.00,0.00,0.00,;
        	      IIF(DocCab.IndSig=='-','-','+'),"ANULADA","4")
        SELE TmpSel
		LOOP	  
	ENDIF
	
	SELE TmpMovCab
	REPLACE	TotDeb WITH DocCab.ImpTot, ;
			TotHab WITH DocCab.ImpTot, ;
			TotDebSol WITH DocCab.ImpTotSol, ;
			TotHabSol WITH DocCab.ImpTotSol, ;
			TotDebDol WITH DocCab.ImpTotDol, ;
			TotHabDol WITH DocCab.ImpTotDol
				
	*- Obtengo Glosa para el Asiento
	lcGlosa = "VENTAS"
*	lcGlosa = TipVta.DesVta
	lcGlosa = DocCab.NomAux

	SELE TmpMovCab
	*- VALOR TOTAL
	AddMovDet(DocCab.CodCta,DocCab.TipAux,DocCab.CodAux,DocCab.NomAux,DocCab.NroRuc,DocCab.CenCos,;
    	      DocCab.ImpTot,DocCab.ImpTotSol,DocCab.ImpTotDol,;
        	  IIF(DocCab.IndSig=='-','-','+'),lcGlosa,"4")
          
	*- TRIBUTOS
	*- IGV
	IF !EMPTY(DocCab.ImpIgv)
		AddMovDet(TabPar.CodCtaIgv,DocCab.TipAux,DocCab.CodAux,DocCab.NomAux,DocCab.NroRuc,DocCab.CenCos,;
   	  			  DocCab.ImpIgv,DocCab.ImpIgvSol,DocCab.ImpIgvDol,;
       			  IIF(DocCab.IndSig=='-','+','-'),lcGlosa,"2")
   	ENDIF

	*- VALOR AFECTO/INAFECTO/OTROS TRIBUTOS
	SELE DocDet
	SEEK DocCab.NroSec
	SCAN WHILE !EOF() AND DocDet.NroSec = DocCab.NroSec
		IF !EMPTY(DocDet.ImpAfe)
			AddMovDet(DocDet.CodCta,DocCab.TipAux,DocCab.CodAux,DocCab.NomAux,DocCab.NroRuc,DocCab.CenCos,;
       				  DocDet.ImpAfe,DocDet.ImpAfeSol,DocDet.ImpAfeDol,;
       				  IIF(DocCab.IndSig=='-','+','-'),PADR(DocDet.Detalle,40),"1")
		ENDIF
		IF !EMPTY(DocDet.ImpIna)
			AddMovDet(DocDet.CodCta,DocCab.TipAux,DocCab.CodAux,DocCab.NomAux,DocCab.NroRuc,DocCab.CenCos,;
       				  DocDet.ImpIna,DocDet.ImpInaSol,DocDet.ImpInaDol,;
       				  IIF(DocCab.IndSig=='-','+','-'),PADR(DocDet.Detalle,40),"3")
		ENDIF
		SELE DocDet
	ENDSCAN
	SELE TmpMovCab

*	IF !EMPTY(DocCab.ImpAfe)
*		lnImpAfeDol = IIF(DocCab.TipMnd = "U",DocCab.ImpAfe,ROUND(DocCab.ImpAfe/DocCab.ImpCam,2))
*		lnImpAfeSol = IIF(DocCab.TipMnd = "U",ROUND(DocCab.ImpAfe*DocCab.ImpCam,2),DocCab.ImpAfe)
*		AddMovDet(TipVta.CodCta,DocCab.TipAux,DocCab.CodAux,DocCab.NomAux,DocCab.NroRuc,DocCab.CenCos,;
*   			  DocCab.ImpAfe,lnImpAfeSol,lnImpAfeDol,;
*   	  		  IIF(DocCab.IndSig=='-','+','-'),PADR(lcGlosa,40),"1")
*	ENDIF
*	SELE TmpMovCab
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
*- Adiciona Detalle del Asiento de Compra
FUNCTION AddMovDet(lcCodCta,lcTipAux,lcCodAux,lcNomAux,lcNroRuc,lcCenCos,lnImpTot,lnImpTotSol,lnImpTotDol,lcIndSig,lcGlosa,lcIndUbi)
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
		Glosa  WITH lcGlosa, ;
		IndUbi WITH lcIndUbi, ;
		IndIna WITH IIF(IndUbi == '5',1,0)
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
				CodAux WITH lcCodAux, ;
				NomAux WITH lcNomAux, ;
				NroRuc WITH lcNroRuc
	ENDIF
	IF IndCenCos == 1
		REPLACE CodCenCos WITH lcCenCos
	ENDIF
	IF IndRef == 1
		IF TmpMovCab.TipDoc == "07" or TmpMovCab.TipDoc == "08" 
			REPLACE	TipRef WITH TmpMovCab.TipRef, ;
					NroRef WITH TmpMovCab.NroRef
		ELSE
			REPLACE	TipRef WITH TmpMovCab.TipDoc, ;
					NroRef WITH TmpMovCab.NroDoc
		ENDIF	
*!*			REPLACE	TipRef WITH TmpMovCab.TipDoc, ;
*!*					NroRef WITH TmpMovCab.NroDoc
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