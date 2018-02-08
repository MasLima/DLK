*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Tipo            Genero      Tela                           Color        Talla     Cant      Total  
*123456789012345 1234567890  123456789012345678901234567890 123456789012345 12  999,999 9999,999.99
*Tipo   : 1
*Genero : 1
*Tela   : 12
*Color  : 12
*Corre  : 12
*Codigo 
*1234567890 123456789012345678901234567890 12 
*Talla  : 12                                                                 
*Codigo     Descripcion                             Cant     Precio        Total      Costo        Total      Utlidad     %  
*                                                              Und        Precio        Und        Costo        Total        
*12/12/1234 12-123-1234567890 12-123-1234567890   999999  999999.99  9999,999.99  999999.99  9999,999.99  9999,999.99  999.99  

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = gRuta+"\Temp\Utilidad"+gcodusu+SUBS(SYS(2015),3,10)+".PRN"
lcProceso = "Rep_Util()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Util
LOCAL lcTipArt,lcTipGen,lcCodtela,lcCodCol,lcCodTalla,lnCanArt,lnTotPre,lnTotCos,lnUtil,lnPcje
LOCAL lnSecCanArt,lnSecTotPre,lnSecTotCos
LOCAL lnColCanArt,lnColTotPre,lnColTotCos
LOCAL lnTelaCanArt,lnTelaTotPre,lnTelaTotCos
LOCAL lnGenCanArt,lnGenTotPre,lnGenTotCos
LOCAL lnTipCanArt,lnTipTotPre,lnTipTotCos
LOCAL lnTotCanArt,lnTotTotPre,lnTotTotCos
@0,0 SAY CHR(18)+CHR(15)
TIT_Util()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotCanArt,lnTotTotPre,lnTotTotCos
DO WHILE !EOF()
	lcTipArt = TipArt
	R = R + 1
	@R,01 SAY "Modelo : "+IIF(SEEK(lcTipArt,"ArtTip","TipArt"),ArtTip.DesTipArt,SPACE(01))
	STORE 0 TO lnTipCanArt,lnTipTotPre,lnTipTotCos
	DO WHILE !EOF() AND TipArt = lcTipArt
		lcTipGen = TipGen
		R = R + 1
		@R,01 SAY "Genero : "+IIF(SEEK(lcTipGen,"ArtGen","TipGen"),ArtGen.DesGen,SPACE(01))
		STORE 0 TO lnGenCanArt,lnGenTotPre,lnGenTotCos
		DO WHILE !EOF() AND TipArt = lcTipArt AND TipGen = lcTipGen
			lcCodTela = CodTela
			R = R + 1
			@R,01 SAY "Tela   : "+IIF(SEEK(lcCodTela,"ArtTela","CodTela"),ArtTela.Destela,SPACE(01))
			STORE 0 TO lnTelaCanArt,lnTelaTotPre,lnTelaTotCos
			DO WHILE !EOF() AND TipArt = lcTipArt AND TipGen = lcTipGen AND CodTela = lcCodTela
				lcCodCol = CodCol
				R = R + 1
				@R,01 SAY "Color  : "+IIF(SEEK(lcCodCol,"ArtCol","CodCol"),ArtCol.DesCol,SPACE(01))
				STORE 0 TO lnColCanArt,lnColTotPre,lnColTotCos
				DO WHILE !EOF() AND TipArt = lcTipArt AND TipGen = lcTipGen AND CodTela = lcCodTela AND CodCol = lcCodCol
					lcNroSec = NroSec
					*R = R + 1
					*@R,01 SAY "Corre  : "+NroSec
					STORE 0 TO lnSecCanArt,lnSecTotPre,lnSecTotCos
					DO WHILE !EOF() AND TipArt = lcTipArt AND TipGen = lcTipGen AND CodTela = lcCodTela AND CodCol = lcCodCol AND NroSec = lcNroSec
						lcCodTalla = CodTalla
						STORE 0 TO lnCanArt,lnTotPre,lnTotCos
						DO WHILE !EOF() AND TipArt = lcTipArt AND TipGen = lcTipGen AND CodTela = lcCodTela AND CodCol = lcCodCol AND NroSec = lcNroSec AND CodTalla = lcCodTalla
							lnCanArt = lnCanArt + CanArt
							lnTotPre = lnTotPre + TotPre
							lnTotCos = lnTotCos + TotCos
							SKIP
						ENDDO
						R = R + 1
						IF R > 55
							TIT_Util()
							R = R + 1
						ENDIF
						@R,001 SAY PADR(CodArt,10)
						@R,013 SAY PADR(DesArt,30)
						@R,045 SAY IIF(SEEK(lcCodTalla,"ArtTalla","CodTalla"),PADR(ArtTalla.DesTalla,3),SPACE(01))
						@R,050 SAY lnCanArt PICTURE "@Z 999,999"
						*@R,059 SAY ImpPre PICTURE "@Z 999999.99"
						@R,070 SAY lnTotPre PICTURE "@Z 9999,999.99"
						*@R,083 SAY ImpCos PICTURE "@Z 999999.99"
						@R,094 SAY lnTotCos PICTURE "@Z 9999,999.99"
						lnUtil = lnTotPre - lnTotCos
						lnPcje = IIF(lnTotCos > 0,ROUND((lnUtil/lnTotCos)*100,2),0.00)
						@R,107 SAY lnUtil PICTURE "9999,999.99"
						@R,120 SAY lnPcje PICTURE "999.99"
						lnSecCanArt = lnSecCanArt + lnCanArt
						lnSecTotPre = lnSecTotPre + lnTotPre
						lnSecTotCos = lnSecTotCos + lnTotCos
					ENDDO
					*R = R + 1
					*@R,030 SAY "Total Correlativo"
					*@R,050 SAY lnSecCanArt PICTURE "@Z 999,999"
					*@R,070 SAY lnSecTotPre PICTURE "@Z 9999,999.99"
					*@R,094 SAY lnSecTotCos PICTURE "@Z 9999,999.99"
					lnUtil = lnSecTotPre - lnSecTotCos
					lnPcje = IIF(lnSecTotCos > 0,ROUND((lnUtil/lnSecTotCos)*100,2),0.00)
					*@R,107 SAY lnUtil PICTURE "9999,999.99"
					*@R,120 SAY lnPcje PICTURE "999.99"
					*R = R + 1
					lnColCanArt = lnColCanArt + lnSecCanArt
					lnColTotPre = lnColTotPre + lnSecTotPre
					lnColTotCos = lnColTotCos + lnSecTotCos
				ENDDO
				R = R + 1
				@R,030 SAY "Total Color"
				@R,050 SAY lnColCanArt PICTURE "@Z 999,999"
				@R,070 SAY lnColTotPre PICTURE "@Z 9999,999.99"
				@R,094 SAY lnColTotCos PICTURE "@Z 9999,999.99"
				lnUtil = lnColTotPre - lnColTotCos
				lnPcje = IIF(lnColTotCos > 0,ROUND((lnUtil/lnColTotCos)*100,2),0.00)
				@R,107 SAY lnUtil PICTURE "9999,999.99"
				@R,120 SAY lnPcje PICTURE "999.99"
				*R = R + 1
				lnTelaCanArt = lnTelaCanArt + lnColCanArt
				lnTelaTotPre = lnTelaTotPre + lnColTotPre
				lnTelaTotCos = lntelaTotCos + lnColTotCos
			ENDDO
			R = R + 1
			@R,030 SAY "Total Tela"
			@R,050 SAY lnTelaCanArt PICTURE "@Z 999,999"
			@R,070 SAY lnTelaTotPre PICTURE "@Z 9999,999.99"
			@R,094 SAY lnTelaTotCos PICTURE "@Z 9999,999.99"
			lnUtil = lnTelaTotPre - lnTelaTotCos
			lnPcje = IIF(lnTelaTotCos > 0,ROUND((lnUtil/lntelaTotCos)*100,2),0.00)
			@R,107 SAY lnUtil PICTURE "9999,999.99"
			@R,120 SAY lnPcje PICTURE "999.99"
			*R = R + 1
			lnGenCanArt = lnGenCanArt + lnTelaCanArt
			lnGenTotPre = lnGenTotPre + lnTelaTotPre
			lnGenTotCos = lnGenTotCos + lnTelaTotCos
		ENDDO
		R = R + 1
		@R,030 SAY "Total Genero"
		@R,050 SAY lnGenCanArt PICTURE "@Z 999,999"
		@R,070 SAY lnGenTotPre PICTURE "@Z 9999,999.99"
		@R,094 SAY lnGenTotCos PICTURE "@Z 9999,999.99"
		lnUtil = lnGenTotPre - lnGenTotCos
		lnPcje = IIF(lnGenTotCos > 0,ROUND((lnUtil/lnGenTotCos)*100,2),0.00)
		@R,107 SAY lnUtil PICTURE "9999,999.99"
		@R,120 SAY lnPcje PICTURE "999.99"
		*R = R + 1
		lnTipCanArt = lnTipCanArt + lnGenCanArt
		lnTipTotPre = lnTipTotPre + lnGenTotPre
		lnTipTotCos = lnTipTotCos + lnGenTotCos
	ENDDO
	R = R + 1
	@R,030 SAY "Total Modelo"
	@R,050 SAY lnTipCanArt PICTURE "@Z 999,999"
	@R,070 SAY lnTipTotPre PICTURE "@Z 9999,999.99"
	@R,094 SAY lnTipTotCos PICTURE "@Z 9999,999.99"
	lnUtil = lnTipTotPre - lnTipTotCos
	lnPcje = IIF(lnTipTotCos > 0,ROUND((lnUtil/lnTipTotCos)*100,2),0.00)
	@R,107 SAY lnUtil PICTURE "9999,999.99"
	@R,120 SAY lnPcje PICTURE "999.99"
	*R = R + 1
	lnTotCanArt = lnTotCanArt + lnTipCanArt
	lnTotTotPre = lnTotTotPre + lnTipTotPre
	lnTotTotCos = lnTotTotCos + lnTipTotCos
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,030 SAY "Total General"
@R,050 SAY lnTotCanArt PICTURE "@Z 999,999"
@R,070 SAY lnTotTotPre PICTURE "@Z 9999,999.99"
@R,094 SAY lnTotTotCos PICTURE "@Z 9999,999.99"
lnUtil = lnTotTotPre - lnTotTotCos
lnPcje = IIF(lnTotTotCos > 0,ROUND((lnUtil/lnTotTotCos)*100,2),0.00)
@R,107 SAY lnUtil PICTURE "9999,999.99"
@R,120 SAY lnPcje PICTURE "999.99"
R = R + 1
@R,001 SAY REPLICATE("-",130)
RETURN

PROCEDURE TIT_Util()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,120 SAY DATE()
@02,042 SAY PADC(pTitulo,72)
@02,120 SAY PADR(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",130)
@05,001 SAY "Codigo"
@05,013 SAY "Descripcion"
@05,042 SAY "Talla"
@05,050 SAY PADL("Cant",7)
@05,059 SAY PADL("Precio",9)
@05,070 SAY PADL("Total",11)
@05,083 SAY PADL("Costo",9)
@05,094 SAY PADL("Total",11)
@05,107 SAY PADL("Utilidad",11)
@05,120 SAY PADC("%",6)
@06,001 SAY REPLICATE("-",130)
R=7
RETURN