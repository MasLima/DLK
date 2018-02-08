*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Linea  : 123456789012345678901234567890
*Clase  : 123  
*Codigo     Descripcion                                    UND    Cantidad       Venta       Costo     Utlidad   %  
*1234567890 1234567890123456789012345678901234567890123456 123 999,999.999 9999,999.99 9999,999.99 9999,999.99 999.999 

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "UtilResumen"
lcProceso = "Rep_UtiRes()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_UtiRes
LOCAL lcCodLin,lcCodCla,lnUtil,lnPcje,lnCanArt,lnTotTotPre,lnTotTotCos
LOCAL lnLinTotPre,lnLinTotCos,lnClaTotPre,lnClaTotCos

@0,0 SAY CHR(18)+CHR(15)

TIT_UtiRes()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotTotPre,lnTotTotCos
DO WHILE !EOF()
	lcCodLin = CodLin
	R = R + 1
	@R,01 SAY "Linea : "+IIF(SEEK(lcCodLin,"ArtLin","CodLin"),ArtLin.DesLin,SPACE(01))
	STORE 0 TO lnLinTotPre,lnLinTotCos
	DO WHILE !EOF() AND CodLin = lcCodLin
		lcCodCla = CodCla
		R = R + 1
		@R,01 SAY "Clase : "+IIF(SEEK(lcCodLin+lcCodCla,"ArtCla","CodCla"),ArtCla.DesCla,SPACE(01))
		STORE 0 TO lnClaTotPre,lnClaTotCos
		DO WHILE !EOF() AND CodLin = lcCodLin AND CodCla = lcCodCla
			R = R + 1
			IF R > 55
				TIT_UtiRes()
				R = R + 1
			ENDIF
			@R,001 SAY PADR(CodArt,10)
			@R,012 SAY PADR(DesArt,46)
			@R,059 SAY PADR(CodUnd,3)
			@R,063 SAY CanArt PICTURE "@Z 999,999.999"
			@R,075 SAY TotPre PICTURE "@Z 9999,999.99"
			@R,087 SAY TotCos PICTURE "@Z 9999,999.99"
			lnUtil = TotPre - TotCos
			lnPcje = IIF(TotCos > 0,ROUND((lnUtil/TotCos)*100,3),0.000)
			@R,099 SAY lnUtil PICTURE "9999,999.99"
			@R,111 SAY lnPcje PICTURE "999.999"
			lnClaTotPre = lnClaTotPre + TotPre
			lnClaTotCos = lnClaTotCos + TotCos
			SKIP
		ENDDO	
		R = R + 1
		@R,030 SAY "Total Clase"
		@R,075 SAY lnClaTotPre PICTURE "@Z 9999,999.99"
		@R,087 SAY lnClaTotCos PICTURE "@Z 9999,999.99"
		lnUtil = lnClaTotPre - lnClaTotCos
		lnPcje = IIF(lnClaTotCos > 0,ROUND((lnUtil/lnClaTotCos)*100,3),0.000)
		@R,099 SAY lnUtil PICTURE "9999,999.99"
		@R,111 SAY lnPcje PICTURE "999.999"
		R = R + 1
		lnLinTotPre = lnLinTotPre + lnClaTotPre
		lnLinTotCos = lnLinTotCos + lnClaTotCos
	ENDDO
	R = R + 1
	@R,030 SAY "Total Linea"
	@R,075 SAY lnLinTotPre PICTURE "@Z 9999,999.99"
	@R,087 SAY lnLinTotCos PICTURE "@Z 9999,999.99"
	lnUtil = lnLinTotPre - lnLinTotCos
	lnPcje = IIF(lnLinTotCos > 0,ROUND((lnUtil/lnLinTotCos)*100,3),0.000)
	@R,099 SAY lnUtil PICTURE "9999,999.99"
	@R,111 SAY lnPcje PICTURE "999.999"
	R = R + 1
	lnTotTotPre = lnTotTotPre + lnLinTotPre
	lnTotTotCos = lnTotTotCos + lnLinTotCos
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,030 SAY "Total General"
@R,075 SAY lnTotTotPre PICTURE "@Z 9999,999.99"
@R,087 SAY lnTotTotCos PICTURE "@Z 9999,999.99"
lnUtil = lnTotTotPre - lnTotTotCos
lnPcje = IIF(lnTotTotCos > 0,ROUND((lnUtil/lnTotTotCos)*100,3),0.000)
@R,099 SAY lnUtil PICTURE "9999,999.99"
@R,111 SAY lnPcje PICTURE "999.999"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_UtiRes()
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
@05,059 SAY "UND"
@05,063 SAY PADL("Cantidad",11)
@05,075 SAY PADL("Venta",11)
@05,087 SAY PADL("Costo",11)
@05,099 SAY PADL("Utilidad",11)
@05,111 SAY PADC("%",7)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN