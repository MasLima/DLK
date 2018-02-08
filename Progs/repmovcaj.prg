*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Caja    : 123  1234567890123456789012345678901234567890
*Usuario : 1234 1234567890123456789012345678901234567890
*Fecha   : 12/12/1234    No Mov : 1234567
*Documento              Importe     Auxiliar                      Ingreso       Salida      Ingreso       Salida T Concepto
*                                                                     S/.          S/.          US$          US$ 
*12-123456789012345 9999,999.99 123 1234567890123456789012345 9999,999.99  9999,999.99  9999,999.99  9999,999.99 1 1234567890123456

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "MovCaja"
lcProceso = "Rep_MovCaja()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_MovCaja
LOCAL lnTotImpIngSol,lnTotImpSalSol,lnTotImpIngDol,lnTotImpSalDol
LOCAL lnEfeImpIngSol,lnEfeImpSalSol,lnEfeImpIngDol,lnEfeImpSalDol
LOCAL lnTjtImpIngSol,lnTjtImpSalSol,lnTjtImpIngDol,lnTjtImpSalDol
LOCAL lnChqImpIngSol,lnChqImpSalSol,lnChqImpIngDol,lnChqImpSalDol
LOCAL lnTotMov,lnEfeMov,lnTjtMov,lnChqMov
@0,0 SAY CHR(18)+CHR(15)
*@0,0 SAY CHR(27)+CHR(18)
*@0,0 SAY CHR(27)+'p'
TIT_MovCaja()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpIngSol,lnTotImpSalSol,lnTotImpIngDol,lnTotImpSalDol
STORE 0 TO lnEfeImpIngSol,lnEfeImpSalSol,lnEfeImpIngDol,lnEfeImpSalDol
STORE 0 TO lnTjtImpIngSol,lnTjtImpSalSol,lnTjtImpIngDol,lnTjtImpSalDol
STORE 0 TO lnChqImpIngSol,lnChqImpSalSol,lnChqImpIngDol,lnChqImpSalDol
STORE 0 TO lnTotMov,lnEfeMov,lnTjtMov,lnChqMov
R = R + 1
@R,001 SAY "Caja      : "+CodCaj+"  "+DesCaj
R = R + 1
@R,001 SAY "Usuario   : "+CodUsu+" "+NomUsu
R = R + 1
@R,001 SAY "Fecha     : "+DTOC(FecMov)
@R,025 SAY "No. Mov : "+ALLTRIM(STR(NroMov))
R = R + 1
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_MovCaja()
		R = R + 1
	ENDIF
	@R,001 SAY TipDoc+" "+IIF(TipOpe=="1",TRANSFORM(NroDoc,"@R 999-999999"),PADR(NroDoc,15))
	@R,020 SAY ImpAmo PICTURE "@Z 9999,999.99"
	@R,032 SAY Simbol
	@R,036 SAY PADR(NomAux,25)
	@R,062 SAY ImpIngSol PICTURE "@Z 9999,999.99"
	@R,075 SAY ImpSalSol PICTURE "@Z 9999,999.99"
	@R,088 SAY ImpIngDol PICTURE "@Z 9999,999.99"
	@R,101 SAY ImpSalDol PICTURE "@Z 9999,999.99"
	@R,113 SAY IndPgo
	@R,115 SAY PADR(Detalle,16)
	IF IndPgo == 1
		lnEfeMov = lnEfeMov + 1
		lnEfeImpIngSol = lnEfeImpIngSol + ImpIngSol
		lnEfeImpSalSol = lnEfeImpSalSol + ImpSalSol
		lnEfeImpIngDol = lnEfeImpIngDol + ImpIngDol
		lnEfeImpSalDol = lnEfeImpSalDol + ImpSalDol
	ENDIF
	IF IndPgo == 2
		lnTjtMov = lnTjtMov + 1
		lnTjtImpIngSol = lnTjtImpIngSol + ImpIngSol
		lnTjtImpSalSol = lnTjtImpSalSol + ImpSalSol
		lnTjtImpIngDol = lnTjtImpIngDol + ImpIngDol
		lnTjtImpSalDol = lnTjtImpSalDol + ImpSalDol
	ENDIF
	IF IndPgo == 3
		lnChqMov = lnChqMov + 1
		lnChqImpIngSol = lnChqImpIngSol + ImpIngSol
		lnChqImpSalSol = lnChqImpSalSol + ImpSalSol
		lnChqImpIngDol = lnChqImpIngDol + ImpIngDol
		lnChqImpSalDol = lnChqImpSalDol + ImpSalDol
	ENDIF
	lnTotMov = lnTotMov + 1
	lnTotImpIngSol = lnTotImpIngSol + ImpIngSol
	lnTotImpSalSol = lnTotImpSalSol + ImpSalSol
	lnTotImpIngDol = lnTotImpIngDol + ImpIngDol
	lnTotImpSalDol = lnTotImpSalDol + ImpSalDol
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,036 SAY "Total"
@R,062 SAY lnTotImpIngSol PICTURE "@ 9999,999.99"
@R,075 SAY lnTotImpSalSol PICTURE "@ 9999,999.99"
@R,088 SAY lnTotImpIngDol PICTURE "@ 9999,999.99"
@R,101 SAY lnTotImpSalDol PICTURE "@ 9999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 2
@R,036 SAY "RESUMEN"
R = R + 1
@R,036 SAY "TOTAL    ("+ALLTRIM(STR(lnTotMov))+")"
@R,062 SAY (lnTotImpIngSol - lnTotImpSalSol) PICTURE "@ 9999,999.99"
@R,088 SAY (lnTotImpIngDol - lnTotImpSalDol) PICTURE "@ 9999,999.99"
R = R + 1
@R,036 SAY "EFECTIVO ("+ALLTRIM(STR(lnEfeMov))+")"
@R,062 SAY (lnEfeImpIngSol - lnEfeImpSalSol) PICTURE "@ 9999,999.99"
@R,088 SAY (lnEfeImpIngDol - lnEfeImpSalDol) PICTURE "@ 9999,999.99"
R = R + 1
@R,036 SAY "TARJETA  ("+ALLTRIM(STR(lnTjtMov))+")"
@R,062 SAY (lnTjtImpIngSol - lnTjtImpSalSol) PICTURE "@ 9999,999.99"
@R,088 SAY (lnTjtImpIngDol - lnTjtImpSalDol) PICTURE "@ 9999,999.99"
R = R + 1
@R,036 SAY "CHEQUE   ("+ALLTRIM(STR(lnTjtMov))+")"
@R,062 SAY (lnChqImpIngSol - lnChqImpSalSol) PICTURE "@ 9999,999.99"
@R,088 SAY (lnChqImpIngDol - lnChqImpSalDol) PICTURE "@ 9999,999.99"
R = R + 1
RETURN

PROCEDURE TIT_MovCaja()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,120 SAY DATE()
@02,042 SAY PADC("MOVIMIENTO DE CAJA",76)
@02,120 SAY PADR(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",130)
@05,001 SAY "Documento"
@05,020 SAY PADL("Importe",11)
@05,036 SAY "Auxiliar"
@05,062 SAY PADL("Ingreso",11)
@05,075 SAY PADL("Salida",11)
@05,088 SAY PADL("Ingreso",11)
@05,101 SAY PADL("Salida",11)
@05,113 SAY "T"
@05,115 SAY "Detalle"
@06,062 SAY PADL("S/.",11)
@06,075 SAY PADL("S/.",11)
@06,088 SAY PADL("US$",11)
@06,101 SAY PADL("US$",11)
@07,001 SAY REPLICATE("-",130)
R=8
RETURN