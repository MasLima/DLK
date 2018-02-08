*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Zona      : 123  1234567890123456789012345678901234567890
*Fecha : 99/99/9999  Documento : 123-123456                   Total = 99,999,999.99
*Codigo 	Deatalle                                 Und       Cant.         Total
*1234567890 1234567890123456789012345678901234567890 xxx 999,999.999  99,999,999.99
PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "CpaPvdArt"
lcProceso = "Rep_CpaPvdArt()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_CpaPvdArt
LOCAL lcNomAux,lcNomPvd,lnPvd,lnTot,lnDoc,lnTotDoc,lnTotAux,lnTotGen

@0,0 SAY CHR(18)+CHR(15)

TIT_CpaPvdArt()
SELE TmpRep
GO TOP 
STORE 0 TO lnTot,lnTotGen
DO WHILE !EOF()
	lcNomAux = ALLTRIM(NomAux)
	R = R + 1
	@R,001 SAY lcNomAux
	R = R + 1
	STORE 0 TO lnPvd,lnTotAux
	DO WHILE !EOF() AND NomAux = lcNomAux
		lcNroDoc = NroDoc
		R = R + 1
		@R,001 SAY "Fecha : "+DTOC(FecDoc)+"  Documento : "+TRANSFORM(NroDoc,"@R 999-9999999")
		@R,062 SAY "Total : "
		@R,070 SAY ImpSol PICTURE "@Z 99,999,999.99"
		STORE 0 TO lnDoc,lnTotDoc
		DO WHILE !EOF() AND NomAux = lcNomAux AND NroDoc = lcNroDoc
			R = R + 1
			IF R > 70
				TIT_CpaPvdArt()
				R = R + 1
			ENDIF
			@R,001 SAY PADR(CodArt,10)
			@R,012 SAY PADR(Detalle,40)
			@R,052 SAY CodUnd 
			@R,057 SAY CanArt PICTURE "@Z 999,999.999"
			@R,070 SAY TotArt PICTURE "@Z 99,999,999.99"
			lnDoc = lnDoc + 1
			lnTotDoc = lnTotDoc + TotArt
			SKIP
		ENDDO
		lnPvd = lnPvd + 1
		@R,070 SAY lnTotDoc PICTURE "@Z 99,999,999.99"
		lnTotAux = lnTotAux + lnTotDoc
		R = R + 1
	ENDDO
	R = R + 1
	@R,012 SAY PADR("Total por "+lcNomAux,20)
	@R,070 SAY lnTotAux PICTURE "@Z 99,999,999.99"
	R = R + 1
	lnTot = lnTot + lnPvd
	lnTotGen = lnTotGen + lnTotAux
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,012 SAY PADR("Total General",20)
@R,070 SAY lnTotAux PICTURE "@Z 99,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_CpaPvdArt()
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
@05,001 SAY "Cod."
@05,012 SAY "Descripcion"
@05,052 SAY "UND"
@05,057 SAY PADL("Cant.",11)
@05,070 SAY PADL("Importe",13)
@07,001 SAY REPLICATE("-",130)
R=7
RETURN