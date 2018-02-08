*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9   
*1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*Codigo  Proveedor                                RUC         Telefono   Direccion                                          Distrito
*12-1234 1234567890123456789012345678901234567890 12345678901 1234567890 12345678901234567890123456789012345678901234567890 1234567890
*PARAMETERS lcPeriodo

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "RegAux"
lcProceso = "REP_RegAux()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_RegAux
LOCAL lcTipAux
Tit_RegAux()
SELE TmpRep
GO TOP
DO WHILE !EOF() 
	lcTipAux = TipAux
	R = R + 1
	@R,001 SAY lcTipAux+"-"+IIF(SEEK(lcTipAux,"TipAux","TipAux"),TipAux.DesAux,SPACE(01))
	R = R + 1
	DO WHILE !EOF() AND TipAux = lcTipAux
		R = R + 1
		IF R > 55
			Tit_RegAux()
			R = R + 1
		ENDIF
		@R,001 SAY TipAux+"-"+CodAux
		@R,009 SAY PADR(NomAux,40)
		@R,050 SAY PADR(NroRuc,11)
		@R,062 SAY PADR(NroTlf,10)
		@R,073 SAY PADR(ALLTRIM(Direccion)+" "+IIF(SEEK(CodPostal,"TabDtt","CodPostal"),TabDtt.DesPos,SPACE(01)),60)
		SKIP
	ENDDO
	R = R + 1
ENDDO	
*R = R + 1
*@R,001 SAY REPLICATE("-",132)
*R = R + 1
*@R,042 SAY "TOTAL REGISTRO "
*@R,073 SAY lnTotReg PICTURE "99999,999.99"
*@R,001 SAY REPLICATE("-",132)
RETURN

PROCEDURE TIT_RegAux()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,120 SAY DATE()
@02,042 SAY PADC("R E G I S T R O   DE   "+ALLTRIM(UPPER(TipAux.DesAux)),76)
@02,120 SAY PADR(ALLTRIM(TTOC(DATETIME(),2)),10)
@03,120 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",130)
@05,001 SAY "Codigo"
@05,009 SAY "Razon Social / Nombre"
@05,050 SAY "RUC"
@05,062 SAY "Telefono"
@05,073 SAY "Direccion"
@06,001 SAY REPLICATE("-",130)
R=6
RETURN