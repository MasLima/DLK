*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Fecha      Reg Documento      GLOSA                                              Importe       Importe  Auxiliar                      
*                                                                                     S/.           US$
*12/12/1234 123 123-1234567890 1234567890123456789012345678901234567890 123 99,999,999.99 99,999,999.99  123456789012345678901234567 
		
		
PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "ComCto"
lcProceso = "Rep_ComCto()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_ComCto
LOCAL lnTotImpSol,lnTotImpDol,lnCtoImpSol,lnCtoImpDol
LOCAL lcTipCto,lcCodCto,lcDesCto

@0,0 SAY CHR(18)+CHR(15)
TIT_ComCto()

SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpSol,lnTotImpDol
DO WHILE !EOF()
	lcTipCto = TipCto
	lcCodCto = CodCto
	lcDesCto = ALLTRIM(DesCto)
	R = R + 1
	@R,001 SAY "Concepto : "+PADR(lcDesCto,40)
	R = R + 1
	@R,001 SAY "Cuenta   : "+CodCta
	R = R + 1
	STORE 0 TO lnCtoImpSol,lnCtoImpDol
	DO WHILE !EOF() AND TipCto+CodCto = lcTipCto+lcCodCto
		R = R + 1
		IF R > 55
			TIT_ComCto()
			R = R + 1
		ENDIF
		@R,001 SAY FecDoc
		@R,012 SAY NroCom PICTURE "999"
		@R,016 SAY PADR(NroDoc,14)
		@R,031 SAY PADR(Detalle,40)
		@R,072 SAY IIF(TipMnd=="U","US$","S/.")
		@R,076 SAY ImpDol PICTURE "@Z 99,999,999.99"
		@R,090 SAY ImpSol PICTURE "@Z 99,999,999.99"
		@R,105 SAY PADR(NomAux,27)
		lnCtoImpSol = lnCtoImpSol + ImpSol
		lnCtoImpDol = lnCtoImpDol + ImpDol
		SKIP
	ENDDO
	R = R + 1
	@R,031 SAY "Total "+lcDesCto
	@R,076 SAY lnCtoImpDol PICTURE "@Z 99,999,999.99"
	@R,090 SAY lnCtoImpSol PICTURE "@Z 99,999,999.99"
	lnTotImpSol = lnTotImpSol + lnCtoImpSol
	lnTotImpDol = lnTotImpDol + lnCtoImpDol
	R = R + 1
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,001 SAY "TOTAL GENERAL"
@R,076 SAY lnTotImpDol PICTURE "@Z 99,999,999.99"
@R,090 SAY lnTotImpSol PICTURE "@Z 99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_ComCto()
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
@05,001 SAY "Fecha"
@05,012 SAY "Reg"
@05,016 SAY "Documento"
@05,031 SAY "Glosa"
@05,072 SAY "Mnd"
@05,076 SAY PADL("Importe",13)
@05,090 SAY PADL("Importe",13)
@05,105 SAY "Auxiliar"
@06,076 SAY PADL("US$",13)
@06,090 SAY PADL("S/.",13)
@07,001 SAY REPLICATE("-",130)
R=8
RETURN