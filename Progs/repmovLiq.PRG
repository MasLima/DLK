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
lcFile = gRuta+"\Temp\"+gcodusu+"PosBco.PRN"
lcProceso = "Rep_MovBco()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_MovBco
LOCAL lcCodBco, lcNroCta, lnTotIng, lnTotSal, lnBcoIng, lnBcoSal, lnCtaIng, lnCtaSal
LOCAL lnBco, lnCta
lnTotIng = 0
lnTotSal = 0
lnBco = 0
@0,0 SAY CHR(15)
TIT_MovBco()
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcCodBco = CodBco
	lnBcoIng = 0
	lnBcoSal = 0
	lnCta = 0
	R = R + 1
	@R,01 SAY " Banco : "+DesBco
	R = R + 1
	DO WHILE !EOF() AND lcCodBco = CodBco
		lcNroCta = NroCta
		lnCtaIng = 0
		lnCtaSal = 0
		R = R + 1
		@R,01 SAY "Cuenta : "+DesCtaCte
		R = R + 1
		@R,01 SAY "NroCta : "+NroCtaCte+" "+Simbol
		R = R + 1
		DO WHILE !EOF() AND lcCodBco = CodBco AND lcNroCta = NroCta
			R = R + 1
			IF R > 55
				TIT_MovBco()
				R = R + 1
			ENDIF
			@R,01 SAY FecDoc
			@R,12 SAY PADR(TipDoc+"-"+NroDoc,13)
			@R,26 SAY PADR(NomAux,35)
			@R,62 SAY ImpIng PICTURE "@Z 99,999,999.99"
			@R,77 SAY ImpSal PICTURE "@Z 99,999,999.99"
			@R,92 SAY ImpSld PICTURE "@Z 99,999,999.99"
			lnCtaIng = lnCtaIng + ImpIng
			lnCtaSal = lnCtaSal + ImpSal
			SKIP
		ENDDO
		R = R + 1
		@R,26 SAY PADL("TOTAL CUENTA",35)
		@R,62 SAY lnCtaIng PICTURE "99,999,999.99"
		@R,77 SAY lnCtaSal PICTURE "99,999,999.99"
		@R,92 SAY (lnCtaIng - lnCtaSal)PICTURE "99,999,999.99"
		lnCta = lnCta + 1
		R = R + 1
		lnBcoIng = lnBcoIng + lnCtaIng
		lnBcoSal = lnBcoSal + lnCtaSal
	ENDDO
	*IF lnCta > 1
	R = R + 1
	@R,26 SAY PADL("TOTAL BANCO",35)
	@R,62 SAY lnBcoIng PICTURE "99,999,999.99"
	@R,77 SAY lnBcoSal PICTURE "99,999,999.99"
	@R,92 SAY (lnBcoIng - lnBcoSal)PICTURE "99,999,999.99"
	lnBco = lnBco + 1
	R = R + 1
	*ENDIF
	lnTotIng = lnTotIng + lnBcoIng
	lnTotSal = lnTotSal + lnBcoSal
ENDDO
*IF lnBco > 1
R = R + 2
@R,01 SAY REPLICATE("-",130)
R = R + 1
@R,26 SAY PADL("TOTAL GENERAL",35)
@R,62 SAY lnTotIng PICTURE "99,999,999.99"
@R,77 SAY lnTotSal PICTURE "99,999,999.99"
@R,92 SAY (lnTotIng - lnTotSal)PICTURE "99,999,999.99"
R = R + 1
@R,01 SAY REPLICATE("-",130)
*ENDIF
RETURN

PROCEDURE TIT_MovBco()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("M O V I M I E N T O S   D E   B A N C O S",90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("-",130)
@05,01 SAY "Fecha"
@05,12 SAY "Documento"
@05,26 SAY "Beneficiario"
@05,62 SAY PADL("Ingreso",13)
@05,77 SAY PADL("Salida",13)
@05,92 SAY PADL("Saldo",13)
@06,001 SAY REPLICATE("-",130)
R=7
RETURN