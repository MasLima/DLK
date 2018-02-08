*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*
*Documento  : 12 123-1234567  Fecha : 12-12-1234
*Auxiliar   : 12-1234 1234567890123456789012345678901234567890 
*Referencia : 12 123-1234567 
*Codigo      Descripcion                                         UND        Cant        Precio        Total
*1234567890  12345678901234567890123456789012345678901234567890  123  999,999.99  999,999.9999  9999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "GuiAlm"
lcProceso = "Rep_GuiAlm()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_GuiAlm
@0,0 SAY CHR(18)+CHR(15)
TIT_GuiAlm()
SELE TmpRep
GO TOP 
@R,001 SAY "Documento  : "+TipDoc+" "+TRANSFORM(NroDoc,"@R 999-9999999")
@R,030 SAY "Fecha : "
@R,038 SAY FecDoc
R = R + 1
@R,001 SAY "Auxiliar   : "+ALLTRIM(NomAux)+"   "+IIF(!EMPTY(NroRuc),"RUC : "+NroRuc,"")
R = R + 1
@R,001 SAY "Referencia : "+TipDocRef+" "+NroDocRef
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,001 SAY "Codigo"
@R,013 SAY "Descripcion"
@R,065 SAY "UND"
@R,070 SAY PADL("Cantidad",10)
@R,082 SAY PADL("Precio",10)
@R,096 SAY PADL("Total",11)
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_GuiAlm()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(CodArt,10)
	@R,013 SAY PADR(Detalle,50)
	@R,065 SAY PADR(CodUnd,03)
	@R,070 SAY CanArt PICTURE "999,999.99"
	@R,082 SAY ImpPre PICTURE "999,999.9999"
	@R,096 SAY ImpTot PICTURE "9999,999.99"
	SKIP
ENDDO
SELE TmpRep
GO TOP 
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,096 SAY Total PICTURE "9999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",130)
RETURN

PROCEDURE TIT_GuiAlm()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("GUIA DE "+IIF(ArtMovCab.TipMov == "I","INGRESO","SALIDA"),90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("=",130)
R=6
RETURN