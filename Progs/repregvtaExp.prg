*         1         2         3         4         5         6         7         8         9         0         1         2         3
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
*
*Documento     Dia Reg   RUC         Cliente                                 V.Venta         I.G.V.       Inafecto    Exportacion        P.Venta
*1234 12345678 123 12345 12345678901 12345678901234567890123456789012 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 
*               Dia  Reg
*004-32279/32289 12 1234 12345678901

*PARAMETERS lcPeriodo
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "RegVta"
lcProceso = "Rep_RegVta()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_RegVta
LOCAL lcTipDoc, lcIndSigVta, lnSeries
LOCAL lnTotImpVta, lnTotmpIgv, lnTotImpIna, lnTotTotVta, lnTotImpExp
LOCAL lnDocImpVta, lnDocImpIgv, lnDocImpIna, lnDocTotVta, lnDocImpExp
LOCAL lnSerImpVta, lnSerImpIgv, lnSerImpIna, lnSerTotVta, lnSerImpExp
@00,01 SAY CHR(15)
lnTotImpVta = 0
lnTotImpIgv = 0
lnTotImpIna = 0
lnTotImpExp = 0
lnTotImpTot = 0
TIT_RegVta()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
lcTipDoc = TipDoc
lnDocImpVta = 0
lnDocImpIgv = 0
lnDocImpIna = 0
lnDocImpExp = 0
lnDocImpTot = 0
lnSeries = 0
R = R + 1
@R,01 SAY lcTipDoc
@R,04 SAY IIF(SEEK(lcTipDoc,"TipDoc","TipDoc"),TipDoc.DesDoc,SPACE(01))
lcIndSigVta = IIF(SEEK(lcTipDoc,"TipDoc","TipDoc"),TipDoc.IndSigVta,"+")
DO WHILE !EOF() AND TipDoc = lcTipDoc
	lcNroSer = NroSer
	R = R + 1
	@R,01 SAY "SERIE : "+lcNroSer
	lnSerImpVta = 0
	lnSerImpIgv = 0
	lnSerImpIna = 0
	lnSerImpExp = 0
	lnSerImpTot = 0
	DO WHILE !EOF() AND TipDoc = lcTipDoc AND NroSer = lcNroSer
	R = R + 1
	IF R > 55
		R = R + 1
		@R,001 SAY REPLICATE("-",143)
		R = R + 1
		@R,038 SAY ""
		@R,070 SAY lnTotImpVta PICTURE "999,999,999.99"
		@R,085 SAY lnTotImpIgv PICTURE "999,999,999.99"
		@R,100 SAY lnTotImpIna PICTURE "999,999,999.99"
		@R,115 SAY lnTotImpExp PICTURE "999,999,999.99"
		@R,130 SAY lnTotImpTot PICTURE "999,999,999.99"
		Tit_RegVta()
		R = R + 1
	ENDIF
	*@R,001 SAY NroSer+' '+PADR(NroDoc,8)
	@R,001 SAY PADR(NroDoc,15)
	@R,017 SAY DAY(FecDoc) PICTURE "99"
	@R,020 SAY NroCom PICTURE "9999"
	@R,025 SAY NroRuc
	@R,037 SAY PADR(NomAux,32)
	@R,070 SAY ImpVta PICTURE "999,999,999.99"
	@R,085 SAY ImpIgv PICTURE "999,999,999.99"
	@R,100 SAY ImpIna PICTURE "@Z 999,999,999.99"
	@R,115 SAY ImpExp PICTURE "@Z 999,999,999.99"
	@R,130 SAY ImpTot PICTURE "999,999,999.99"
	lnSerImpVta = lnSerImpVta + ImpVta
	lnSerImpIgv = lnSerImpIgv + ImpIgv
	lnSerImpIna = lnSerImpIna + ImpIna
	lnSerImpExp = lnSerImpExp + ImpExp
	lnSerImpTot = lnSerImpTot + ImpTot
	lnTotImpVta = lnTotImpVta + IIF(lcIndSigVta=="+",ImpVta,-1*ImpVta)
	lnTotImpIgv = lnTotImpIgv + IIF(lcIndSigVta=="+",ImpIgv,-1*ImpIgv) 
	lnTotImpIna = lnTotImpIna + IIF(lcIndSigVta=="+",ImpIna,-1*ImpIna)
	lnTotImpExp = lnTotImpExp + IIF(lcIndSigVta=="+",ImpExp,-1*ImpExp) 
	lnTotImpTot = lnTotImpTot + IIF(lcIndSigVta=="+",ImpTot,-1*ImpTot)
	SKIP
	ENDDO
	IF TipDoc = lcTipDoc OR lnSeries > 0
		R = R + 1
		@R,038 SAY PADR("TOTAL SERIE : "+lcNroSer,30)
		@R,070 SAY lnSerImpVta PICTURE "999,999,999.99"
		@R,085 SAY lnSerImpIgv PICTURE "999,999,999.99"
		@R,100 SAY lnSerImpIna PICTURE "999,999,999.99"
		@R,115 SAY lnSerImpExp PICTURE "999,999,999.99"
		@R,130 SAY lnSerImpTot PICTURE "999,999,999.99"
		R = R + 1
		lnSeries = lnSeries + 1
	ENDIF
	lnDocImpVta = lnDocImpVta + lnSerImpVta
	lnDocImpIgv = lnDocImpIgv + lnSerImpIgv
	lnDocImpIna = lnDocImpIna + lnSerImpIna
	lnDocImpExp = lnDocImpExp + lnSerImpExp
	lnDocImpTot = lnDocImpTot + lnSerImpTot
ENDDO	
R = R + 1
@R,038 SAY PADR("TOTAL "+IIF(SEEK(lcTipDoc,"TipDoc","TipDoc"),TipDoc.DesDoc,SPACE(01)),30)
@R,070 SAY lnDocImpVta PICTURE "999,999,999.99"
@R,085 SAY lnDocImpIgv PICTURE "999,999,999.99"
@R,100 SAY lnDocImpIna PICTURE "999,999,999.99"
@R,115 SAY lnDocImpExp PICTURE "999,999,999.99"
@R,130 SAY lnDocImpTot PICTURE "999,999,999.99"
R = R + 1
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",143)
R = R + 1
@R,038 SAY "TOTAL REGISTRO DE VENTAS"
@R,070 SAY lnTotImpVta PICTURE "999,999,999.99"
@R,085 SAY lnTotImpIgv PICTURE "999,999,999.99"
@R,100 SAY lnTotImpIna PICTURE "999,999,999.99"
@R,115 SAY lnTotImpExp PICTURE "999,999,999.99"
@R,130 SAY lnTotImpTot PICTURE "999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",143)
RETURN

PROCEDURE TIT_RegVta()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,130 SAY DATE()
@02,042 SAY PADC("R E G I S T R O   DE   V E N T A S",86)
@02,130 SAY TIME()
@03,042 SAY PADC(pTitulo,86)
@03,130 SAY ALLTRIM(STR(pPagAnt+lnPag))
@04,001 SAY REPLICATE("-",143)
@05,001 SAY "DOCUMENTO"
@05,016 SAY "Dia"
@05,021 SAY "Reg"
@05,025 SAY "R.U.C."
@05,037 SAY "C L I E N T E"
@05,070 SAY PADL("V. VENTA",14)
@05,085 SAY PADL("I.G.V.",14)
@05,100 SAY PADL("INAFECTO",14)
@05,115 SAY PADL("EXPORTACION",14)
@05,130 SAY PADL("P. VENTA",14)
@06,001 SAY REPLICATE("-",143)
R=6
RETURN