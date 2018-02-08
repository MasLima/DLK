*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Fecha      Documento     Beneficiario                              Ingreso         Salida          Saldo
*   Banco : 12345678901234567890
*  Cuenta : 12345678901234567890
*  NroCta : 12345678901234567890 123
*12/12/1234 12-1234567890 12345678901234567890123456789012345 99,999,999.99  99,999,999.99  99,999,999.99
*
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "MovCcc"
lcProceso = "Rep_MovCcc()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_MovCcc
LOCAL lcCodBco, lcNroCta, lnTotIng, lnTotSal, lnBcoIng, lnBcoSal, lnCtaIng, lnCtaSal
LOCAL lnBco, lnCta
lnTotCgo = 0
lnTotAbo = 0
lnBco = 0
@0,0 SAY CHR(15)
TIT_MovCcc()
SELE TmpPdte
GO TOP 
DO WHILE !EOF()
	lcCodBco = CodBco
	lnBcoCgo = 0
	lnBcoAbo = 0
	lnCta = 0
	R = R + 1
	@R,01 SAY " Banco : "+IIF(SEEK(lcCodBco,"TabBco","CodBco"),TabBco.DesBco,"")
	R = R + 1
	DO WHILE !EOF() AND lcCodBco = CodBco
		lcNroCta = NroCta
		lnCtaCgo = 0
		lnCtaAbo = 0
		R = R + 1
		@R,01 SAY "Cuenta : "+IIF(SEEK(lcCodBco+lcNroCta,"BcoCtaCte","NroCta"),BcoCtaCte.DesCtaCte,"")
		R = R + 1
		*@R,01 SAY "NroCta : "+NroCtaCte+" "+Simbol
		@R,01 SAY "NroCta : "+IIF(SEEK(lcCodBco+lcNroCta,"BcoCtaCte","NroCta"),BcoCtaCte.NroCtaCte,"")
		R = R + 1
		DO WHILE !EOF() AND lcCodBco = CodBco AND lcNroCta = NroCta
			R = R + 1
			IF R > 55
				TIT_MovCcc()
				R = R + 1
			ENDIF
			@R,01 SAY FecDoc
			@R,12 SAY PADR(TipDoc+"-"+NroDoc,13)
			@R,26 SAY PADR(NomAux,40)
			@R,67 SAY ImpCgo PICTURE "@Z 99,999,999.99"
			@R,82 SAY ImpAbo PICTURE "@Z 99,999,999.99"
			lnCtaCgo = lnCtaCgo + ImpCgo
			lnCtaAbo = lnCtaAbo + ImpAbo
			SKIP
		ENDDO
		R = R + 1
		@R,26 SAY PADL("TOTAL CUENTA",35)
		@R,67 SAY lnCtaCgo PICTURE "99,999,999.99"
		@R,82 SAY lnCtaAbo PICTURE "99,999,999.99"
		lnCta = lnCta + 1
		R = R + 1
		lnBcoCgo = lnBcoCgo + lnCtaCgo
		lnBcoAbo = lnBcoAbo + lnCtaAbo
	ENDDO
	IF lnCta > 1
	R = R + 1
	@R,26 SAY PADL("TOTAL BANCO",35)
	@R,67 SAY lnBcoIng PICTURE "99,999,999.99"
	@R,82 SAY lnBcoSal PICTURE "99,999,999.99"
	lnBco = lnBco + 1
	R = R + 1
	ENDIF
	lnTotCgo = lnTotCgo + lnBcoCgo
	lnTotAbo = lnTotAbo + lnBcoAbo
ENDDO
IF lnBco > 1
R = R + 2
@R,01 SAY REPLICATE("-",130)
R = R + 1
@R,26 SAY PADL("TOTAL GENERAL",35)
@R,67 SAY lnTotCgo PICTURE "99,999,999.99"
@R,82 SAY lnTotAbo PICTURE "99,999,999.99"
R = R + 1
@R,01 SAY REPLICATE("-",130)
ENDIF
RETURN


PROCEDURE TIT_MovCcc()
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
@05,26 SAY "Beneficiario"
@05,67 SAY PADL("Cargo",13)
@05,82 SAY PADL("Abono",13)
@06,001 SAY REPLICATE("-",130)
R=7
RETURN