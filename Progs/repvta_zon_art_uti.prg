*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Zona      : 123  1234567890123456789012345678901234567890
*Codigo 	Deatalle                                 Und       Cant.         Total    Costo Und        Costo       Utilidad
*1234567890 1234567890123456789012345678901234567890 xxx 999,999.999 99,999,999.99 999,999.9999 99,999,999.99 99,999,999.99

PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "UtiZonArt"
lcProceso = "Rep_UtiZonArt()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_UtiZonArt
LOCAL lcCodZon,lnZon,lnTot
LOCAL lnTotTotArt,lnTotTotCos,lnTotImpUti,lnZonTotArt,lnZonTotCos,lnZonImpUti

@0,0 SAY CHR(18)+CHR(15)

TIT_UtiZonArt()
SELE TmpRep
GO TOP 
STORE 0 TO lnTot,lnTotTotArt,lnTotTotCos,lnTotImpUti
DO WHILE !EOF()
	lcZona = DesZon
	R = R + 1
	@R,001 SAY lcZona
	STORE 0 TO lnZon,lnZonTotArt,lnZonTotCos,lnZonImpUti
	DO WHILE !EOF() AND DesZon = lcZona
		R = R + 1
		IF R > 68
			TIT_UtiZonArt()
			R = R + 1
		ENDIF
		@R,001 SAY PADR(CodArt,10)
		@R,012 SAY PADR(Detalle,40)
		@R,052 SAY CodUnd 
		@R,057 SAY CanArt PICTURE "@Z 999,999.999"
		@R,069 SAY TotArt PICTURE "@Z 99,999,999.99"
		@R,083 SAY ImpCos PICTURE "@Z 999,999.9999"
		@R,096 SAY TotCos PICTURE "@Z 999,999.9999"
		@R,110 SAY ImpUti PICTURE "999,999.9999"
		lnZon = lnZon + 1
		lnZonTotArt = lnZonTotArt + TotArt
		lnZonTotCos = lnZonTotCos + TotCos
		lnZonImpUti = lnZonImpUti + ImpUti
		SKIP
	ENDDO
	R = R + 1
	@R,012 SAY PADR("Articulos por "+ALLTRIM(lcZona)+" : ",22)
	@R,035 SAY lnZon PICTURE "@Z 9999"
	@R,069 SAY lnZonTotArt PICTURE "@Z 99,999,999.99"
	@R,096 SAY lnZonTotCos PICTURE "@Z 999,999.9999"
	@R,110 SAY lnZonImpUti PICTURE "999,999.9999"
	R = R + 1
	lnTot = lnTot + lnZon
	lnTotTotArt = lnTotTotArt + lnZonTotArt
	lnTotTotCos = lnTotTotCos + lnZonTotCos
	lnTotImpUti = lnTotImpUti + lnZonImpUti
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,012 SAY PADR("Total Articulos",20)
@R,035 SAY lnTot PICTURE "@Z 9999"
@R,069 SAY lnTotTotArt PICTURE "@Z 99,999,999.99"
@R,096 SAY lnTotTotCos PICTURE "@Z 999,999.9999"
@R,110 SAY lnTotImpUti PICTURE "999,999.9999"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_UtiZonArt()
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
@05,057 SAY PADL("Cant",11)
@05,069 SAY PADL("Venta",13) 
@05,083 SAY PADL("Costo",12)
@05,096 SAY PADL("Costo",12)
@05,110 SAY PADL("Utilidad",12)
@06,069 SAY PADL("Total",13) 
@06,083 SAY PADL("Und",12)
@06,096 SAY PADL("Total",12)
@06,110 SAY PADL("Total",12)
@07,001 SAY REPLICATE("-",130)
R=7
RETURN