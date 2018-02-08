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
lcFile = "VtaVdd"
lcProceso = "Rep_VtaVdd()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_VtaVdd
LOCAL lnTotImpSol,lnTotImpDol,lnVddImpSol,lnVddImpDol
LOCAL lcTipAuxVdd,lcCodAuxVdd,lcVendedor

@0,0 SAY CHR(18)+CHR(15)

TIT_VtaVdd()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpSol,lnTotImpDol
DO WHILE !EOF()
	lcTipAuxVdd = TipAuxVdd
	lcCodAuxVdd = CodAuxVdd
	lcVendedor  = Vendedor
	R = R + 1
	IF lnTipRep <> 1
	@R,001 SAY "Vendedor  : "+Vendedor
	R = R + 1
	ELSE
	@R,001 SAY PADR(Vendedor,25)
	ENDIF
	STORE 0 TO lnVddImpSol,lnVddImpDol
	DO WHILE !EOF() AND TipAuxVdd = lcTipAuxVdd AND CodAuxVdd = lcCodAuxVdd
		IF lnTipRep <> 1
		R = R + 1
		IF R > 55
			TIT_VtaVdd()
			R = R + 1
		ENDIF
		@R,001 SAY FecDoc
		@R,013 SAY TRANSFORM(NroDoc,"@R 999-9999999")
		@R,028 SAY ImpDol PICTURE "@Z 999,999,999.99"
		@R,044 SAY ImpSol PICTURE "@Z 999,999,999.99"
		@R,060 SAY PADR(DesSit,4)
		@R,066 SAY PADR(NomAux,40)
		ENDIF
		lnVddImpSol = lnVddImpSol + ImpSol
		lnVddImpDol = lnVddImpDol + ImpDol
		SKIP
	ENDDO
	IF lnTipRep <> 1
	R = R + 1
	@R,001 SAY PADL("Total Vendedor",26)
	ENDIF
	@R,028 SAY lnVddImpDol PICTURE "@Z 999,999,999.99"
	@R,044 SAY lnVddImpSol PICTURE "@Z 999,999,999.99"
	IF lnTipRep <> 1
	R = R + 1
	ENDIF
	lnTotImpSol = lnTotImpSol + lnVddImpSol
	lnTotImpDol = lnTotImpDol + lnVddImpDol
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

PROCEDURE TIT_VtaVdd()
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
@05,013 SAY "Documento"
ELSE
@05,001 SAY "Vendedor"
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