*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0   
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

*UTILIDAD DEL PEDIDO
*CLIENTE 1234567890123456789012345678901234567890 
*FECHA      PEDIDO     ORD COMPRA ENTREGA    VENDEDOR                       ORD CLIENTE          
*12/12/1234 1234567890 1234567890 12/12/1234 123456789012345678901234567890 12345678901234567890 
*			PRDUCTO                                            UND      PEDIDO    ATENDIDO      COSTOxUND       COSTO     PRECIOxUND       VENTA    UTILIDAD    %       
*			12345678901234567890123456789012345678901234567890 123 999,999.999 999,999.999                9999,999.99                9999,999.99 9999,999.99 999.999
*                   			  12/12/1234 GR 123-1234567890                 999,999.999 999,999.999999 9999,999.99  
*                                 12/12/1234 FT 123-1234567890     999,999.999                                        999,999.999999 9999,999.99
*                                                                                                         9999,999.99                9999,999.99 9999,999.99 999.999                     

*			12345678901234567890123456789012345678901234567890 123 999,999.999 999,999.999 999,999.999999 999,999.99 999,999.999999 9999,999.99 9999,999.99 999.999
*                   			  12/12/1234 XX 123-1234567890                 999,999.999 999,999.999999 999,999.99  
*                   			  12/12/1234 XX 123-1234567890                 999,999.999
*                                 12/12/1234 XX 123-1234567890                                                       999,999.999999 9999,999.99 9999,999.99 999.999                     
*
*          TOTAL PEDIDO                                                                                   999,999.99                9999,999.99 9999,999.99 999.999
*          TOTAL CLIENTE                                                                                  999,999.99                9999,999.99 9999,999.99 999.999
*          TOTAL GENERAL                                                                                  999,999.99                9999,999.99 9999,999.99 999.999


PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "PedDes"
lcProceso = "Rep_PedDes()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_PedDes
LOCAL lcNomAux,lcNroPed,lcCodArt

@0,0 SAY CHR(18)+CHR(15)

TIT_PedDes()
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	lcNomAux = NomAux
	R = R + 1
	@R,01 SAY "Cliente : "+NomAux
	DO WHILE !EOF() AND NomAux = lcNomAux
		lcNroPed = NroPed
		R = R + 1
		@R,01 SAY FecPed
		@R,12 SAY PADR(NroPed,10)
		@R,23 SAY PADR(OrdCom,10)
		@R,34 SAY FecEnt
		@R,45 SAY PADR(Vendedor,30)
		R = R + 1
		@R,12 SAY "PRODUCTO"
		*@R,063 SAY "UND"
		@R,067 SAY PADL("PEDIDO",11)
		@R,079 SAY PADL("ATENDIDO",11)
		@R,091 SAY PADL("SALDO",11)
		DO WHILE !EOF() AND NomAux = lcNomAux AND NroPed = lcNroPed
			lcCodArt = CodArt
			R = R + 1
			@R,12 SAY PADR(DesArt,50)
			@R,63 SAY CodUnd
			@R,67 SAY CanArt PICTURE "999,999.999"
			@R,79 SAY Atendido PICTURE "999,999.999"
			@R,91 SAY Saldo PICTURE "999,999.999"
			DO WHILE !EOF() AND NomAux = lcNomAux AND NroPed = lcNroPed AND CodArt = lcCodArt
				R = R + 1
				IF R > 55
					TIT_PedDes()
					R = R + 1
				ENDIF
				@R,034 SAY FecDoc
				@R,045 SAY TipDoc
				@R,048 SAY TRANSFORM(NroDoc,"@R 999-9999999")
				@R,079 SAY CanAte PICTURE "@Z 999,999.999"
				SKIP
			ENDDO
			R = R + 1
		ENDDO
		R = R + 1
	ENDDO
ENDDO
RETURN

PROCEDURE TIT_PedDes()
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
@05,001 SAY "FECHA"
@05,012 SAY "PEDIDO"
@05,023 SAY "ORD COMPRA"
@05,034 SAY "ENTREGA"
@05,045 SAY "VENDEDOR"
@06,001 SAY REPLICATE("-",130)
R=7
RETURN