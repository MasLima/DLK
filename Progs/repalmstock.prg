*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*1234567890  12345678901234567890123456789012345678901234567890 123   123,456.12

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Stock"
lcProceso = "Rep_SldArt()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_SldArt
LOCAL lnArt,lnCanArt
*-
@0,0 SAY CHR(18)+CHR(15)
*-
TIT_SldArt()
lnCanArt = 0
lnArt = 0
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_SldArt()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(CodArt,10)
	@R,013 SAY PADR(DesArt,50)
	@R,064 SAY PADR(CodUnd,03)
	@R,070 SAY CanArt PICTURE "999,999.99"
	lnArt = lnArt + 1
	lnCanArt = lnCanArt + CanArt
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,013 SAY "TOTAL"
@R,020 SAY lnArt PICTURE "999,999"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_SldArt()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,76)
@01,120 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,76)
@02,120 SAY TIME() && PADR(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,042 SAY PADC(pTitMnd,76)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Codigo"
@05,013 SAY "Descripcion"
@05,064 SAY "UND"
@05,070 SAY PADL("STOCK",10)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN