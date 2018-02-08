*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*    
*DISAN S.R.L.                                                      CODIGO  : OCI-DISA-02              
*Av. Universitaria Nº 630 - Lima                                   VERSION : 1
*Telf. 452-2300 / 561-2557                                         FECHA   : 09.04.02
*
*
*               ORDEN DE COMPRA Nº 9999-99
*
*
*Fecha          : 12-12-1234        
*Cliente        : 1234567890123456789012345678901234567890
*RUC            : 12345678901
*Direccion      : 12345678901234567890123456789012345678901234567890
*Lugar/Entrega  : 12345678901234567890123456789012345678901234567890   
*Condicion/Pago : 123456789012345678901234567890                    Moneda : 123
*Vendedor       : 123456789012345678901234567890             Fecha/Entrega : 12-12-1234
*
*-----------------------------------------------------------------------------------------------
*Item    Cantidad UND Descripcion                                               Precio      Total
*-----------------------------------------------------------------------------------------------
* 1   999,999.999 123 12345678901234567890123456789012345678901234567890 99,999.999999 9999,999.99
*-----------------------------------------------------------------------------------------------
*                                                                        SUB-TOTAL     9999,999.99               
*                                                                        I.G.V.        9999,999.99               
*                                                                        TOTAL         9999,999.99
*
* Observaciones : 12345678901234567890123456789012345678901234567890
*                 12345678901234567890123456789012345678901234567890  
*                 12345678901234567890123456789012345678901234567890
*
*
*
*          --------------------                          ---------------------
*                 Vº Bº                                      DPTO. VENTAS
*
*
*

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "OrdComVdd"
lcProceso = "Rep_OrdVdd()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_OrdVdd
LOCAL lnFil,lnCol
*@0,0 SAY CHR(18)+CHR(15)

lnFil = 02
lnCol = 04

*TIT_OrdVdd()

SELE TmpRep
GO TOP 
@0,0 SAY CHR(18)+CHR(18)
@lnFil+01,lnCol SAY "DISAN S.R.L.                                          CODIGO  : OCI-DISA-02"
@lnFil+02,lnCol SAY "Av. Universitaria 630 - Lima                          VERSION : 1"
@lnFil+03,lnCol SAY "Telf. 452-2300 / 561-2557                             FECHA   : 09.04.02"
@lnFil+04,lnCol SAY ""
@lnFil+05,lnCol SAY ""
@lnFil+06,lnCol SAY ""
@lnFil+07,lnCol SAY "                 ORDEN DE COMPRA "+NroDoc
@lnFil+08,lnCol SAY ""
@lnFil+09,lnCol SAY ""
@lnFil+10,lnCol SAY "Fecha          : "+DTOC(FecDoc)
@lnFil+11,lnCol SAY "Cliente        : "+NomAux
@lnFil+12,lnCol SAY "RUC            : "+NroRuc
@lnFil+13,lnCol SAY "Direccion      : "+Direccion
@lnFil+14,lnCol SAY "Lugar/Entrega  : "+LugEnt
@lnFil+15,lnCol SAY "Condicion/Pago : "+PADR(Condicion,35)+"Moneda : "+Simbol
@lnFil+16,lnCol SAY "Vendedor       : "+PADR(Vendedor,28)+"Fecha/Entrega : "+DTOC(FecEnt)
@lnFil+17,lnCol SAY CHR(18)+CHR(15)
@lnFil+18,lnCol+15 SAY "----------------------------------------------------------------------------------------------------"
@lnFil+19,lnCol+15+01 SAY "ITEM"
@lnFil+19,lnCol+15+06 SAY PADL("CANTIDAD",11)
@lnFil+19,lnCol+15+18 SAY "UND"
@lnFil+19,lnCol+15+22 SAY PADC("D E S C R I P C I O N",50)
@lnFil+19,lnCol+15+73 SAY PADL("PRECIO",13)
@lnFil+19,lnCol+15+87 SAY PADL("TOTAL",11)
@lnFil+20,lnCol+15 SAY "----------------------------------------------------------------------------------------------------"
lnFil = lnFil + 20
DO WHILE !EOF()
	lnFil = lnFil + 1
*	@lnFil,lnCol+15+01 SAY NroItm PICTURE "@Z 999"
	@lnFil,lnCol+15+06 SAY CanArt && PICTURE "@Z 999,999.999"
	@lnFil,lnCol+15+18 SAY CodUnd
	@lnFil,lnCol+15+22 SAY PADR(DesArt,50)
	@lnFil,lnCol+15+73 SAY ImpArt PICTURE "99,999.999999"
	@lnFil,lnCol+15+87 SAY ImpTot PICTURE "9999,999.99"
	
	SKIP
ENDDO
SELE TmpRep
GO TOP
lnFil = lnFil + 1
@lnFil,lnCol+15 SAY "----------------------------------------------------------------------------------------------------"
lnFil = lnFil + 1
@lnFil,lnCol+15+073 SAY "SUB-TOTAL"
@lnFil,lnCol+15+087 SAY ImpAfe PICTURE "9999,999.99"
lnFil = lnFil + 1
@lnFil,lnCol+15+073 SAY "I.G.V."
@lnFil,lnCol+15+087 SAY ImpIgv PICTURE "9999,999.99"
lnFil = lnFil + 1
@lnFil,lnCol+15+073 SAY "TOTAL "+Simbol
@lnFil,lnCol+15+087 SAY Total PICTURE "9999,999.99"
lnFil = lnFil + 1
@lnFil,lnCol SAY CHR(18)+CHR(15)
lnFil = lnFil + 1
@lnFil,lnCol SAY "Observaciones : "+Observa1
lnFil = lnFil + 1
@lnFil,lnCol+ 16 SAY Observa2
lnFil = lnFil + 1
@lnFil,lnCol+ 16 SAY Observa3
lnFil = 50
@lnFil+0,lnCol SAY CHR(18)+CHR(18)
@lnFil+4,lnCol SAY DATETIME()
RETURN

PROCEDURE TIT_OrdVdd()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("ORDEN DE COMPRA",90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("=",130)
R=6
RETURN