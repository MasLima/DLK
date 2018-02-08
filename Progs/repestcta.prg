*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*Fecha      Documento     Mnd        Importe Referencia                   Debe           Haber  Detalle
*12/12/1234 12 1234567890 123 999,999,999.99 12 123456789012345 999,999,999.99  999,999,999.99  1234567890123456789012345678901234567890 

PARAMETERS lnTipRep
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "EstCta"
lcProceso = "Rep_EstCta()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_EstCta
LOCAL lnTotImpDeb,lnTotImpHab
LOCAL lcNomAux

@0,0 SAY CHR(18)+CHR(15)

TIT_EstCta()
SELE TmpRep
GO TOP 
STORE 0 TO lnTotImpDeb,lnTotImpHab
DO WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_EstCta()
		R = R + 1
	ENDIF
	@R,001 SAY FecDoc
	@R,012 SAY TipDoc+"-"+PADR(NroDoc,10)
	@R,026 SAY Simbol
	@R,030 SAY ImpTot PICTURE "@Z 999,999,999.99"
	@R,045 SAY TipRef+"-"+PADR(NroRef,15)
	@R,064 SAY ImpDeb PICTURE "@Z 999,999,999.99"
	@R,080 SAY ImpHab PICTURE "@Z 999,999,999.99"
	@R,096 SAY PADR(Detalle,40)
	lnTotImpDeb = lnTotImpDeb + ImpDeb
	lnTotImpHab = lnTotImpHab + ImpHab
	SKIP
ENDDO
R = R + 1
@R,001 SAY REPLICATE("=",130)
R = R + 1
@R,001 SAY PADL("TOTAL ",26)
@R,064 SAY lnTotImpDeb PICTURE "@Z 999,999,999.99"
@R,080 SAY lnTotImpHab PICTURE "@Z 999,999,999.99"
R = R + 1
@R,001 SAY PADL("SALDO ",26)
@R,064 SAY IIF(lnTotImpDeb >= lnTotImpHab,(lnTotImpDeb - lnTotImpHab),0.00) PICTURE "@Z 999,999,999.99"
@R,080 SAY IIF(lnTotImpHab > lnTotImpDeb,(lnTotImpHab - lnTotImpDeb),0.00) PICTURE "@Z 999,999,999.99"
R = R + 1
@R,001 SAY REPLICATE("=",130)
RETURN

PROCEDURE TIT_EstCta()
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
@05,001 SAY "Fecha"
@05,012 SAY "Documento"
@05,026 SAY "Mnd"
@05,030 SAY PADL("Importe",14)
@05,045 SAY "Referencia"
@05,064 SAY PADL("Importe",14)
@05,080 SAY PADL("Importe",14)
@06,064 SAY PADL("DEBE",14)
@06,080 SAY PADL("HABER",14)
@06,096 SAY "Detalle"
@07,001 SAY REPLICATE("-",130)
R=7
RETURN