*         1         2         3         4         5         6         7         8         9         0         1         2         3
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
*1234567890  123456789012345678901234567890 123456789012345 12
*Fecha      Documento       Referencia      Codigo     Descripcion                              UND   Cantidad       Importe        Total
*12/12/1234 12-123-12345678 12-123-12345678 1234567890 1234567890123456789012345678901234567890 123 999,999.99 999999.999999 99999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "AlmMovAux"
lcProceso = "Rep_MovAux()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_MovAux
LOCAL lcNomAux,lnTotTot,lnCanArt,lnImpTot

@PROW(),PCOL() SAY CHR(27)+"C"+CHR(66) 
@PROW(),PCOL() SAY CHR(18)+CHR(15)

TIT_MovAux()
STORE 0 TO lnTotTot
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcNomAux = NomAux
	R = R + 1
	@R,001 SAY NomAux
	R = R + 1
	STORE 0 TO lnCanArt,lnImpTot
	DO WHILE !EOF() AND NomAux = lcNomAux
		R = R + 1
		IF R > 55
			TIT_MovAux()
			R = R + 1
		ENDIF
		@R,001 SAY FecDoc
		@R,012 SAY TipDoc+" "+TRANSFORM(NroDoc,"@R 999-99999999")
		@R,028 SAY TipDocRef+" "+PADR(ALLTRIM(NroDocRef),12)
		@R,044 SAY PADR(CodArt,10) 
		@R,055 SAY PADR(Detalle,40)
		@R,096 SAY CodUnd
		@R,100 SAY CanArt PICTURE "@Z 999,999.99"
		@R,111 SAY ImpArt PICTURE "@Z 999999.999999"
		@R,125 SAY ImpTot PICTURE "@Z 99999,999.99"
		lnCanArt = lnCanArt + CanArt
		lnImpTot = lnImpTot + ImpTot
		SKIP
	ENDDO
	R = R + 1
	@R,20 SAY ""
	@R,100 SAY lnCanArt PICTURE "@Z 999,999.99"
	@R,125 SAY lnImpTot PICTURE "@Z 99999,999.99"
	lnTotTot = lnTotTot + lnImpTot
	R = R + 1
ENDDO
R = R + 1
@R,20 SAY "TOTAL GENERAL"
@R,125 SAY lnTotTot PICTURE "@Z 99999,999.99"
RETURN

PROCEDURE TIT_MovAux()
LOCAL lnColumna,lnOldSele
lnOldSele = SELECT()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,76)
@01,120 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,76)
@02,120 SAY TIME() && PADR(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,042 SAY PADC(pTitMnd,76)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",140)
@05,001 SAY "Fecha"
@05,012 SAY "Documento"
@05,028 SAY "Referencia"
@05,044 SAY PADR("Codigo",10)
@05,055 SAY PADR("Delatte",40)
@05,096 SAY PADR("UND",03)
@05,100 SAY PADL("Cantidad",10)
@05,111 SAY PADL("Importe",13)
@05,125 SAY PADL("Total",12)
@06,001 SAY REPLICATE("-",140)
R=7
RETURN