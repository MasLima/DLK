*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Linea  : 123456789012345678901234567890
*Clase  : 123  
*Articulo  : 1234567890 
*Fecha      Documento      Referencia           Cantidad          Precio       Total           Costo       Total     Utlidad   %  
*12/12/1234 12-123-1234567 12-12345678901234 999,999.999 9999,999.999999 9999,999.99 9999,999.999999 9999,999.99 9999,999.99 999.999 

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Utilidad"
lcProceso = "Rep_Util()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Util
LOCAL lcCodLin,lcCodCla,lnUtil,lnPcje,lnCanArt,lnTotTotPre,lnTotTotCos
LOCAL lnLinTotPre,lnLinTotCos,lnClaTotPre,lnClaTotCos

@0,0 SAY CHR(18)+CHR(15)

TIT_Util()
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
			lcCodArt = CodArt
			R = R + 1
			@R,01 SAY PADR(CodArt,10)+" "+DesArt+" "+CodUnd
			STORE 0 TO lnCanArt,lnTotPre,lnTotCos
			DO WHILE !EOF() AND CodLin = lcCodLin AND CodCla = lcCodCla AND CodArt = lcCodArt
				R = R + 1
				IF R > 55
					TIT_Util()
					R = R + 1
				ENDIF
				@R,001 SAY FecDoc
				@R,012 SAY TipDoc+" "+TRANSFORM(NroDoc,"@R 999-9999999")
				@R,027 SAY TipDocRef+" "+PADR(NroDocRef,14)
				@R,045 SAY CanArt PICTURE "@Z 999,999.999"
				@R,057 SAY ImpPre PICTURE "@Z 9999,999.999999"
				@R,073 SAY TotPre PICTURE "@Z 9999,999.99"
				@R,085 SAY ImpCos PICTURE "@Z 9999,999.999999"
				@R,101 SAY TotCos PICTURE "@Z 9999,999.99"
				lnUtil = TotPre - TotCos
				lnPcje = IIF(TotCos > 0,ROUND((lnUtil/TotCos)*100,3),0.000)
				@R,113 SAY lnUtil PICTURE "9999,999.99"
				@R,125 SAY lnPcje PICTURE "999.999"
				lnCanArt = lnCanArt + CanArt
				lnTotPre = lnTotPre + TotPre
				lnTotCos = lnTotCos + TotCos
				SKIP
			ENDDO
			R = R + 1
			@R,030 SAY "Total Articulo"
			@R,045 SAY lnCanArt PICTURE "@Z 999,999.999"
			@R,073 SAY lnTotPre PICTURE "@Z 9999,999.99"
			@R,101 SAY lnTotCos PICTURE "@Z 9999,999.99"
			lnUtil = lnTotPre - lnTotCos
			lnPcje = IIF(lnTotCos > 0,ROUND((lnUtil/lnTotCos)*100,3),0.000)
			@R,113 SAY lnUtil PICTURE "9999,999.99"
			@R,125 SAY lnPcje PICTURE "999.999"
			R = R + 1
			lnClaTotPre = lnClaTotPre + lnTotPre
			lnClaTotCos = lnClaTotCos + lnTotCos
		ENDDO	
		R = R + 1
		@R,030 SAY "Total Clase"
		@R,073 SAY lnClaTotPre PICTURE "@Z 9999,999.99"
		@R,101 SAY lnClaTotCos PICTURE "@Z 9999,999.99"
		lnUtil = lnClaTotPre - lnClaTotCos
		lnPcje = IIF(lnClaTotCos > 0,ROUND((lnUtil/lnClaTotCos)*100,3),0.000)
		@R,113 SAY lnUtil PICTURE "9999,999.99"
		@R,125 SAY lnPcje PICTURE "999.999"
		R = R + 1
		lnLinTotPre = lnLinTotPre + lnClaTotPre
		lnLinTotCos = lnLinTotCos + lnClaTotCos
	ENDDO
	R = R + 1
	@R,030 SAY "Total Linea"
	@R,073 SAY lnLinTotPre PICTURE "@Z 9999,999.99"
	@R,101 SAY lnLinTotCos PICTURE "@Z 9999,999.99"
	lnUtil = lnLinTotPre - lnLinTotCos
	lnPcje = IIF(lnLinTotCos > 0,ROUND((lnUtil/lnLinTotCos)*100,3),0.000)
	@R,113 SAY lnUtil PICTURE "9999,999.99"
	@R,125 SAY lnPcje PICTURE "999.999"
	R = R + 1
	lnTotTotPre = lnTotTotPre + lnLinTotPre
	lnTotTotCos = lnTotTotCos + lnLinTotCos
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,030 SAY "Total General"
@R,073 SAY lnTotTotPre PICTURE "@Z 9999,999.99"
@R,101 SAY lnTotTotCos PICTURE "@Z 9999,999.99"
lnUtil = lnTotTotPre - lnTotTotCos
lnPcje = IIF(lnTotTotCos > 0,ROUND((lnUtil/lnTotTotCos)*100,3),0.000)
@R,113 SAY lnUtil PICTURE "9999,999.99"
@R,125 SAY lnPcje PICTURE "999.999"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_Util()
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
@05,001 SAY "Fecha"
@05,012 SAY "Documento"
@05,027 SAY "Referencia"
@05,045 SAY PADL("Cantidad",11)
@05,057 SAY PADL("Precio",15)
@05,073 SAY PADL("Total",11)
@05,085 SAY PADL("Costo",15)
@05,101 SAY PADL("Total",11)
@05,113 SAY PADL("Utilidad",11)
@05,125 SAY PADC("%",7)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN