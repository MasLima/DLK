*         1         2         3         4         5         6         7         8         9         0         1         2         3
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
*1234567890  123456789012345678901234567890 123456789012345 12
*Descripcion                                       Total
*1234567890123456789012345678901234567890 99,9999,999.99
*1234567890123456789012345678901234567890 99,9999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "AlmMovLin"
lcProceso = "Rep_MovLin()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_MovLin
LOCAL lcCodLin,lcCodCla,lnTotTot,lnTotLin

@PROW(),PCOL() SAY CHR(27)+"C"+CHR(66) 
@PROW(),PCOL() SAY CHR(18)+CHR(15)

TIT_MovLin()
STORE 0 TO lnTotTot
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcCodLin = CodLin
	R = R + 1
	@R,001 SAY DesLin
	R = R + 1
	STORE 0 TO lnTotLin
	DO WHILE !EOF() AND CodLin = lcCodLin
		R = R + 1
		IF R > 55
			TIT_MovLin()
			R = R + 1
		ENDIF
		@R,001 SAY PADR(DesCla,40)
		@R,042 SAY ImpTot PICTURE "@Z 99,999,999.99"
		lnTotLin = lnTotLin + ImpTot
		SKIP
	ENDDO
	R = R + 1
	@R,020 SAY "TOTAL LINEA"
	@R,042 SAY lnTotLin PICTURE "@Z 99,999,999.99"
	lnTotTot = lnTotTot + lnTotLin
	R = R + 1
ENDDO
R = R + 1
@R,020 SAY "TOTAL GENERAL"
@R,042 SAY lnTotTot PICTURE "@Z 99,999,999.99"
RETURN

PROCEDURE TIT_MovLin()
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
@05,001 SAY PADR("Descripcion",40)
@05,042 SAY PADL("Total",13)
@06,001 SAY REPLICATE("-",130)
R=7
RETURN