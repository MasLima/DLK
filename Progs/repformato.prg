*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*

*PARAMETERS lcTipDoc
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Formato"
lcProceso = "Rep_Factura()"
lnPag = 0
R = 0
*Imprimetexto(lcFile,lcProceso)
ImprimetextoDir(lcFile,lcProceso)
*ImprimeDir(lcFile,lcProceso)
RETURN

PROCEDURE REP_Factura
LOCAL lnFila,lnCol,lcDato
*@00,00 SAY CHR(27)+"@"
*@00,00 SAY CHR(18)
*@00,00 SAY CHR(27)+"M"
SELE TmpRep
GO TOP
lcTipDoc = TmpRep.TipDoc
*- Cabecera
IF !SEEK(lcTipDoc+"1","Formato","Tipo")
	MESSAGEBOX("No se Tiene Formato de Cabecera",0+64,"Validacion")
	RETURN 
ENDIF
SELE Formato
DO WHILE !EOF() AND TipDoc = lcTipDoc AND Tipo = "1"
	lnFila = Fila
	lnCol  = Columna
	lcDato = Dato
	SELE TmpRep
	@lnFila,lnCol SAY &lcDato
	SELE Formato
	SKIP
ENDDO
*- Detalle
IF SEEK(lcTipDoc+"2","Formato","Tipo")
SELE Formato
lnFila = Fila
SELE TmpRep
GO TOP
DO WHILE !EOF()
	SELE Formato
	IF SEEK(lcTipDoc+"2","Formato","Tipo")
		DO WHILE !EOF() AND TipDoc = lcTipDoc AND Tipo = "2"
			lnCol  = Columna
			lcDato = Dato
			SELE TmpRep
			@lnFila,lnCol SAY &lcDato
			SELE Formato
			SKIP
		ENDDO
	ENDIF
	SELE TmpRep
	SKIP
	lnFila = lnFila + 1
ENDDO
ENDIF

*- Totales
SELE TmpRep
GO TOP
IF !SEEK(lcTipDoc+"3","Formato","Tipo")
	*MESSAGEBOX("No se Tiene Formato de Totales",0+64,"Validacion")
	RETURN 
ENDIF
SELE Formato
DO WHILE !EOF() AND TipDoc = lcTipDoc AND Tipo = "3"
	lnFila = Fila
	lnCol  = Columna
	lcDato = Dato
	SELE TmpRep
	@lnFila,lnCol SAY &lcDato
	SELE Formato
	SKIP
ENDDO
*-
*@00,00 SAY ""
*eject
*-
RETURN