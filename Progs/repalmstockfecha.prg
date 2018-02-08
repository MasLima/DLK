*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Codigo      Descripcion                    		  UND	S.Anterior     Ingreso      Salida       STOCK       Costo         Total
*1234567890  1234567890123456789012345678901234567890 123  999,999.999 999,999.999 999,999.999 999,999.999 9999.999999 99,999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "StockFecha"
lcProceso = "Rep_SldArtFecha()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_SldArtFecha
LOCAL lnArt, lnCanAnt, lnCanIng, lnCanSal, lnCanSld
*-
@0,0 SAY CHR(18)+CHR(15)
*-
TIT_SldArtFecha()
*-
STORE 0 TO lnArt, lnCanAnt, lnCanIng, lnCanSal, lnCanSld
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_SldArtFecha()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(CodArt,10)
	@R,013 SAY PADR(DesArt,40)
	@R,054 SAY PADR(CodUnd,03)
	@R,059 SAY CanAnt PICTURE "@Z 999,999.999"
	@R,071 SAY CanIng PICTURE "@Z 999,999.999"
	@R,083 SAY CanSal PICTURE "@Z 999,999.999"
	@R,095 SAY CanSld PICTURE "@Z 999,999.999"
	@R,107 SAY ImpCos PICTURE "@Z 9999.999999"
	@R,119 SAY ImpTot PICTURE "@Z 99,999,999.99"
	lnArt = lnArt + 1
	lnCanAnt = lnCanAnt + CanAnt
	lnCanIng = lnCanIng + CanIng
	lnCanSal = lnCanSal + CanSal
	lnCanSld = lnCanSld + CanSld
	lnImpTot = lnCanSld + ImpTot
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,013 SAY "TOTAL"
@R,020 SAY lnArt PICTURE "999,999"
*@R,059 SAY lnCanAnt PICTURE "@Z 999,999.999"
*@R,071 SAY lnCanIng PICTURE "@Z 999,999.999"
*@R,083 SAY lnCanSal PICTURE "@Z 999,999.999"
*@R,095 SAY lnCanSld PICTURE "@Z 999,999.999"
*@R,107 SAY lnImpCos PICTURE "@Z 999,999.999"
@R,119 SAY lnImpTot PICTURE "@Z 99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_SldArtFecha()
nPag =lnPag + 1
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
@05,053 SAY "UND"
@05,059 SAY PADL("Inicio",10)
@05,071 SAY PADL("Ingreso",10)
@05,083 SAY PADL("Salida",10)
@05,095 SAY PADL("STOCK",10)
@05,107 SAY PADL("Costo",10)
@05,119 SAY PADL("TOTAL",12)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN