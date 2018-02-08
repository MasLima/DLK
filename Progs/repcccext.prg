*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*    Periodo : 1234-12  
*      Banco : 123456789012345678901234567890               
* Cta en Bco : 12345678901234567890  Moneda : 123
*
*Documento     Fecha      Auxiliar                              Cargo         Abono
*12-1234567890 12-12-1234 123456789012345678901234567890 99999,999.99  99999,999.99

*PARAMETERS lcPeriodo
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Extracto"
lcProceso = "Rep_CccExt()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_CccExt
LOCAL lnTotCgo, lnTotAbo
@00,00 SAY CHR(15)
lnTotCgo = 0.00
lnTotAbo = 0.00
TIT_CccExt()
SELE TmpRep
GO TOP
R = R + 1
@R,01 SAY PADL("Periodo :",13)
@R,15 SAY Periodo PICTURE "@R 9999-99"
R = R + 1
@R,01 SAY PADL("Banco :",13)
@R,15 SAY DesBco
R = R + 1
@R,01 SAY PADL("Cta en Bco :",13)
@R,15 SAY NroCtaCte
R = R + 1
@R,01 SAY PADL("Moneda :",13)
@R,72 SAY Simbol
R = R + 1
SCAN WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_CccExt()
		R = R + 1
	ENDIF 
	@R,01 Say TipDoc+"-"+PADR(NroDoc,10)
	@R,15 Say FecDoc
	@R,26 Say PADR(NomAux,30)
	@R,57 Say ImpCgo PICTURE "@Z 99999,999.99"
	@R,71 Say ImpAbo PICTURE "@Z 99999,999.99"
	lnTotCgo = lnTotCgo + ImpCgo
	lnTotAbo = lnTotAbo + ImpAbo
ENDSCAN
R = R + 1
@R,01 SAY REPLICATE("-",132)
R = R + 1
@R,57 Say lnTotCgo PICTURE "99999,999.99"
@R,71 Say lnTotAbo PICTURE "99999,999.99"
GO TOP
RETURN

PROCEDURE TIT_CccExt()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("CONCILIACION   BANCARIA",88)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,120 SAY PADL(ALLTRIM(STR(lnPag)),10)
@04,001 SAY REPLICATE("=",132)
@05,01 Say "Documento"
@05,15 Say "Fecha"
@05,26 Say "Auxiliar"
@05,57 Say PADL("Cargo",12)
@05,71 Say PADL("Abono",12)
@06,01 SAY REPLICATE("=",132)
R=06
RETURN