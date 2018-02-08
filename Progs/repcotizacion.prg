*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*                                                 Lima, 12 de Marzo del 2002
*                                              
*                             COTIZACION No : 1234567890
*
*           Señores
*           1234567890123456789012345678901234567890  RUC : 12345678901
*           12345678901234567890123456789012345678901234567890
*           Telef : 1234567890    FAX : 1234567890
*
*           Atencion : 123456789012345678901234567890
*           Vendedor : 123456789012345678901234567890
*
*           Estimados Señores :
*           Mediante la presente les estamos remitiendo la siguiente cotizacion
*           de nuestros productos segun su solicitud :
*
*
*           Articulo                                                      UND     Cant     Precio
*           -------------------------------------------------------------------------------------
*           123456789012345678901234567890123456789012345678901234567890  123 99999.99 999,999.99
*                                                                                      ----------
*                                                                            TOTAL US$ 999,999.99
*
*           Precios Expresados en 
*           Los precios No Incluyen IGV.
*           Condiciones de Pago  : CONTADO
*           Validez de la Oferta : DE ACUERDO A STOCK
*           Tiempo de Entrega    : INMEDIATO
*
*                                                                        Atentamente
*
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Cotiza"
lcProceso = "Rep_Cotiza()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Cotiza
@0,0 SAY CHR(18)
*TIT_Cotiza()
SELE TmpRep
GO TOP 
R = 6
@R,050 SAY "LIma, "+SUBS(DTOS(FecDoc),7,1)+" de "+IIF(SEEK(SUBS(DTOS(FecDoc),5,2),"Meses","CodMes"),ALLTRIM(Meses.NomMes),"")+" del "+SUBS(DTOS(FecDoc),1,4)
R = R + 2
@R,030 SAY "COTIZACION No : "+NroDoc
R = R + 2
@R,012 SAY "Señores"
R = R + 1
@R,012 SAY ALLTRIM(NomAux)+" "+"RUC : "+PADR(NroRuc,11)
R = R + 1
@R,012 SAY ALLTRIM(Direccion)
R = R + 1
@R,012 SAY "Telef : "+NroTlf+"    "+"Fax : "+NroFax
R = R + 2
@R,012 SAY "Atención : "+Atencion
R = R + 1
@R,012 SAY "Vendedor : "+Vendedor
R = R + 2
@R,012 SAY "Estimados Señores :"
R = R + 2
@R,012 SAY "Mediante la presente les estamos remitiendo la siguiente cotizacion"
R = R + 1
@R,012 SAY "de nuestros productos segun su solicitud :"
R = R + 2
@R,001 SAY CHR(18)+CHR(15)
@R,012 SAY "Articulo"
@R,074 SAY "UND"
@R,078 SAY PADL("Cant",8)
@R,087 SAY PADL("Precio",10)
R = R + 1
@R,012 SAY REPLICATE("-",085)
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		lnPag =lnPag + 1
		IF lnPag > 1
			@00,00 SAY ""
		ENDIF
		R = 6
		@R,012 SAY "Articulo"
		@R,074 SAY "UND"
		@R,078 SAY PADL("Cant",8)
		@R,087 SAY PADL("Precio",10)
		*TIT_Cotiza()
		R = R + 1
	ENDIF
	@R,012 SAY PADR(DesArt,60)
	@R,074 SAY PADR(CodUnd,03)
	@R,078 SAY CanArt PICTURE "@Z 99999.99"
	@R,087 SAY ImpPre PICTURE "@Z 999,999.99"
	SKIP
ENDDO
SELE TmpRep
GO TOP 
R = R + 1
@R,087 SAY "----------"
R = R + 1
@R,077 SAY "TOTAL"
@R,083 SAY Simbol
@R,087 SAY ImpAfe PICTURE "999,999.99"
R = R + 3
@R,001 SAY CHR(18)
@R,012 SAY "Precios Expresados en "+IIF(SEEK(TipMnd,"TipMnd","TipMnd"),TipMnd.DesMnd,Simbol)
R = R + 1
@R,012 SAY "Los Precios NO Incluyen el IGV."
R = R + 1
@R,012 SAY "Condiciones de Pago  : "+Condicion
R = R + 1
@R,012 SAY "Validez de la Oferta : "+ValOfe
R = R + 1
@R,012 SAY "Tiempo de Entrega    : "+Entrega
R = R + 3
@R,060 SAY "Atentamente"
RETURN

PROCEDURE TIT_Cotiza()
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