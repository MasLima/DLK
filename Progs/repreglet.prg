*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Emision    Dia Vencmto    Letra           RUC         Razon Social / Nombre          Mnd         US$          S/. Sit Ubicacion
*12/12/1234 123 12/12/1234 123456789012345 12345678901 123456789012345678901234567890 123 1234,123.12  1234,123.12 123 123456789012

*PARAMETERS lcPeriodo
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "RegLet"
lcProceso = "Rep_RegLet()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_RegLet
LOCAL lnImpSol, lnImpDol
@00,01 SAY CHR(15)
lnImpSol = 0
lnImpDol = 0
TIT_RegLet()
SELE TmpRep
GO TOP
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		R = R + 1
		Tit_RegLet()
		R = R + 1
	ENDIF
	@R,001 SAY FecDoc
	@R,012 SAY Dias PICTURE "999"
	@R,016 SAY FecVen
	@R,027 SAY PADR(NroDoc,15)
	@R,043 SAY NroRuc
	@R,055 SAY PADR(NomAux,30)
	@R,086 SAY Simbol
	@R,090 SAY ImpDol PICTURE "9999,999.99"
	@R,103 SAY ImpSol PICTURE "9999,999.99"
	@R,115 SAY PADR(Situacion,3)
	@R,119 SAY PADR(Ubicacion,12)
	lnImpDol = lnImpDol + ImpOrg
	lnImpSol = lnImpSol + ImpOrg		
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,055 SAY "TOTAL REGISTRO DE LETRAS"
@R,089 SAY lnImpDol PICTURE "99999,999.99"
@R,102 SAY lnImpSol PICTURE "99999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_RegLet()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC(pTitulo,88)
@02,120 SAY TIME()
@03,120 SAY ALLTRIM(STR(pPagAnt+lnPag))
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Emision"
@05,011 SAY "Dias"
@05,016 SAY "Vencmto"
@05,027 SAY "Letra"
@05,043 SAY "R.U.C."
@05,055 SAY "Razon Social / Nombre"
@05,086 SAY "Mnd"
@05,090 SAY PADL("US$",11)
@05,103 SAY PADL("S/.",11)
@05,115 SAY "Sit"
@05,119 SAY "Ubicacion"
@06,001 SAY REPLICATE("-",132)
R=6
RETURN