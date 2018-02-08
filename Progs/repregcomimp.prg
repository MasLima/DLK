*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2 
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*Reg  Dia        Documento         RUC          Proveedor                            V.Venta        I.G.V.       V.Venta        I.G.V.      Inafecto         Otros   Importacion        Gastos        I.G.V.       P.Venta
*                Ser  Nro                                                        Con Derecho   Con Derecho   Sin Derecho   Sin Derecho                    Tributos                  No Identif   
*1234 12/12/1234 1234 123456789012 123456789012 123456789012345678901234567890 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99
*PARAMETERS lcPeriodo

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "RegCompra"
lcProceso = "REP_RegCom()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_RegCom
LOCAL lcTipDoc, lcDesDoc, lcIndSigCom
LOCAL lnTotImpVta, lnTotImpIgv, lnTotImpIna, lnTotInpTot, lnTotImpVta2, lnTotImpIgv2, lnTotImpOtt, lnTotImpVtaMix, lnTotImpIgvMix, lnTotImpImp
LOCAL lnDocImpVta, lnDocImpIgv, lnDocImpIna, lnDocInpTot, lnDocImpVta2, lnDocImpIgv2, lnDocImpOtt, lnDocImpVtaMix, lnDocImpIgvMix, lnDocImpImp
@00,01 SAY CHR(15)
lnTotImpVta = 0
lnTotImpIgv = 0
lnTotImpIna = 0
lnTotImpVta2= 0
lnTotImpIgv2= 0
lnTotImpVtaMix = 0
lnTotImpIgvMix= 0
lnTotImpOtt = 0
lnTotImpTot = 0
lnTotImpImp = 0
TIT_RegCom()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
lcTipDoc = TipDoc
lcDesDoc = DesDoc
lcIndSigCom = IndSigCom
lnDocImpVta = 0
lnDocImpIgv = 0
lnDocImpIna = 0
lnDocImpVta2= 0
lnDocImpIgv2= 0
lnDocImpVtaMix = 0
lnDocImpIgvMix = 0
lnDocImpOtt = 0
lnDocImpTot = 0
lnDocImpImp = 0
R = R + 1
@R,01 SAY lcTipDoc
@R,04 SAY lcDesDoc
DO WHILE !EOF() AND TipDoc = lcTipDoc
	R = R + 1
	IF R > 55
		R = R + 1
		@R,001 SAY REPLICATE("-",220)
		R = R + 1
		@R,048 SAY ""
		@R,079 SAY lnTotImpVta  PICTURE "99,999,999.99"
		@R,093 SAY lnTotImpIgv  PICTURE "99,999,999.99"
		@R,107 SAY lnTotImpVta2 PICTURE "99,999,999.99"
		@R,121 SAY lnTotImpIgv2 PICTURE "99,999,999.99"
		@R,135 SAY lnTotImpIna  PICTURE "99,999,999.99"
		@R,149 SAY lnTotImpOtt  PICTURE "99,999,999.99"
		@R,163 SAY lnTotImpImp  PICTURE "99,999,999.99"
		@R,177 SAY lnTotImpVtaMix PICTURE "99,999,999.99"
		@R,191 SAY lnTotImpIgvMix PICTURE "99,999,999.99"
		@R,205 SAY lnTotImpTot  PICTURE "99,999,999.99"
		Tit_RegCom()
		R = R + 1
	ENDIF
	@R,001 SAY ALLTRIM(STR(NroCom,4)) PICTURE "9999"
	@R,006 SAY FecDoc
	@R,017 SAY NroSer
	@R,022 SAY PADR(NroDoc,12)
	@R,035 SAY NroRuc
	@R,048 SAY PADR(NomAux,30)
	@R,079 SAY ImpVta  PICTURE "@Z 99,999,999.99"
	@R,093 SAY ImpIgv  PICTURE "@Z 99,999,999.99"
	@R,107 SAY ImpVta2 PICTURE "@Z 99,999,999.99"
	@R,121 SAY ImpIgv2 PICTURE "@Z 99,999,999.99"
	@R,135 SAY ImpIna  PICTURE "@Z 99,999,999.99"
	@R,149 SAY ImpOtt  PICTURE "@Z 99,999,999.99"
	@R,163 SAY ImpImp  PICTURE "@Z 99,999,999.99"
	@R,177 SAY ImpVtaMix PICTURE "@Z 99,999,999.99"
	@R,191 SAY ImpIgvMix PICTURE "@Z 99,999,999.99"
	@R,205 SAY ImpTot  PICTURE "99,999,999.99"
	lnDocImpVta = lnDocImpVta + ImpVta
	lnDocImpIgv = lnDocImpIgv + ImpIgv
	lnDocImpIna = lnDocImpIna + ImpIna
	lnDocImpVta2= lnDocImpVta2+ ImpVta2
	lnDocImpIgv2= lnDocImpIgv2+ ImpIgv2
	lnDocImpOtt = lnDocImpOtt + ImpOtt
	lnDocImpImp = lnDocImpImp + ImpImp
	lnDocImpVtaMix = lnDocImpVtaMix + ImpVtaMix
	lnDocImpIgvMix = lnDocImpIgvMix + ImpIgvMix
	lnDocImpTot = lnDocImpTot + ImpTot
	lnTotImpVta = lnTotImpVta + IIF(lcIndSigCom=="+",ImpVta,-1*ImpVta)
	lnTotImpIgv = lnTotImpIgv + IIF(lcIndSigCom=="+",ImpIgv,-1*ImpIgv) 
	lnTotImpIna = lnTotImpIna + IIF(lcIndSigCom=="+",ImpIna,-1*ImpIna) 
	lnTotImpVta2 = lnTotImpVta2 + IIF(lcIndSigCom=="+",ImpVta2,-1*ImpVta2)
	lnTotImpIgv2 = lnTotImpIgv2 + IIF(lcIndSigCom=="+",ImpIgv2,-1*ImpIgv2) 
	lnTotImpOtt = lnTotImpOtt + IIF(lcIndSigCom=="+",ImpOtt,-1*ImpOtt)
	lnTotImpImp = lnTotImpImp + IIF(lcIndSigCom=="+",ImpImp,-1*ImpImp)
	lnTotImpVtaMix = lnTotImpVtaMix + IIF(lcIndSigCom=="+",ImpVtaMix,-1*ImpVtaMix)
	lnTotImpIgvMix = lnTotImpIgvMix + IIF(lcIndSigCom=="+",ImpIgvMix,-1*ImpIgvMix)
	lnTotImpTot = lnTotImpTot + IIF(lcIndSigCom=="+",ImpTot,-1*ImpTot)
	SKIP
ENDDO	
R = R + 1
@R,048 SAY PADR("TOTAL "+lcDesDoc,30)
@R,079 SAY lnDocImpVta  PICTURE "99,999,999.99"
@R,093 SAY lnDocImpIgv  PICTURE "99,999,999.99"
@R,107 SAY lnDocImpVta2 PICTURE "99,999,999.99"
@R,121 SAY lnDocImpIgv2 PICTURE "99,999,999.99"
@R,135 SAY lnDocImpIna  PICTURE "99,999,999.99"
@R,149 SAY lnDocImpOtt  PICTURE "99,999,999.99"
@R,163 SAY lnDocImpImp  PICTURE "99,999,999.99"
@R,177 SAY lnDocImpVtaMix PICTURE "99,999,999.99"
@R,191 SAY lnDocImpIgvMix PICTURE "99,999,999.99"
@R,205 SAY lnDocImpTot  PICTURE "99,999,999.99"
R = R + 1
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",220)
R = R + 1
@R,048 SAY "TOTAL REGISTRO DE COMPRAS"
@R,079 SAY lnTotImpVta  PICTURE "99,999,999.99"
@R,093 SAY lnTotImpIgv  PICTURE "99,999,999.99"
@R,107 SAY lnTotImpVta2 PICTURE "99,999,999.99"
@R,121 SAY lnTotImpIgv2 PICTURE "99,999,999.99"
@R,135 SAY lnTotImpIna  PICTURE "99,999,999.99"
@R,149 SAY lnTotImpOtt  PICTURE "99,999,999.99"
@R,163 SAY lnTotImpImp  PICTURE "99,999,999.99"
@R,177 SAY lnTotImpVtaMix PICTURE "99,999,999.99"
@R,191 SAY lnTotImpIgvMix PICTURE "99,999,999.99"
@R,205 SAY lnTotImpTot  PICTURE "99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",220)
RETURN

PROCEDURE TIT_RegCom()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,170 SAY DATE()
@02,042 SAY PADC("R E G I S T R O   DE   C O M P R A S",156)
@02,210 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,042 SAY PADC(pTitulo,156)
@03,210 SAY PADL(ALLTRIM(STR(pPagAnt+lnPag)),10)
@04,001 SAY REPLICATE("-",220)
@05,001 SAY "Reg"
@05,006 SAY "Fecha"
@05,017 SAY "DOCUMENTO"
@05,035 SAY "R.U.C."
@05,048 SAY "P R O V E E D O R"
@05,079 SAY PADL("V. COMPRA",13)
@05,093 SAY PADL("I.G.V.",13)
@05,107 SAY PADL("V. COMPRA",13)
@05,121 SAY PADL("I.G.V.",13)
@05,135 SAY PADL("INAFECTO",13)
@05,149 SAY PADL("OTROS",13)
@05,163 SAY PADL("IMPORTAC",13)
@05,177 SAY PADL("GASTOS",13)
@05,191 SAY PADL("I.G.V.",13)
@05,205 SAY PADL("P. COMPRA",13)
@06,017 SAY "Ser"
@06,021 SAY "NRO."
@06,079 SAY PADL("Con Derecho",13)
@06,093 SAY PADL("Con Derecho",13)
@06,107 SAY PADL("Sin Derecho",13)
@06,121 SAY PADL("Sin Derecho",13)
@06,149 SAY PADL("TRIBUTOS",13)
@06,177 SAY PADL("NO IDENTI",13)
@06,191 SAY PADL("NO IDENTI",13)
@07,001 SAY REPLICATE("-",220)
R=7
RETURN