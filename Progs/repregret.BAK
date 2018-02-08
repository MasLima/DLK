*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9   
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*Reg  Dia        Documento    RUC         Proveedor                           IMPORTE    RETENCION       I.E.S.      IMPORTE  FORMULA
*                Ser Nro                                                        TOTAL     Imp. Rta                      NETO          
*1234 12/12/1234 123 12345678 12345678901 123456789012345678901234567890 99999,999.99 99999,999.99 99999,999.99 99999,999.99 12345678
*PARAMETERS lcPeriodo

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "RegRet"
lcProceso = "REP_RegRet()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_RegRet
LOCAL lnTotImpBto, lnTotImpRet, lnTotImpIes, lnTotInpNet
lnTotImpBto = 0
lnTotImpRet = 0
lnTotImpIes = 0
lnTotImpNet = 0
TIT_RegRet()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
	R = R + 1
	IF R > 55
		Tit_RegRet()
		R = R + 1
	ENDIF
	@R,001 SAY ALLTRIM(STR(NroCom,4)) PICTURE "9999"
	@R,006 SAY FecDoc
	@R,017 SAY NroSer
	@R,021 SAY PADR(NroDoc,08)
	@R,030 SAY PADR(NroRuc,11)
	@R,042 SAY PADR(NomAux,30)
	@R,073 SAY ImpBto PICTURE "99999,999.99"
	@R,086 SAY ImpRet PICTURE "99999,999.99"
	@R,099 SAY ImpIes PICTURE "99999,999.99"
	@R,112 SAY ImpNet PICTURE "99999,999.99"
	@R,125 SAY NroFor
	lnTotImpBto = lnTotImpBto + ImpBto
	lnTotImpRet = lnTotImpRet + ImpRet
	lnTotImpIes = lnTotImpIes + ImpIes
	lnTotImpNet = lnTotImpNet + ImpNet
	SKIP
ENDDO	
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,042 SAY "TOTAL REGISTRO "
@R,073 SAY lnTotImpBto PICTURE "99999,999.99"
@R,086 SAY lnTotImpRet PICTURE "99999,999.99"
@R,099 SAY lnTotImpIes PICTURE "99999,999.99"
@R,112 SAY lnTotImpNet PICTURE "99999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_RegRet()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("R E G I S T R O   DE   RET. TRAB. INDEPED.",90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,030 SAY PADC(pTitulo,90)
@03,120 SAY PADL(ALLTRIM(STR(pPagAnt+lnPag)),10)
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Reg"
@05,006 SAY "Fecha"
@05,017 SAY "DOCUMENTO"
@05,030 SAY "R.U.C."
@05,042 SAY "P R O V E E D O R"
@05,073 SAY PADL("IMPORTE",12)
@05,086 SAY PADL("RETENCION",12)
@05,099 SAY PADL("I.E.S.",12)
@05,112 SAY PADL("IMPORTE",12)
@05,125 SAY "FORM"
@06,017 SAY "Ser"
@06,021 SAY "NRO."
@06,073 SAY PADL("TOTAL",12)
@06,086 SAY PADL("Imp Rta",12)
@06,112 SAY PADL("NETO",12)
@07,001 SAY REPLICATE("-",132)
R=7
RETURN