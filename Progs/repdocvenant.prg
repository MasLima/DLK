*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Emision    Dia Vencmto    Letra           RUC         Razon Social / Nombre          Mnd         US$          S/. Sit Ubicacion
*12/12/1234 123 12/12/1234 123456789012345 12345678901 123456789012345678901234567890 123 1234,123.12  1234,123.12 123 123456789012

*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Vencmto    Letra           Mnd     Importe       Rango1        Rango2      Rango3       Rango4      Rango5  Sit Auxiliar
*                                                   Al 
*                                                 Rango1                                            
*12/12/1234 123456789012345 123 1234,123.12  1234,123.12  12134,123.12 1234,123.12  1234,123.12  1234,123.12 123 12345678901234567890     

PARAMETERS ldFecIni,ldFecFin,ldFecIni1,ldFecFin1,ldFecIni2,ldFecFin2,ldFecIni3,ldFecFin3,ldFecIni4,ldFecFin4
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = gRuta+"\Temp\DocVenAnt"+gcodusu+SUBS(SYS(2015),3,10)+".PRN"
lcProceso = "Rep_DocVenAnt()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_DocVenAnt
LOCAL lnImpOrg, lnRango1, lnRango2, lnRango3, lnRango4, lnRango5
@00,01 SAY CHR(15)
STORE 0 TO lnImpOrg, lnRango1, lnRango2, lnRango3, lnRango4, lnRango5
TIT_DocVenAnt()
SELE TmpRep
GO TOP
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		R = R + 1
		Tit_DocVenAnt()
		R = R + 1
	ENDIF
	@R,001 SAY FecVen
	@R,012 SAY PADR(TipDoc+" "+NroDoc,15)
	@R,028 SAY Simbol
	@R,032 SAY ImpTot PICTURE "9999,999.99"
	@R,045 SAY Dias PICTURE "999999"
*	@R,045 SAY Rango1 PICTURE "@Z 9999,999.99"
*	@R,058 SAY Rango2 PICTURE "@Z 9999,999.99"
*	@R,071 SAY Rango3 PICTURE "@Z 9999,999.99"
*	@R,084 SAY Rango4 PICTURE "@Z 9999,999.99"
*	@R,097 SAY Rango5 PICTURE "@Z 9999,999.99"
	@R,053 SAY PADR(Situacion,3)
	@R,058 SAY PADR(NomAux,40)
	lnImpOrg = lnImpOrg + ImpTot
	lnRango1 = lnRango1 + Rango1
	lnRango2 = lnRango2 + Rango2
	lnRango3 = lnRango3 + Rango3
	lnRango4 = lnRango4 + Rango4		
	lnRango5 = lnRango5 + Rango5		
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,001 SAY "TOTAL"
@R,032 SAY lnImpOrg PICTURE "9999,999.99"
*@R,045 SAY lnRango1 PICTURE "9999,999.99"
*@R,058 SAY lnRango2 PICTURE "9999,999.99"
*@R,071 SAY lnRango3 PICTURE "9999,999.99"
*@R,084 SAY lnRango4 PICTURE "9999,999.99"
*@R,097 SAY lnRango5 PICTURE "9999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_DocVenAnt()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("ANTIGUEDAD DE LA DEUDA SEGUN VENCIMIENTO",88)
@02,120 SAY TIME()
@03,030 SAY PADC(pTitulo,88)
@03,120 SAY ALLTRIM(STR(lnPag))
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Vencmto"
@05,012 SAY "Documento"
@05,032 SAY PADL("Importe",11)
@05,045 SAY "Dias"
*@05,045 SAY PADL(DTOC(ldFecIni1),11)
*@05,058 SAY PADL(DTOC(ldFecIni2),11)
*@05,071 SAY PADL(DTOC(ldFecIni3),11)
*@05,084 SAY PADL(DTOC(ldFecIni4),11)
*@05,097 SAY PADL(DTOC(ldFecFin),11)
@05,053 SAY "Sit"
@05,058 SAY "Auxiliar"
*@06,045 SAY PADL("Al",11)
*@06,058 SAY PADL("Al",11)
*@06,071 SAY PADL("Al",11)
*@06,084 SAY PADL("Al",11)
*@07,045 SAY PADL(DTOC(ldFecFin1),11)
*@07,058 SAY PADL(DTOC(ldFecFin2),11)
*@07,071 SAY PADL(DTOC(ldFecFin3),11)
*@07,084 SAY PADL(DTOC(ldFecFin4),11)
@07,001 SAY REPLICATE("-",132)
R=8
RETURN