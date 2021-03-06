*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0   
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*UTILIDAD POR CLIENTE
*PRDUCTO                                            UND    CANTIDAD      COSTOxUND       COSTO     PRECIOxUND       VENTA    UTILIDAD    %       
*CLIENTE 1234567890123456789012345678901234567890 
*12345678901234567890123456789012345678901234567890 123 999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*12345678901234567890123456789012345678901234567890 123 999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*
*          TOTAL CLIENTE                                                           9999,999.99                9999,999.99 9999,999.99 999.999
*          TOTAL GENERAL                                                           9999,999.99                9999,999.99 9999,999.99 999.999

*PRDUCTO                                            UND    CANTIDAD       COSTO       VENTA    UTILIDAD    %       
*CLIENTE 1234567890123456789012345678901234567890 
*12345678901234567890123456789012345678901234567890 123 999,999.999 9999,999.99 9999,999.99 9999,999.99 999.999
*PRDUCTO                                            UND    CANTIDAD      COSTOxUND       COSTO     PRECIOxUND       VENTA    UTILIDAD    %       
*CLIENTE 1234567890123456789012345678901234567890 
*12345678901234567890123456789012345678901234567890 
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
**********************PRODUCTO                          999,999.999                9999,999.99                9999,999.99 9999,999.99 999.999

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "UtiCli"
lcProceso = "Rep_UtiCli()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_UtiCli
LOCAL lnTotCos,lnTotVta,lnCliCos,lnCliVta,lnArtCos,lnArtVta,lnCanArt,lnImpUti,lnPcjUti
LOCAL lcNomAux,lcCodArt,lnArt,lnDoc

@0,0 SAY CHR(18)+CHR(15)

TIT_UtiCli()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotCos,lnTotVta,lnImpUti,lnPcjUti
DO WHILE !EOF()
	lcNomAux = NomAux
	R = R + 1
	@R,001 SAY "Cliente  : "+PADR(NomAux,40)
	STORE 0 TO lnArt,lnCliCos,lnCliVta
	DO WHILE !EOF() AND NomAux = lcNomAux
		lcCodArt = CodArt
		R = R + 1
		@R,001 SAY PADR(Detalle,50)
		@R,052 SAY PADR(CodUnd,03)
		STORE 0 TO lnDoc,lnCanArt,lnArtCos,lnArtVta
		DO WHILE !EOF() AND NomAux = lcNomAux AND CodArt = lcCodArt
			R = R + 1
			IF R > 55
				TIT_UtiCli()
				R = R + 1
			ENDIF
			@R,020 SAY FecDoc
			@R,031 SAY TRANSFORM(NroDoc,"@R 999-9999999")
			@R,052 SAY CodUnd
			@R,056 SAY CanArt PICTURE "@Z 999,999.999"
			@R,068 SAY ImpCos PICTURE "@Z 9999,999.999999"
			@R,083 SAY TotCos PICTURE "@Z 9999,999.99"
			@R,095 SAY ImpVta PICTURE "@Z 9999,999.999999"
			@R,110 SAY TotVta PICTURE "@Z 9999,999.99"
			@R,122 SAY ImpUti PICTURE "@Z 9999,999.99"
			@R,134 SAY PcjUti PICTURE "@Z 999.999"
			lnCanArt = lnCanArt + CanArt
			lnArtCos = lnArtCos + TotCos
			lnArtVta = lnArtVta + TotVta
			lnDoc = lnDoc + 1
			SKIP
		ENDDO
		lnImpUti = lnArtVta - lnArtCos
		lnPcjUti = IIF(lnArtCos > 0,ROUND((lnImpUti/lnArtCos)*100,3),0.000)
		IF lnDoc > 1
		R = R + 1
		@R,056 SAY lnCanArt PICTURE "@Z 999,999.999"
		@R,083 SAY lnArtCos PICTURE "@Z 9999,999.99"
		@R,110 SAY lnArtVta PICTURE "@Z 9999,999.99"
		@R,122 SAY lnImpUti PICTURE "@Z 9999,999.99"
		@R,134 SAY lnPcjUti PICTURE "@Z 999.999"
		ENDIF
		R = R + 1
		lnCliCos = lnCliCos + lnArtCos
		lnCliVta = lnCliVta + lnArtVta
		lnArt = lnArt + 1
	ENDDO
	lnImpUti = lnCliVta - lnCliCos
	lnPcjUti = IIF(lnCliCos > 0,ROUND((lnImpUti/lnCliCos)*100,3),0.000)
	IF lnArt > 1
	R = R + 1
	@R,020 SAY "TOTAL Cliente"
	@R,083 SAY lnCliCos PICTURE "@Z 9999,999.99"
	@R,110 SAY lnCliVta PICTURE "@Z 9999,999.99"
	@R,122 SAY lnImpUti PICTURE "@Z 9999,999.99"
	@R,134 SAY lnPcjUti PICTURE "@Z 999.999"
	ENDIF
	R = R + 1
	lnTotCos = lnTotCos + lnCliCos
	lnTotVta = lnTotVta + lnCliVta
ENDDO
lnImpUti = lnTotVta - lnTotCos
lnPcjUti = IIF(lnTotCos > 0,ROUND((lnImpUti/lnTotCos)*100,3),0.000)
R = R + 1
@R,001 SAY REPLICATE("=",150)
R = R + 1
@R,001 SAY "TOTAL GENERAL"
@R,083 SAY lnTotCos PICTURE "@Z 9999,999.99"
@R,110 SAY lnTotVta PICTURE "@Z 9999,999.99"
@R,122 SAY lnImpUti PICTURE "@Z 9999,999.99"
@R,134 SAY lnPcjUti PICTURE "@Z 999.999"
R = R + 1
@R,001 SAY REPLICATE("=",150)
RETURN

PROCEDURE TIT_UtiCli()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,86)
@01,130 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,86)
@02,130 SAY TIME()
@03,042 SAY PADC(pTitMnd,86)
@03,130 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",142)
*@05,020 SAY "Fecha"
*@05,031 SAY "Documento"
@05,001 SAY "DESCRIPCION"
@05,052 SAY "UND"
@05,056 SAY PADL("CANTIDAD",11)
@05,068 SAY PADL("COSTO x UND",15)
@05,083 SAY PADL("COSTO",11)
@05,095 SAY PADL("PRECIO x UND",15)
@05,110 SAY PADL("VENTA",11)
@05,122 SAY PADL("UTILIDAD",11)
@05,134 SAY PADC("%",7)
@06,001 SAY REPLICATE("-",142)
R=7
RETURN