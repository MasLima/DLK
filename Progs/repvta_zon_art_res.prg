*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Zona      : 123  1234567890123456789012345678901234567890
*Codigo 	Deatalle                                 Und       Cant.        Importe
*1234567890 1234567890123456789012345678901234567890 xxx 999,999.999  99,999,999.99
PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "VtaZonArt_Res"
lcProceso = "Rep_VtaZonArt_Res()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_VtaZonArt_Res
LOCAL lnArt,lnTotTotArt

@0,0 SAY CHR(18)+CHR(15)

TIT_VtaZonArt_Res()
SELE TmpRep
GO TOP 
STORE 0 TO lnArt,lnTotTotArt
DO WHILE !EOF()
	R = R + 1
	IF R > 68
		TIT_VtaZonArt_Res()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(CodArt,10)
	@R,012 SAY PADR(Detalle,40)
	@R,052 SAY CodUnd 
	@R,057 SAY CanArt PICTURE "@Z 999,999.999"
	@R,069 SAY TotArt PICTURE "@Z 99,999,999.99"
	lnTotTotArt = lnTotTotArt + TotArt
	lnArt = lnArt + 1
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
@R,012 SAY PADR("Articulos",15)
@R,030 SAY lnArt PICTURE "@Z 9999"
@R,069 SAY lnTotTotArt PICTURE "@Z 99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_VtaZonArt_Res()
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
@05,001 SAY "Cod."
@05,012 SAY "Descripcion"
@05,052 SAY "UND"
@05,057 SAY PADL("Cant.",11)
@05,069 SAY PADL("Total",13)
@07,001 SAY REPLICATE("-",130)
R=7
RETURN