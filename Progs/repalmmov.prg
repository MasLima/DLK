*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*
*Fecha      Documento     Referencia      Auxiliar                       Mnd          Total   Cambio          Soles        Dolares
*12/12/1234 12-1234567890 12-123456789012 123456789012345678901234567890 123 123,123,123.12 123.1234 123,123,123.12 123,123,123.12

*PARAMETERS lcPeriodo
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "AlmMov"
lcProceso = "Rep_AlmMov()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_AlmMov
LOCAL lcTipMov, lcTipTsc
LOCAL lnTotSol, lnTotDol,lnMovSol, lnMovDol,lnTscSol, lnTscDol

@00,01 SAY CHR(15)
lnTotSol = 0
lnTotDol = 0
lnMov = 0
TIT_AlmMov()

SELE TmpRep
GO TOP
DO WHILE !EOF() 
lcTipMov = TipMov
lnMovSol = 0
lnMovDol = 0
lnMov = lnMov + 1
R = R + 1
@R,01 SAY lcTipMov
@R,04 SAY IIF(SEEK(lcTipMov,"TipMovArt","TipMov"),TipMovArt.DesMov,SPACE(01))
DO WHILE !EOF() AND TipMov = lcTipMov
	lcTipTsc = TipTsc
	@R,01 SAY lcTipTsc
	@R,04 SAY IIF(SEEK(lcTipMov+lcTipTsc,"ArtTsc","TipTsc"),ArtTsc.DesTsc,SPACE(01))
	lnTscSol = 0
	lnTscDol = 0
	DO WHILE !EOF() AND TipMov = lcTipMov AND TipTsc = lcTipTsc
		R = R + 1
		IF R > 55
			R = R + 1
			Tit_AlmMov()
			R = R + 1
		ENDIF
		@R,001 SAY FecDoc
		@R,012 SAY TipDoc+"-"+PADR(NroDoc,10)
		@R,026 SAY TipDocRef+"-"+PADR(NroDocRef,12)
		@R,042 SAY PADR(NomAux,30)
		@R,073 SAY IIF(SEEK(TipMnd,"TipMnd","TipMnd"),PADR(TipMnd.Simbol,3),SPACE(01))
		@R,077 SAY ImpTot PICTURE "@Z 999,999,999.99"
		@R,092 SAY ImpCam PICTURE "999.9999"
		@R,101 SAY ImpTotSol PICTURE "@Z 999,999,999.99"
		@R,116 SAY ImpTotDol PICTURE "@Z 999,999,999.99"
		lnTscSol = lnTscSol + ImpTotSol
		lnTscDol = lnTscDol + ImpTotDol
		SKIP
	ENDDO
	R = R + 1
	@R,042 SAY PADR("TOTAL POR TRANSACCION",30)
	@R,101 SAY lnTscSol PICTURE "@Z 999,999,999.99"
	@R,116 SAY lnTscDol PICTURE "@Z 999,999,999.99"
	lnMovSol = lnMovSol + lnTscSol
	lnMovDol = lnMovDol + lnTscDol
	R = R + 1
ENDDO	
IF lnMov > 1
	R = R + 1
	@R,042 SAY PADR("TOTAL POR MOVIMIENTO",30)
	@R,101 SAY lnMovSol PICTURE "@Z 999,999,999.99"
	@R,116 SAY lnMovDol PICTURE "@Z 999,999,999.99"
	R = R + 1
ENDIF
lnTotSol = lnTotSol + lnMovSol
lnTotDol = lnTotDol + lnMovDol
ENDDO
IF lnMov > 1
	R = R + 1
	@R,001 SAY REPLICATE("-",132)
	R = R + 1
	@R,042 SAY PADR("TOTAL POR MOVIMIENTO",30)
	@R,101 SAY lnTotSol PICTURE "@Z 999,999,999.99"
	@R,116 SAY lnTotDol PICTURE "@Z 999,999,999.99"
	R = R + 1
	@R,001 SAY REPLICATE("-",132)
ENDIF
RETURN

PROCEDURE TIT_AlmMov()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,120 SAY DATE()
@02,042 SAY PADC("MOVIMIENTOS DE ALMACEN",76)
@02,120 SAY TIME()
@03,042 SAY PADC(pTitulo,76)
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Fecha"
@05,012 SAY "Documento"
@05,026 SAY "Referencia"
@05,042 SAY "Auxiliar"
@05,073 SAY "Mnd"
@05,077 SAY PADL("Total",14)
@05,092 SAY PADL("Cambio",08)
@05,101 SAY PADL("Soles",14)
@05,116 SAY PADL("Dolares",14)
@06,001 SAY REPLICATE("-",132)
R=6
RETURN