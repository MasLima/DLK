LOCAL lcFile, llAuto, lnAut, lnRec, lnImpOrg, lnImpSol, lnImpDol, lnTotOrg, lnTotSol, lnTotDol

*- Generacion de Asientos Automaticos
llAuto = .F.
SELE TmpMovDet
*SET ORDER TO NroSec
SEEK TmpMovCab.NroSec
SCAN WHILE !EOF() AND TmpMovDet.NroSec = TmpMovCab.NroSec
	IF TmpMovDet.IndAut == 1
		llAuto = .T.
		EXIT
	ENDIF
ENDSCAN
IF !llAuto
	RETURN
ENDIF

lcFile = gCodUsu+"Tmp"
SELE TmpMovDet
SEEK TmpMovCab.NroSec
COPY TO &gRuta\Temp\&lcFile WHILE TmpMovDet.NroSec = TmpMovCab.NroSec FOR TmpMovDet.IndAut == 1
USE &gRuta\Temp\&lcFile IN 0 ALIAS Tmp

SELE Tmp
SCAN WHILE !EOF()
	lnAut = 0
	SELE TabAut
	SET ORDER TO TipAut
	SEEK Tmp.CodCta+Tmp.TipAut
	SCAN WHILE !EOF() AND TabAut.CodCta+TabAut.TipAut = Tmp.CodCta+Tmp.TipAut
		lnAut = lnAut + 1
	ENDSCAN
	IF lnAut > 0
		lnRec = 0
		STORE 0 TO lnImpOrg, lnImpSol, lnImpDol
		STORE 0 TO lnTotOrg, lnTotSol, lnTotDol
		SEEK Tmp.CodCta+Tmp.TipAut
		SCAN WHILE !EOF() AND TabAut.CodCta+TabAut.TipAut = Tmp.CodCta+Tmp.TipAut
			lnRec = lnRec + 1
			IF lnAut == lnRec
				lnImpOrg = Tmp.ImpOrg - lnTotOrg
				lnImpSol = Tmp.ImpSol - lnTotSol
				lnImpDol = Tmp.ImpDol - lnTotDol
			ELSE
				lnImpOrg = ROUND((Tmp.ImpOrg*TabAut.Porctje)/100,2)
				lnImpSol = ROUND((Tmp.ImpSol*TabAut.Porctje)/100,2)
				lnImpDol = ROUND((Tmp.ImpDol*TabAut.Porctje)/100,2)
			ENDIF
			AdiDetalle(TabAut.CodCtaDeb,lnImpOrg,lnImpSol,lnImpDol,Tmp.IndSig)
			AdiDetalle(TabAut.CodCtaHab,lnImpOrg,lnImpSol,lnImpDol,IIF(Tmp.IndSig=="+","-","+"))
			lnTotOrg = lnTotOrg + lnImpOrg
			lnTotSol = lnTotSol + lnImpSol
			lnTotDol = lnTotDol + lnImpDol
		ENDSCAN
	ENDIF
	SELE Tmp
ENDSCAN
USE IN Tmp
RETURN

FUNCTION AdiDetalle(lcCodCta,lnImpOrg,lnImpSol,lnImpDol,lcIndSig)
REPLACE TmpMovCab.NroSecDet WITH TmpMovCab.NroSecDet + 1
SELE TmpMovDet
APPEND BLANK
REPLACE NroSec    WITH TmpMovCab.NroSec, ;
		NroSecDet WITH TmpMovCab.NroSecDet, ;
		Periodo   WITH TmpMovCab.Periodo, ;
		TipCom WITH TmpMovCab.TipCom, ;
		NroCom WITH TmpMovCab.NroCom, ;
		IndReg WITH 1, ;
		CodCta WITH lcCodCta, ;
		TipDoc WITH Tmp.TipDoc, ;
		NroDoc WITH Tmp.NroDoc, ;
		FecDoc WITH Tmp.FecDoc, ;
		FecVen WITH Tmp.FecVen, ;
		TipMnd WITH Tmp.TipMnd, ;
		Tipcam WITH Tmp.TipCam, ;
		CodMnd WITH Tmp.CodMnd, ;
		Impcam WITH Tmp.ImpCam, ;
		ImpOrg WITH lnImpOrg, ;
		ImpSol WITH lnImpSol, ;
		ImpDol WITH lnImpDol, ;
		IndSig WITH lcIndSig, ;
		IndIna WITH Tmp.IndIna, ;
		Glosa  WITH Tmp.Glosa
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
		REPLACE	TipAux WITH Tmp.TipAux, ;
				CodAux WITH Tmp.CodAux, ;
				NomAux WITH Tmp.NomAux, ;
				NroRuc WITH Tmp.NroRuc
	ENDIF
	IF IndCenCos == 1
		REPLACE CodCenCos WITH Tmp.CodCenCos
	ENDIF
	IF IndRef == 1
		REPLACE	TipRef WITH Tmp.TipDoc, ;
				NroRef WITH Tmp.NroDoc
	ENDIF
ENDIF
ENDFUNC