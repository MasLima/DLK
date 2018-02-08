*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*
*Pedido     : 1234567890  Fecha : 12-12-1234    Ord. Compra : 12345678912345  Cotizac : 123456790
*Se�or(es)  : 1234567890123456789012345678901234567890  RUC : 12345678901
*Direccion  : 12345678901234567890123456789012345678901234567890
*Entregar   : 12345678901234567890123456789012345678901234567890  Fecha : 12/12/1234
*Proyecto   : 1234567890123456789012345678901234567890
*Vendedor   : 123456789012345678901234567890 Cond. Venta : 123456789012345678901234567890 Moneda : 123

*Itm Codigo      Descripcion                                        UND       Cant    Inporte      Total
*1   1234567890  12345678901234567890123456789012345678901234567890 123 999,999.99 999,999.99 999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Pedido"
lcProceso = "Rep_Pedido()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Pedido
@0,0 SAY CHR(18)+CHR(15)
TIT_Pedido()
SELE TmpRep
GO TOP 
@R,001 SAY "Pedido     : "+PADR(NroDoc,10)
@R,026 SAY "Fecha : "
@R,034 SAY FecDoc
@R,048 SAY "Ord. Compra : "+PADR(OrdCom,15)
@R,078 SAY "Cotizac : "+PADR(NroDocRef,10)
R = R + 1
@R,001 SAY "Se�or(es)  : "+ALLTRIM(NomAux)+" "+"RUC : "+PADR(NroRuc,11)
R = R + 1
@R,001 SAY "Direccion  : "+PADR(Direccion,50)
R = R + 1
@R,001 SAY "Entregar   : "+PADR(LugEnt,50)
R = R + 1
@R,001 SAY "Vendedor   : "+PADR(Vendedor,30)
@R,045 SAY "Cond. Venta : "+PADR(Condicion,30)
@R,090 SAY "Moneda : "+Simbol
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,005 SAY "Codigo"
@R,017 SAY "Descripcion"
@R,068 SAY "UND"
@R,072 SAY PADL("Cantidad",10)
@R,083 SAY PADL("Importe",10)
@R,094 SAY PADL("Total",10)
R = R + 1
@R,001 SAY REPLICATE("-",130)
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_Pedido()
		R = R + 1
	ENDIF
	@R,005 SAY PADR(CodArt,10)
	@R,017 SAY PADR(DesArt,50)
	@R,068 SAY CodUnd
	@R,072 SAY CanArt PICTURE "@Z 999,999.99"
	@R,083 SAY ImpPre PICTURE "@Z 999,999.99"
	@R,094 SAY ImpTot PICTURE "@Z 999,999.99"
	SKIP
ENDDO
SELE TmpRep
GO TOP 
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,083 SAY PADL("Sub-Total",10)
@R,094 SAY ImpAfe PICTURE "999,999.99"
R = R + 1
@R,083 SAY PADL("IGV",10)
@R,094 SAY ImpIgv PICTURE "999,999.99"
R = R + 1
@R,083 SAY PADL("Total "+Simbol,10)
@R,094 SAY Total PICTURE "999,999.99"
R = R + 1
@R,001 SAY REPLICATE("-",130)
RETURN

PROCEDURE TIT_Pedido()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("PEDIDO",90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("=",130)
R=6
RETURN