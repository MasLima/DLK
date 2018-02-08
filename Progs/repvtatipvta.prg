*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*
*Tipo Venta : 1234567890123456789012345678901234567890
*Cliente : 1234567890123456789012345678901234567890
*Fecha      Documento      Detalle                                         Importe         Importe  Sit   
*                                                                              S/.             US$
*12/12/1234 123-1234567890 1234567890123456789012345678901234567890 999,999,999.99  999,999,999.99  1234  
PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "VtaTipVta"
lcProceso = "Rep_VtaTipVta()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_VtaTipVta
LOCAL lnTotImpSol,lnTotImpDol,lnCliImpSol,lnCliImpDol
LOCAL lcNomAux

@0,0 SAY CHR(18)+CHR(15)

TIT_VtaTipVta()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpSol,lnTotImpDol

IF lnTipRep == 1
DO WHILE !EOF()
	lcDesVta = DesVta
	R = R + 1
	@R,001 SAY "Tipo : "+PADR(lcDesVta,40)
	R = R + 1
	STORE 0 TO lnVtaImpSol,lnVtaImpDol
	Do WHILE !EOF() AND DesVta = lcDesVta
		R = R + 1
		IF R > 55
			TIT_VtaTipVta()
			R = R + 1
		ENDIF
		@R,027 SAY PADR(NomAux,40)
		@R,068 SAY ImpDol PICTURE "@Z 999,999,999.99"
		@R,084 SAY ImpSol PICTURE "@Z 999,999,999.99"
		lnVtaImpSol = lnVtaImpSol + ImpSol
		lnVtaImpDol = lnVtaImpDol + ImpDol
		SKIP
	ENDDO
	R = R + 1
	@R,027 SAY PADL("Total "+ALLTRIM(lcDesVta),40)
	@R,068 SAY lnVtaImpDol PICTURE "@Z 999,999,999.99"
	@R,084 SAY lnVtaImpSol PICTURE "@Z 999,999,999.99"
	R = R + 1
	lnTotImpSol = lnTotImpSol + lnVtaImpSol
	lnTotImpDol = lnTotImpDol + lnVtaImpDol
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,027 SAY PADL("TOTAL GENERAL",40)
@R,068 SAY lnTotImpDol PICTURE "@Z 999,999,999.99"
@R,084 SAY lnTotImpSol PICTURE "@Z 999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
ELSE
DO WHILE !EOF()
	lcDesVta = DesVta
	R = R + 1
	@R,001 SAY "Tipo : "+PADR(lcDesVta,40)
	R = R + 1
	STORE 0 TO lnVtaImpSol,lnVtaImpDol
	Do WHILE !EOF() AND DesVta = lcDesVta
		lcNomAux = NomAux
		R = R + 1
		@R,001 SAY "Cliente  : "+PADR(lcNomAux,40)
		R = R + 1
		STORE 0 TO lnCliImpSol,lnCliImpDol
		DO WHILE !EOF() AND DesVta = lcDesVta AND NomAux = lcNomAux
			R = R + 1
			IF R > 55
				TIT_VtaTipVta()
				R = R + 1
			ENDIF
			@R,001 SAY FecDoc
			@R,013 SAY TRANSFORM(NroDoc,"@R 999-9999999")
			@R,027 SAY PADR(Detalle,40)
			@R,068 SAY ImpDol PICTURE "@Z 999,999,999.99"
			@R,084 SAY ImpSol PICTURE "@Z 999,999,999.99"
			@R,100 SAY PADR(DesSit,4)
			lnCliImpSol = lnCliImpSol + ImpSol
			lnCliImpDol = lnCliImpDol + ImpDol
			SKIP
		ENDDO
		R = R + 1
		@R,027 SAY PADL("Total "+ALLTRIM(lcNomAux),40)
		@R,068 SAY lnCliImpDol PICTURE "@Z 999,999,999.99"
		@R,084 SAY lnCliImpSol PICTURE "@Z 999,999,999.99"
		R = R + 1
		lnVtaImpSol = lnVtaImpSol + lnCliImpSol
		lnVtaImpDol = lnVtaImpDol + lnCliImpDol
	ENDDO
	R = R + 1
	@R,027 SAY PADL("Total "+ALLTRIM(lcDesVta),40)
	@R,068 SAY lnVtaImpDol PICTURE "@Z 999,999,999.99"
	@R,084 SAY lnVtaImpSol PICTURE "@Z 999,999,999.99"
	R = R + 1
	lnTotImpSol = lnTotImpSol + lnVtaImpSol
	lnTotImpDol = lnTotImpDol + lnVtaImpDol
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,027 SAY PADL("TOTAL GENERAL",40)
@R,068 SAY lnTotImpDol PICTURE "@Z 999,999,999.99"
@R,084 SAY lnTotImpSol PICTURE "@Z 999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
ENDIF
RETURN

PROCEDURE TIT_VtaTipVta()
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
@04,001 SAY REPLICATE("-",130)
IF lnTipRep <> 1
@05,001 SAY "Fecha"
@05,013 SAY "Documento"
@05,027 SAY "Detalle"
ELSE
@05,027 SAY "Cliente"
ENDIF
@05,068 SAY PADL("Importe",14)
@05,084 SAY PADL("Importe",14)
IF lnTipRep <> 1
@05,100 SAY "Sit"
ENDIF
@06,068 SAY PADL("US$",14)
@06,084 SAY PADL("S/.",14)
@07,001 SAY REPLICATE("-",130)
R=8
RETURN