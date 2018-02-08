LOCAL lcCodCta, lnImpOrg, lnImpSol, lnImpDol, lcIndSig

*- Calculo de Asientos por Redondeo
IF TmpMovcab.TotDebSol == TmpMovcab.TotHabSol AND TmpMovcab.TotDebDol == TmpMovcab.TotHabDol
	RETURN
ENDIF
lcCodCtaHab = TabPar.CodCtaHab
lcCodCtaDeb = TabPar.CodCtaDeb
IF TmpMovcab.TotDebSol <> TmpMovcab.TotHabSol
	IF TmpMovcab.TotDebSol > TmpMovcab.TotHabSol
		lcCodCta = lcCodCtaHab
		lnImpOrg = 0
		lnImpSol = ROUND(TmpMovcab.TotDebSol - TmpMovcab.TotHabSol,2)
		lnImpDol = 0
		lcIndSig = "-"
	ELSE
		lcCodCta = lcCodCtaDeb
		lnImpOrg = 0
		lnImpSol = ROUND(TmpMovcab.TotHabSol - TmpMovcab.TotDebSol,2)
		lnImpDol = 0
		lcIndSig = "+"
	ENDIF
ELSE
IF TmpMovcab.TotDebDol <> TmpMovcab.TotHabDol
	IF TmpMovcab.TotDebDol > TmpMovcab.TotHabDol
		lcCodCta = lcCodCtaHab
		lnImpOrg = 0
		lnImpSol = 0
		lnImpDol = ROUND(TmpMovcab.TotDebDol - TmpMovcab.TotHabDol,2)
		lcIndSig = "-"
	ELSE
		lcCodCta = lcCodCtaDeb
		lnImpOrg = 0
		lnImpSol = 0
		lnImpDol = ROUND(TmpMovcab.TotHabDol - TmpMovcab.TotDebDol,2)
		lcIndSig = "+"
	ENDIF
ENDIF
ENDIF

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
		TipDoc WITH TmpMovCab.TipDoc, ;
		NroDoc WITH TmpMovCab.NroDoc, ;
		FecDoc WITH TmpMovCab.FecDoc, ;
		FecVen WITH TmpMovCab.FecVen, ;
		TipMnd WITH TmpMovCab.TipMnd, ;
		Tipcam WITH TmpMovCab.TipCam, ;
		CodMnd WITH TmpMovCab.CodMnd, ;
		Impcam WITH TmpMovCab.ImpCam, ;
		ImpOrg WITH lnImpOrg, ;
		ImpSol WITH lnImpSol, ;
		ImpDol WITH lnImpDol, ;
		IndSig WITH lcIndSig, ;
		Glosa  WITH "AJUSTE DE REDONDEO POR D.C."
		
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
	IF IndRef == 1
		REPLACE	TipRef WITH TmpMovCab.TipDoc, ;
				NroRef WITH TmpMovCab.NroDoc
	ENDIF
ENDIF
RETURN