*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*1234567890  123456789012345678901234567890 123456789012345 12
*Fecha      Documento       Referencia         Ingreso   Importe       Total      Salida   Importe       Total      Saldo       Total    
*12/12/1234 12-123-12345678 12-123-12345678 999,999.99 99,999.99 9999,999.99 999,999.999 99,999.99 9999,999.99 999,999.99 9999,999.99

*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Fecha Documento       Referencia         Ingreso   Importe       Total     Salida       Importe       Total      Saldo       Total    
*12/12 12-123-12345678 12-123-12345678 999,999.99 99,999.99 9999,999.99 999,999.99 99,999.999999 9999,999.99 999,999.99 9999,999.99
*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Fecha Documento       Referencia         Ingreso     Importe       Total     Salida       Importe       Total      Saldo       Total    
*12/12 12-123-12345678 12-123-12345678 999,999.99 99,999.9999 9999,999.99 999,999.99 99,999.999999 9999,999.99 999,999.99 9999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "KardexVal"
lcProceso = "Rep_KdxVal()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_KdxVal
LOCAL lcCodArt,lnImpSld,lnTotSld
LOCAL lnTotCanIng,lnTotTotIng, lnTotCanSal,lnTotTotSal, lnTotCanSld,lnTotTotSld

@PROW(),PCOL() SAY CHR(27)+"C"+CHR(66) 
@PROW(),PCOL() SAY CHR(18)+CHR(15)

TIT_KdxVal()
STORE 0 TO lnTotCanIng,lnTotTotIng, lnTotCanSal,lnTotTotSal, lnTotCanSld,lnTotTotSld
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcCodArt = CodArt
	lnImpSld = ImpCos
	lnTotSld = TotCos
	R = R + 1
	@R,001 SAY ALLTRIM(CodArt)+" "+ALLTRIM(DesArt)+"  ("+CodUnd+")"
	STORE 0 TO lnCanIng,lnTotIng, lnCanSal,lnTotSal, lnCanSld
	DO WHILE !EOF() AND CodArt = lcCodArt
		R = R + 1
		IF R > 55
			TIT_KdxVal()
			R = R + 1
		ENDIF
		@R,001 SAY SUBS(DTOC(FecDoc),1,5)
		@R,007 SAY TipDoc+" "+TRANSFORM(NroDoc,"@R 999-99999999")
		@R,023 SAY TipRef+" "+PADR(ALLTRIM(NroRef),12)
		@R,039 SAY CanIng PICTURE "@Z 999,999.99"
		@R,050 SAY ImpIng PICTURE "@Z 99,999.9999"
		@R,062 SAY TotIng PICTURE "@Z 9999,999.99"
		@R,074 SAY CanSal PICTURE "@Z 999,999.99"
		@R,085 SAY ImpSal PICTURE "@Z 99,999.999999"
		@R,099 SAY TotSal PICTURE "@Z 9999,999.99"
		@R,111 SAY CanSld PICTURE "9999,999.99"
		@R,122 SAY TotSld PICTURE "9999,999.99"
		lnCanIng = lnCanIng + CanIng
		lnCanSal = lnCanSal + CanSal
		lnTotIng = lnTotIng + TotIng
		lnTotSal = lnTotSal + TotSal
		SKIP
	ENDDO
	R = R + 1
	@R,20 SAY "TOTAL ARTICULO"
	@R,039 SAY lnCanIng PICTURE "999,999.99"
	@R,062 SAY lnTotIng PICTURE "9999,999.99"
	@R,074 SAY lnCanSal PICTURE "999,999.99"
	@R,099 SAY (lnTotIng - lnTotSld) PICTURE "9999,999.99"
	@R,111 SAY (lnCanIng - lnCanSal) PICTURE "9999,999.99"
	@R,122 SAY lnTotSld PICTURE "9999,999.99"
	@R,135 SAY IIF(lnTotSal <> (lnTotIng - lnTotSld), "***","")

	lnTotCanIng = lnTotCanIng + lnCanIng
	lnTotCanSal = lnTotCanSal + lnCanSal
	lnTotTotIng = lnTotTotIng + lnTotIng
	lnTotTotSal = lnTotTotSal + lnTotSal
	lnTotTotSld = lnTotTotSld + lnTotSld
	R = R + 1
ENDDO
R = R + 1
@R,20 SAY "TOTAL GENERAL"
@R,062 SAY lnTotTotIng PICTURE "9999,999.99"
@R,099 SAY (lnTotTotIng - lnTotTotSld) PICTURE "9999,999.99"
@R,122 SAY (lnTotTotSld) PICTURE "9999,999.99"
RETURN

PROCEDURE TIT_KdxVal()
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
@05,001 SAY "Fecha"
@05,007 SAY "Documento"
@05,023 SAY "Referencia"
@05,039 SAY PADL("Ingreso",10)
@05,050 SAY PADL("Importe",09)
@05,062 SAY PADL("Total",11)
@05,074 SAY PADL("Salida",10)
@05,085 SAY PADL("Importe",09)
@05,099 SAY PADL("Total",11)
@05,111 SAY PADL("Saldo",10)
@05,122 SAY PADL("Total",11)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN