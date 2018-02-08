*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Tipo            Marca                        Cant        Total        Costo      Utlidad     %  
*123456789012345 1234567890123456789012345 999,999  9999,999.99  9999,999.99  9999,999.99  999.99  

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = gRuta+"\Temp\UtilMar"+gcodusu+SUBS(SYS(2015),3,10)+".PRN"
lcProceso = "Rep_UtilMar()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_UtilMar
LOCAL lcTipArt,lcCodMar,lnUtil,lnPcje,lcDesTipArt
LOCAL lnTipCan,lnTipTot,lnTipCos
LOCAL lnTotCan,lnTotTot,lnTotCos,lnDet
@0,0 SAY CHR(18)+CHR(15)
TIT_UtilMar()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotCan,lnTotTot,lnTotCos
DO WHILE !EOF()
	lcTipArt = TipArt
	lcDesTipArt = DesTipArt
	lnDet = 0
	R = R + 1
	@R,01 SAY PADR(DesTipArt,15)
	STORE 0 TO lnTipCan,lnTipTot,lnTipCos
	DO WHILE !EOF() AND TipArt = lcTipArt
		@R,017 SAY PADR(Desgen,25)
		@R,043 SAY Cantidad PICTURE "@Z 999,999"
		@R,052 SAY Total PICTURE "@Z 9999,999.99"
		@R,065 SAY Costo PICTURE "@Z 9999,999.99"
		lnDet = lnDet + 1
		lnUtil = Total - Costo
		lnPcje = IIF(Costo > 0,ROUND((lnUtil/Costo)*100,2),0.00)
		@R,078 SAY lnUtil PICTURE "9999,999.99"
		@R,091 SAY lnPcje PICTURE "999.99"
		lnTipCan = lnTipCan + Cantidad
		lnTipTot = lnTipTot + Total
		lnTipCos = lnTipCos + Costo
		R = R + 1
		IF R > 55
			TIT_UtilMar()
			R = R + 1
		ENDIF
		SKIP
	ENDDO
	*R = R + 1
	lnUtil = lnTipTot - lnTipCos
	lnPcje = IIF(lnTipCos > 0,ROUND((lnUtil/lnTipCos)*100,2),0.00)
	IF lnDet > 1
	@R,017 SAY "Total "+PADR(lcDesTipArt,15)
	@R,043 SAY lnTipCan PICTURE "@Z 999,999"
	@R,052 SAY lnTipTot PICTURE "@Z 9999,999.99"
	@R,065 SAY lnTipCos PICTURE "@Z 9999,999.99"
	@R,078 SAY lnUtil PICTURE "9999,999.99"
	@R,091 SAY lnPcje PICTURE "999.99"
	R = R + 1
	ENDIF
	lnTotCan = lnTotCan + lnTipCan
	lnTotTot = lnTotTot + lnTipTot
	lnTotCos = lnTotCos + lnTipCos
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,017 SAY "Total General"
@R,043 SAY lnTotCan PICTURE "@Z 999,999"
@R,052 SAY lnTotTot PICTURE "@Z 9999,999.99"
@R,065 SAY lnTotCos PICTURE "@Z 9999,999.99"
lnUtil = lnTotTot - lnTotCos
lnPcje = IIF(lnTotCos > 0,ROUND((lnUtil/lnTotCos)*100,2),0.00)
@R,078 SAY lnUtil PICTURE "9999,999.99"
@R,091 SAY lnPcje PICTURE "999.99"
R = R + 1
@R,001 SAY REPLICATE("-",130)
RETURN

PROCEDURE TIT_UtilMar()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,032 SAY PADC(pTitulo,86)
@02,120 SAY PADR(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",130)
@05,001 SAY "Modelo"
@05,017 SAY "Genero"
@05,043 SAY PADL("Cant",7)
@05,052 SAY PADL("Total",11)
@05,065 SAY PADL("Costo",11)
@05,078 SAY PADL("Utilidad",11)
@05,091 SAY PADC("%",6)
@06,001 SAY REPLICATE("-",130)
R=7
RETURN