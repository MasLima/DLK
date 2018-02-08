*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0   
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*UTILIDAD POR CLIENTE
*PRDUCTO                                            UND    CANTIDAD         PRECIO       TOTAL
*CLIENTE  1234567890123456789012345678901234567890 
*12345678901234567890123456789012345678901234567890 123 999,999.999 999,999.999999 9999,999.99
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99
*          			  12/12/1234 XX 123-1234567890      999,999.999 999,999.999999 9999,999.99
*-                    TOTAL PRODUCTO                    999,999.999 999,999.999999 9999,999.99
*         TOTAL CLIENTE                                 999,999.999 999,999.999999 9999,999.99
*TOTAL GENERAL                                          999,999.999 999,999.999999 9999,999.99

*PRDUCTO                                                       UND    CANTIDAD         PRECIO       TOTAL
*1234567890 12345678901234567890123456789012345678901234567890 123 999,999.999 999,999.999999 9999,999.99
*          	12/12/1234 XX 123-1234567890                           999,999.999 999,999.999999 9999,999.99
*          	12/12/1234 XX 123-1234567890                           999,999.999 999,999.999999 9999,999.99
*           TOTAL PRODUCTO                                         999,999.999 999,999.999999 9999,999.99
*        TOTAL CLIENTE                                             999,999.999 999,999.999999 9999,999.99
*TOTAL GENERAL                                                     999,999.999 999,999.999999 9999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "VddCliArt"
lcProceso = "Rep_VddCliArt()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_VddCliArt
LOCAL lnTotVta,lnCliVta,lnArtVta,lnCanArt
LOCAL lcNomAux,lcCodArt,lnArt,lnDoc

@0,0 SAY CHR(18)+CHR(15)

TIT_VddCliArt()
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
		@R,001 SAY PADR(DesArt,50)
		@R,052 SAY PADR(CodUnd,03)
		STORE 0 TO lnDoc,lnCanArt,lnArtVta
		DO WHILE !EOF() AND NomAux = lcNomAux AND CodArt = lcCodArt
			R = R + 1
			IF R > 55
				TIT_VddCliArt()
				R = R + 1
			ENDIF
			@R,020 SAY FecDoc
			@R,031 SAY PADR(NroDoc,10)
			@R,052 SAY CodUnd
			@R,056 SAY CanArt PICTURE "@Z 999,999.999"
			@R,068 SAY ImpArt PICTURE "@Z 9999,999.999999"
			@R,083 SAY TotArt PICTURE "@Z 9999,999.99"
			lnCanArt = lnCanArt + CanArt
			lnArtVta = lnArtVta + TotArt
			lnDoc = lnDoc + 1
			SKIP
		ENDDO
		IF lnDoc > 1
		R = R + 1
		@R,056 SAY lnCanArt PICTURE "@Z 999,999.999"
		@R,083 SAY lnArtVta PICTURE "@Z 9999,999.99"
		ENDIF
		R = R + 1
		lnCliVta = lnCliVta + lnArtVta
		lnArt = lnArt + 1
	ENDDO
	IF lnArt > 1
	R = R + 1
	@R,010 SAY "TOTAL CLIENTE"
	@R,083 SAY lnCliVta PICTURE "@Z 9999,999.99"
	ENDIF
	R = R + 1
	lnTotVta = lnTotVta + lnCliVta
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",132)
R = R + 1
@R,001 SAY "TOTAL GENERAL"
@R,083 SAY lnTotVta PICTURE "@Z 9999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",132)
RETURN

PROCEDURE TIT_VddCliArt()
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
@04,001 SAY REPLICATE("-",132)
*@05,020 SAY "Fecha"
*@05,031 SAY "Documento"
@05,001 SAY "DESCRIPCION"
@05,052 SAY "UND"
@05,056 SAY PADL("CANTIDAD",11)
@05,068 SAY PADL("PRECIO x UND",15)
@05,083 SAY PADL("VENTA",11)
@06,001 SAY REPLICATE("-",132)
R=7
RETURN