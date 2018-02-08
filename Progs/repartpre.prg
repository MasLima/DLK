*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Codigo      Descripcion                    				    UND          PRECIO     PRECIO       FECHA
*1234567890  12345678901234567890123456789012345678901234567890 123  123 123,456.12 123,456.12  12/12/1234
PARAMETERS lnIndPre
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "ArtPre"
lcProceso = "Rep_ArtPre()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_ArtPre
*-
@0,0 SAY CHR(18)+CHR(15)
*-
TIT_ArtPre()
SELE TmpRep
GO TOP 
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_ArtPre()
		R = R + 1
	ENDIF
	@R,001 SAY PADR(CodArt,10)
	@R,013 SAY PADR(DesArt,50)
	@R,064 SAY PADR(CodUnd,03)
	@R,069 SAY PADR(Simbol,03)
	@R,073 SAY IIF(lnIndPre == 1,PreUnd,PreUndCre) PICTURE "999,999.99"
	@R,084 SAY IIF(lnIndPre == 1,PreMay,PreMayCre) PICTURE "999,999.99"
	@R,096 SAY FecPre
	SKIP
ENDDO
RETURN

PROCEDURE TIT_ArtPre()
LOCAL lnColumna,lnOldSele
lnOldSele = SELECT()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,72)
@01,120 SAY DATE()
@02,042 SAY PADC(pTitulo,76)
@02,120 SAY PADR(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",130)
@05,001 SAY "Codigo"
@05,013 SAY "Descripcion"
@05,064 SAY "UND"
@05,073 SAY PADL("Precio",10)
@05,084 SAY PADL("Precio",10)
@05,096 SAY "Fecha"
@06,073 SAY PADL(IIF(lnIndPre == 1,"Publico","Contado"),10)
@06,084 SAY PADL(IIF(lnIndPre == 1,"xMayor","Credito"),10)
@07,001 SAY REPLICATE("-",130)
R=8
RETURN