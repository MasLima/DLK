*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9   
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*12345678901 123456789012345678901234567890
*Periodo Reg  Dia        Documento              V.Venta         I.G.V.       Inafecto        P.Venta 
*                        Ser  Nro        
*1234-12 1234 12/12/1234 1234 1234567890 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99  
*PARAMETERS lcPeriodo

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "PDTIng"
lcProceso = "REP_PdtIng()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_PdtIng
LOCAL lcTipAux, lcCodAux, lcNroRuc, lcNomAux
LOCAL lnTotImpVta, lnTotImpIgv, lnTotImpIna, lnTotInpTot
LOCAL lnAuxImpVta, lnAuxImpIgv, lnAuxImpIna, lnAuxInpTot
lnTotImpVta = 0
lnTotImpIgv = 0
lnTotImpIna = 0
lnTotImpTot = 0
TIT_RegCom()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
lcTipAux = TipAux
lcCodAux = CodAux
lcNroRuc = NroRuc
lcNomAux = NomAux
lnAuxImpVta = 0
lnAuxImpIgv = 0
lnAuxImpIna = 0
lnAuxImpTot = 0
R = R + 1
@R,01 SAY lcNroRuc
@R,15 SAY lcNomAux
DO WHILE !EOF() AND TipAux = lcTipAux AND CodAux = lcCodAux
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
	@R,041 SAY ImpVta  PICTURE "@Z 999,999,999.99"
	@R,056 SAY ImpIgv  PICTURE "@Z 999,999,999.99"
	@R,071 SAY ImpIna  PICTURE "@Z 999,999,999.99"
	@R,086 SAY ImpTot  PICTURE "999,999,999.99"
	lnAuxImpVta = lnAuxImpVta + IIF(IndSigVta=="+",ImpVta,-1*ImpVta)
	lnAuxImpIgv = lnAuxImpIgv + IIF(IndSigVta=="+",ImpIgv,-1*ImpIgv) 
	lnAuxImpIna = lnAuxImpIna + IIF(IndSigVta=="+",ImpIna,-1*ImpIna) 
	lnAuxImpTot = lnAuxImpTot + IIF(IndSigVta=="+",ImpTot,-1*ImpTot)
	SKIP
ENDDO	
R = R + 1
@R,009 SAY PADR("TOTAL "+lcNomAux,30)
@R,041 SAY lnAuxImpVta  PICTURE "999,999,999.99"
@R,056 SAY lnAuxImpIgv  PICTURE "999,999,999.99"
@R,071 SAY lnAuxImpIna  PICTURE "999,999,999.99"
@R,086 SAY lnAuxImpTot  PICTURE "999,999,999.99"
R = R + 1
lnTotImpVta = lnTotImpVta + lnAuxImpVta
lnTotImpIgv = lnTotImpIgv + lnAuxImpIgv 
lnTotImpIna = lnTotImpIna + lnAuxImpIna
lnTotImpTot = lnTotImpTot + lnAuxImpTot
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,010 SAY "TOTAL GENERAL"
@R,041 SAY lnTotImpVta  PICTURE "999,999,999.99"
@R,056 SAY lnTotImpIgv  PICTURE "999,999,999.99"
@R,071 SAY lnTotImpIna  PICTURE "999,999,999.99"
@R,086 SAY lnTotImpTot  PICTURE "999,999,999.99"
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
@02,042 SAY PADC("OPERACIONES QUE GENERAN INGRESOS",66)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Periodo"
@05,009 SAY "Reg"
@05,014 SAY "Fecha"
@05,025 SAY "DOCUMENTO"
@05,041 SAY PADL("V. COMPRA",14)
@05,056 SAY PADL("I.G.V.",14)
@05,071 SAY PADL("INAFECTO",14)
@05,086 SAY PADL("P. COMPRA",14)
@06,025 SAY "Ser"
@06,030 SAY "NRO."
@07,001 SAY REPLICATE("-",132)
R=7
RETURN