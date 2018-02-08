*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*
*Pedido     : 1234567890  Fecha : 12-12-1234    Ord. Compra : 12345678912345  Cotizac : 123456790
*Se�or(es)  : 1234567890123456789012345678901234567890  
*Atender A  : 1234567890123456789012345678901234567890  RUC : 12345678901
*Proyecto   : 1234567890123456789012345678901234567890
*
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Itm Codigo      Descripcion                                        UND     Pedido    Atendido       Saldo
*1   1234567890  12345678901234567890123456789012345678901234567890 123 999,999.99  999,999.99  999,999.99
*
*Factura    : 1234567890      Fecha : 12/12/1234
*Ord Compra : 123456789012345 
*
*
*
*RELACION DE DESPACHOS
*Fecha      Guia       Itm Codigo     Descripcion                                        UND   Cantidad
*12/12/1234 1234567890 123 1234567890 12345678901234567890123456789012345678901234567890 123 999,999.99

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Despacho"
lcProceso = "Rep_Despacho()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Despacho
@0,0 SAY CHR(18)+CHR(15)
TIT_Despacho()
SELE PedCab
R = R + 1
@R,001 SAY "Se�ores    : "+ALLTRIM(LugEnt)
R = R + 1
@R,001 SAY "Atender  A : "+ALLTRIM(NomAux)+" "+"RUC : "+PADR(NroRuc,11)
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,005 SAY "Codigo"
@R,017 SAY "Descripcion"
@R,068 SAY "UND"
@R,072 SAY PADL("Pedido",10)
@R,084 SAY PADL("Atendido",10)
@R,096 SAY PADL("Saldo",10)
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
*- Atencion
SELE TmpAtn
GO TOP
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_Despacho()
		R = R + 1
	ENDIF
	@R,005 SAY PADR(CodArt,10)
	@R,017 SAY PADR(DesArt,50)
	@R,068 SAY CodUnd
	@R,072 SAY CanArt PICTURE "@Z 999,999.99"
	@R,084 SAY Atendido PICTURE "@Z 999,999.99"
	@R,096 SAY Saldo PICTURE "@Z 999,999.99"
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 2
*- Obtengo Factura
*IF SEEK(PedCab.TipDoc+STR(PedCab.NroSec,10),"DocCab","NroRef")
*	@R,001 SAY "Factura     : "+TRANSFORM(DocCab.NroDoc,"@R 999-9999999")
*	@R,030 SAY "Fecha : "+DTOC(DocCab.FecDoc)
*	R = R + 1		
*ENDIF
@R,001 SAY "Ord. Compra : "+PADR(PedCab.NroOrdCom,15)
R = R + 4

*- Despachos
R = R + 1
@R,001 SAY "RELACION DE DESPACHOS"
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
@R,001 SAY "Fecha"
@R,012 SAY "Guia"
@R,027 SAY "Codigo"
@R,038 SAY "Descripcion"
@R,089 SAY "UND"
@R,093 SAY PADL("Cantidad",10)
R = R + 1
@R,001 SAY REPLICATE("-",130)
R = R + 1
SELE TmpDes
GO TOP
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_Despacho()
		R = R + 1
	ENDIF
	@R,001 SAY TTOD(FecDoc)
	@R,012 SAY PADR(NroDoc,10) PICTURE "@R 999-9999999"
	@R,027 SAY PADR(CodArt,10)
	@R,038 SAY PADR(DesArt,50)
	@R,089 SAY CodUnd
	@R,093 SAY CanArt PICTURE "@Z 999,999.99"
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",130)
RETURN

PROCEDURE TIT_Despacho()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("ORDEN DE DESPACHO",90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY "PEDIDO No  : "+PADR(PedCab.NroDoc,10)
@04,026 SAY "Fecha : "
@04,034 SAY PedCab.FecDoc
R=5
RETURN