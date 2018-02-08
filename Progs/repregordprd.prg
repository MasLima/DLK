*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0   
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*REGISTRO DE GUIAS
*ORDEN      FECHA      FECHA      DESCRIPCION                                        UND CANTIDAD    ALMACEN    ALMACEN       ALMACEN     PEDIDO     PEDIDO
*PRODUCCION            ENTREGA                                                                       FECHA      DOCUMENTO     CANTIDAD    DOCUMENTO  FECHA
*1234567890 12/12/1234 12/12/1234 12345678901234567890123456789012345678901234567890 123 999,999.999 12/12/1234 12-1234567890 999,999.999 1234567890 12/12/1234
*1234567890 12/12/1234 12/12/1234 12345678901234567890123456789012345678901234567890 123 999,999.999 12/12/1234 12-1234567890 999,999.999 1234567890 12/12/1234


PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "RegOrdPrd"
lcProceso = "Rep_RegOrdPrd()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_RegOrdPrd
LOCAL lnDoc
*-
@0,0 SAY CHR(18)+CHR(15)
*-
TIT_RegOrdPrd()
*-
STORE 0 TO lnDoc
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_RegOrdPrd()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(NroDoc,10)
	@R,012 SAY FecDoc
	@R,023 SAY FecEnt
	@R,034 SAY PADR(Detalle,50)
	@R,085 SAY PADR(CodUnd,03)
	@R,089 SAY CanArt PICTURE "999,999.999"
	@R,101 SAY FecGuiAlm
	@R,112 SAY TipDocAlm+"-"+PADR(NroGuiAlm,10)
	@R,126 SAY CanArtAlm PICTURE "999,999.999"
	@R,138 SAY NroPed
	@R,149 SAY FecPed
	lnDoc = lnDoc + 1
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",160)
R = R + 1
@R,001 SAY "TOTAL DOCUMENTOS : "
@R,020 SAY lnDoc PICTURE "@Z 999,999"
R = R + 1
@R,001 SAY REPLICATE("-",160)
RETURN

PROCEDURE TIT_RegOrdPrd()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,104)
@01,150 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,104)
@02,150 SAY TIME()
@03,042 SAY PADC(pTitMnd,104)
@03,150 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",160)
@05,001 SAY "ORDEN"
@05,012 SAY "FECHA"
@05,023 SAY "FECHA"
@05,034 SAY "DESCRIPCION"
@05,085 SAY "UND"
@05,089 SAY "CANTIDAD"
@05,101 SAY "ALMACEN"
@05,112 SAY "ALMACEN"
@05,126 SAY "ALMACEN"
@05,138 SAY "PEDIDO"
@05,149 SAY "PEDIDO"
@06,001 SAY "PRODUCCION"
@06,023 SAY "ENTREGA"
@06,101 SAY "FECHA"
@06,112 SAY "GUIA"
@06,126 SAY "CANTIDAD"
@06,149 SAY "FECHA"
@07,001 SAY REPLICATE("-",160)
R=8
RETURN