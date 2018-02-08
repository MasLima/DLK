*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*1
*2						R E C I B O   D E    E G R E S O
*3
*4          No. : 1234567890   Fecha : 12/12/1234   Importe : 123 12,123,123.12   
*5 
*6   A Nombre de : 1234567890123456789012345678901234567890
*7     Recibi de : 1234567890123456789012345678901234567890
* la Cantidad de : 123456789012345678901234567890123456789012345678901234567890
*9	               123456789012345678901234567890123456789012345678901234567890
*Por Concepto de : 1234567890123456789012345678901234567890
*Detalle      								
*1234567890123456789012345678901234567890 12,1213,123.12
*13
*14
*15
*16
*17
*18       -----------------------                        ----------------------
*19           Recibi Conforme                                    Vo. Bo.

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Recibo"
lcProceso = "Rep_Recibo()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Recibo
@00,00 SAY CHR(27)+"@"
@00,00 SAY CHR(18)
@00,00 SAY CHR(27)+"M"
@00,00 SAY CHR(27)+"k"+"0"
*TIT_RECIBO()
SELE TmpRcb
@02,01 SAY PADC("R E C I B O   D E   "+IIF(TipOpe=="1","I N G R E S O","E G R E S O"),80)
@04,01 SAY PADL("No. :",17)
@04,18 SAY NroDoc
@04,31 SAY "Fecha :"
@04,39 SAY FecDoc
@04,52 SAY "Importe :"
@04,62 SAY Simbol
@04,66 SAY ImpOrg PICTURE "@B 99,999,999.99"
@06,01 SAY PADL("A Nombre de :",17)+" "+IIF(TipOpe=="1",TabPar.NomEmp,NomAux)
@07,01 SAY PADL("Recibi de :",17)+" "+IIF(TipOpe=="1",NomAux,TabPar.NomEmp)
@08,01 SAY PADL("La Cantidad de :",17)+" "+Letras
@10,01 SAY PADL("Por Concepto de :",17)+" "+DesCto
@11,01 SAY "Detalle"
R = 11
SCAN WHILE !EOF() 
	R = R + 1	
	@R,01 SAY Detalle
	@R,42 SAY ImpDet PICTURE "@Z 99,999,999.99"
ENDSCAN
GO TOP
@18,10 SAY REPLICATE("-",25)
@18,50 SAY REPLICATE("-",25)
@19,10 SAY PADC("Recibi Conforme",25)
@19,50 SAY PADC("Vo Bo",25)
RETURN

PROCEDURE TIT_RECIBO()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY TabPar.NomEmp
@01,070 SAY DATE()
@02,030 SAY PADC("R E C I B O   D E   E G R E S O S",80)
@02,070 SAY PADL(ALLTRIM(TTOC(DATETIME(),2)),10)
@04,001 SAY REPLICATE("-",80)
R=5
RETURN