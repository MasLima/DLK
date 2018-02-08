*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Compbte : 12-123456   Periodo : 1234-12
*Fecha   : 12/12/1234   Moneda : 123   Cambio : 1234.123
*Cuenta Auxiliar C.C. Documneto          Referencia         Mn          Debe         Haber           S/.           US$ A Glosa                
*12345678 12-1234 1234 12-12345678901234 12-123456789012345 12 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 1 1234567890123456789012
*123456 12-1234  1234 12-123456789012345 12-123456789012345 12 99,999,999.99 99,999,999.99 99,999,999.99 99,999,999.99 1 1234567890123456789012

*PARAMETERS lcPeriodo
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "DiaCom"
lcProceso = "Rep_DiaCom()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_DiaCom
LOCAL lcTipCom, lnNroCom, lnSec, lnCom, lnTip
LOCAL lnTotDol, lnTotSol
LOCAL lnTipDol, lnTipSol
LOCAL lnComDeb, lnComHab, lnComDol, lnComSol
STORE 0 TO lnSec, lnCom, lnTip
lnTotSol = 0
lnTotDol = 0
lnTip = 0
TIT_DiaCom()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
lcTipCom = TipCom
lnTipSol = 0
lnTipDol = 0
lnCom = 0
R = R + 1
@R,01 SAY "Registro :"+IIF(SEEK(lcTipCom,"TipCom","TipCom"),TipCom.DesCom,"***")
DO WHILE !EOF() AND TipCom = lcTipCom
	lnNroCom = NroCom
	lnComDeb = 0
	lnComHab = 0
	lnComDol = 0
	lnComSol = 0
	lnSec = 0
	R = R + 2
	@R,01 SAY "Compbte  : "+lcTipCom+"-"+STR(lnNroCom,6)
	R = R + 1
	@R,01 SAY "Fecha    : "
	@R,12 SAY FecDoc
	@R,24 SAY "Moneda : "
	@R,33 SAY TipMnd
	@R,39 SAY "Cambio : "
	@R,48 SAY ImpCam PICTURE "9999.999"
	DO WHILE !EOF() AND TipCom = lcTipCom AND nroCom = lnNroCom
		R = R + 1
		IF R > 55
			TIT_DiaCom()
			R = R + 1
		ENDIF
		@R,001 SAY PADR(CodCta,8)
		@R,010 SAY Auxiliar
		@R,018 SAY CodCenCos
		@R,023 SAY PADR(Documento,17)
		@R,041 SAY PADR(Referencia,18)
		@R,060 SAY CodMnd
		@R,063 SAY ImpDeb PICTURE "@Z 99,999,999.99"
		@R,077 SAY ImpHab PICTURE "@Z 99,999,999.99"
		@R,091 SAY ImpSol PICTURE "@Z 99,999,999.99"
		@R,105 SAY ImpDol PICTURE "@Z 99,999,999.99"
		@R,119 SAY TipAut
		@R,121 SAY PADR(Glosa,12)
		lnComDeb = lnComDeb + ImpDeb
		lnComHab = lnComHab + ImpHab
		lnComSol = lnComSol + ImpSol
		lnComDol = lnComDol + ImpDol
		lnSec  = lnSec  + 1
	SKIP
	ENDDO
	IF lnSec > 1
		R = R + 1
		@R,063 SAY "-------------"
		@R,077 SAY "-------------"
		@R,091 SAY "-------------"
		@R,105 SAY "-------------"
		R = R + 1
		@R,063 SAY lnComDeb PICTURE "@ 99,999,999.99"
		@R,077 SAY lnComHab PICTURE "@ 99,999,999.99"
		@R,091 SAY lnComSol PICTURE "@ 99,999,999.99"
		@R,105 SAY lnComDol PICTURE "@ 99,999,999.99"
		lnTipSol = lnTipSol + lnComSol
		lnTipDol = lnTipDol + lnComDol
		lnCom = lnCom + 1
	ENDIF
ENDDO
IF lnCom > 1
R = R + 2
IF R > 55
	TIT_DiaCom()
	R = R + 1
ENDIF
R = R + 1
@R,091 SAY "-------------"
@R,105 SAY "-------------"
R = R + 1
@R,091 SAY lnTipSol PICTURE "@ 99,999,999.99"
@R,105 SAY lnTipDol PICTURE "@ 99,999,999.99"
lnTotSol = lnTotSol + lnTipSol
lnTotDol = lnTotDol + lnTipDol
lnTip = lnTip + 1
ENDIF
ENDDO
IF lnTip > 1
R = R + 2
@R,001 SAY REPLICATE("-",132)
R = R + 1
@R,091 SAY lnTotSol PICTURE "@ 99,999,999.99"
@R,105 SAY lnTotDol PICTURE "@ 99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",132)
ENDIF
RETURN

PROCEDURE TIT_DiaCom()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("R E G I S T R O  DE  C O M P R O B A N T E S",88)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,030 SAY PADC(pTitulo,88)
@03,120 SAY PADL(ALLTRIM(STR(pPagAnt+lnPag)),10)
@04,001 SAY REPLICATE("-",132)
@05,001 SAY "Cuenta"
@05,008 SAY "Auxiliar"
@05,017 SAY "C.C."
@05,022 SAY "Documento"
@05,041 SAY "Referencia"
@05,060 SAY "Mn"
@05,063 SAY PADL("Debe",13)
@05,077 SAY PADL("Haber",13)
@05,091 SAY PADL("S/.",13)
@05,105 SAY PADL("US$",13)
@05,119 SAY "A"
@05,121 SAY "Glosa"
@06,001 SAY REPLICATE("-",132)
R=6
RETURN