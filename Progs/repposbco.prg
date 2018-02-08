*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Banco  Cuenta             NroCta               Mnd           S/.            US$
*12345678901234567890
*       123456789012345678 12345678901234567890 123 99,999,999.99  99,999,999.99
*
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "PosBco"
lcProceso = "Rep_PosBco()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_PosBco
LOCAL lcCodBco, lnTotSol, lnTotDol, lnBcoSol, lnBcoDol

@PROW(),PCOL() SAY CHR(27)+"C"+CHR(66) 
@PROW(),PCOL() SAY CHR(18)

lnTotSol = 0
lnTotDol = 0
TIT_PosBco()
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcCodBco = CodBco
	lnBcoSol = 0
	lnBcoDol = 0
	R = R + 1
	@R,01 SAY DesBco
	DO WHILE !EOF() AND lcCodBco = CodBco
		R = R + 1
		IF R > 55
			TIT_PosBco()
			R = R + 1
		ENDIF
		@R,08 SAY PADR(DesCtaCte,18)
		@R,27 SAY PADR(NroCtaCte,20)
		@R,48 SAY Simbol
		@R,52 SAY SldSol PICTURE "99,999,999.99"
		@R,67 SAY SldDol PICTURE "99,999,999.99"
		lnBcoSol = lnBcoSol + SldSol
		lnBcoDol = lnBcoDol + SldDol
		SKIP
	ENDDO
	R = R + 1
	@R,52 SAY lnBcoSol PICTURE "99,999,999.99"
	@R,67 SAY lnBcoDol PICTURE "99,999,999.99"
	lnTotSol = lnTotSol + lnBcoSol
	lnTotDol = lnTotDol + lnBcoDol
ENDDO
R = R + 2
@R,01 SAY REPLICATE("-",80)
R = R + 1
@R,52 SAY lnTotSol PICTURE "99,999,999.99"
@R,67 SAY lnTotDol PICTURE "99,999,999.99"
R = R + 1
@R,01 SAY REPLICATE("-",80)
RETURN

PROCEDURE TIT_PosBco()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,26)
@01,070 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,26)
@02,120 SAY TIME()
@03,042 SAY PADC(pTitMnd,26)
@03,070 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",080)
@05,01 SAY "Banco"
@05,08 SAY PADR("Cuenta",18)
@05,27 SAY PADR("NroCta",20)
@05,48 SAY "Mnd"
@05,52 SAY PADL("S/.",13)
@05,67 SAY PADL("US$",13)
@06,001 SAY REPLICATE("-",080)
R=7
RETURN