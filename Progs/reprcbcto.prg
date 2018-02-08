*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Fecha      Documento     Beneficiario                              Ingreso         Salida          Saldo
*Concepto : 12345678901234567890
*Cuenta   : 12345678901234567890
*12/12/1234 12-1234567890 12345678901234567890123456789012345 99,999,999.99  99,999,999.99  99,999,999.99
*
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "RcbCto"
lcProceso = "Rep_RcbCto()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_RcbCto
LOCAL lcCodCto, lcCodCta
LOCAL lnTotSol, lnTotDol
lnTotSol = 0
lnTotDol = 0
@0,0 SAY CHR(15)
TIT_RcbCto()
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcCodCto = CodCto
	R = R + 1
	@R,01 SAY "Concepto : "+IIF(SEEK(TipOpe+lcCodCto,"TabCto","CodCto"),TabCto.DesCto,"")
	R = R + 1
	@R,01 SAY "Cuenta   : "+CodCta
	R = R + 1
	DO WHILE !EOF() AND lcCodCto = CodCto
		R = R + 1
		IF R > 55
			TIT_RcbCto()
			R = R + 1
		ENDIF
		@R,01 SAY FecDoc
		@R,12 SAY PADR(Documento,13)
		@R,26 SAY PADR(NomAux,40)
		@R,67 SAY ImpSol PICTURE "@Z 99,999,999.99"
		@R,82 SAY ImpDol PICTURE "@Z 99,999,999.99"
		SKIP
	ENDDO
	R = R + 1
ENDDO
RETURN

PROCEDURE TIT_RcbCto()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,76)
@01,120 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,76)
@02,120 SAY TIME()
@03,042 SAY PADC(pTitMnd,76)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",130)
@05,01 SAY "Fecha"
@05,12 SAY "Documento"
@05,26 SAY "Auxiliar"
@05,67 SAY PADL("Soles",13)
@05,82 SAY PADL("Dolares",13)
@06,001 SAY REPLICATE("-",130)
R=7
RETURN