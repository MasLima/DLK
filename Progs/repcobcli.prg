*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Fecha      Documento     Referencia               Importe         Importe  Concepto
*                                                      S/.             US$
*12/12/1234 12 1234567890 12 123456789012   999,999,999.99  999,999,999.99  1234567890123456789012345678901234567890 

PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "VtaCli"
lcProceso = "Rep_CobCli()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_CobCli
LOCAL lnTotImpSol,lnTotImpDol,lnCliImpSol,lnCliImpDol
LOCAL lcNomAux

@0,0 SAY CHR(18)+CHR(15)

TIT_CobCli()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpSol,lnTotImpDol
DO WHILE !EOF()
	lcNomAux = NomAux
	R = R + 1
	IF lnTipRep <> 1
	@R,001 SAY "Cliente  : "+PADR(NomAux,40)
	R = R + 1
	ELSE
	ENDIF
	STORE 0 TO lnCliImpSol,lnCliImpDol
	DO WHILE !EOF() AND NomAux = lcNomAux
		IF lnTipRep <> 1
		R = R + 1
		IF R > 55
			TIT_CobCli()
			R = R + 1
		ENDIF
		@R,001 SAY FecDoc
		@R,012 SAY TipDoc+"-"+PADR(NroDoc,10)
		@R,026 SAY TipRef+"-"+PADR(NroRef,12)
		@R,044 SAY ImpDol PICTURE "@Z 999,999,999.99"
		@R,060 SAY ImpSol PICTURE "@Z 999,999,999.99"
		@R,076 SAY PADR(DesCto,40)
		ENDIF
		lnCliImpSol = lnCliImpSol + ImpSol
		lnCliImpDol = lnCliImpDol + ImpDol
		SKIP
	ENDDO
	IF lnTipRep <> 1
	R = R + 1
	@R,001 SAY PADL("Total Cliente",26)
	ELSE
	@R,001 SAY PADR(lcNomAux,40)
	ENDIF
	@R,044 SAY lnCliImpDol PICTURE "@Z 999,999,999.99"
	@R,060 SAY lnCliImpSol PICTURE "@Z 999,999,999.99"
	IF lnTipRep <> 1
	R = R + 1
	ELSE
	ENDIF
	lnTotImpSol = lnTotImpSol + lnCliImpSol
	lnTotImpDol = lnTotImpDol + lnCliImpDol
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,001 SAY PADL("TOTAL GENERAL",26)
@R,044 SAY lnTotImpDol PICTURE "@Z 999,999,999.99"
@R,060 SAY lnTotImpSol PICTURE "@Z 999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_CobCli()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,76)
@01,120 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,76)
@02,120 SAY TIME()
@03,042 SAY PADC(pTitMnd,76)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",130)
IF lnTipRep <> 1
@05,001 SAY "Fecha"
@05,012 SAY "Documento"
@05,026 SAY "Referencia"
ELSE
@05,001 SAY "Cliente"
ENDIF
@05,044 SAY PADL("Importe",14)
@05,060 SAY PADL("Importe",14)
IF lnTipRep <> 1
ELSE
ENDIF
@06,044 SAY PADL("US$",14)
@06,060 SAY PADL("S/.",14)
@07,001 SAY REPLICATE("-",130)
R=8
RETURN