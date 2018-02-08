*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9   
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*12345678901 123456789012345678901234567890
*Periodo Reg  Dia        Documento               V.Venta        I.G.V.       V.Venta        I.G.V.      Inafecto         Otros       P.Venta 
*                        Ser  Nro            Con Derecho   Con Derecho   Sin Derecho   Sin Derecho                    Tributos
*1234-12 1234 12/12/1234 1234 123456789012 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99
*Periodo Reg  Dia        Documento            V.Venta       I.G.V.      V.Venta       I.G.V.     Inafecto        Otros       P.Venta 
*                        Ser  Nro         Con Derecho  Con Derecho  Sin Derecho  Sin Derecho                  Tributos
*1234-12 1234 12/12/1234 1234 1234567890 99999,999.99 99999,999.99 99999,999.99 99999,999.99 99999,999.99 99999,999.99 99,999,999.99
*PARAMETERS lcPeriodo

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "PDTCos"
lcProceso = "REP_PdtCos()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_PdtCos
LOCAL lcTipAux, lcNroRuc, lcNomAux, lcIndSigCom
LOCAL lnTotImpVta, lnTotImpIgv, lnTotImpIna, lnTotInpTot, lnTotImpVta2, lnTotImpIgv2, lnTotImpOtt
LOCAL lnAuxImpVta, lnAuxImpIgv, lnAuxImpIna, lnAuxInpTot, lnAuxImpVta2, lnAuxImpIgv2, lnAuxImpOtt
lnTotImpVta = 0
lnTotImpIgv = 0
lnTotImpIna = 0
lnTotImpVta2= 0
lnTotImpIgv2= 0
lnTotImpOtt = 0
lnTotImpTot = 0
TIT_RegCom()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
lcTipAux = TipAux
lcNroRuc = NroRuc
lcNomAux = NomAux
lnAuxImpVta = 0
lnAuxImpIgv = 0
lnAuxImpIna = 0
lnAuxImpVta2= 0
lnAuxImpIgv2= 0
lnAuxImpOtt = 0
lnAuxImpTot = 0
R = R + 1
@R,01 SAY lcNroRuc
@R,15 SAY lcNomAux
DO WHILE !EOF() AND TipAux = lcTipAux AND NroRuc = lcNroRuc
	R = R + 1
	IF R > 55
		Tit_RegCom()
		R = R + 1
	ENDIF
	@R,001 SAY TRANSFORM(Periodo,"@R 9999-99")
	@R,009 SAY ALLTRIM(STR(NroCom,4)) PICTURE "9999"
	@R,014 SAY FecDoc
	@R,025 SAY NroSer
	@R,030 SAY PADR(NroDoc,10)
	@R,041 SAY ImpVta  PICTURE "@Z 99999,999.99"
	@R,054 SAY ImpIgv  PICTURE "@Z 99999,999.99"
	@R,067 SAY ImpVta2 PICTURE "@Z 99999,999.99"
	@R,080 SAY ImpIgv2 PICTURE "@Z 99999,999.99"
	@R,093 SAY ImpIna  PICTURE "@Z 99999,999.99"
	@R,106 SAY ImpOtt  PICTURE "@Z 99999,999.99"
	@R,119 SAY ImpTot  PICTURE "99,999,999.99"
	lnAuxImpVta = lnAuxImpVta + IIF(IndSigCom=="+",ImpVta,-1*ImpVta)
	lnAuxImpIgv = lnAuxImpIgv + IIF(IndSigCom=="+",ImpIgv,-1*ImpIgv) 
	lnAuxImpIna = lnAuxImpIna + IIF(IndSigCom=="+",ImpIna,-1*ImpIna) 
	lnAuxImpVta2 = lnAuxImpVta2 + IIF(IndSigCom=="+",ImpVta2,-1*ImpVta2)
	lnAuxImpIgv2 = lnAuxImpIgv2 + IIF(IndSigCom=="+",ImpIgv2,-1*ImpIgv2) 
	lnAuxImpOtt = lnAuxImpOtt + IIF(IndSigCom=="+",ImpOtt,-1*ImpOtt)
	lnAuxImpTot = lnAuxImpTot + IIF(IndSigCom=="+",ImpTot,-1*ImpTot)
	SKIP
ENDDO	
R = R + 1
@R,009 SAY PADR("TOTAL "+lcNomAux,30)
@R,041 SAY lnAuxImpVta  PICTURE "99999,999.99"
@R,054 SAY lnAuxImpIgv  PICTURE "99999,999.99"
@R,067 SAY lnAuxImpVta2 PICTURE "99999,999.99"
@R,080 SAY lnAuxImpIgv2 PICTURE "99999,999.99"
@R,093 SAY lnAuxImpIna  PICTURE "99999,999.99"
@R,106 SAY lnAuxImpOtt  PICTURE "99999,999.99"
@R,119 SAY lnAuxImpTot  PICTURE "99,999,999.99"
R = R + 1
lnTotImpVta = lnTotImpVta + lnAuxImpVta
lnTotImpIgv = lnTotImpIgv + lnAuxImpIgv 
lnTotImpIna = lnTotImpIna + lnAuxImpIna
lnTotImpVta2 = lnTotImpVta2 + lnAuxImpVta2
lnTotImpIgv2 = lnTotImpIgv2 + lnAuxImpIgv2
lnTotImpOtt = lnTotImpOtt + lnAuxImpOtt
lnTotImpTot = lnTotImpTot + lnAuxImpTot
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,010 SAY "TOTAL GENERAL"
@R,041 SAY lnTotImpVta  PICTURE "99,999,999.99"
@R,054 SAY lnTotImpIgv  PICTURE "99,999,999.99"
@R,067 SAY lnTotImpVta2 PICTURE "99,999,999.99"
@R,080 SAY lnTotImpIgv2 PICTURE "99,999,999.99"
@R,093 SAY lnTotImpIna  PICTURE "99,999,999.99"
@R,106 SAY lnTotImpOtt  PICTURE "99,999,999.99"
@R,119 SAY lnTotImpTot  PICTURE "99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_RegCom()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,042 SAY PADC("OPERACIONES QUE GENERAN GASTOS Y/O COSTOS",66)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Periodo"
@05,009 SAY "Reg"
@05,014 SAY "Fecha"
@05,025 SAY "DOCUMENTO"
@05,041 SAY PADL("V. COMPRA",13)
@05,054 SAY PADL("I.G.V.",13)
@05,067 SAY PADL("V. COMPRA",13)
@05,080 SAY PADL("I.G.V.",13)
@05,093 SAY PADL("INAFECTO",13)
@05,106 SAY PADL("OTROS",13)
@05,119 SAY PADL("P. COMPRA",13)
@06,025 SAY "Ser"
@06,030 SAY "NRO."
@06,041 SAY PADL("Con Derecho",13)
@06,054 SAY PADL("Con Derecho",13)
@06,067 SAY PADL("Sin Derecho",13)
@06,080 SAY PADL("Sin Derecho",13)
@06,106 SAY PADL("TRIBUTOS",13)
@07,001 SAY REPLICATE("-",132)
R=7
RETURN