*         1         2         3         4         5         6         7         8         9         0         1         2         3
*123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*    Periodo : 1234-12  Comprobante : 12-123456                Cambio : 1234.123                        
*      Banco : 123456789012345678901234567890                   Fecha : 12/12/1234        Diferido : 12/12/1234
* Cta en Bco : 12345678901234567890                         Documento : 12-1234567890 
*Beneficiario: 1234567890123456789012345678901234567890       Importe : 123 99,999,999.99
*Auxiliar                  Documento          Importe        Concepto                       Operacion
*1234567890123456789012345 12-123456789012345 99,999,999.99+ 123456789012345678901234567890 123456789012345678901234567890  

*------------------------------------------------------------------------------------------------------------------------------------    
*Recibi Conforme                                                                         Aprobado   
* 12345678901234567890123456789012345  1234567890  12/12/1234
*------------------------------------------------------------------------------------------------------------------------------------
*    Nombre y Apellidos                    DNI        Fecha               Firma                              Firma







    
*PARAMETERS lcPeriodo
PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "Voucher"
lcProceso = "Rep_Voucher()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_Voucher
@00,00 SAY CHR(15)
lnTotal = 0
TIT_Voucher()
SELE TmpRep
GO TOP
@R,01 SAY PADL("Periodo :",13)
@R,15 SAY Periodo PICTURE "@R 9999-99"
@R,24 SAY "Comprobante :"
@R,38 SAY Comprobante
@R,60 SAY PADL("Cambio :",11)
@R,72 SAY ImpCam PICTURE "@B 9999.999"
R = R + 1
@R,01 SAY PADL("Banco :",13)
@R,15 SAY DesBco
@R,60 SAY PADL("Fecha :",11)
@R,72 SAY FecDoc
@R,90 SAY "Diferido :"
@R,101 SAY FecVen

R = R + 1
@R,01 SAY PADL("Cta en Bco :",13)
@R,15 SAY NroCtaCte
@R,60 SAY PADL("Documento :",11)
@R,72 SAY Documento
R = R + 1
@R,01 SAY PADL(IIF(TipOpe == "1","Recibi de :","Beneficiario:"),13)
@R,15 SAY PADR(NomAux,35)
@R,60 SAY PADL("Importe :",11)
@R,72 SAY Simbol
@R,PCOL() SAY TotImpOrg PICTURE "@B 99,999,999.99"
R = R + 1
@R,01 SAY REPLICATE("-",132)
R = R + 1
@R,01 Say "Auxiliar"
@R,27 Say "Documento"
@R,46 Say "Importe"
@R,61 Say "Concepto"
R = R + 1
@R,01 SAY REPLICATE("-",132)
R = R + 1
SCAN WHILE !EOF()
	R = R + 1
	IF R > 55
		TIT_Voucher()
		R = R + 1
	ENDIF 
	@R,01 Say PADR(NomAuxDet,25)
	@R,27 Say TipDoc+"-"+PADR(NroDoc,15)
	@R,46 Say ImpOrg PICTURE "99,999,999.99"
	@R,59 Say IndSig
	@R,61 Say PADR(DesCto,40)
	lnTotal = lnTotal + IIF(IndSig=="+",ImpOrg,-1*ImpOrg)
	IF !EMPTY(Glosa)
		R = R + 1
		@R,61 Say PADR(Glosa,40)
	ENDIF
ENDSCAN
R = R + 1
@R,27 Say PADL("Total",18)
@R,46 Say lnTotal PICTURE "99,999,999.99"
R = R + 2
@R,01 SAY "------------------------------------------------------------------------------------------------------------------------------------"
R = R + 1
@R,01 SAY "RECIBI CONFORME                                                                         APROBADO"
R = R + 2
@R,01 SAY "------------------------------------------------------------------------------------------------------------------------------------"
R = R + 1
@R,01 SAY "    Nombre y Apellidos                    DNI          Fecha             Firma                              Firma"
GO TOP
RETURN

PROCEDURE TIT_Voucher()
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
R=5
RETURN