*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Codigo     Descripcion                    		               UND	      STOCK          Costo          Total
*1234567890 12345678901234567890123456789012345678901234567890 123  999,999.999  999999.999999  99,999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "StockPer"
lcProceso = "Rep_SldPer()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_SldPer
LOCAL lnArt, lnCanAnt, lnCanIng, lnCanSal, lnCanSld
*-
@0,0 SAY CHR(18)+CHR(15)
*-
TIT_SldPer()
*-
STORE 0 TO lnArt, lnImpTot
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_SldPer()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(CodArt,10)
	@R,012 SAY PADR(DesArt,50)
	@R,063 SAY PADR(CodUnd,03)
	@R,068 SAY CanSld PICTURE "@Z 999,999.999"
	@R,081 SAY ImpCos PICTURE "@Z 999999.999999"
	@R,096 SAY ImpTot PICTURE "@Z 99,999,999.99"
	lnArt = lnArt + 1
	lnImpTot = lnImpTot + ImpTot
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,013 SAY "TOTAL"
@R,096 SAY lnImpTot PICTURE "@Z 99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_SldPer()
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
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Codigo"
@05,012 SAY "Descripcion"
@05,063 SAY "UND"
@05,068 SAY PADL("STOCK",11)
@05,081 SAY PADL("Costo",13)
@05,096 SAY PADL("TOTAL",13)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN