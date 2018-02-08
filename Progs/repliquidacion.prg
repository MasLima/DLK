*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*    Periodo : 1234-12  Comprobante : 12-123456                Cambio : 1234.123                        
*  Documento : 12-1234567890 								    Fecha : 12/12/1234 
*   Auxiliar : 1234567890123456789012345678901234567890        Moneda : 123
*Auxiliar                  Documento          Saldo         Amortiza       Debe          Haber         Concepto                       
*1234567890123456789012345 12-123456789012345 99,999,999.99 99,999,999.99+ 99,999,999.99 99,999,999.99 123456789012345678901234567890

*PARAMETERS lcPeriodo
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Liquidacion"
lcProceso = "Rep_Liquida()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Liquida
@00,00 SAY CHR(15)
lnTotDeb = 0
lnTotHab = 0
TIT_Liquida()
SELE TmpRep
GO TOP
@R,01 SAY PADL("Periodo :",13)
@R,15 SAY Periodo PICTURE "@R 9999-99"
@R,24 SAY "Comprobante :"
@R,38 SAY Comprobante
@R,60 SAY PADL("Cambio :",11)
@R,72 SAY ImpCam PICTURE "@B 9999.999"
R = R + 1
@R,01 SAY PADL("Documento :",13)
@R,15 SAY Documento
@R,60 SAY PADL("Fecha :",11)
@R,72 SAY FecDoc
R = R + 1
@R,01 SAY PADL("Auciliar :",13)
@R,15 SAY PADR(NomAux,35)
@R,60 SAY PADL("Moneda :",11)
@R,72 SAY Simbol
R = R + 1
@R,01 SAY REPLICATE("-",132)
R = R + 1
@R,01 Say "Auxiliar"
@R,27 Say "Documento"
@R,46 Say PADL("Saldo",13)
@R,60 Say PADL("Amortiza",13)
@R,75 Say PADL("Debe",13)
@R,89 Say PADL("Haber",13)
@R,103 Say "Concepto"
R = R + 1
@R,01 SAY REPLICATE("-",132)
R = R + 1
SCAN WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_Liquida()
		R = R + 1
	ENDIF 
	@R,01 Say PADR(NomAuxDet,25)
	@R,27 Say TipDoc+"-"+PADR(NroDoc,15)
	@R,46 Say ImpSld PICTURE "99,999,999.99"
	@R,60 Say ImpAmo PICTURE "99,999,999.99"
	@R,73 Say IndSig
	@R,75 Say ImpDeb PICTURE "99,999,999.99"
	@R,89 Say ImpHab PICTURE "99,999,999.99"
	@R,103 Say PADR(DesCto,22)
	lnTotDeb = lnTotDeb + ImpDeb
	lnTotHab = lnTotHab + ImpHab
ENDSCAN
R = R + 1
@R,01 SAY REPLICATE("-",132)
R = R + 1
@R,75 Say lnTotDeb PICTURE "99,999,999.99"
@R,89 Say lnTotHab PICTURE "99,999,999.99"
GO TOP
RETURN

PROCEDURE TIT_Liquida()
lnPag = lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("L I Q U I D A C I O N",88)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,120 SAY PADL(ALLTRIM(STR(lnPag)),10)
@04,001 SAY REPLICATE("-",132)
R=5
RETURN