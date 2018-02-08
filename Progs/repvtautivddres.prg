*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0   
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*UTILIDAD POR VENDEDOR
*VENDEDOR 1234567890123456789012345678901234567890 
*CLIENTE  1234567890123456789012345678901234567890                  9999,999.99 9999,999.99 9999,999.99 999.999
*
* VENDEDOR                                                          9999,999.99 9999,999.99 9999,999.99 999.999
* GENERAL                                                           9999,999.99 9999,999.99 9999,999.99 999.999


PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "UtiVddRes"
lcProceso = "Rep_UtiVddRes()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_UtiVddRes
LOCAL lnTotCos,lnTotVta,lnVddCos,lnVddVta,lnImpUti,lnPcjUti
LOCAL lcVendedor,lnCli

@0,0 SAY CHR(18)+CHR(15)

TIT_UtiVddRes()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotCos,lnTotVta,lnImpUti,lnPcjUti
DO WHILE !EOF()
	lcVendedor = Vendedor
	R = R + 1
	@R,001 SAY "Vendedor  : "+PADR(Vendedor,40)
	STORE 0 TO lnCli,lnVddCos,lnVddVta
	DO WHILE !EOF() AND Vendedor = lcVendedor
		R = R + 1
		IF R > 55
			TIT_UtiVddRes()
			R = R + 1
		ENDIF
		@R,015 SAY PADR(NomAux,40)
		@R,068 SAY TotCos PICTURE "@Z 9999,999.99"
		@R,080 SAY TotVta PICTURE "@Z 9999,999.99"
		@R,092 SAY ImpUti PICTURE "@Z 9999,999.99"
		@R,104 SAY PcjUti PICTURE "@Z 999.999"
		lnVddCos = lnVddCos + TotCos
		lnVddVta = lnVddVta + TotVta
		lnCli = lnCli + 1
		SKIP
	ENDDO
	lnImpUti = lnVddVta - lnVddCos
	lnPcjUti = IIF(lnVddCos > 0,ROUND((lnImpUti/lnVddCos)*100,3),0.000)
	IF lnCli > 1
	R = R + 1
	@R,020 SAY "TOTAL Vendedor"
	@R,068 SAY lnVddCos PICTURE "@Z 9999,999.99"
	@R,080 SAY lnVddVta PICTURE "@Z 9999,999.99"
	@R,092 SAY lnImpUti PICTURE "@Z 9999,999.99"
	@R,104 SAY lnPcjUti PICTURE "@Z 999.999"
	ENDIF
	R = R + 1
	lnTotCos = lnTotCos + lnVddCos
	lnTotVta = lnTotVta + lnVddVta
ENDDO
lnImpUti = lnTotVta - lnTotCos
lnPcjUti = IIF(lnTotCos > 0,ROUND((lnImpUti/lnTotCos)*100,3),0.000)
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,001 SAY "TOTAL GENERAL"
@R,068 SAY lnTotCos PICTURE "@Z 9999,999.99"
@R,080 SAY lnTotVta PICTURE "@Z 9999,999.99"
@R,092 SAY lnImpUti PICTURE "@Z 9999,999.99"
@R,104 SAY lnPcjUti PICTURE "@Z 999.999"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_UtiVddRes()
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
@05,015 SAY "CLIENTE"
@05,068 SAY PADL("COSTO",11)
@05,080 SAY PADL("VENTA",11)
@05,092 SAY PADL("UTILIDAD",11)
@05,104 SAY PADC("%",7)
@06,001 SAY REPLICATE("-",130)
R=7
RETURN