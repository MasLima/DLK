*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Tipo      : 123  1234567890123456789012345678901234567890
*Situacion : 1    1234567890123456789012345678901234567890

*Documento   Fecha      Auxiliar                      Importe     Amortiza      Importe     Amortiza
*                                                         S/.          S/.          US$          US$
*123-1234567 12/12/1234 1234567890123456789012345 9999,999.99  9999,999.99  9999,999.99  9999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "DocVtaSit"
lcProceso = "Rep_DocVtaSit()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_DocVtaSit
LOCAL lnTotImpIngSol,lnTotImpSalSol,lnTotImpIngDol,lnTotImpSalDol
LOCAL lnTipImpIngSol,lnTipImpSalSol,lnTipImpIngDol,lnTipImpSalDol
@0,0 SAY CHR(18)+CHR(15)
TIT_DocVtaSit()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpTotSol,lnTotImpAmoSol,lnTotImpTotDol,lnTotImpAmoDol
DO WHILE !EOF()
	lcTipDoc = TipDoc
	R = R + 1
	@R,001 SAY "TIPO  : "+lcTipDoc+"  "+IIF(SEEK(lcTipDoc,"TipDoc","TipDoc"),TipDoc.DesDoc,SPACE(01))
	R = R + 1
	STORE 0 TO lnTipImpTotSol,lnTipImpAmoSol,lnTipImpTotDol,lnTipImpAmoDol
	DO WHILE !EOF() AND TipDoc = lcTipDoc
		R = R + 1
		IF R > 55
			TIT_DocVtaSit()
			R = R + 1
		ENDIF
		@R,001 SAY TRANSFORM(NroDoc,"@R 999-999999")
		@R,013 SAY FecDoc
		IF IndSit == 9
			@R,024 SAY "*** ANULADA ******"
		ELSE
			@R,024 SAY PADR(NomAux,25)
			IF TipMnd == "P"
				@R,050 SAY ImpTot PICTURE "@Z 9999,999.99"
				@R,063 SAY ImpAmo PICTURE "@Z 9999,999.99"
				lnTipImpTotSol = lnTipImpTotSol + ImpTot
				lnTipImpAmoSol = lnTipImpAmoSol + ImpAmo
			ELSE
				@R,076 SAY ImpTot PICTURE "@Z 9999,999.99"
				@R,089 SAY ImpAmo PICTURE "@Z 9999,999.99"
				lnTipImpTotDol = lnTipImpTotDol + ImpTot
				lnTipImpAmoDol = lnTipImpAmoDol + ImpAmo
			ENDIF
		ENDIF
		SKIP
	ENDDO
	R = R + 1
	@R,001 SAY REPLICATE("-",130)
	R = R + 1
	@R,024 SAY PADR("Total "+IIF(SEEK(lcTipDoc,"TipDoc","TipDoc"),TipDoc.DesDoc,SPACE(01)),25)
	@R,050 SAY lnTipImpTotSol PICTURE "@ 9999,999.99"
	@R,063 SAY lnTipImpAmoSol PICTURE "@ 9999,999.99"
	@R,076 SAY lnTipImpTotDol PICTURE "@ 9999,999.99"
	@R,089 SAY lnTipImpAmoDol PICTURE "@ 9999,999.99"
	R = R + 1
	lnTotImpTotSol = lnTotImpTotSol + lnTipImpTotSol
	lnTotImpAmoSol = lnTotImpAmoSol + lnTipImpAmoSol
	lnTotImpTotDol = lnTotImpTotDol + lnTipImpTotDol
	lnTotImpAmoDol = lnTotImpAmoDol + lnTipImpAmoDol
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,024 SAY "TOTAL GENERAL"
@R,050 SAY lnTotImpTotSol PICTURE "@ 9999,999.99"
@R,063 SAY lnTotImpAmoSol PICTURE "@ 9999,999.99"
@R,076 SAY lnTotImpTotDol PICTURE "@ 9999,999.99"
@R,089 SAY lnTotImpAmoDol PICTURE "@ 9999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_DocVtaSit()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("MOVIMIENTO DE CAJA",90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("-",130)
@05,001 SAY "Documento"
@05,013 SAY "Fecha"
@05,024 SAY "Auxiliar"
@05,050 SAY PADL("Importe",11)
@05,063 SAY PADL("Amortiza",11)
@05,076 SAY PADL("Importe",11)
@05,089 SAY PADL("Amortiza",11)
@06,050 SAY PADL("S/.",11)
@06,063 SAY PADL("S/.",11)
@06,076 SAY PADL("US$",11)
@06,089 SAY PADL("US$",11)
@07,001 SAY REPLICATE("-",130)
R=8
RETURN