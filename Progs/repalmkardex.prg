*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*1234567890  123456789012345678901234567890 123456789012345 12
*Fecha      Documento         Referencia        Transaccion       Ingreso       Salida        Saldo
*12/12/1234 12-123-1234567890 12-123-1234567890 1234567890123 999,999.999  999,999.999  999,999.999

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Kardex"
lcProceso = "Rep_Kardex()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Kardex
LOCAL lcCodArt,lnCanIng,lnCanSal,lcCodAlm,lnCanIngAlm,lnCanSalAlm,lnCanAlm

@PROW(),PCOL() SAY CHR(27)+"C"+CHR(66) 
@PROW(),PCOL() SAY CHR(18)+CHR(15)

TIT_Kardex()
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcCodArt = CodArt
	R = R + 1
	@R,001 SAY ALLTRIM(CodArt)+" "+ALLTRIM(DesArt)+"  ("+CodUnd+")"
	STORE 0 TO lnCanIng,lnCanSal,lnCanAlm
	DO WHILE !EOF() AND CodArt = lcCodArt
		lcCodAlm = CodAlm
		R = R + 1
		@R,001 SAY ALLTRIM(CodAlm)+" "+ALLTRIM(DesAlm)
		STORE 0 TO lnCanIngAlm,lnCanSalAlm
		DO WHILE !EOF() AND CodArt = lcCodArt AND CodAlm = lcCodAlm
			R = R + 1
			IF R > 55
				TIT_Kardex()
				R = R + 1
			ENDIF
			@R,01 SAY FecDoc
			@R,12 SAY TipDoc+" "+TRANSFORM(NroDoc,"@R 999-9999999")
			@R,30 SAY TipDocRef+" "+PADR(NroDocRef,11)
			@R,46 SAY PADR(DesTsc,15)
			@R,62 SAY CanIng PICTURE "@(Z 999,999.999"
			@R,75 SAY CanSal PICTURE "@(Z 999,999.999"
			@R,88 SAY CanSld PICTURE "999,999.999"
			lnCanIngAlm = lnCanIngAlm + CanIng
			lnCanSalAlm = lnCanSalAlm + CanSal
			lnCanIng = lnCanIng + CanIng
			lnCanSal = lnCanSal + CanSal
			SKIP
		ENDDO
		R = R + 1
		@R,46 SAY PADR("TOTAL ALAMCEN",15)
		@R,62 SAY lnCanIngAlm PICTURE "@(Z 999,999.999"
		@R,75 SAY lnCanSalAlm PICTURE "@(Z 999,999.999"
		@R,88 SAY (lnCanIngAlm - lnCanSalAlm) PICTURE "999,999.999"
		lnCanAlm = lnCanAlm + 1
	ENDDO
	IF lnCanAlm > 1
	R = R + 1
	@R,46 SAY PADR("TOTAL ARTICULO",15)
	@R,62 SAY lnCanIng PICTURE "@(Z 999,999.999"
	@R,75 SAY lnCanSal PICTURE "@(Z 999,999.999"
	@R,88 SAY (lnCaning - lnCanSal) PICTURE "999,999.999"
	ENDIF
	R = R + 1
ENDDO
RETURN

PROCEDURE TIT_Kardex()
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
@04,001 SAY REPLICATE("-",132)
@05,01 SAY "Fecha"
@05,12 SAY "Documento"
@05,30 SAY "Referencia"
@05,46 SAY "Transaccion"
@05,62 SAY PADL("Ingreso",11)
@05,75 SAY PADL("Salida",11)
@05,88 SAY PADL("Saldo",11)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN