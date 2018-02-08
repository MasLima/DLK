*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*    
*DISAN S.R.L.                                                      CODIGO  : OP-DISA-03              
*Av. Universitaria Nº 630 - Lima                                   VERSION : 1
*Telf. 452-2300 / 561-2557                                         FECHA   : 09.04.02
*
*
*               ORDEN DE PRODUCCION Nº 9999-99
*
*
*FECHA            : 12-12-1234        
*ORDEN DE COMPRA  : 123456789012345                              LINEA : 123456789012345
*COLOR            : 12345678901234567890
*JEFE DE LINEA    : 1234567890123456789012345678901234567890
*SOLICITADO POR   : 1234567890123456789012345678901234567890
*FECHA DE ENTREGA : 12-12-1234                                   TURNO : 1234567890
*
*-----------------------------------------------------------------------------------------------
*Item    Cantidad UND Descripcion                                        OBSERAVCIONES
*-----------------------------------------------------------------------------------------------
* 1   999,999.999 123 12345678901234567890123456789012345678901234567890 
*-----------------------------------------------------------------------------------------------
*
* SEGUN MODELO  :
*
*
*
*
*
*
* OBSERVACIONES : 12345678901234567890123456789012345678901234567890*
*

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "OrdPrd"
lcProceso = "Rep_OrdPrd()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_OrdPrd
LOCAL lnFil,lnCol
*@0,0 SAY CHR(18)+CHR(15)

lnFil = 02
lnCol = 04

*TIT_OrdVdd()

SELE TmpRep
GO TOP 
@0,0 SAY CHR(18)+CHR(18)
@lnFil+01,lnCol SAY "DISAN S.R.L.                                    CODIGO  : OP-DISA-03"
@lnFil+02,lnCol SAY "Av. Universitaria 630 - Lima                    VERSION : 1"
@lnFil+03,lnCol SAY "Telf. 452-2300 / 561-2557                       FECHA   : 09.04.02"
@lnFil+04,lnCol SAY ""
@lnFil+05,lnCol SAY ""
@lnFil+06,lnCol SAY ""
@lnFil+07,lnCol SAY "                 ORDEN DE PRODUCCION "+NroDoc
@lnFil+08,lnCol SAY ""
@lnFil+09,lnCol SAY ""
@lnFil+10,lnCol SAY "FECHA            : "+DTOC(FecDoc)+PADR("",20)+"LINEA : "+Linea
@lnFil+11,lnCol SAY ""
@lnFil+12,lnCol SAY "ORDEN DE COMPRA  : "+OrdCom
@lnFil+13,lnCol SAY "COLOR            : "+Color
@lnFil+14,lnCol SAY "JEFE DE LINEA    : "+NomAuxJef
@lnFil+15,lnCol SAY "SOLICITADO POR   : "+NomAuxSol
@lnFil+16,lnCol SAY "FECHA DE ENTREGA : "+DTOC(FecEnt)+PADR("",20)+"TURNO : "+Turno
@lnFil+17,lnCol SAY ""
@lnFil+18,lnCol+01 SAY REPLICATE("-",74)
@lnFil+19,lnCol+01 SAY "ITEM"
@lnFil+19,lnCol+06 SAY PADL("CANTIDAD",11)
@lnFil+19,lnCol+18 SAY "UND"
@lnFil+19,lnCol+22 SAY PADC("D E S C R I P C I O N",50)
@lnFil+20,lnCol+01 SAY REPLICATE("-",74)
lnFil = lnFil + 20
DO WHILE !EOF()
	lnFil = lnFil + 1
*	@lnFil,lnCol+15+01 SAY NroItm PICTURE "@Z 999"
	@lnFil,lnCol+06 SAY CanArt && PICTURE "@Z 999,999.999"
	@lnFil,lnCol+18 SAY CodUnd
	@lnFil,lnCol+22 SAY PADR(Detalle,50)
	SKIP
ENDDO
SELE TmpRep
GO TOP
lnFil = lnFil + 1
@lnFil,lnCol+01 SAY REPLICATE("-",74)
lnFil = lnFil + 1
@lnFil,lnCol SAY "SEGUN MODELO : "
lnFil = 50
@lnFil,lnCol SAY "OBSERVACIONES: "
lnFil = lnFil + 1
@lnFil+4,lnCol SAY DATETIME()
RETURN

PROCEDURE TIT_OrdPrd()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,120 SAY DATE()
@02,030 SAY PADC("ORDEN DE PRODUCCION",90)
@02,120 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("=",74)
R=6
RETURN