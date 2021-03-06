*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
*
*Documento     Dia Reg   RUC         Cliente                                  Vencmto    Mnd    Cambio   V.Venta(US$)        V.Venta         I.G.V.        P.Venta 
*1234 12345678 123 12345 12345678901 1234567890123456789012345678901234567890 12/12/1234 123 9999.9999 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 

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
LOCAL lnTotImpVta, lnTotmpIgv, lnTotImpIna, lnTotInpVta, lnTotImpVtaDol
LOCAL lnDocImpVta, lnDocImpIgv, lnDocImpIna, lnDocInpVta, lnDocImpVtaDol
LOCAL lnSerImpVta, lnSerImpIgv, lnSerImpIna, lnSerInpVta, lnSerImpVtaDol
@00,01 SAY CHR(15)
lnTotImpVtaDol = 0
lnTotImpVta = 0
lnTotImpIgv = 0
lnTotImpIna = 0
lnTotImpTot = 0
TIT_RegVta()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
lcTipDoc = TipDoc
lnDocImpVtaDol = 0
lnDocImpVta = 0
lnDocImpIgv = 0
lnDocImpIna = 0
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
	lnSerImpVtaDol = 0
	lnSerImpVta = 0
	lnSerImpIgv = 0
	lnSerImpIna = 0
	lnSerImpTot = 0
	DO WHILE !EOF() AND TipDoc = lcTipDoc AND NroSer = lcNroSer
	R = R + 1
	IF R > 55
		R = R + 1
		@R,001 SAY REPLICATE("-",172)
		R = R + 1
		@R,038 SAY ""
		@R,103 SAY lnTotImpVtaDol PICTURE "999,999,999.99"
		@R,118 SAY lnTotImpVta PICTURE "999,999,999.99"
		@R,133 SAY lnTotImpIgv PICTURE "999,999,999.99"
		@R,148 SAY lnTotImpTot PICTURE "999,999,999.99"
		Tit_RegVta()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(NroDoc,13)
	@R,015 SAY DAY(FecDoc) PICTURE "99"
	@R,019 SAY NroCom PICTURE "9999"
	@R,025 SAY NroRuc
	@R,037 SAY PADR(NomAux,40)
	@R,078 SAY FecVen
	@R,089 SAY PADR(Simbol,03)
	@R,093 SAY ImpCam PICTURE "9999.9999"
	@R,103 SAY ImpVtaDol PICTURE "999,999,999.99"
	@R,118 SAY ImpVta PICTURE "999,999,999.99"
	@R,133 SAY ImpIgv PICTURE "999,999,999.99"
	@R,148 SAY ImpTot PICTURE "999,999,999.99"
	lnSerImpVtaDol = lnSerImpVtaDol + ImpVta
	lnSerImpVta = lnSerImpVta + ImpVta
	lnSerImpIgv = lnSerImpIgv + ImpIgv
	lnSerImpIna = lnSerImpIna + ImpIna
	lnSerImpTot = lnSerImpTot + ImpTot
	lnTotImpVtaDol = lnTotImpVtaDol + IIF(lcIndSigVta=="+",ImpVtaDol,-1*ImpVtaDol)
	lnTotImpVta = lnTotImpVta + IIF(lcIndSigVta=="+",ImpVta,-1*ImpVta)
	lnTotImpIgv = lnTotImpIgv + IIF(lcIndSigVta=="+",ImpIgv,-1*ImpIgv) 
	lnTotImpIna = lnTotImpIna + IIF(lcIndSigVta=="+",ImpIna,-1*ImpIna) 
	lnTotImpTot = lnTotImpTot + IIF(lcIndSigVta=="+",ImpTot,-1*ImpTot)
	SKIP
	ENDDO
	IF TipDoc = lcTipDoc OR lnSeries > 0
		R = R + 1
		@R,038 SAY PADR("TOTAL SERIE : "+lcNroSer,30)
		@R,103 SAY lnSerImpVtaDol PICTURE "999,999,999.99"
		@R,118 SAY lnSerImpVta PICTURE "999,999,999.99"
		@R,133 SAY lnSerImpIgv PICTURE "999,999,999.99"
		@R,148 SAY lnSerImpTot PICTURE "999,999,999.99"
		R = R + 1
		lnSeries = lnSeries + 1
	ENDIF
	lnDocImpVtaDol = lnDocImpVtaDol + lnSerImpVtaDol
	lnDocImpVta = lnDocImpVta + lnSerImpVta
	lnDocImpIgv = lnDocImpIgv + lnSerImpIgv
	lnDocImpIna = lnDocImpIna + lnSerImpIna
	lnDocImpTot = lnDocImpTot + lnSerImpTot
ENDDO	
R = R + 1
@R,038 SAY PADR("TOTAL "+IIF(SEEK(lcTipDoc,"TipDoc","TipDoc"),TipDoc.DesDoc,SPACE(01)),30)
@R,103 SAY lnDocImpVtaDol PICTURE "999,999,999.99"
@R,118 SAY lnDocImpVta PICTURE "999,999,999.99"
@R,133 SAY lnDocImpIgv PICTURE "999,999,999.99"
@R,148 SAY lnDocImpTot PICTURE "999,999,999.99"
R = R + 1
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",172)
R = R + 1
@R,038 SAY "TOTAL REGISTRO DE VENTAS"
@R,103 SAY lnTotImpVtaDol PICTURE "999,999,999.99"
@R,118 SAY lnTotImpVta PICTURE "999,999,999.99"
@R,133 SAY lnTotImpIgv PICTURE "999,999,999.99"
@R,148 SAY lnTotImpTot PICTURE "999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",172)
RETURN

PROCEDURE TIT_RegVta()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,160 SAY DATE()
@02,042 SAY PADC("R E G I S T R O   DE   V E N T A S",116)
@02,160 SAY TIME()
@03,042 SAY PADC(pTitulo,116)
@03,160 SAY ALLTRIM(STR(pPagAnt+lnPag))
@04,001 SAY REPLICATE("-",172)
@05,001 SAY "DOCUMENTO"
@05,016 SAY "Dia"
@05,021 SAY "Reg"
@05,025 SAY "R.U.C."
@05,037 SAY "C L I E N T E"
@05,078 SAY "Vencmto"
@05,089 SAY "Mnd"
@05,093 SAY PADL("Cambio",9)
@05,103 SAY PADL("V. VENTA(US$)",14)
@05,118 SAY PADL("V. VENTA",14)
@05,133 SAY PADL("I.G.V.",14)
@05,148 SAY PADL("P. VENTA",14)
@06,001 SAY REPLICATE("-",172)
R=6
RETURN