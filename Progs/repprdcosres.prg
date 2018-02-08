*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0                             
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890                 
*Codigo     Descripcion                              UND Ord. Prod     Cantidad Prd   Cant Prod         M.P.         M.O.         G.F.        Total         Costo        Venta     Utilidad    %   
*1234567890 1234567890123456789012345678901234567890 123 1234567890 999,999.999 123 999,999.999 99999,999.99 99999,999.99 99999,999.99 99999,999.99 999999.999999 99999,999.99 99999,999.99 999.999 

*         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0                             
*12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890                 
*Codigo     Descripcion                              Orden         Cantidad UND    Cantidad UND      Materia         Mano       Gastos        Total         Costo        Venta     Utilidad    %   
*                                                    Produccion   Producida           Linea            Prima         Obra     Fabricac        Costo        Unidad                             Util              
*1234567890 1234567890123456789012345678901234567890 1234567890 999,999.999 123 999,999.999 123 99999,999.99 99999,999.99 99999,999.99 99999,999.99 999999.999999 99999,999.99 99999,999.99 999.999 

PUBLIC lnPag, R
LOCAL lcFile, lcProceso
lcFile = "PrdCosRes"
lcProceso = "Rep_PrdRes()"
lnPag = 0
R = 0
Imprimetexto(lcFile,lcProceso)
RETURN

PROCEDURE REP_PrdRes
LOCAL lcCodLin
LOCAL lnTotMP,lnTotMO,lnTotGF,lnTotVta,lnTotUti,lnPcjUti
LOCAL lnCanPrd,lnImpMP,lnImpMO,lnImpGF,lnImpCos,lnImpVta,lnImpUti,lnPcjUti

@PROW(),PCOL() SAY CHR(27)+"C"+CHR(66) 
@PROW(),PCOL() SAY CHR(18)+CHR(15)


TIT_PrdRes()
STORE 0.00 TO lnTotMP,lnTotMO,lnTotGF,lnTotVta,lnTotUti,lnPcjUti
SELE TmpRep
GO TOP
DO WHILE !EOF()
	lcCodLin = CodLin
	R = R + 1
	@R,001 SAY "Linea : "+CodLin+" "+IIF(SEEK(lcCodLin,"ArtLin","CodLin"),PADR(ArtLin.DesLin,40),"")
	R = R + 1
	STORE 0.00 TO lnCanPrd,lnImpMP,lnImpMO,lnImpGF,lnImpCos,lnImpVta,lnImpUti,lnPcjUti
	ll1raVez = .T.
	DO WHILE !EOF() AND CodLin = lcCodLin
		R = R + 1
		IF R > 55
			TIT_PrdRes()
			R = R + 1
		ENDIF
		*IF ll1raVez
		*	ll1raVez = .F.
		*	@R,001 SAY PADR(CodArt,10)
		*	@R,012 SAY PADR(DesArt,40)
		*ELSE
		*	IF CodArt <> lcCodArt	
		*		@R,001 SAY PADR(CodArt,10)
		*		@R,012 SAY PADR(DesArt,40)
		*	ENDIF
		*ENDIF
		*lcCodArt = CodArt	
		@R,001 SAY PADR(CodArt,10)
		@R,012 SAY PADR(DesArt,40)
		@R,053 SAY PADR(NroDoc,10)
		@R,064 SAY CanArt PICTURE "@Z 999,999.999"
		@R,076 SAY PADR(CodUnd,3)
		@R,080 SAY CanPrd PICTURE "@Z 999,999.999"
		@R,092 SAY PADR(UndPrd,3)
		@R,096 SAY ImpMP  PICTURE "@Z 99999,999.99"
		@R,109 SAY ImpMO  PICTURE "@Z 99999,999.99"
		@R,122 SAY ImpGF  PICTURE "@Z 99999,999.99"
		@R,135 SAY ImpTot PICTURE "@Z 99999,999.99"
		@R,148 SAY ImpCos PICTURE "@Z 999999.999999"
		@R,162 SAY ImpVta PICTURE "@Z 99999,999.99"
		@R,175 SAY ImpUti PICTURE "@Z 99999,999.99"
		lnPcjUti = IIF(ImpTot > 0,ROUND((ImpUti/ImpTot)*100,3),0.00)
		@R,188 SAY lnPcjUti PICTURE "@Z 999.999"
		lnCanPrd = lnCanPrd + CanPrd
		lnImpMP  = lnImpMP  + ImpMP
		lnImpMO  = lnImpMO  + ImpMO
		lnImpGF  = lnImpGF  + ImpGF
		lnImpVta = lnImpVta + ImpVta
		SKIP
	ENDDO
	lnImpTot = lnImpMP + lnImpMO + lnImpGF
	lnImpCos =  IIF(lnCanPrd > 0,ROUND(lnImpTot/lnCanPrd,6),0.00)
	lnImpUti = lnImpVta - lnImpTot
	lnPcjUti = IIF(lnImpTot > 0,ROUND((lnImpUti/lnImpTot)*100,3),0.00)
	R = R + 1
	@R,012 SAY PADR("TOTAL LINEA : "+IIF(SEEK(lcCodLin,"ArtLin","CodLin"),ArtLin.DesLin,""),40)
	@R,080 SAY lnCanPrd PICTURE "@Z 999,999.999"
	@R,092 SAY PADR(IIF(SEEK(lcCodLin,"ArtLin","CodLin"),ArtLin.UndPrd,""),3)
	@R,096 SAY lnImpMP  PICTURE "@Z 99999,999.99"
	@R,109 SAY lnImpMO  PICTURE "@Z 99999,999.99"
	@R,122 SAY lnImpGF  PICTURE "@Z 99999,999.99"
	@R,135 SAY lnImpTot PICTURE "@Z 99999,999.99"
	@R,148 SAY lnImpCos PICTURE "@Z 999999.999999"
	@R,162 SAY lnImpVta PICTURE "@Z 99999,999.99"
	@R,175 SAY lnImpUti PICTURE "@Z 99999,999.99"
	@R,188 SAY lnPcjUti PICTURE "@Z 999.999"
	R = R + 1
	lnTotMP = lnTotMP + lnImpMP
	lnTotMO = lnTotMO + lnImpMO
	lnTotGF = lnTotGF + lnImpGF
	lnTotVta = lnTotVta + lnImpVta
ENDDO
R = R + 1
@R,001 SAY REPLICATE("-",200)
R = R + 1
@R,012 SAY "TOTAL GENERAL"
lnTotTot = lnTotMP + lnTotMO + lnTotGF
lnTotUti = lnTotVta - lnTotTot
lnPcjUti = IIF(lnTotTot > 0,ROUND((lnTotUti/lnTotTot)*100,3),0.00)
@R,096 SAY lnTotMP  PICTURE "@Z 99999,999.99"
@R,109 SAY lnTotMO  PICTURE "@Z 99999,999.99"
@R,122 SAY lnTotGF  PICTURE "@Z 99999,999.99"
@R,135 SAY lnTotTot PICTURE "@Z 99999,999.99"
@R,162 SAY lnTotVta PICTURE "@Z 99999,999.99"
@R,175 SAY lnTotUti PICTURE "@Z 99999,999.99"
@R,188 SAY lnPcjUti PICTURE "@Z 999.999"
R = R + 1
@R,001 SAY REPLICATE("-",200)
RETURN

PROCEDURE TIT_PrdRes()
LOCAL lnColumna,lnOldSele
lnOldSele = SELECT()
lnPag =lnPag + 1
IF lnPag > 1
	@00,00 SAY ""
ENDIF
@01,001 SAY PADR(TabPar.NomEmp,40)
@01,042 SAY PADC(pTitNom,146)
@01,190 SAY DATE()
@02,001 SAY PADR("RUC : "+TabPar.NroRuc,40)
@02,042 SAY PADC(pTitRng,146)
@02,190 SAY TIME()
@03,042 SAY PADC(pTitMnd,146)
@03,190 SAY lnPag PICTURE "@B 9999"
@04,001 SAY REPLICATE("-",200)
@05,001 SAY "Codigo"
@05,012 SAY "Descripcion"
@05,053 SAY "Orden de"
@05,064 SAY PADL("Cantidad",11)
@05,076 SAY "UND"
@05,080 SAY PADL("Cantidad",11)
@05,092 SAY "UND"
@05,096 SAY PADL("Materia",12)
@05,109 SAY PADL("Mano",12)
@05,122 SAY PADL("Gasto",12)
@05,135 SAY PADL("Total",12)
@05,148 SAY PADL("Costo",12)
@05,162 SAY PADL("Venta",12)
@05,175 SAY PADL("Utilidad",12)
@05,188 SAY PADC("%",07)
@06,001 SAY ""
@06,012 SAY ""
@06,053 SAY "Produccion"
@06,064 SAY PADL("Producida",11)
@06,076 SAY ""
@06,080 SAY PADL("Linea",11)
@06,092 SAY ""
@06,096 SAY PADL("Prima",12)
@06,109 SAY PADL("Obra",12)
@06,122 SAY PADL("Fabricacion",12)
@06,135 SAY PADL("Costo",12)
@06,148 SAY PADL("Unidad",12)
@06,162 SAY PADL("",12)
@06,175 SAY PADL("",12)
@06,188 SAY PADC("Util",07)
@07,001 SAY REPLICATE("-",200)
R=8
RETURN