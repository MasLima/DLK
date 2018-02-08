*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Tipo      : 123  1234567890123456789012345678901234567890
*Situacion : 1    1234567890123456789012345678901234567890

*Fecha      Documento              Importe         Importe  Sit   Auxiliar                      
*                                      S/.             US$
*12/12/1234 123-1234567890  999,999,999.99  999,999,999.99  1234  1234567890123456789012345678901234567890 
PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "VtaDia"
lcProceso = "Rep_VtaDia()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_VtaDia
LOCAL lnTotImpSol,lnTotImpDol,lnDiaImpSol,lnDiaImpDol
LOCAL ldFecDoc

@0,0 SAY CHR(18)+CHR(15)

TIT_VtaDia()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpSol,lnTotImpDol
DO WHILE !EOF()
	ldFecDoc = FecDoc
	R = R + 1
	IF lnTipRep <> 1
	@R,001 SAY "Dia  : "+DTOC(ldFecDoc)
	R = R + 1
	ELSE
	@R,001 SAY FecDoc
	ENDIF
	STORE 0 TO lnDiaImpSol,lnDiaImpDol
	DO WHILE !EOF() AND FecDoc = ldFecDoc
		IF lnTipRep <> 1
		R = R + 1
		IF R > 55
			TIT_VtaDia()
			R = R + 1
		ENDIF
		@R,013 SAY TRANSFORM(NroDoc,"@R 999-9999999")
		@R,028 SAY ImpDol PICTURE "@Z 999,999,999.99"
		@R,044 SAY ImpSol PICTURE "@Z 999,999,999.99"
		@R,060 SAY PADR(DesSit,4)
		@R,066 SAY PADR(NomAux,40)
		ENDIF
		lnDiaImpSol = lnDiaImpSol + ImpSol
		lnDiaImpDol = lnDiaImpDol + ImpDol
		SKIP
	ENDDO
	IF lnTipRep <> 1
	R = R + 1
	@R,001 SAY PADL("Total Dia",26)
	ENDIF
	@R,028 SAY lnDiaImpDol PICTURE "@Z 999,999,999.99"
	@R,044 SAY lnDiaImpSol PICTURE "@Z 999,999,999.99"
	IF lnTipRep <> 1
	R = R + 1
	ENDIF
	lnTotImpSol = lnTotImpSol + lnDiaImpSol
	lnTotImpDol = lnTotImpDol + lnDiaImpDol
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,001 SAY PADL("TOTAL GENERAL",26)
@R,028 SAY lnTotImpDol PICTURE "@Z 999,999,999.99"
@R,044 SAY lnTotImpSol PICTURE "@Z 999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_VtaDia()
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
@05,013 SAY "Documento"
ELSE
@05,001 SAY "Fecha"
ENDIF
@05,028 SAY PADL("Importe",14)
@05,044 SAY PADL("Importe",14)
IF lnTipRep <> 1
@05,060 SAY "Sit"
@05,066 SAY "Cliente"
ENDIF
@06,028 SAY PADL("US$",14)
@06,044 SAY PADL("S/.",14)
@07,001 SAY REPLICATE("-",130)
R=8
RETURN