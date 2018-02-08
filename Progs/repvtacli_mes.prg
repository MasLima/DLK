*         1         2         3         4         5         6         7         8         9         1         1         2         3         4         5         6         7         8         9         2         1         2         3         4
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*AUXILIAR                                          TOTAL          ENERO        FEBRERO          MARZO          ABRIL           MAYO          JUNIO          JULIO         AGOSTO      SETIEMBRE        OCTUBRE       NOVIMBRE      DICIEMBRE
*12345678 123456789012345678901234567890  999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99

*PARAMETERS lcPeriodoIni, lcPeriodo, lnIndNiv, lnIndMnd, lnIndOpc
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "VtaCliMes"
lcProceso = "Rep_VtaCliMes()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE Rep_VtaCliMes()
LOCAL lnTOT,ln01,ln02,ln03,ln04,ln05,ln06,ln07,ln08,ln09,ln10,ln11,ln12
@PROW(),PCOL() SAY CHR(27)+"C"+CHR(66) 
@PROW(),PCOL() SAY CHR(18)+CHR(15)
STORE 0 TO lnTOT,ln01,ln02,ln03,ln04,ln05,ln06,ln07,ln08,ln09,ln10,ln11,ln12
TIT_VtaCliMes()

SELE TmpSel
GO TOP
SCAN WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_VtaCliMes()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(NomAux,40)
	@R,042 SAY Total PICTURE "@Z 999,999,999.99"
	@R,057 SAY Ene PICTURE "@Z 999,999,999.99"
	@R,072 SAY Feb PICTURE "@Z 999,999,999.99"
	@R,087 SAY Mar PICTURE "@Z 999,999,999.99"
	@R,102 SAY Abr PICTURE "@Z 999,999,999.99"
	@R,117 SAY May PICTURE "@Z 999,999,999.99"
	@R,132 SAY Jun PICTURE "@Z 999,999,999.99"
	@R,147 SAY Jul PICTURE "@Z 999,999,999.99"
	@R,162 SAY Ago PICTURE "@Z 999,999,999.99"
	@R,177 SAY Sep PICTURE "@Z 999,999,999.99"
	@R,192 SAY Oct PICTURE "@Z 999,999,999.99"
	@R,207 SAY Nov PICTURE "@Z 999,999,999.99"
	@R,222 SAY Dic PICTURE "@Z 999,999,999.99"
	ln01 = ln01 + Ene
	ln02 = ln02 + Feb
	ln03 = ln03 + Mar
	ln04 = ln04 + Abr
	ln05 = ln05 + May
	ln06 = ln06 + Jun
	ln07 = ln07 + Jul
	ln08 = ln08 + Ago
	ln09 = ln09 + Sep
	ln10 = ln10 + Oct
	ln11 = ln11 + Nov
	ln12 = ln12 + Dic
	lnTot = lnTot + Total
ENDSCAN
R = R + 1
@R,001 SAY REPLICATE("-",240)
R = R + 1
@R,001 SAY PADR("TOTAL GENERAL",30)
@R,042 SAY lnTot PICTURE "@Z 999,999,999.99"
@R,057 SAY ln01 PICTURE "@Z 999,999,999.99"
@R,072 SAY ln02 PICTURE "@Z 999,999,999.99"
@R,087 SAY ln03 PICTURE "@Z 999,999,999.99"
@R,102 SAY ln04 PICTURE "@Z 999,999,999.99"
@R,117 SAY ln05 PICTURE "@Z 999,999,999.99"
@R,132 SAY ln06 PICTURE "@Z 999,999,999.99"
@R,147 SAY ln07 PICTURE "@Z 999,999,999.99"
@R,162 SAY ln08 PICTURE "@Z 999,999,999.99"
@R,177 SAY ln09 PICTURE "@Z 999,999,999.99"
@R,192 SAY ln10 PICTURE "@Z 999,999,999.99"
@R,207 SAY ln11 PICTURE "@Z 999,999,999.99"
@R,222 SAY ln12 PICTURE "@Z 999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",240)
RETURN

PROCEDURE TIT_VtaCliMes()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,176)
@01,220 SAY DATE()
@02,042 SAY PADC(pTitRng,176)
@02,220 SAY TIME()
@03,001 SAY PADR("RUC "+ALLTRIM(TabPar.NroRuc),40)
@03,042 SAY PADC(pTitMnd,176)
@03,220 SAY ALLTRIM(STR(pPagAnt+lnPag))
@04,001 SAY REPLICATE("-",240)
@05,001 SAY "AUXILIAR"
@05,042 SAY PADL("TOTAL",14)
@05,057 SAY PADL("ENERO",14) 
@05,072 SAY PADL("FEBRERO",14)
@05,087 SAY PADL("MARZO",14) 
@05,102 SAY PADL("ABRIL",14) 
@05,117 SAY PADL("MAYO",14) 
@05,132 SAY PADL("JUNIO",14) 
@05,147 SAY PADL("JULIO",14) 
@05,162 SAY PADL("AGOSTO",14) 
@05,177 SAY PADL("SEPTIEMBRE",14) 
@05,192 SAY PADL("OCTUBRE",14)
@05,207 SAY PADL("NOVIEMBRE",14) 
@05,222 SAY PADL("DICIEMBRE",14) 
@06,001 SAY REPLICATE("-",240)
R=6
RETURN