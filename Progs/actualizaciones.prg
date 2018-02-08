*------------------------------------------------
*- PERIODO
*-------------------------------------------------
*- Obtengo Periodo Inicial del Ano
FUNCTION CAL_PerIni(lcPeriodo)
LOCAL lcPeriodoIni
lcPeriodoIni = ""
IF !EMPTY(lcPeriodo)
	lcPeriodoIni = SUBS(lcPeriodo,1,4)+"00"
ENDIF
RETURN lcPeriodoIni
ENDFUNC

*- Obtengo Periodo Anterior solo del Ano
FUNCTION CAL_PerAnt_INI(lcPeriodo)
LOCAL lcPeriodoAnt
lcPeriodoAnt = ""
IF !EMPTY(lcPeriodo)
	IF SUBS(lcPeriodo,5,2) == "01"
		lcPeriodoAnt = SUBS(lcPeriodo,1,4)+"00"
	ELSE
		lcPeriodoAnt = SUBS(lcPeriodo,1,4)+PADL(ALLTRIM(STR(VAL(SUBS(lcPeriodo,5,2))-1)),2,"0")
	ENDIF
ENDIF
RETURN lcPeriodoAnt
ENDFUNC

*- Calculo del Periodo Anterior
FUNCTION CAL_PerAnt(lcPeriodo)
LOCAL lcPeriodoAnt
lcPeriodoAnt = ""
IF !EMPTY(lcPeriodo)
	IF SUBS(lcPeriodo,5,2) == "01"
		lcPeriodoAnt = ALLTRIM(STR(VAL(SUBS(lcPeriodo,1,4))-1))+"12"
	ELSE
		lcPeriodoAnt = SUBS(lcPeriodo,1,4)+PADL(ALLTRIM(STR(VAL(SUBS(lcPeriodo,5,2))-1)),2,"0")
	ENDIF
ENDIF
RETURN lcPeriodoAnt
ENDFUNC

*- Obtengo Periodo Siguiente
FUNCTION CAL_PerSig(lcPeriodo)
LOCAL lcPeriodoSig
IF SUBS(lcPeriodo,5,2) == "12"
	lcPeriodoSig = ALLTRIM(STR(VAL(SUBS(lcPeriodo,1,4))+1))+"01"
ELSE
	lcPeriodoSig = SUBS(lcPeriodo,1,4)+PADL(ALLTRIM(STR(VAL(SUBS(lcPeriodo,5,2))+1)),2,"0")
ENDIF
RETURN lcPeriodoSig
ENDFUNC

*- Obtengo Periodo Inicial Siguiente
FUNCTION CAL_PerIniSig(lcPeriodo)
LOCAL lcPeriodoIni
lcPeriodoIni = ""
IF !EMPTY(lcPeriodo)
	lcPeriodoIni = ALLTRIM(STR(VAL(SUBS(lcPeriodo,1,4))+1))+"00"
ENDIF
RETURN lcPeriodoIni
ENDFUNC

********************************************
*- EQUIVALENCIAS
*------------------------------------------
PROCEDURE SEL_ArtTip_TipExi(lcTipArt,lcTipExi,lcDesExi)
STORE "" TO lcTipExi,lcDesExi,lcDesTipArt
lnReg = SEL_ArtTip_TipArt_TipExi(lcTipArt,@lcTipExi)
IF lnReg < 1
	MESSAGEBOX("Problemas al Seleccionar en ArtTip",0+64,"Validacion")
	RETURN .F.
ENDIF
IF EMPTY(lcTipExi)
	MESSAGEBOX("Tipo de Articulo No tiene Equivalencia con Existencia",0+64,"Validacion")
	RETURN .F.
ENDIF
IF lcTipExi == "99"
	lnReg = SEL_ArtTip_TipArt_DesTipArt(lcTipArt,@lcDesTipArt)
	lcDesExi = lcTipExi+" "+ALLTRIM(lcDesTipArt)
ELSE
	lnReg = SEL_TipExi_TipExi_DesExi(lcTipExi,@lcDesExi)
	lcDesExi = lcTipExi+" "+ALLTRIM(lcDesExi)
ENDIF
RETURN .T.
ENDPROC

PROCEDURE SEL_ArtUnd_LibUnd(lcCodUnd,lcLibUnd,lcDesUnd)
STORE "" TO lcLibUnd,lcDesUnd
IF EMPTY(lcCodUnd)
	lcLibUnd = "99"
	lcDesUnd = "99"
	RETURN .T.
ENDIF
lnReg = SEL_ArtUnd_CodUnd_LibUnd(lcCodUnd,@lcLibUnd)
IF lnReg < 1
	MESSAGEBOX("Problemas al Seleccionar en ArtUnd",0+64,"Validacion")
	RETURN .F.
ENDIF
IF EMPTY(lcLibUnd)
	MESSAGEBOX("Unidad de Articulo No tiene Equivalencia",0+64,"Validacion")
	RETURN .F.
ENDIF
lcDesUnd = lcLibUnd+" "+ALLTRIM(lcCodUnd)
IF lcLibUnd == "99"
	lnReg = SEL_ArtUnd_CodUnd_DesUnd(lcCodUnd,@lcDesUnd)
	lcDesUnd = lcLibUnd+" "+ALLTRIM(lcDesUnd)
	*lcDesUnd = lcLibUnd+" "+ALLTRIM(lcCodUnd)
ELSE
	lnReg = SEL_LibUnd_LibUnd_DesUnd(lcLibUnd,@lcDesUnd)
	lcDesUnd = lcLibUnd+" "+ALLTRIM(lcDesUnd)
	*lcDesUnd = lcLibUnd
ENDIF
RETURN .T.
ENDPROC

PROCEDURE SEL_ArtTsc_TipOpe(lcTipMov,lcTipTsc,lcDesTsc,lcTipOpe,lcDesOpe)
LOCAL lnReg 
STORE "" TO lcTipOpe,lcDesOpe
lnReg = SEL_ArtTsc_MovTsc_TipOpe(lcTipMov,lcTipTsc,@lcTipOpe)
IF lnReg < 1
	MESSAGEBOX("Problemas al Seleccionar en ArtTsc",0+64,"Validacion")
	RETURN .F.
ENDIF
IF EMPTY(lcTipOpe)
	MESSAGEBOX("Transaccion de Articulo No tiene Equivalencia",0+64,"Validacion")
	RETURN .F.
ENDIF
IF lcTipOpe == "99"
	lcDesOpe = lcTipOpe+" "+ALLTRIM(lcDesTsc)
ELSE
	lnReg = SEL_LibOpe_TipOpe_DesOpe(lcTipOpe,@lcDesOpe)
	lcDesOpe = lcTipOpe+" "+ALLTRIM(lcDesOpe)
ENDIF
RETURN .T.
ENDPROC

FUNCTION SEL_ArtTsc_MovTsc(lcTipMov,lcTipTsc)
LOCAL lnReg
SELE M.TipMov, M.TipTsc FROM ArtTsc M ;
WHERE M.TipMov+M.TipTsc == lcTipMov+lcTipTsc INTO CURSOR Tmp
lnReg = _TALLY
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_ArtTsc_MovTsc_TipOpe(lcTipMov,lcTipTsc,lcTipOpe)
LOCAL lnReg
lcTipOpe = ""
SELE M.TipMov, M.TipTsc, M.TipOpe FROM ArtTsc M ;
WHERE M.TipMov+M.TipTsc == lcTipMov+lcTipTsc INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcTipOpe = Tmp.TipOpe
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_LibOpe_TipOpe_DesOpe(lcTipOpe,lcDesOpe)
LOCAL lnReg
lcDesOpe = ""
SELE M.TipOpe, M.DesOpe FROM LibOpe M WHERE M.TipOpe == lcTipOpe INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcDesOpe = Tmp.DesOpe
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_ArtTip_TipArt_TipExi(lcTipArt,lcTipExi)
LOCAL lnReg
lcTipExi = ""
SELE M.TipArt, M.TipExi FROM ArtTip M WHERE M.TipArt == lcTipArt INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcTipExi = Tmp.TipExi
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_ArtTip_TipArt_DesTipArt(lcTipArt,lcDesTipArt)
LOCAL lnReg
lcDesTipArt = ""
SELE M.TipArt, M.DesTipArt FROM ArtTip M WHERE M.TipArt == lcTipArt INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcDesTipArt = Tmp.DesTipArt
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_TipExi_TipExi_DesExi(lcTipExi,lcDesExi)
LOCAL lnReg
lcDesExi = ""
SELE M.TipExi, M.DesExi FROM TipExi M WHERE M.TipExi == lcTipExi INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcDesExi = Tmp.DesExi
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_LibUnd_LibUnd_DesUnd(lcLibUnd,lcDesUnd)
LOCAL lnReg
lcDesUnd = ""
SELE M.LibUnd, M.LibDesUnd FROM LibUnd M WHERE M.LibUnd == lcLibUnd INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcDesUnd = Tmp.LibDesUnd
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_ArtUnd_CodUnd_LibUnd(lcCodUnd,lcLibUnd)
LOCAL lnReg
lcLibUnd = ""
SELE M.CodUnd, M.LibUnd FROM ArtUnd M WHERE M.CodUnd == lcCodUnd INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcLibUnd = Tmp.LibUnd
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_ArtUnd_CodUnd_DesUnd(lcCodUnd,lcDesUnd)
LOCAL lnReg
lcLibUnd = ""
SELE M.CodUnd, M.DesUnd FROM ArtUnd M WHERE M.CodUnd == lcCodUnd INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcDesUnd = Tmp.DesUnd
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC


FUNCTION SEL_TipMnd_TipMnd_LibMnd(lcTipMnd,lcLibMnd)
LOCAL lnReg
lcLibMnd = ""
SELE M.TipMnd, M.LibMnd FROM TipMnd M WHERE M.TipMnd == lcTipMnd INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcLibMnd = Tmp.LibMnd
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_TabBco_CodBco_CodEnt(lcCodBco,lcCodEnt)
LOCAL lnReg
lcCodEnt = ""
SELE M.CodBco, M.CodEnt FROM TabBco M WHERE M.CodBco == lcCodBco INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcCodEnt = Tmp.CodEnt
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

*********************************************
*- SELECCIONO CALCULO DEL COSTO 
FUNCTION SEL_CAL_ArtCos_PER(lcPeriodo,lcCodArt)
LOCAL lnReg,lcPeriodoIni,lcPeriodoAnt,lcPeriodoFin
IF EMPTY(lcPeriodo) OR ISNULL(lcPeriodo)
	RETURN .F.
ENDIF
IF EMPTY(lcCodArt) OR ISNULL(lcCodArt)
	lcCodArt = ""
ENDIF
lcPeriodoIni = CAL_PerIni(lcPeriodo)
lcPeriodoAnt = CAL_PerAnt_INI(lcPeriodo)

*- Verifico si Periodo Tiene Calculos
IF !EMPTY(lcCodArt)
	lnReg = SEL_ARTCOS_PerArt_REG(lcPeriodo,lcCodArt)
ELSE
	lnReg = SEL_ARTCOS_PER_REG(lcPeriodo)
ENDIF
IF lnReg < 1
	MESSAGEBOX("Periodo No Tiene Calculos",0+64,"Validacion")
	RETURN .F.
ENDIF

*- Selecciono Calculos del Periodo
IF !EMPTY(lcCodArt)
	IF !SEL_ARTCOS_PerArt_CAL(lcPeriodo,lcCodArt)
		MESSAGEBOX("Problemas al Seleccionar Calculos del Periodo",0+64,"Validacion")
		RETURN .f.
	ENDIF
ELSE
	IF !SEL_ARTCOS_PER_CAL(lcPeriodo)
		MESSAGEBOX("Problemas al Seleccionar Calculos del Periodo para el Articulo",0+64,"Validacion")
		RETURN .f.
	ENDIF
ENDIF
IF !USED("TmpIni")
	RETURN .f.
ENDIF

*- Selecciono Movimiento del Periodo
IF !EMPTY(lcCodArt)
	IF !SEL_ARTMOVCAB_PerArt_COS(lcPeriodo,lcCodArt)
		RETURN .F.
	ENDIF
ELSE
	IF !SEL_ARTMOVCAB_Per_COS(lcPeriodo)
		RETURN .F.
	ENDIF
ENDIF
IF !USED("TmpMov")
	RETURN .F.
ENDIF

*- Cargos Costo
SELE TmpCos
ZAP
SELE TmpIni
GO TOP
SCAN WHILE !EOF()
	SELE TmpIni
	SCATTER NAME oMov
	SELE TmpCos
	APPEND BLANK
	GATHER NAME oMov
	RELEASE oMov
	SELE TmpIni
ENDSCAN
USE IN TmpIni

*- Filtro Articulos
SELECT DISTINCT A.CodArt, A.CodLin, A.CodCla, A.TipArt, A.CodMar, A.DesArt, ;
                A.CodUnd, A.UndCon, A.FacCon FROM ArtArt A INTO CURSOR TmpArt

*- Datos del Articulo
SELE M.*, PADR(NVL(A.TipArt,""),01) As TipArt, PADR(NVL(A.CodLin,""),02) As CodLin, ;
     PADR(NVL(A.CodCla,""),02) As CodCla, PADR(NVL(A.CodMar,""),02) As CodMar, ;
	 NVL(A.FacCon,00000000.000000) As FacCon, PADR(NVL(A.UndCon,""),03) As UndCon ;
FROM TmpCos M LEFT OUTER JOIN TmpArt A ON M.CodArt == A.CodArt ;
ORDER BY A.DesArt INTO CURSOR TmpCab
USE IN TmpArt

*- Cargo Temporal
SELE TmpSel
ZAP
IF !CAL_ArtCos_PER_TMP(lcPeriodo)
	RETURN .F.
ENDIF

*- Verifico Totales
IF MESSAGEBOX('Desea Verificar Totales ...',4+32+256,'Validacion') = 7
	USE IN TmpCab
	RETURN .t.
ENDIF

SELECT * FROM TmpSel WHERE IndMov == 3 INTO CURSOR TmpTot

SELE TmpTot
GO TOP
SCAN WHILE !EOF()
	SELE TmpTot
	*- Selecciono Cabecera
	SELECT M.* FROM TmpCab M WHERE M.CodArt == TmpTot.CodArt INTO CURSOR Tmp
		
    IF !(TmpTot.CanIng == Tmp.CanIng)
		IF MESSAGEBOX('Problemas Detalle de Cantidad Ingresada No Cuadra con Calculo ...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
    IF !(TmpTot.CanSal == Tmp.CanSal)
		IF MESSAGEBOX('Problemas Detalle de Cantidad de Salida No Cuadra con Calculo...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
 	IF !(TmpTot.CANSLD == Tmp.CanSld)
		IF MESSAGEBOX('Problemas Detalle de Cantidad de Saldo No Cuadra con Calculo...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
    IF !(TmpTot.TotIng == Tmp.TotIng)
		IF MESSAGEBOX('Problemas Detalle de Total Importe Ingresado No Cuadra con Calculo...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
    IF !(TmpTot.TotSal == Tmp.TotSal)
		IF MESSAGEBOX('Problemas Detalle de Total Importe Salida No Cuadra con Calculo...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
    IF !(TmpTot.TOTSLD == Tmp.TotSld)
		IF MESSAGEBOX('Problemas Detalle de Total Importe Saldo No Cuadra con Calculo...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
    IF !(TmpTot.IMPSAL == Tmp.ImpSal)
		IF MESSAGEBOX('Problemas Detalle de Importe Salida No Cuadra con Calculo...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
    IF !(TmpTot.IMPSLD == Tmp.ImpSld)
		IF MESSAGEBOX('Problemas Detalle de Importe Saldo No Cuadra con Calculo...Continuar...',4+32+256,'Validacion') = 7
			RETURN .F.
		ENDIF
    ENDIF
	USE IN Tmp
	
	SELE TmpTot
ENDSCAN
USE IN TmpTot
USE IN TmpCab
RETURN .t.
ENDFUNC

*- Calculo de Costo al Temporal
FUNCTION CAL_ArtCos_PER_TMP(lcPeriodo)
LOCAL lcCodArt,lcDesArt,lcCodUnd,lcUndCon,lcTipArt,lcCodLin,lcCodCla,lcCodMar,lnFacCon, ;
      lnCanIni,lnImpIni,lnTotIni,lnImpIniDol,lnTotIniDol,lnTotCanIng,lnTotTotIng,lnTotTotIngDol, ;
	  lnTotCanSal,lnTotTotSal,lnTotTotSalDol,lnCanSld,lnTotSld,lnImpSld,lnTotSldDol,lnImpSldDol, ;
	  lnImpMed,lnImpIng,lnImpIngDol,lnCanIng,lnTotIng,lnTotIngDol, ;
	  lnCanSal,lnTotSal,lnImpSal,lnTotSalDol,lnImpSalDol,lnCanCon,lnImpCon,lnImpCosCon,lnImpCosConD, ;
	  lnImpCam,lnPcjIgv,lnImpArt,lcTipMnd,lnIndErr,lnIndPar,ldFecIni,ldFecFin,lnSec,lnCanReg
	  
ldFecIni = CTOD("01/"+SUBS(lcPeriodo,5,2)+"/"+SUBS(lcPeriodo,1,4))	  
ldFecFin = CTOD("01/"+SUBS(lcPeriodo,5,2)+"/"+SUBS(lcPeriodo,1,4))
ldFecFin = gomonth(ldFecFin - DAY(ldFecFin) + 1, 1 )-1

STORE 0 TO lnSec,lnIndPar,lnCanReg

SELE TmpCab
GO TOP
SCAN WHILE !EOF()
	SELE TmpCab
	
	*- Datos del Articulo
	lcCodArt = TmpCab.CodArt
	lcDesArt = TmpCab.DesArt
	lcCodUnd = TmpCab.CodUnd
	
	lcUndCon = TmpCab.UndCon
	lnFacCon = TmpCab.FacCon
	lcTipArt = TmpCab.TipArt
	lcCodLin = TmpCab.CodLin
	lcCodCla = TmpCab.CodCla
	lcCodMar = TmpCab.CodMar
	
	*- Saldo Inicial
	lnCanIni = TmpCab.CanIni
	lnImpIni = TmpCab.ImpIni
	lnTotIni = TmpCab.TotIni
	lnImpIniDol = TmpCab.ImpIniDol
	lnTotIniDol = TmpCab.TotIniDol
	
	lnIndErr = 0
	lnSec = lnSec + 1
	lnIndPar = IIF(!(MOD(lnSec,2) == 0),1,2)
	lnCanReg = 0
	
	*- Saldo Inicial
	INSERT INTO TmpSel (CodArt, Periodo, FecDoc, ;
		NroSec, TipDoc, NroDoc, NroSecDet, SecRef, TipRef, NroRef, ItmRef, ;
	   	CodAlm, TipMov, TipTsc, TipMnd, ImpCam, PcjIgv, ;
	   	CodUnd, CanArt, ImpArt, UndMed, CanMed, ImpMed, ;
	   	CanIni, ImpIni, TotIni, CanIng, ImpIng, TotIng, ;
	   	CanSal, ImpSal, TotSal, CanSld, ImpSld, TotSld, ;
	   	ImpIniDol, TotIniDol, ImpIngDol, TotIngDol, ;
	   	ImpSalDol, TotSalDol, ImpSldDol, TotSldDol, ;
	   	FacCon, UndCon, IndIgv, IndIna, ;
       	DesArt, DesMov, DesTsc, TipNroDoc, TipNroRef, ;
       	IndMov, IndErr, IndPar) ; 
	VALUES (lcCodArt, lcPeriodo, ldFecIni, ;
	   	0, "", "", 0, 0, "", "", 0, ;
	   	"", "I", "00", "P", IIF(!(lnTotIniDol == 0),ROUND(lnTotIni/lnTotIniDol,2),0.00), 0.00, ;
	   	lcCodUnd, lnCanIni, lnImpIni, lcCodUnd, lnCanIni, lnImpIni, ;
	   	lnCanIni, lnImpIni, lnTotIni, 000000.000, 00000000.000000, 000000000.00, ;
	   	000000.000, 00000000.000000, 000000000.00, lnCanIni, lnImpIni, lnTotIni, ;
	   	lnImpIniDol, lnTotIniDol, 00000000.000000, 000000000.00, ;
	   	00000000.000000, 000000000.00, lnImpIniDol, lnTotIniDol, ;
	   	lnFacCon, lcUndCon, 0, 0, ;
       	lcDesArt, "SALDO", "SALDO INICIAL", "", "", ;
       	1, lnIndErr, lnIndPar)
       	
    *- Movimientos
    STORE 0 TO lnTotCanIng,lnTotTotIng,lnTotTotIngDol,lnTotCanSal,lnTotTotSal,lnTotTotSalDol, ;
			   lnCanSld,lnTotSld,lnImpSld,lnTotSldDol,lnImpSldDol
			   
	lnCanSld = lnCanIni
	lnTotSld = lnTotIni
	lnImpSld = IIF(!(lnCanSld = 0),ROUND(lnTotSld/lnCanSld,6),0.000000)
	lnTotSldDol = lnTotIniDol
	lnImpSldDol = IIF(!(lnCanSld = 0),ROUND(lnTotSldDol/lnCanSld,6),0.000000)
    
    SELECT M.* FROM TmpMov M WHERE M.CodArt = lcCodArt ORDER BY M.CodArt,M.TipMov,M.FecDoc INTO CURSOR TmpMovArt
	
	*- Movimientos que Afectan el Costo Promedio
	SELECT M.* FROM TmpMovArt M WHERE M.IndCosPrm = 1 ORDER BY M.CodArt, M.FecDoc INTO CURSOR TmpMovIng

	SELE TmpMovIng
	GO TOP
	SCAN WHILE !EOF()
		STORE 0 TO lnImpMed,lnImpIng,lnImpIngDol,lnCanIng,lnTotIng,lnTotIngDol, ;
		           lnImpCam,lnPcjIgv,lnImpArt,lnIndErr
		STORE "" TO lcTipMnd
		lcTipMnd = TmpMovIng.TipMnd
		lnImpCam = TmpMovIng.ImpCam
		lnPcjIgv = TmpMovIng.PcjIgv
		lnImpArt = TmpMovIng.ImpArt
		lnImpArt = IIF(TmpMovIng.IndIgv == 1,ROUND((lnImpArt)/((100 + lnPcjIgv)/100),2),lnImpArt)
		IF EMPTY(lnImpArt)
			lnIndErr = 1
		ENDIF

		*- Valorizacion
		lnImpMed = IIF(TmpMovIng.CodUnd == TmpMovIng.UndMed,lnImpArt,ROUND(lnImpArt*lnFacCon,2))
		lnImpIng = IIF(lcTipMnd == "U",ROUND(lnImpMed*lnImpCam,6),lnImpMed)
		lnImpIngDol = IIF(lcTipMnd == "U",lnImpMed,IIF(lnImpCam > 0,ROUND(lnImpMed/lnImpCam,6),0.00))
		lnCanIng = IIF(TmpMovIng.TipMov == "I",TmpMovIng.CanMed,-1*TmpMovIng.CanMed)
		lnTotIng = ROUN(lnCanIng*lnImpIng,2)
		lnTotIngDol = ROUN(lnCanIng*lnImpIngDol,2)
		
		lnTotCanIng = lnTotCanIng + lnCanIng
		lnTotTotIng = lnTotTotIng + lnTotIng
		lnTotTotIngDol = lnTotTotIngDol + lnTotIngDol
		
		*- COSTO PROMEDIO
		lnCanSld = lnCanIni + lnTotCanIng
		lnTotSld = lnTotIni + lnTotTotIng
		lnImpSld = IIF(!(lnCanSld = 0),ROUND(lnTotSld/lnCanSld,6),0.000000)
		lnTotSldDol = lnTotIniDol + lnTotTotIngDol
		lnImpSldDol = IIF(!(lnCanSld = 0),ROUND(lnTotSldDol/lnCanSld,6),0.000000)
		
		*- Adiciono
		INSERT INTO TmpSel (CodArt, Periodo, FecDoc, ;
	   		NroSec, TipDoc, NroDoc, NroSecDet, SecRef, TipRef, NroRef, ItmRef, ;
	   		CodAlm, TipMov, TipTsc, TipMnd, ImpCam, PcjIgv, ;
	   		CodUnd, CanArt, ImpArt, UndMed, CanMed, ImpMed, ;
	   		CanIni, ImpIni, TotIni, CanIng, ImpIng, TotIng, ;
	   		CanSal, ImpSal, TotSal, CanSld, ImpSld, TotSld, ;
	   		ImpIniDol, TotIniDol, ImpIngDol, TotIngDol, ;
	   		ImpSalDol, TotSalDol, ImpSldDol, TotSldDol, ;
	   		FacCon, UndCon, IndIgv, IndIna, ;
       		DesArt, DesMov, DesTsc, TipNroDoc, TipNroRef, ;
       		IndMov, IndErr, IndPar); 
		VALUES (lcCodArt, lcPeriodo, TmpMovIng.FecDoc, ;
			TmpMovIng.NroSec, TmpMovIng.TipDoc, TmpMovIng.NroDoc, TmpMovIng.NroSecDet, ;
			TmpMovIng.SecRef, TmpMovIng.TipRef, TmpMovIng.NroRef, TmpMovIng.NroItmRef, ;
	   		TmpMovIng.CodAlm, TmpMovIng.TipMov, TmpMovIng.TipTsc, lcTipMnd, lnImpCam, lnPcjIgv, ;
	   		TmpMovIng.CodUnd, TmpMovIng.CanArt, lnImpArt, ;
	   		TmpMovIng.UndMed, TmpMovIng.CanMed, lnImpMed, ;
	   		000000.000, 00000000.000000, 000000000.00, lnCanIng, lnImpIng, lnTotIng, ;
	   		000000.000, 00000000.000000, 000000000.00, lnCanSld, lnImpSld, lnTotSld, ;
	   		00000000.000000, 000000000.00, lnImpIngDol, lnTotIngDol, ;
	   		00000000.000000, 000000000.00, lnImpSldDol, lnTotSldDol, ;
	   		lnFacCon, lcUndCon, TmpMovIng.IndIgv, TmpMovIng.IndIna, ;
       		lcDesArt, TmpMovIng.DesMov, TmpMovIng.DesTsc, ;
       		TmpMovIng.TipDoc+" "+TmpMovIng.NroDoc, TmpMovIng.TipRef+" "+TmpMovIng.NroRef, ;
       		2, lnIndErr, lnIndPar)

		SELE TmpMovIng
	ENDSCAN
	USE IN TmpMovIng
	
	*- Movimientos que afectan el costo de venta
	STORE 0 TO lnCanSal,lnTotSal,lnImpSal,lnTotSalDol,lnImpSalDol,lnIndErr
	
	SELECT M.* FROM TmpMovArt M WHERE M.IndCos = 1 ORDER BY M.CodArt, M.FecDoc INTO CURSOR TmpMovSal
		
	SELE TmpMovSal
	GO TOP
	SCAN WHILE !EOF()
		lnCanSal = IIF(TmpMovSal.TipMov == "I",-1*TmpMovSal.CanMed,TmpMovSal.CanMed)
		lnTotCanSal = lnTotCanSal + lnCanSal
		lnImpSal = lnImpSld  &&IIF(!(lnCanSal = 0),ROUND(lnTotSal/lnCanSal,6),0.000000)
		lnTotSal = ROUND(lnCanSal*lnImpSal,2) &&lnTotIni + lnTotTotIng - lnTotSld
		lnTotTotSal = lnTotTotSal + lnTotSal
		lnImpSalDol = lnImpSldDol &&IIF(!(lnCanSal = 0),ROUND(lnTotSalDol/lnCanSal,6),0.000000)
		lnTotSalDol = ROUND(lnCanSal*lnImpSalDol,2) &&lnTotIniDol + lnTotTotIngDol - lnTotSldDol
		lnTotTotSalDol = lnTotTotSalDol + lnTotSalDol
		
		lnCanSld = lnCanIni + lnTotCanIng - lnTotCanSal 
		lnTotSld = ROUND(lnCanSld*lnImpSld,2)
		lnTotSldDol = ROUND(lnCanSld*lnImpSldDol,2)
		
		*- Adiciono
		INSERT INTO TmpSel (CodArt, Periodo, FecDoc, ;
	   		NroSec, TipDoc, NroDoc, NroSecDet, SecRef, TipRef, NroRef, ItmRef, ;
	   		CodAlm, TipMov, TipTsc, TipMnd, ImpCam, PcjIgv, ;
	   		CodUnd, CanArt, ImpArt, UndMed, CanMed, ImpMed, ;
	   		CanIni, ImpIni, TotIni, CanIng, ImpIng, TotIng, ;
	   		CanSal, ImpSal, TotSal, CanSld, ImpSld, TotSld, ;
	   		ImpIniDol, TotIniDol, ImpIngDol, TotIngDol, ;
	   		ImpSalDol, TotSalDol, ImpSldDol, TotSldDol, ;
	   		FacCon, UndCon, IndIgv, IndIna, ;
	   		DesArt, DesMov, DesTsc, TipNroDoc, TipNroRef, ;
       		IndMov, IndErr, IndPar); 
		VALUES (lcCodArt, lcPeriodo, TmpMovSal.FecDoc, ;
			TmpMovSal.NroSec, TmpMovSal.TipDoc, TmpMovSal.NroDoc, TmpMovSal.NroSecDet, ;
			TmpMovSal.SecRef, TmpMovSal.TipRef, TmpMovSal.NroRef, TmpMovSal.NroItmRef, ;
	   		TmpMovSal.CodAlm, TmpMovSal.TipMov, TmpMovSal.TipTsc, TmpMovSal.TipMnd, TmpMovSal.ImpCam, TmpMovSal.PcjIgv, ;
	   		TmpMovSal.CodUnd, TmpMovSal.CanArt, TmpMovSal.ImpArt, ;
	   		TmpMovSal.UndMed, TmpMovSal.CanMed, TmpMovSal.ImpMed, ;
	   		000000.000, 00000000.000000, 000000000.00, 000000.000, 00000000.000000, 000000000.00, ;
	   		lnCanSal, lnImpSal, lnTotSal, lnCanSld, lnImpSld, lnTotSld, ;
	   		00000000.000000, 000000000.00, 00000000.000000, 000000000.00, ;
	   		lnImpSalDol, lnTotSalDol, lnImpSldDol, lnTotSldDol, ;
	   		lnFacCon, lcUndCon, TmpMovSal.IndIgv, TmpMovSal.IndIna, ;
       		lcDesArt, TmpMovSal.DesMov, TmpMovSal.DesTsc, ;
       		TmpMovSal.TipDoc+" "+TmpMovSal.NroDoc, TmpMovSal.TipRef+" "+TmpMovSal.NroRef, ;
       		2, lnIndErr, lnIndPar)

		SELE TmpMovSal
	ENDSCAN
	USE IN TmpMovSal
	USE IN TmpMovArt
	
	lnTotTotSal = lnTotIni + lnTotTotIng - lnTotSld 
	lnTotTotSalDol = lnTotIniDol + lnTotTotIngDol - lnTotSldDol

	lnIMPING = IIF(!(lnTotCANING = 0),ROUND(lnTotTOTING/lnTotCANING,6),0.000000)
	lnIMPSAL = IIF(!(lnTotCANSAL = 0),ROUND(lnTotTOTSAL/lnTotCANSAL,6),0.000000)
	lnIMPINGDOL = IIF(!(lnTotCANING = 0),ROUND(lnTotTOTINGDOL/lnTotCANING,6),0.000000)
	lnIMPSALDOL = IIF(!(lnTotCANSAL = 0),ROUND(lnTotTOTSALDOL/lnTotCANSAL,6),0.000000)
	lnIndErr = IIF(ALLTRIM(lcDesArt) == "***ELIMINADO***",1,0)
	
	*- Adiciono Totales
	INSERT INTO TmpSel (CodArt, Periodo, FecDoc, ;
		NroSec, TipDoc, NroDoc, NroSecDet, SecRef, TipRef, NroRef, ItmRef, ;
		CodAlm, TipMov, TipTsc, TipMnd, ImpCam, PcjIgv, ;
		CodUnd, CanArt, ImpArt, UndMed, CanMed, ImpMed, ;
		CanIni, ImpIni, TotIni, CanIng, ImpIng, TotIng, ;
		CanSal, ImpSal, TotSal, CanSld, ImpSld, TotSld, ;
		ImpIniDol, TotIniDol, ImpIngDol, TotIngDol, ;
		ImpSalDol, TotSalDol, ImpSldDol, TotSldDol, ;
		FacCon, UndCon, IndIgv, IndIna, ;
		DesArt, DesMov, DesTsc, TipNroDoc, TipNroRef, ;
    	IndMov, IndErr, IndPar); 
	VALUES (lcCodArt, lcPeriodo, ldFecFin, ;
		0, "", "", 0, 0, "", "", 0, ;
	   	"", "", "99", "P", IIF(!(lnTOTSLDDOL == 0),ROUND(lnTOTSLD/lnTOTSLDDOL,2),0.00), 0.00, ;
	   	lcCodUnd, 0.00, 0.00, lcCodUnd, 0.00, 0.00, ;
	   	lnCANINI,lnIMPINI,lnTOTINI,lnTotCANING,lnIMPING,lnTotTOTING, ;
	   	lnTotCANSAL,lnIMPSAL,lnTotTOTSAL,lnCANSLD,lnIMPSLD,lnTOTSLD, ;
		lnIMPINIDOL,lnTOTINIDOL,lnIMPINGDOL,lnTotTOTINGDOL, ;
		lnIMPSALDOL,lnTotTOTSALDOL,lnIMPSLDDOL,lnTOTSLDDOL, ;
		lnFacCon, lcUndCon, 0, 0, ;
       	lcDesArt, "SALDO", "TOTAL", "", "", ;
       	3, lnIndErr, lnIndPar)

	SELE TmpCab
ENDSCAN
RETURN .t.
ENDFUNC

***********************************************************************
***********************************************************************

*------------------------------------------------
*- ARTCOS
*-------------------------------------------------
*- Elimino Calculos
FUNCTION DEL_ARTCOS_Per(lcPeriodo)
LOCAL lnReg
lnReg = 0
DELETE FROM ARTCOS WHERE Periodo == lcPeriodo
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*- Selecciono Calculo del Costo del Periodo
FUNCTION SEL_ARTCOS_PER_CAL(lcPeriodo)
SELECT M.* FROM ArtCos M WHERE M.Periodo = lcPeriodo ORDER BY M.CodArt INTO CURSOR TmpIni
RETURN .T.
ENDFUNC

*- Selecciono Calculo del Costo del Periodo para el Articulo
FUNCTION SEL_ARTCOS_PerArt_CAL(lcPeriodo,lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.* FROM ArtCos M WHERE M.Periodo = lcPeriodo AND M.CodArt == lcCodArt ORDER BY M.CodArt INTO CURSOR TmpIni
RETURN .t.
ENDFUNC

*- Selecciono Totales del Costo del Periodo Anterior
FUNCTION SEL_ARTCOS_PER(lcPeriodo)
SELECT M.Periodo, M.CodAlm, M.CodArt, M.CodUnd, M.CanSld, M.ImpSld, M.TotSld, M.ImpSldDol, M.TotSldDol ;
FROM ArtCos M WHERE M.Periodo = lcPeriodo ORDER BY M.CodArt INTO CURSOR TmpIni
IF _TALLY < 1
	RETURN .f.
ENDIF
RETURN .t.
ENDFUNC

*- Selecciono Registros del Periodo
FUNCTION SEL_ARTCOS_PER_REG(lcPeriodo)
LOCAL lnReg
lnReg = 0
SELECT M.Periodo FROM ArtCos M WHERE M.Periodo == lcPeriodo INTO CURSOR Tmp
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*- Selecciono Registros del Periodo para el Articulo
FUNCTION SEL_ARTCOS_PerArt_REG(lcPeriodo,lcCodArt)
LOCAL lnReg
lnReg = 0
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.Periodo, M.CodArt FROM ArtCos M WHERE M.Periodo == lcPeriodo AND M.CodArt == lcCodArt INTO CURSOR Tmp
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*- Selecciono Registros del Periodo y Articulo
FUNCTION SEL_ARTCOS_ArtPer(lcCodArt,lcPeriodo)
LOCAL lnReg
lnReg = 0
SELECT M.CodArt, M.Periodo FROM ArtCos M ;
WHERE M.CodArt+M.Periodo == lcCodArt+lcPeriodo INTO CURSOR Tmp
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*- Selecciono Ultimo periodo procesado
FUNCTION SEL_ARTCOS_PERULT()
LOCAL lcPeriodo
lcPeriodo = ""
SELECT MAX(M.Periodo) As Periodo FROM ArtCos M WHERE !EMPTY(M.CodArt) INTO CURSOR Tmp
IF _TALLY > 0
	lcPeriodo = Tmp.Periodo
ENDIF
RETURN lcPeriodo
ENDFUNC

*- Selecciono Costo Por Año
FUNCTION SEL_ARTCOS_ANO(lcAno)
SELECT M.Periodo, SUM(M.TotIni) As TotIni, SUM(M.TotIng) As TotIng, ;
	              SUM(M.TotSal) As TotSal, SUM(M.TotSld) As TotSld, ;
				  SUM(M.TotIniDol) As TotIniDol, SUM(M.TotIngDol) As TotIngDol, ;
	              SUM(M.TotSalDol) As TotSalDol, SUM(M.TotSldDol) As TotSldDol ;	              
FROM ArtCos M WHERE SUBS(M.Periodo,1,4) = lcAno ;
ORDER BY M.Periodo GROUP BY M.Periodo INTO CURSOR TmpIni
RETURN .t.
ENDFUNC

*- Selecciono Registros en Tmp por Codigo de Articulo
FUNCTION SEL_ArtCos_CodArt_Tmp_Reg(lcCodArt,lcFile)
LOCAL lnReg
SELECT M.* FROM ArtCos M WHERE M.CodArt == lcCodArt INTO CURSOR &lcFile
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*- Selecciono Registros en Tmp por Periodo
FUNCTION SEL_ArtCos_Per_Tmp_Reg(lcPeriodo,lcFile)
LOCAL lnReg
SELECT M.* FROM ArtCos M WHERE M.Periodo == lcPeriodo INTO CURSOR &lcFile
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*------------------------------------------------
*- ARTSLD
*-------------------------------------------------
*- Saldos Por Articulo
FUNCTION SEL_ARTSLD_ART_TmpSld(lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT S.CodArt, S.CodAlm, S.CanArt FROM ArtSld S ;
WHERE S.CodArt == lcCodArt ORDER BY S.CodArt, S.CodAlm INTO CURSOR TmpSld
RETURN .t.
ENDFUNC

*- Saldos por Almacen
FUNCTION SEL_ARTSLD_TmpSld()
SELECT S.CodArt, S.CodAlm, S.CanArt FROM ArtSld S ;
WHERE !EMPTY(S.CodArt) ORDER BY S.CodArt, S.CodAlm INTO CURSOR TmpSld
RETURN .t.
ENDFUNC

*------------------------------------------------
*- ARTSLDMES
*-------------------------------------------------
*- Saldos Por Rango de Periodos y Articulo
FUNCTION SEL_ARTSLDMES_RNGPER_ART(lcPeriodoIni,lcPeriodoFin,lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT S.Periodo, S.CodAlm, S.CodArt, S.CanIng, S.CanSal, S.CanIngCon, S.CanSalCon FROM ArtSldMes S ;
WHERE BETWEEN(S.Periodo,lcPeriodoIni,lcPeriodoFin) AND S.CodArt == lcCodArt ;
ORDER BY S.Periodo, S.CodArt, S.CodAlm INTO CURSOR TmpSldMes
RETURN .t.
ENDFUNC

*- Saldos por Rango de Periodo
FUNCTION SEL_ARTSLDMES_RNGPER(lcPeriodoIni,lcPeriodoFin)
SELECT S.Periodo, S.CodAlm, S.CodArt, S.CanIng, S.CanSal, S.CanIngCon, S.CanSalCon FROM ArtSldMes S ;
WHERE BETWEEN(S.Periodo,lcPeriodoIni,lcPeriodoFin) AND !EMPTY(S.CodArt) ;
ORDER BY S.Periodo, S.CodArt, S.CodAlm INTO CURSOR TmpSldMes
RETURN .t.
ENDFUNC

*- Selecciono Ultimo periodo de Movimiento
FUNCTION SEL_ARTSLDMES_PERULT()
LOCAL lcPeriodo
lcPeriodo = ""
SELECT MAX(M.Periodo) As Periodo FROM ArtSldMes M WHERE !EMPTY(M.CodArt) INTO CURSOR Tmp
IF _TALLY > 0
	lcPeriodo = Tmp.Periodo
ENDIF
RETURN lcPeriodo
ENDFUNC

*- Selecciono Ultimo periodo Inicial Actualizado
FUNCTION SEL_ARTSLDMES_PERINIULT()
LOCAL lcPeriodo
lcPeriodo = ""
SELECT MAX(M.Periodo) As Periodo FROM ArtSldMes M ;
WHERE SUBS(M.periodo,5,2) == "00" AND !EMPTY(M.CodArt) INTO CURSOR Tmp
IF _TALLY > 0
	lcPeriodo = Tmp.Periodo
ENDIF
RETURN lcPeriodo
ENDFUNC

*- Selecciono Saldos Por Año por Articulo
FUNCTION SEL_ARTSLDMES_ANO(lcAno,lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT S.Periodo, S.CodAlm, S.CodArt, S.CanIng, S.CanSal ;
FROM ArtSldMes S WHERE SUBS(S.Periodo,1,4) = lcAno AND S.CodArt == lcCodArt ;
ORDER BY S.CodArt, S.Periodo INTO CURSOR TmpAno
RETURN .t.
ENDFUNC

*- Selecciono Registros del Periodo
FUNCTION SEL_ArtSldMes_PER_REG(lcPeriodo)
LOCAL lnReg
lnReg = 0
SELECT M.Periodo FROM ArtSldMes M WHERE M.Periodo == lcPeriodo INTO CURSOR Tmp
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*- Elimino devulvo cantidad de registro Eliminados
FUNCTION DEL_ArtSldMes_Per_Reg(lcPeriodo)
LOCAL lnReg
lnReg = 0
DELETE FROM ArtSldMes WHERE Periodo == lcPeriodo
lnReg = _TALLY
RETURN lnReg
ENDFUNC

*- Saldo por Periodo
FUNCTION SEL_ARTSLDMES_PER(lcPeriodo)
LOCAL lcPeriodoIni,lcPeriodoAnt,lcPeriodoFin
lcPeriodoIni = CAL_PerIni(lcPeriodo)
lcPeriodoAnt = CAL_PerAnt_INI(lcPeriodo)
IF !SEL_ARTSLDMES_RNGPER(lcPeriodoIni,lcPeriodo)
	RETURN .F.
ENDIF
SELECT S.* FROM TmpSldMes S WHERE .T. ORDER BY S.Periodo, S.CodArt, S.CodAlm INTO CURSOR TmpSld
IF !SEL_ARTSLDMES_PER_TOT(lcPeriodo,lcPeriodoIni,lcPeriodoAnt)
	RETURN .F.
ENDIF
RETURN .t.
ENDFUNC

FUNCTION SEL_ARTSLDMES_PER_TOT(lcPeriodo,lcPeriodoIni,lcPeriodoAnt)
IF !USED("TmpSld")
	RETURN .F.
ENDIF

*- Totalizo
SELECT S.CodArt, S.CodAlm, SUM(S.CanIng - S.CanSal) As CanSld, SUM(S.CanIngCon - S.CanSalCon) As CanSldCon ;
FROM TmpSld S ORDER BY S.CodArt, S.CodAlm GROUP BY S.CodArt, S.CodAlm INTO CURSOR TmpTot

*- Saldo Al Periodo Anterior
SELECT S.CodArt, S.CodAlm, SUM(S.CanIng - S.CanSal) As CanIni, SUM(S.CanIngCon - S.CanSalCon) As CanIniCon ;
FROM TmpSld S WHERE BETWEEN(S.Periodo,lcPeriodoIni,lcPeriodoAnt) ;
ORDER BY S.CodArt, S.CodAlm GROUP BY S.CodArt, S.CodAlm INTO CURSOR TmpAnt

*- Saldo Al Periodo
SELECT S.CodArt, S.CodAlm, SUM(S.CanIng) As CanIng, SUM(S.CanSal) As CanSal, ;
                           SUM(S.CanIngCon) As CanIngCon, SUM(S.CanSalCon) As CanSalCon ;
FROM TmpSld S WHERE S.Periodo == lcPeriodo ;
ORDER BY S.CodArt, S.CodAlm GROUP BY S.CodArt, S.CodAlm INTO CURSOR TmpPer
USE IN TmpSld

*- Relaciono
SELECT S.CodArt, S.CodAlm, S.CanSld As TotSld, ;
       NVL(A.CanIni,000000.000) As TotIni, NVL(B.CanIng,000000.000) As TotIng, NVL(B.CanSal,000000.000) As TotSal, ;
       S.CanSldCon As TotSldCon, ;
       NVL(A.CanIniCon,000000.000) As TotIniCon, NVL(B.CanIngCon,000000.000) As TotIngCon, NVL(B.CanSalCon,000000.000) As TotSalCon ;
FROM TmpTot S LEFT OUTER JOIN TmpAnt A ON S.CodArt == A.CodArt AND S.CodAlm == A.CodAlm ;
			  LEFT OUTER JOIN TmpPer B ON S.CodArt == B.CodArt AND S.CodAlm == B.CodAlm ;
INTO CURSOR Tmp
USE IN TmpTot
USE IN TmpAnt
USE IN TmpPer

*- ORDENO
SELECT A.* FROM Tmp A ORDER BY A.CodArt INTO CURSOR TmpSld
RETURN .t.
ENDFUNC

*--------------------------------------------------
*-  ARTMOVCAB
*----------------------------------------------------------
*- Movimiento por Ranngo de Periodos
FUNCTION SEL_ARTMOVCAB_PER(lcPeriodoIni,lcPeriodoFin)
SELECT C.Periodo, C.FecDoc, C.CodAlm, C.TipMov, C.TipTsc, C.NroSec, C.TipDoc, C.NroDoc, ;
	   C.NroSecRef As SecRef, C.TipDocRef As TipRef, C.NroDocRef As NroRef, ;
	   D.CodArt, D.CodUnd, D.CanArt, D.UndMed, D.CanMed, D.UndCon, D.CanCon, D.FacCon, ;
       IIF(C.TipMov == "I",D.CanMed,000000.000) As CanIng, ;
       IIF(C.TipMov == "S",D.CanMed,000000.000) As CanSal, ;
       IIF(C.TipMov == "I",D.CanCon,000000.000) As CanIngCon, ;
       IIF(C.TipMov == "S",D.CanCon,000000.000) As CanSalCon, ;
       PADR(NVL(E.DesMov,""),30) As DesMov, PADR(NVL(F.DesTsc,""),30) As DesTsc ;
FROM ArtMovCab C INNER JOIN ArtMovDet D ON C.NroSec = D.NroSec AND !EMPTY(D.CodArt) AND !EMPTY(D.CanArt) ;
			     LEFT OUTER JOIN TipMovArt E ON C.TipMov == E.TipMov ;
			     LEFT OUTER JOIN ArtTsc F    ON C.TipMov+C.TipTsc == F.TipMov+F.TipTsc ; 
WHERE BETWEEN(C.Periodo,lcPeriodoIni,lcPeriodoFin) ORDER BY D.CodArt INTO CURSOR TmpMov
RETURN .t.
ENDFUNC

*- Costo Por Periodo
FUNCTION SEL_ARTMOVCAB_Per_COS(lcPeriodo)
SELECT C.Periodo, C.FecDoc, C.CodAlm, C.TipMov, C.TipTsc, ;
       C.NroSec, C.TipDoc, C.NroDoc, C.TipMnd, C.ImpCam, C.PcjIgv, ;
	   C.NroSecRef As SecRef, C.TipDocRef As TipRef, C.NroDocRef As NroRef, ;
       D.NroSecDet, D.NroItmRef, D.CodArt, D.CodUnd, D.CanArt, D.ImpArt, ;
       D.UndMed, D.CanMed, D.ImpMed, D.FacCon, D.IndIgv, D.IndIna ;
FROM ArtMovCab C INNER JOIN ArtMovDet D ON C.NroSec = D.NroSec AND !EMPTY(D.CodArt) ;
WHERE C.Periodo == lcPeriodo ORDER BY D.CodArt INTO CURSOR TmpMov

SELECT M.*, PADR(NVL(C.DesMov,""),30) As DesMov, PADR(NVL(D.DesTsc,""),30) As DesTsc, ;
			NVL(D.IndCosPrm,0) As IndCosPrm, NVL(D.IndCos,0) As IndCos ;
FROM TmpMov M LEFT OUTER JOIN TipMovArt C ON M.TipMov == C.TipMov ;
			  LEFT OUTER JOIN ArtTsc D ON M.TipMov+M.TipTsc == D.TipMov+D.TipTsc ;
ORDER BY M.CodArt,M.TipMov,M.FecDoc INTO CURSOR Tmp
USE IN TmpMov

SELECT M.* FROM Tmp M WHERE M.IndCosPrm == 1 OR M.IndCos == 1 ;
ORDER BY M.CodArt, M.TipMov, M.FecDoc INTO CURSOR TmpMov
USE IN Tmp
RETURN .t.
ENDFUNC

*- Costo por Periodo y Articulo
FUNCTION SEL_ARTMOVCAB_PerArt_COS(lcPeriodo,lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT C.Periodo, C.FecDoc, C.CodAlm, C.TipMov, C.TipTsc, ;
       C.NroSec, C.TipDoc, C.NroDoc, C.TipMnd, C.ImpCam, C.PcjIgv, ;
	   C.NroSecRef As SecRef, C.TipDocRef As TipRef, C.NroDocRef As NroRef, ;
       D.NroSecDet, D.NroItmRef, D.CodArt, D.CodUnd, D.CanArt, D.ImpArt, ;
       D.UndMed, D.CanMed, D.ImpMed, D.FacCon, D.IndIgv, D.IndIna ;
FROM ArtMovCab C INNER JOIN ArtMovDet D ON C.NroSec = D.NroSec AND D.CodArt == lcCodArt ;
WHERE C.Periodo == lcPeriodo ORDER BY D.CodArt INTO CURSOR TmpMov

SELECT M.*, PADR(NVL(C.DesMov,""),30) As DesMov, PADR(NVL(D.DesTsc,""),30) As DesTsc, ;
			NVL(D.IndCosPrm,0) As IndCosPrm, NVL(D.IndCos,0) As IndCos ;
FROM TmpMov M LEFT OUTER JOIN TipMovArt C ON M.TipMov == C.TipMov ;
			  LEFT OUTER JOIN ArtTsc D ON M.TipMov+M.TipTsc == D.TipMov+D.TipTsc ;
ORDER BY M.CodArt,M.TipMov,M.FecDoc INTO CURSOR Tmp
USE IN TmpMov

SELECT M.* FROM Tmp M WHERE M.IndCosPrm == 1 OR M.IndCos == 1 ;
ORDER BY M.CodArt, M.TipMov, M.FecDoc INTO CURSOR TmpMov
USE IN Tmp
RETURN .t.
ENDFUNC

*--------------------------------------------------
*-  ALMACEN
*----------------------------------------------------------
*- Selecciono Almacen
FUNCTION SEL_ArtAlm_Cod()
LOCAL lnReg
lcCodAlm = ""
SELECT M.CodAlm FROM ArtAlm M WHERE !EMPTY(M.CodAlm) INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg == 1
	lcCodAlm = Tmp.CodAlm
ENDIF
USE IN Tmp
RETURN lcCodAlm
ENDFUNC

*- DesAlmacen Almacen
FUNCTION SEL_ArtAlm_Cod_Des(lcCodAlm)
LOCAL lnReg
lcDesAlm = ""
SELECT M.CodAlm, M.DesAlm FROM ArtAlm M WHERE M.CodAlm == lcCodAlm INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg == 1
	lcDesAlm = Tmp.DesAlm
ENDIF
USE IN Tmp
RETURN lcDesAlm
ENDFUNC

*--------------------------------------------------
*-  ARTICULO
*----------------------------------------------------------
*- Selecciono Cuenta del Articulo
FUNCTION Sel_ArtArt_Cod_Cta(lcCodArt,lcCtaVta,lcCtaCpa)
LOCAL lnReg
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.CodArt, M.DesArt, M.CtaVta, M.CtaCpa ;
FROM ArtArt M WHERE M.CodArt == lcCodArt INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcDesArt = Tmp.DesArt
	lcCtaVta = Tmp.CtaVta
	lcCtaCpa = Tmp.CtaCpa
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

*- Descripcion del Articulo
FUNCTION SEL_ArtArt_Cod_Des(lcCodArt,lcDesArt)
LOCAL lnReg
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.CodArt, M.DesArt FROM ArtArt M WHERE M.CodArt == lcCodArt INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX('No se Selecciono Codigo de Articulo en ArtArt',0+64,'Validacion')
	USE IN Tmp
	RETURN .F.
ENDIF
lcDesArt = Tmp.DesArt
USE IN Tmp
RETURN .T.
ENDFUNC

*- Selecciono Descripcion y Und
FUNCTION SEL_ArtArt_Cod_DesUnd(lcCodArt,lcDesArt,lcCodUnd)
LOCAL lnReg
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.CodArt, M.DesArt, M.CodUnd FROM ArtArt M WHERE M.CodArt == lcCodArt INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX('No se Selecciono Codigo de Articulo en ArtArt',0+64,'Validacion')
	USE IN Tmp
	RETURN .F.
ENDIF
lcDesArt = Tmp.DesArt
lcCodUnd = Tmp.CodUnd
USE IN Tmp
RETURN .T.
ENDFUNC

*- Descripcion del Articulo
FUNCTION SEL_ArtArt_Cod_Reg(lcCodArt)
LOCAL lnReg
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.CodArt FROM ArtArt M WHERE M.CodArt == lcCodArt INTO CURSOR Tmp
lnReg = _TALLY
USE IN Tmp
RETURN .T.
ENDFUNC

*- Descripcion del Articulo
FUNCTION SEL_ArtArt_Cod_TipArt(lcCodArt,lcTipArt)
LOCAL lnReg
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.CodArt, M.TipArt FROM ArtArt M WHERE M.CodArt == lcCodArt INTO CURSOR Tmp
lnReg = _TALLY
IF lnReg > 0
	lcTipArt = Tmp.TipArt
ENDIF
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_ArtArt_Cod_CodUnd(lcCodArt,lcCodUnd)
LOCAL lnReg
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.CodArt, M.CodUnd FROM ArtArt M WHERE M.CodArt == lcCodArt INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX('No se Selecciono Codigo de Articulo en ArtArt',0+64,'Validacion')
	USE IN Tmp
	RETURN .F.
ENDIF
lcCodUnd = Tmp.CodUnd
USE IN Tmp
RETURN .T.
ENDFUNC

*--------------------------------------------------
*- STOCK
*------------------------------------------------
*- Saldo por Almacen / articulo
FUNCTION SEL_ArtSld_SLD(lcCodAlm,lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
lcCodAlm = PADR(ALLTRIM(lcCodAlm),03)
STORE 0 TO lnSldArt
SELECT M.CodAlm, M.CodArt, M.CanArt FROM ArtSld M ;
WHERE M.CodAlm+M.CodArt == lcCodAlm+lcCodArt INTO CURSOR Tmp
IF _TALLY > 0
	lnSldArt = Tmp.CanArt 
ENDIF
USE IN Tmp
RETURN lnSldArt
ENDFUNC

*- Selecciono Ultimo periodo procesado
FUNCTION SEL_ARTCOS_PERULT()
LOCAL lcPeriodo
lcPeriodo = ""
SELECT MAX(M.Periodo) As Periodo FROM ArtCos M WHERE !EMPTY(M.CodArt) INTO CURSOR Tmp
IF _TALLY > 0
	lcPeriodo = Tmp.Periodo
ENDIF
RETURN lcPeriodo
ENDFUNC

*- Selecciono Calculo del Costo del Periodo
FUNCTION SEL_ARTCOS_PER_CAL(lcPeriodo)
SELECT M.* FROM ArtCos M WHERE M.Periodo = lcPeriodo ORDER BY M.CodArt INTO CURSOR TmpIni
RETURN .t.
ENDFUNC

*- Selecciono Calculo del Costo del Periodo para el Articulo
FUNCTION SEL_ARTCOS_PerArt_CAL(lcPeriodo,lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
SELECT M.* FROM ArtCos M WHERE M.Periodo = lcPeriodo AND M.CodArt == lcCodArt ORDER BY M.CodArt INTO CURSOR TmpIni
RETURN .t.
ENDFUNC

*- Obtengo Ultimo Precio de Compra
FUNCTION SEL_DOCCAB_RngFec_UPC(ldFecIni,ldFecFin)
LOCAL ldFecAnt
ldFecAnt = ldFecIni - 100

SELECT M.FecDoc, M.TipOpe, M.TipMnd, M.ImpCam, D.CodArt, D.CodUnd, ;
	   IIF(D.IndIna == 1,D.ImpArt,IIF(M.IndIgv == 1,ROUND((D.ImpArt)/((100 + M.PcjIgv)/100),2),D.ImpArt)) As ImpArt ;
FROM DocCab M INNER JOIN DocDet D ON M.NroSec = D.NroSec AND !EMPTY(D.CodArt) ;
WHERE BETWEEN(M.FecDoc,ldFecAnt,ldFecFin) AND M.TipOpe == '2' AND M.IndSig == '+' AND !(M.IndSit == 9) ;
ORDER BY D.CodArt, M.FecDoc ;
INTO CURSOR TmpMov1

SELECT M.CodArt, M.FecDoc, M.CodUnd, ;
       IIF(M.TipMnd == "P",M.ImpArt,ROUND(M.ImpArt*M.ImpCam,4)) As ImpArt ;
FROM TmpMov1 M ORDER BY M.CodArt, M.FecDoc INTO CURSOR TmpMov
USE IN TmpMov1

SELECT M.CodArt, M.FecDoc, M.CodUnd, M.ImpArt FROM TmpMov M ;
ORDER BY M.CodArt GROUP BY M.CodArt INTO CURSOR TmpDoc
USE IN TmpMov

RETURN .T.
ENDFUNC

*-----------------------
* LETRAS
*-------------------------
FUNCTION Ins_LetCab(oCab)
LOCAL lcNroDoc,lnNroSec,lnNroCom
*- Secuencia del Documento
IF oCab.TipOpe == "1"
	lcNroDoc = ""
	lcNroDoc = GenNroDoc(oCab.TipDoc,"000")
	IF EMPTY(lcNroDoc)
		MESSAGEBOX("No se pudo Obter la secuencia del Documento para el Canje",0+64,"Validacion")
		RETURN .F.
	ENDIF
	lcNroDoc = PADR(ALLTRIM(lcNroDoc),20)
ELSE
	lcNroDoc = oCab.NroDoc
ENDIF
*- Verifico Documento
SELECT M.TipOpe, M.TipDoc, M.NroDoc FROM LetCab M ;
WHERE M.TipOpe+M.TipDoc+M.NroDoc == oCab.TipOpe+oCab.TipDoc+lcNroDoc INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Nro de Documento de LETRA ya Registrado",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*- Secuencia del Registro
lnNroSec = 0
lnNroSec = GenNroSec("01","LETCAB")
IF EMPTY(lnNroSec)
	MESSAGEBOX("No se pudo Obter la secuencia del registro para LETCAB",0+64,"Validacion")
	RETURN .F.
ENDIF
*- Verifico Secuencia del Registro
SELECT M.NroSec ;
FROM LetCab M ;
WHERE M.NroSec == lnNroSec ;
INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Nro de secuencia del registro del Documento ya Registrado",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*- Secuencia de Comprobante
lnNroCom = 0
*lnNroCom = GenNroCom(oCab.Periodo,oCab.TipCom)
*IF EMPTY(lnNroCom)
*	MESSAGEBOX("No se pudo Obter la secuencia del Comprobante",0+64,"Validacion")
*	RETURN .F.
*ENDIF
*- Verifico Secuencia de Comprobante
*SELECT M.TipOpe, M.Periodo, M.TipCom, M.NroCom ;
*FROM LetCanCab M ;
*WHERE M.TipOpe+M.Periodo+M.TipCom+STR(M.NroCom,6) == oCab.TipOpe+oCab.Periodo+oCab.TipCom+STR(lnNroCom,6) ;
*INTO CURSOR Tmp
*IF _TALLY > 0
*	MESSAGEBOX("Nro de Comprobante del Documento ya Registrado",0+64,"Validacion")
*	USE IN Tmp
*	RETURN .F.
*ENDIF
*USE IN Tmp
*-
oCab.NroDoc = lcNroDoc
oCab.NroSec = lnNroSec
oCab.NroCom = lnNroCom
oCab.IMPAMO = 0.00
oCab.INDSIT = 1
oCab.FECSIT = DATE()
oCab.USUADD = gCodUsu
oCab.FECADD = DATETIME()
oCab.USUACT = gCodUsu
oCab.FECACT = DATETIME()

*- Actualizo
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	INSERT INTO LetCab (NROSEC,TIPOPE,PERIODO,TIPCOM,NROCOM, ;
			TIPDOC,NRODOC,FECDOC,FECVEN,DIAS,TIPVAL, ;
			TIPAUX,CODAUX,NRORUC,NOMAUX,DIRECCION, ;
			CODPOSTAL,CODCDD,CODPAIS,NROTLF,NROFAX, ;
			TIPMND,TIPCAM,CODMND,SIMBOL,IMPCAM, ;
			IMPORG,IMPSOL,IMPDOL,IMPAMO, ;
			FECACE,CODBCO,TIPUBI,NROUNI, ;
			INDSIT,FECSIT,CODCTA,CENCOS,NROOPE,INDSIG, ;
			USUADD,FECADD,USUACT,FECACT) ;
	VALUES (oCab.NROSEC,oCab.TIPOPE,oCab.PERIODO,oCab.TIPCOM,oCab.NROCOM, ;
			oCab.TIPDOC,oCab.NRODOC,oCab.FECDOC,oCab.FECVEN,oCab.DIAS,oCab.TIPVAL, ;
			oCab.TIPAUX,oCab.CODAUX,oCab.NRORUC,oCab.NOMAUX,oCab.DIRECCION, ;
			oCab.CODPOSTAL,oCab.CODCDD,oCab.CODPAIS,oCab.NROTLF,oCab.NROFAX, ;
			oCab.TIPMND,oCab.TIPCAM,oCab.CODMND,oCab.SIMBOL,oCab.IMPCAM, ;
			oCab.IMPORG,oCab.IMPSOL,oCab.IMPDOL,oCab.IMPAMO, ;
			oCab.FECACE,oCab.CODBCO,oCab.TIPUBI,oCab.NROUNI, ;
			oCab.INDSIT,oCab.FECSIT,oCab.CODCTA,oCab.CENCOS,oCab.NROOPE,oCab.INDSIG, ;
			oCab.USUADD,oCab.FECADD,oCab.USUACT,oCab.FECACT)
	*- Verifica Adicion
	SELECT M.NroSec FROM LetCab M WHERE M.NroSec == oCab.NroSec INTO CURSOR Tmp
	IF _TALLY <> 1
		MESSAGEBOX("Problemas al Adicionar el Registro de LetCab",0+64,"Validacion")
		USE IN Tmp
		ROLLBACK
		ON ERROR	
		RETURN .F.
	ENDIF
	USE IN Tmp
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Actualizo 
FUNCTION Upd_LetCab(oCab)
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	UPDATE LetCab ;
		SET FecDoc = oCab.FecDoc, ;
			FecVen = oCab.FecVen, ;
			Dias = oCab.Dias, ;
		    ImpOrg = oCab.ImpOrg, ;
		    ImpSol = oCab.ImpSol, ;
		    ImpDol = oCab.ImpDol, ;
		    USUACT = gCodUsu, ;
		    FECACT = DATETIME() ;
	WHERE NroSec == oCab.NroSec
	IF _TALLY <> 1
		MESSAGEBOX("PROBLEMAS al ACTUALIZAR el Registro en LetCab",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Elimino
FUNCTION Del_LetCab(oCab)
*- Selecciono
SELECT M.NroSec, M.IndSit, M.IndCon ;
FROM LetCab M ;
WHERE M.NroSec = oCab.NroSec ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Documento No Registrado en LetCab",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.	
ENDIF
SELE Tmp
*- Verifico Situacion
IF Tmp.IndSit <> 1 AND Tmp.IndSit <> 9
	MESSAGEBOX("Documento No se Encuentra Pendiente o Anulado",0+48,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
*- Verifico Contabilizacion
IF Tmp.IndCon == 1
	MESSAGEBOX("Documento Ya Fue Contabilizado",0+48,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*-
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	DELETE FROM LetCab WHERE NroSec == oCab.NroSec
	IF _TALLY <> 1
		MESSAGEBOX("PROBLEMAS al ELIMINAR el Registro en LetCab",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*-----------------------
* CANJE DE LETRAS
*-------------------------
FUNCTION Ins_LetCanCab(oCab)
LOCAL lcNroDoc,lnNroSec,lnNroCom
*- Secuencia del Documento
lcNroDoc = ""
lcNroDoc = GenNroDoc(oCab.TipDoc,"000")
IF EMPTY(lcNroDoc)
	MESSAGEBOX("No se pudo Obter la secuencia del Documento para el Canje",0+64,"Validacion")
	RETURN .F.
ENDIF
lcNroDoc = PADR(ALLTRIM(lcNroDoc),20)
*- Verifico Documento
SELECT M.TipOpe, M.TipDoc, M.NroDoc FROM LetCanCab M ;
WHERE M.TipOpe+M.TipDoc+M.NroDoc == oCab.TipOpe+oCab.TipDoc+lcNroDoc INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Nro de Documento de Canje ya Registrado",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*- Secuencia del Registro
lnNroSec = 0
lnNroSec = GenNroSec("01","LETCANCAB")
IF EMPTY(lnNroSec)
	MESSAGEBOX("No se pudo Obter la secuencia del registro para LETCANCAB",0+64,"Validacion")
	RETURN .F.
ENDIF
*- Verifico Secuencia del Registro
SELECT M.NroSec ;
FROM LetCanCab M ;
WHERE M.NroSec == lnNroSec ;
INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Nro de secuencia del registro del Documento ya Registrado",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*- Secuencia de Comprobante
lnNroCom = 0
lnNroCom = GenNroCom(oCab.Periodo,oCab.TipCom)
IF EMPTY(lnNroCom)
	MESSAGEBOX("No se pudo Obter la secuencia del Comprobante",0+64,"Validacion")
	RETURN .F.
ENDIF
*- Verifico Secuencia de Comprobante
SELECT M.TipOpe, M.Periodo, M.TipCom, M.NroCom ;
FROM LetCanCab M ;
WHERE M.TipOpe+M.Periodo+M.TipCom+STR(M.NroCom,6) == oCab.TipOpe+oCab.Periodo+oCab.TipCom+STR(lnNroCom,6) ;
INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Nro de Comprobante del Documento ya Registrado",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*-
oCab.NroDoc = lcNroDoc
oCab.NroSec = lnNroSec
oCab.NroCom = lnNroCom
oCab.USUADD = gCodUsu
oCab.FECADD = DATETIME()
oCab.USUACT = gCodUsu
oCab.FECACT = DATETIME()

*- Actualizo
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	INSERT INTO LetCanCab (NROSEC,TIPOPE,PERIODO,TIPCOM,NROCOM, ;
			TIPDOC,NRODOC,FECDOC, ;
			TIPAUX,CODAUX,NRORUC,NOMAUX,CONPGO, ;
			TIPMND,TIPCAM,CODMND,simbol,IMPCAM,TOTDEB,TOTHAB, ;
			INDERR,INDSIT,FECSIT,INDCON,FECCON, ;
			USUADD,FECADD,USUACT,FECACT) ;
	VALUES (oCab.NROSEC,oCab.TIPOPE,oCab.PERIODO,oCab.TIPCOM,oCab.NROCOM, ;
			oCab.TIPDOC,oCab.NRODOC,oCab.FECDOC, ;
			oCab.TIPAUX,oCab.CODAUX,oCab.NRORUC,oCab.NOMAUX,oCab.CONPGO, ;
			oCab.TIPMND,oCab.TIPCAM,oCab.CODMND,oCab.simbol,oCab.IMPCAM,oCab.TOTDEB,oCab.TOTHAB, ;
			oCab.INDERR,oCab.INDSIT,oCab.FECSIT,oCab.INDCON,oCab.FECCON, ;
			oCab.USUADD,oCab.FECADD,oCab.USUACT,oCab.FECACT)
	*- Verifica Adicion
	SELECT M.NroSec FROM LetCanCab M WHERE M.NroSec == oCab.NroSec INTO CURSOR Tmp
	IF _TALLY <> 1
		MESSAGEBOX("Problemas al Adicionar el Registro de LetCanCab",0+64,"Validacion")
		USE IN Tmp
		ROLLBACK
		ON ERROR	
		RETURN .F.
	ENDIF
	USE IN Tmp
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Actualizo 
FUNCTION Upd_LetCanCab(oCab)
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	UPDATE LetCanCab ;
		SET FecDoc = oCab.FecDoc, ;
		    TOTDEB = oCab.TOTDEB, ;
		    TOTHAB = oCab.TOTHAB, ;
		    USUACT = gCodUsu, ;
		    FECACT = DATETIME() ;
	WHERE NroSec == oCab.NroSec
	IF _TALLY <> 1
		MESSAGEBOX("PROBLEMAS al ACTUALIZAR el Registro en LetCanCab",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Elimino
FUNCTION Del_LetCanCab(oCab)
*- Selecciono
SELECT M.NroSec, M.IndSit, M.IndCon ;
FROM LetCanCab M ;
WHERE M.NroSec = oCab.NroSec ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Documento No Registrado en LetCanCab",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.	
ENDIF
SELE Tmp
*- Verifico Situacion
IF Tmp.IndSit <> 1 AND Tmp.IndSit <> 9
	MESSAGEBOX("Documento No se Encuentra Pendiente o Anulado",0+48,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
*- Verifico Contabilizacion
IF Tmp.IndCon == 1
	MESSAGEBOX("Documento Ya Fue Contabilizado",0+48,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*-
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	DELETE FROM LetCanCab WHERE NroSec == oCab.NroSec
	IF _TALLY <> 1
		MESSAGEBOX("PROBLEMAS al ELIMINAR el Registro en LetCanCab",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- DETALLE DEL CANJE DE LETRAS
FUNCTION Ins_Let_LetCanDet(oCab,oLet)
LOCAL lnImpDoc,lcIndMov,lnImpDeb,lnImpHab
lnImpDoc = oLet.ImpOrg
oLet.ImpAmo = oLet.ImpOrg
oLet.ImpDol = IIF(oLet.TipMnd == "U",lnImpDoc,IIF(oCab.ImpCam > 0,ROUND(lnImpDoc/oCab.ImpCam,2),0.00))
oLet.ImpSol = IIF(oLet.TipMnd == "U",ROUND(lnImpDoc*oCab.ImpCam,2),lnImpDoc)
oLet.ImpOrg = IIF(oCab.TipMnd == "U",oLet.ImpDol,oLet.ImpSol)
lcIndMov = IIF(oCab.TipOpe == "1",IIF(oLet.IndSig == "-","2","1"),IIF(oLet.IndSig == "-","1","2"))
lnImpDeb = IIF(lcIndMov == "1",oLet.ImpOrg,0.00)
lnImpHab = IIF(lcIndMov == "2",oLet.ImpOrg,0.00)
*- Adicino Letra en Detalle de Canje
BEGIN TRANSACTION
ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	INSERT INTO LetCanDet (NROSEC, IndMov, ;
		   	NROSECDOC, TIPDOC, NRODOC, FECDOC, FECVEN, ;
		   	TIPAUX, CODAUX, TIPMND, TIPCAM, CODMND, SIMBOL, ;
	   	   	ImpDoc, IMPSLD, IMPAMO, IMPORG, IMPSOL, IMPDOL, ;
	   	   	IMPDEB, IMPHAB, INDSIG, CODCTA, CENCOS, NROOPE, ;
			USUADD,FECADD,USUACT,FECACT) ;
	VALUES (oCab.NROSEC, lcIndMov, ;
			oLet.NroSec, oLet.TIPDOC, oLet.NRODOC, oLet.FECDOC, oLet.FECVEN, ;
		   	oLet.TIPAUX, oLet.CODAUX, oLet.TIPMND, oLet.TIPCAM, oLet.CODMND, oLet.SIMBOL, ;
	   	   	lnImpDoc, lnImpDoc, lnImpDoc, oLet.IMPORG, oLet.IMPSOL, oLet.IMPDOL, ;
	   	   	lnIMPDEB, lnIMPHAB, oLet.INDSIG, oLet.CODCTA, oLet.CENCOS, oLet.NROOPE, ;
	   	   	gCodUsu,DATETIME(),gCodUsu,DATETIME())
	*- Verifico Adicion
	SELECT M.NroSec, M.TipDoc, M.NroSecDoc ;
	FROM LetCanDet M ;
	WHERE M.NroSec == oCab.NroSec AND M.TipDoc == oLet.TIPDOC AND M.NroSecDoc == oLet.NROSEC ;
	INTO CURSOR Tmp
	IF _TALLY <> 1
		MESSAGEBOX("Problemas al Actualizar : "+oLet.TipDoc+" "+oLet.NroDoc,0+64,"Validacion")
		USE IN Tmp
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	USE IN Tmp
	
	*- Actualizo Totales
*	lnTotDeb = oCab.TotDeb + Tmp.TotDeb
*	lnTotHab = oCab.TotHab + Tmp.TotHab
	
*	UPDATE LetCanCab ;
*	SET TotDeb = lnTotDeb, ;
*		TotHab = lnTotHab, ;
*		IndErr = IIF(lnTotDeb <> lnTotHab,1,0), ;
*		UsuAct = gCodUsu, ;
*		FecAct = DATETIME() ;
*	WHERE NroSec == oCab.NroSec
*	IF _TALLY <> 1
*		MESSAGEBOX("Problemas al Actualizar el Registro de LetCanCab",0+64,"Validacion")
*		ROLLBACK
*		ON ERROR
*		RETURN .F.
*	ENDIF
	
*	oCab.TotDeb = lnTotDeb
*	oCab.TotHab = lnTotHab
*	oCab.IndErr = IIF(lnTotDeb <> lnTotHab,1,0)
	
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- RECALCULO 
FUNCTION Rec_LetCan(oCab)
LOCAL lnTotDeb,lnTotHab,lnCanDet,lcIndMov
STORE 0.00 TO lnTotDeb,lnTotHab,lnCanDet
*-
SELECT M.* FROM LetCanDet M WHERE M.NroSec == oCab.NroSec INTO CURSOR Tmp
lnCanDet = _TALLY
USE IN Tmp
*-
BEGIN TRANSACTION
ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	*- Actualizo Importes en detalle de canje
	UPDATE LetCanDet ;
	SET ImpDol = IIF(TipMnd == "U",ImpAmo,IIF(oCab.ImpCam > 0,ROUND(ImpAmo/oCab.ImpCam,2),0.00)), ;
		ImpSol = IIF(TipMnd == "U",ROUND(ImpAmo*oCab.ImpCam,2),ImpAmo), ;
		ImpOrg = IIF(oCab.TipMnd == "U",ImpDol,ImpSol), ;
		IndMov = IIF(TIPDOC == "LT", ;
		   		 IIF(oCab.TipOpe == "1",IIF(IndSig == "-","2","1"),IIF(IndSig == "-","1","2")), ;
		   		 IIF(oCab.TipOpe == "1",IIF(IndSig == "-","1","2"),IIF(IndSig == "-","2","1"))), ;
		ImpDeb = IIF(IndMov == "1",ImpOrg,0.00), ;
		ImpHab = IIF(IndMov == "2",ImpOrg,0.00) ;
	WHERE NroSec == oCab.NroSec
	IF _TALLY <> lnCanDet
		MESSAGEBOX("Problemas al Actualizar Registros de LetCanDet",0+64,"Validacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	
	*- Selecciono
	SELECT M.* FROM LetCanDet M WHERE M.NroSec == oCab.NroSec INTO CURSOR TmpMov
	
	*- Totalizo
	SELECT SUM(M.IMPDEB) As TotDeb, SUM(M.IMPHAB) As TotHab ;
	FROM TmpMov M ;
	INTO CURSOR Tmp
	IF _TALLY > 0
		lnTotDeb = Tmp.TotDeb
		lnTotHab = Tmp.TotHab
	ENDIF
	USE IN Tmp

	*- Actualizo Totales
	UPDATE LetCanCab ;
	SET TotDeb = lnTotDeb, ;
		TotHab = lnTotHab, ;
		IndErr = IIF(lnTotDeb <> lnTotHab,1,0), ;
		UsuAct = gCodUsu, ;
		FecAct = DATETIME() ;
	WHERE NroSec == oCab.NroSec
	IF _TALLY <> 1
		MESSAGEBOX("Problemas al Actualizar el Registro de LetCanCab",0+64,"Validacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	
	oCab.TotDeb = lnTotDeb
	oCab.TotHab = lnTotHab
	oCab.IndErr = IIF(lnTotDeb <> lnTotHab,1,0)
	
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Selecciono Datos del Tipo de Documento
FUNCTION Sel_Let_LetOpeDoc(oLet)
SELECT M.TipOpe, M.TipDoc, M.TipCom, M.CodCta, M.IndSig ;
FROM LetOpeDoc M ;
WHERE M.TipOpe+M.TipDoc == oLet.TipOpe+oLet.TipDoc ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX('No se Encontro Documento por Tipo de Operacion',0+64,'Validacion')
	USE IN Tmp
   	RETURN .F.
ENDIF
SELE Tmp
IF EMPTY(Tmp.TipCom)
	MESSAGEBOX("No se Tiene Tipo de Comprobante Asociado al Tipo de Docuemnto",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
oLet.TipCom = Tmp.TipCom
oLet.CodCta = Tmp.CodCta
oLet.IndSig = IIF(EMPTY(Tmp.IndSig),"+",Tmp.IndSig)
USE IN Tmp
RETURN  .T.
ENDFUNC

*- Selecciono Letra
FUNCTION Sel_LetCab(lnNroSec)
SELECT M.* ;
FROM LetCab M ;
WHERE M.NroSec == lnNroSec ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Registro No Ubicado",0+48,"Validacion")
ENDIF
SELE Tmp
SCATTER NAME oLet
USE IN Tmp
RETURN oLet
ENDFUNC

*- Selecciono Cabecera de Canje
FUNCTION Sel_LetCanCab(lnNroSec)
SELECT M.* ;
FROM LetCanCab M ;
WHERE M.NroSec == lnNroSec ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Registro No Ubicado",0+48,"Validacion")
ENDIF
SELE Tmp
SCATTER NAME oCab
USE IN Tmp
RETURN oCab
ENDFUNC

*- Detalle de Hoja de Ruta
FUNCTION Ins_PzaDet(lnNroHoj,lnNroHojRut,oDet)
BEGIN TRANSACTION
LOCAL lnNroSecHoj
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	*- Actualizo Secuencia del Detalle de HR	
	UPDATE HojRut ;
		SET NroSecHoj = NroSecHoj + 1, ;
			CanPza = CanPza + 1 ;
	WHERE STR(NroHoj,6) == STR(lnNroHoj,6)
	IF _TALLY <> 1
		DO WHILE MESSAGEBOX('PROBLEMAS AL ACTUALIZAR HojRut',4+64+256,'Actualizacion') = 7
		ENDDO
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	lnNroSecHoj = 0
	SELECT M.NroHoj, M.NroSecHoj FROM HojRut M WHERE STR(NroHoj,6) == STR(lnNroHoj,6) INTO CURSOR Tmp
	IF _TALLY <> 1
		DO WHILE MESSAGEBOX('PROBLEMAS AL SELECCIONAR la HR',4+64+256,'Seleccion') = 7
		ENDDO
		USE IN Tmp
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	lnNroSecHoj = Tmp.NroSecHoj
	oDet.NroSecHoj = lnNroSecHoj
	USE IN Tmp
	
	*- Adiciono Detalle
	INSERT INTO PzaDet (NROHOJ,NROSECHOJ,FECHOJ,CODCLI,NRORCC,NROSECRCC, ;
			NROMAN,NROREF,TIPSER,CODMSJ,CODIMP,FECDES, ;
			INDSIT,FECSIT,OBSERVACIO,CODUSU,FECSIS) ;
	VALUES (lnNROHOJ,lnNROSECHOJ,oDet.FECHOJ,oDet.CODCLI,oDet.NRORCC,oDet.NROSECRCC, ;
			oDet.NROMAN,oDet.NROREF,oDet.TIPSER,oDet.CODMSJ,oDet.CODIMP,oDet.FECDES, ;
			oDet.INDSIT,oDet.FECSIT,oDet.OBSERVACIO,gCodUsu,DATETIME())
	*- Verifico INSERT
	SELECT M.NroHoj, M.NroMan FROM PzaDet M ;
	WHERE STR(M.NroHoj,6)+M.NroMan == STR(lnNroHoj,6)+oDet.NROMAN INTO CURSOR Tmp
	IF _TALLY <> 1
		DO WHILE MESSAGEBOX('PROBLEMAS AL ADICIONAR DETALLE',4+64+256,'Insert') = 7
		ENDDO
		USE IN Tmp
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	USE IN Tmp
	
	*- Actualizo Pieza
	UPDATE PzaCab ;
		SET NroHojRut = lnNroHojRut, ;
			IndEst = "2", ;
			FecEst = oDet.FECHOJ ;
	WHERE CodCli+NroMan == oDet.CodCli+oDet.NroMan
	IF _TALLY <> 1
		DO WHILE MESSAGEBOX('PROBLEMAS AL ACTUALIZAR PzaCab',4+64+256,'Actualizacion') = 7
		ENDDO
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Eliminio Detalle de Hoja de Ruta
FUNCTION Del_PzaDet(lnNroHoj,lcCodCli,lcNroMan)
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	*- Actualizar Pieza
	UPDATE PzaCab ;
		SET NroHojRut = 0, ;
			IndEst = "1", ;
			FecEst = DATETIME() ;
	WHERE CodCli+NroMan == lcCodCli+lcNroMan
	IF _TALLY <> 1
		DO WHILE MESSAGEBOX('PROBLEMAS AL ACTUALIZAR la Pieza en PzaCab',4+64+256,'Actualizacion') = 7
		ENDDO
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF	
	*- Elimina Detalle
	DELETE FROM PzaDet WHERE STR(NroHoj,6)+NroMan = STR(lnNroHoj,6)+lcNroMan
	IF _TALLY <> 1
		DO WHILE MESSAGEBOX('PROBLEMAS AL ELIMINAR PzaDet',4+64+256,'Eliminacion') = 7
		ENDDO
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Error
PROCEDURE Err_Actualiza
PARAMETER merror, mess, mess1, mprog, mlineno
CLEAR
*- Mensaje
MESSAGEBOX('Número de error: ' + LTRIM(STR(merror)) + CHR(13) + ;
		   'Mensaje de error: ' + mess + CHR(13) + ;
		   'Línea de código con error: ' + mess1 + CHR(13) + ;
		   'Número de línea del error: ' + LTRIM(STR(mlineno)) + CHR(13) + ;
		   'Programa con error: ' + mprog + CHR(13), 0+64, "Error")
*- Anular
ROLLBACK
ON ERROR
CANCEL
RETURN .F.

*-------------------------------------------------------
*-- CLIENTE
*---------------------------------------------------
*- Adiciono Cliente
FUNCTION Ins_TabCli(oCli)
LOCAL lnNroSec,lcCodCli
*- Obtengo Nro de Secuencia 
lnNroSec = 0
lnNroSec = GenNroSec("01","60")
IF EMPTY(lnNroSec)
	MESSAGEBOX('No se GENERO SECUENCIA del Codigo del CLIENTE',0+64,'Validacion')
    RETURN .F.
ENDIF
IF lnNroSec > 9998
	MESSAGEBOX('Codigo del CLIENTE ES : '+ALLTRIM(STR(lnNroSec)),0+64,'Validacion')
    RETURN .F.
ENDIF
lcCodCli = PADL(ALLTRIM(STR(lnNroSec)),4,"0")
*- Verifico si Ya Existe Codigo del Cliente
SELECT M.CodCli FROM TabCli M WHERE M.CodCli == lcCodCli INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Codigo de Cliente : "+lcCodCli+" Ya Registrado",0,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
oCli.CodCli = lcCodCli

BEGIN TRANSACTION
	ON ERROR DO Err_TabCli WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	INSERT INTO TabCli (CODCLI,NOMCLI,DIRECCION,CODPOSTAL,NROTLF,NROFAX,NOMREP, ;
			CODUSU,FECSIS,NRORUC,PASSWORD) ;
	VALUES (oCli.CODCLI,oCli.NOMCLI,oCli.DIRECCION,oCli.CODPOSTAL,oCli.NROTLF,oCli.NROFAX,oCli.NOMREP, ;
			gCODUSU,DATETIME(),oCli.NRORUC,oCli.PASSWORD)
	SELECT M.CodCli FROM TabCli M WHERE M.CodCli == oCli.CODCLI INTO CURSOR Tmp
	IF _TALLY <> 1
   		MESSAGEBOX("PROBLEMAS AL ADICIONAR CLIENTE EN TABCLI",0,"Validacion")
   		USE IN Tmp
   		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	USE IN Tmp
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Actualizo Cliente
FUNCTION Upd_TabCli(oCli)
BEGIN TRANSACTION
	ON ERROR DO Err_TabCli WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	UPDATE TabCli ;
		SET NOMCLI = oCli.NOMCLI, ;
			DIRECCION = oCli.DIRECCION, ;
			CODPOSTAL = oCli.CODPOSTAL, ;
			NROTLF = oCli.NROTLF, ;
			NROFAX = oCli.NROFAX, ;
			NOMREP = oCli.NOMREP, ;
			CODUSU = gCodUsu, ;
			FECSIS = DATETIME(), ;
			NRORUC = oCli.NRORUC, ;
			PASSWORD = oCli.PASSWORD ;
	WHERE CodCli == oCli.CodCli
	IF _TALLY <> 1
		MESSAGEBOX("PROBLEAS AL ACTUALIZAR CLIENTE EN TabCli",0+64,"Validacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Elimino Cliente
FUNCTION Del_TabCli(lccodcli)
*-
IF lccodcli == "9999"
	MESSAGEBOX("Cliente 9999 No se puede Eliminar",0+64,"Validacion")
	RETURN .F.
ENDIF
*- Verifico Registro
SELEC M.* FROM TabCli M WHERE M.CodCli == lccodcli INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Cliente No Registrado",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*- Verifica si Cliente Tiene Movimiento
SELECT M.CodCli FROM PzaCab M WHERE M.CodCli == lccodcli INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Cliente Tiene Movimientos",0+64,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
USE IN Tmp
*-
BEGIN TRANSACTION
	ON ERROR DO Err_TabCli WITH ;
				ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	DELETE FROM TabCli WHERE codcli == lccodcli
	IF _TALLY <> 1
		MESSAGEBOX("PROBLEMAS al ELIMINAR CLIENTE EN TabCli",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Error
PROCEDURE Err_TabCli
PARAMETER merror, mess, mess1, mprog, mlineno
CLEAR
*- Mensaje
MESSAGEBOX('Número de error: ' + LTRIM(STR(merror)) + CHR(13) + ;
		   'Mensaje de error: ' + mess + CHR(13) + ;
		   'Línea de código con error: ' + mess1 + CHR(13) + ;
		   'Número de línea del error: ' + LTRIM(STR(mlineno)) + CHR(13) + ;
		   'Programa con error: ' + mprog + CHR(13), 0+64, "Error")
*- Anular
ROLLBACK
ON ERROR
CANCEL
RETURN .F.

*------------------------------------------
*- VERIFICACION DE CARGO
*---------------------------------------------
*- Verifico si YA Existe en Nro de Recepcion
FUNCTION Ver_NroSecRcc(lcCodCli,lnNroRcc,lnNroSecRcc)
SELECT M.CodCli+STR(M.NroRcc,6)+STR(M.NroSecRcc,5) As Nro ;
FROM PzaCab M ;
WHERE M.CodCli+STR(M.NroRcc,6)+STR(M.NroSecRcc,5) == lcCodCli+STR(lnNroRcc,6)+STR(lnNroSecRcc,5) ;
INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Nro de Secuencia de Recepcion ya Registrado para el Cliente",0+48,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
RETURN .T.
ENDFUNC

*-----------------------------------
*  SELECCIOIN DE CARGO
*---------------------------------------
*- Selecciono Datos de la pieza por NroMan
FUNCTION Sel_Pza_NroMan(lcNroMan)
SELECT M.* ;
FROM PzaCab M ;
WHERE M.NroMan == lcNroMan ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Nro de Cargo No Registrado",0+48,"Validacion")
ENDIF
SELE Tmp
SCATTER NAME oSel
USE IN Tmp
RETURN oSel
ENDFUNC

FUNCTION Sel_Pza_NroMan_1(lcNroMan,oSel)
SELECT M.* ;
FROM PzaCab M ;
WHERE M.NroMan == lcNroMan ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Nro de Cargo No Registrado",0+48,"Validacion")
	USE IN Tmp
	RETURN .F.
ENDIF
SELE Tmp
SCATTER NAME oSel
USE IN Tmp
RETURN .T.
ENDFUNC

*- Selecciono Datos de la piza por Cliente y NroRcc
FUNCTION Sel_Pza_Cli_NroMan(lcCodCli,lcNroMan)
SELECT M.* ;
FROM PzaCab M ;
WHERE M.CodCli+M.NroMan == lcCodCli+lcNroMan ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Nro de Cargo No Registrado para el Cliente",0+48,"Validacion")
ENDIF
SELE Tmp
SCATTER NAME oSel
USE IN Tmp
RETURN oSel
ENDFUNC

*--------------------------------------------------------------
* TABLAS
*--------------------------------------------------------------------
FUNCTION Ins_Tabla(lcTabla,lcColCod,lcColDes,lcTabRef,lcCodigo,lcDescripcion)
LOCAL lcWhere
IF EMPTY(lcCodigo)
	MESSAGEBOX("Ingrese Codigo",0+64,"Validacion")
	RETURN .f.
ENDIF
IF EMPTY(lcDescripcion)
	MESSAGEBOX("Ingrese Descripcion",0+64,"Validacion")
	RETURN .f.
ENDIF

*- Verifico si ya Existe Descripcion
lcWhere = ALLTRIM(lcColDes) + " == '" + ALLTRIM(lcDescripcion) + "'"
SELECT &lcColDes FROM &lcTabla WHERE &lcWhere INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Descripcion ya Registrada",0+64,"Validacion")
	USE IN Tmp
	RETURN .f.
ENDIF

*- Verifico si ya Existe el Codigo
lcWhere = lcColCod + " == '" + lcCodigo + "'"
SELECT &lcColCod FROM &lcTabla WHERE &lcWhere INTO CURSOR Tmp
IF _TALLY > 0
	MESSAGEBOX("Codigo ya Registrado",0+64,"Validacion")
	USE IN Tmp
	RETURN .f.
ENDIF

BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	INSERT INTO &lcTabla (&lcColCod,&lcColDes) VALUES(lcCodigo,lcDescripcion)
	*- Verifica Adicion
	SELECT &lcColCod FROM &lcTabla WHERE &lcWhere INTO CURSOR Tmp
	IF !(_TALLY == 1)
		MESSAGEBOX("Problemas al Adicionar",0+64,"Validacion")
		USE IN Tmp
		ROLLBACK
		ON ERROR	
		RETURN .F.
	ENDIF
	USE IN Tmp
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Actualizo 
FUNCTION Upd_Tabla(lcTabla,lcColCod,lcColDes,lcTabRef,lcCodigo,lcDescripcion)
LOCAL lcWhere,lcSet

*- Verifico Descripcion
lcWhere = ALLTRIM(lcColDes) + " == '" + ALLTRIM(lcDescripcion) + "'"
SELECT &lcColCod FROM &lcTabla WHERE &lcWhere INTO CURSOR Tmp
IF _TALLY > 0
	SELE Tmp
	IF !(&lcColCod == lcCodigo)
		MESSAGEBOX("Descripcion Ya Registrada",0+64,"Validacion")
		USE IN Tmp
		RETURN .F.
	ENDIF
ENDIF
USE IN Tmp
*-
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	*- Selecciono 
	lcWhere = lcColCod + " == '" + lcCodigo + "'"
	SELECT * FROM &lcTabla WHERE &lcWhere INTO CURSOR Tmp
	IF _TALLY < 1
		MESSAGEBOX("No Registrado en Tabla",0+64,"Validacion")
		USE IN Tmp
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	USE IN Tmp
	
	lcSet = lcColDes + " = '" + lcDescripcion + "'"
	UPDATE &lcTabla SET &lcSet WHERE &lcWhere
	IF !(_TALLY == 1)
		MESSAGEBOX("PROBLEMAS al ACTUALIZAR el Registro en Tabla",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Elimino
FUNCTION Del_Tabla(lcTabla,lcColCod,lcColDes,lcTabRef,lcCodigo,lcDescripcion)
LOCAL lcWhere

*- Verifico si tiene Referencia
IF !EMPTY(lcTabRef)
	lcWhere = lcColCod + " == '" + lcCodigo + "'"
	SELECT &lcColCod FROM &lcTabRef WHERE &lcWhere INTO CURSOR Tmp
	IF _TALLY > 0
		MESSAGEBOX("No se puede Eliminar Tiene Referencias en "+lcTabRef,0+64,"Validacion")
		USE IN Tmp
		RETURN .F.
	ENDIF
	USE IN Tmp
ENDIF

lcWhere = lcColCod + " == '" + lcCodigo + "'"
BEGIN TRANSACTION
	ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
	
	lcWhere = lcColCod + " == '" + lcCodigo + "'"
	SELECT &lcColCod FROM &lcTabla WHERE &lcWhere INTO CURSOR Tmp
	IF _TALLY < 1
		MESSAGEBOX("No Registrado en Tabla",0+64,"Validacion")
		USE IN Tmp
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	USE IN Tmp

	DELETE FROM &lcTabla WHERE &lcWhere
	IF !(_TALLY == 1)
		MESSAGEBOX("PROBLEMAS al ELIMINAR el Registro en Tabla",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

*- Actualizo 
FUNCTION UPD_TABLA_REF(lcTabla,lcColCod,lcCodigo,lcTabRef,lcRefCod,lcCodRef)
LOCAL lcWhere,lcSet
ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
BEGIN TRANSACTION
	lcWhere = lcColCod + " == '" + lcCodigo + "'"
	SELECT * FROM &lcTabla WHERE &lcWhere INTO CURSOR Tmp
	IF _TALLY < 1
		MESSAGEBOX("No Registrado en Tabla",0+64,"Validacion")
		USE IN Tmp
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	USE IN Tmp
	
	lcSet = lcRefCod + " = '" + lcCodRef + "'"
	UPDATE &lcTabla SET &lcSet WHERE &lcWhere
	IF !(_TALLY == 1)
		MESSAGEBOX("PROBLEMAS al ACTUALIZAR el Registro en Tabla",0+64,"Actualizacion")
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC


*- Selecciono Tabla
FUNCTION Sel_obj_Tabla(lcCodigo)
SELECT M.* FROM Tabla M WHERE M.Codigo == lcCodigo INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX("Registro No Ubicado",0+48,"Validacion")
ENDIF
SELE Tmp
SCATTER NAME oTab
USE IN Tmp
RETURN oTab
ENDFUNC

FUNCTION Sel_Tmp_Tabla(lcCodigo)
LOCAL llRetorno
llRetorno = .T.
SELECT M.* FROM Tabla M WHERE M.Codigo == lcCodigo INTO CURSOR Tmp
IF _TALLY < 1
	llRetorno = .F.
ENDIF
RETURN llRetorno
ENDFUNC



*----------------------------------
*- ACCESOS
*------------------------------------
FUNCTION Act_TabAcc(lcCodUsu,lcFile)
*- Relaciono con Accesos de Usuario
SELECT M.CodApl, M.CodOpc, M.IndSel, IIF( NVL(D.CodUsu,"****") == "****",0,1) AS IndOpc ;
FROM &lcFile M LEFT OUTER JOIN TabAcc D ON lcCodUsu+M.CodApl+M.CodOpc == D.CodUsu+D.CodApl+D.CodOpc ;
INTO CURSOR TmpOpc

BEGIN TRANSACTION
ON ERROR DO Err_TabAcc WITH ;
	ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
SELE TmpOpc
GO TOP
SCAN WHILE !EOF()
	IF IndSel <> IndOpc
		IF IndSel == 1 
			*- Selecciono
			SELECT M.CodUsu, M.CodApl, M.CodOpc FROM TabAcc M ;
			WHERE M.CodUsu+M.CodApl+M.CodOpc == lcCodUsu+TmpOpc.CodApl+TmpOpc.CodOpc ;
			INTO CURSOR Tmp
			IF _TALLY > 0
				USE IN Tmp
				SELE TmpOpc
				LOOP
			ENDIF
			*- Adiciono 
			INSERT INTO TabAcc (CodUsu,CodApl,CodOpc) ;
				VALUES(lcCodUsu,TmpOpc.CodApl,TmpOpc.CodOpc)
			*- Verifico	
			SELECT M.CodUsu, M.CodApl, M.CodOpc FROM TabAcc M ;
			WHERE M.CodUsu+M.CodApl+M.CodOpc == lcCodUsu+TmpOpc.CodApl+TmpOpc.CodOpc ;
			INTO CURSOR Tmp
			IF _TALLY <> 1
				MESSAGEBOX("PROBLEMAS AL ADICIONAR REGISTRO EN TabAcc",0+64,"Adicionar")
				USE IN Tmp
				USE IN TmpOpc
				ROLLBACK
				ON ERROR
				RETURN .F.
			ENDIF
		ELSE
			*- Selecciono
			SELECT M.CodUsu, M.CodApl, M.CodOpc FROM TabAcc M ;
			WHERE M.CodUsu+M.CodApl+M.CodOpc == lcCodUsu+TmpOpc.CodApl+TmpOpc.CodOpc ;
			INTO CURSOR Tmp
			IF _TALLY < 1
				USE IN Tmp
				SELE TmpOpc
				LOOP
			ENDIF
			*- Elimino			
			DELETE FROM TabAcc WHERE CodUsu+CodApl+CodOpc == lcCodUsu+TmpOpc.CodApl+TmpOpc.CodOpc
			*- Verifico
			IF _TALLY < 1
				MESSAGEBOX("PROBLEMAS AL ELIMINAR REGISTRO EN TabAcc",0+64,"Eliminar")
				USE IN TmpOpc
				ROLLBACK
				ON ERROR
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
	SELE TmpOpc
ENDSCAN
END TRANSACTION
USE IN TmpOpc
ON ERROR
RETURN .T.
ENDFUNC

*- Error
PROCEDURE Err_TabAcc
PARAMETER merror, mess, mess1, mprog, mlineno
CLEAR
*- Mensaje
MESSAGEBOX('Número de error: ' + LTRIM(STR(merror)) + CHR(13) + ;
		   'Mensaje de error: ' + mess + CHR(13) + ;
		   'Línea de código con error: ' + mess1 + CHR(13) + ;
		   'Número de línea del error: ' + LTRIM(STR(mlineno)) + CHR(13) + ;
		   'Programa con error: ' + mprog + CHR(13), 0+64, "Error")
*- Anular
ROLLBACK
ON ERROR
CANCEL
RETURN .F.

*----------------------------------------------
*- CREAR ARCHIVO TEMPORAL
*----------------------------------------------
*- Archivo Temporal
FUNCTION USE_FILE_TMP(lcAlias,lcFile)
IF !USED("Tmp")
	RETURN .F.
ENDIF
lcFile = "TmpSel"+gcodusu+SUBS(SYS(2015),3,10)
SELE Tmp
COPY STRUCTURE TO &gRutTemp\&lcFile
USE IN Tmp
USE &gRutTemp\&lcFile IN 0 ALIAS &lcAlias EXCLUSIVE
lcFile = gRutTemp+"\"+lcFile+".DBF"
RETURN  .T.
ENDFUNC

FUNCTION CREA_FILE_TMP(lcNomFile,lcAlias)
LOCAL lcFile,lcFileTmp
STORE "" TO lcFile,lcFileTmp
lcFile = FUN_FILE_NOMBRE()
SELE * FROM &lcNomFile WHERE NroSec == 0 INTO CURSOR Tmp
SELE Tmp
COPY STRUCTURE TO &lcFile
USE IN Tmp
IF USED("&lcAlias")
	USE IN &lcAlias
ENDIF
USE &lcFile IN 0 ALIAS &lcAlias EXCLUSIVE
lcFileTmp = lcFile+".DBF"
RETURN lcFileTmp
ENDFUNC
*-
FUNCTION Fun_SALIDA(lcMsg,llRet,llRollBack,llError)
IF !EMPTY(ALLTRIM(lcMsg))
	MESSAGEBOX(lcMsg,0+64,"Actualizacion")
ENDIF
IF llRollBack
	ROLLBACK
ENDIF
IF llError
	ON ERROR
ENDIF
RETURN llRet
ENDFUNC

*- Genera Archivo Temporal
FUNCTION GEN_FILE_TMP_(lcAlias,lcFile,lcFileUse,lcFunSel)
LOCAL lnReg
STORE 0 TO lnReg
lcFile = UPPER(ALLTRIM(lcFile))
lnReg = &lcFunSel
IF lnReg < 0
	RETURN .F.
ENDIF
IF !USED("TmpMov")
	MESSAGEBOX("No se pudo crear Archivo Temporal de "+lcFile,0+64,"Validacion")
	RETURN .F.
ENDIF
IF !USE_FILE_TMPMOV("TmpMov",lcAlias,@lcFileUse)
	MESSAGEBOX("No se pudo Abrir Archivo Temporal de "+lcAlias,0+64,"Validacion")
	RETURN .F.
ENDIF
RETURN .T.
ENDFUNC


FUNCTION USE_FILE_TMPMOV(lcFileTmp,lcAlias,lcFile)
IF !USED("&lcFileTmp")
	RETURN .F.
ENDIF
lcFile = FUN_FILE_NOMBRE()
SELE &lcFileTmp
COPY STRUCTURE TO &lcFile
USE IN &lcFileTmp
IF USED("&lcAlias")
	*- Preguntar si desea cerrar Alias
	USE IN &lcAlias
ENDIF
USE &lcFile IN 0 ALIAS &lcAlias EXCLUSIVE
lcFile = lcFile+".DBF"
RETURN .T.
ENDFUNC

FUNCTION FUN_FILE_NOMBRE()
lcFile = "Tmp"+gcodusu+SUBS(SYS(2015),3,10)
lcFile = gRutTemp+"\"+lcFile
RETURN lcFile
ENDFUNC

FUNCTION FUN_FILE_NOMBRE_EXT(lcRutTemp,lcExt)
LOCAL lcFile
IF EMPTY(lcRutTemp) OR ISNULL(lcRutTemp)
	lcRutTemp = gRutTemp
ENDIF
IF EMPTY(lcExt) OR ISNULL(lcExt)
	lcExt = ""
ENDIF
lcFile = "Tmp"+gcodusu+SUBS(SYS(2015),3,10)
lcFile = lcRutTemp+"\"+lcFile
IF !EMPTY(lcExt)
	lcFile = lcFile + "." + lcExt
ENDIF
RETURN lcFile
ENDFUNC

*- Actualizo Temporal
FUNCTION ACT_FILE_TMP(lcFileTmp,lcFile,lnAdi)
SELE &lcFileTmp
SCATTER NAME oMov
SELE &lcFile
IF lnAdi == 1
	APPEND BLANK
ENDIF
GATHER NAME oMov
RELEASE oMov
USE IN &lcFileTmp
RETURN .T.
ENDFUNC

*- Actualizo Temporal
FUNCTION ADI_FILE_TMP(lcFileTmp,lcFile)
SELE &lcFileTmp
GO TOP
SCAN WHILE !EOF()
	SELE &lcFileTmp
	SCATTER NAME oMov
	SELE &lcFile
	APPEND BLANK
	GATHER NAME oMov
	RELEASE oMov
	SELE &lcFileTmp
ENDSCAN
USE IN &lcFileTmp
RETURN .T.
ENDFUNC

FUNCTION ABR_Tmp(lcFile,lcAlias)
IF EMPTY(lcFile) OR ISNULL(lcFile)
	MESSAGEBOX("No se tiene Nombre de Archivo Temporal",0+64,"Validacion")
	RETURN .F.
ENDIF
IF !FILE("&lcFile")
	MESSAGEBOX("No Existe Archivo Temporal",0+64,"Validacion")
	RETURN .F.
ENDIF
USE &lcFile IN 0 ALIAS &lcAlias EXCLUSIVE
IF !USED("&lcAlias")
	MESSAGEBOX("No se pudo Abrir Archivo Temporal",0+64,"Validacion")
	RETURN .F.
ENDIF
RETURN .T.
ENDFUNC

FUNCTION ABR_Tmp_USO(lcAlias)
IF EMPTY(lcAlias) OR ISNULL(lcAlias)
	MESSAGEBOX("No se tiene Nombre de Archivo Temporal",0+64,"Validacion")
	RETURN .F.
ENDIF
IF !USED("&lcAlias")
	MESSAGEBOX("No se tiene Abierto Archivo Temporal",0+64,"Validacion")
	RETURN .F.
ENDIF
RETURN .T.
ENDFUNC

FUNCTION FUN_POS_CAMPO_FILE(lcFile,lcCampo)
LOCAL lnPos,lnCampos
STORE 0 TO lnPos,lnCampos
IF !ABR_Tmp_USO(lcFile)
	RETURN .F.
ENDIF
SELE &lcFile
lnCampos = AFIELDS(laCampos)
lnPos = FUN_POS_CAMPO(lnCampos,lcCampo)
RELEASE ALL LIKE laCampos
IF lnPos = 0
	RETURN .F.
ENDIF
RETURN .T.
ENDFUNC

FUNCTION FUN_POS_CAMPO(lnCampos,lcCampo)
LOCAL lnPos,I
STORE 0 TO lnPos,I
FOR I = 1 TO lnCampos
	IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER(lcCampo)
		lnPos = I
		EXIT
	ENDIF
ENDFOR
RETURN lnPos
ENDFUNC

*------------------------------------------------------
*- FECHAS
*---------------------------------------------------------
*Calculo el primer día del mes
FUNCTION PrimerDiaMes(ldFecha)
LOCAL ldPrimerDia
ldPrimerDia = ldFecha - day(ldFecha) + 1
RETURN ldPrimerDia

*Calculo el último día del mes
FUNCTION UltimoDiaMes(ldFecha)
LOCAL ldUltimoDia
ldUltimoDia = gomonth(ldFecha - DAY(ldFecha) + 1, 1 ) - 1
RETURN ldUltimoDia

* Calculo los días de un mes
FUNCTION DiasDelMes(ldFecha)
LOCAL ld,lnDiasMes
ld = GOMONTH(ldFecha,1)
lnDiasMes = DAY(ld - DAY(ld))
RETURN lnDiasMes
ENDFUNC

******************************

*- Selecciono Maximo Nivel de Cuenta
FUNCTION Sel_Cuentas_MaxNiv()
LOCAL lnIndNiv
lnIndNiv = 0
SELECT MAX(M.IndNiv) As IndNiv FROM Cuentas M WHERE .t. INTO CURSOR Tmp
IF _TALLY > 0
	lnIndNiv = Tmp.IndNiv
ENDIF
USE IN Tmp
RETURN lnIndNiv
ENDFUNC

*- Formato de Cuenta
FUNCTION Fun_Cuentas_Form(lcCodCta)
LOCAL lnLen
lnLen = Sel_Cuentas_Len()
lcCodCta = PADR(ALLTRIM(lcCodCta),lnLen)
RETURN lcCodCta
ENDFUNC

*- Selecciono Longitud de Cuenta
FUNCTION Sel_Cuentas_Len()
LOCAL lnLen
lnLen = 0
SELECT M.CodCta FROM Cuentas M WHERE EMPTY(M.CodCta) INTO CURSOR Tmp
SELE Tmp
lnLen = LEN(CodCta)
USE IN Tmp
RETURN lnLen
ENDFUNC

*- Formato de Cuenta MovDet
FUNCTION Fun_Cuentas_Form_MovDet(lcCodCta)
LOCAL lnLen
lnLen = Sel_Cuentas_Len_MovDet()
lcCodCta = PADR(ALLTRIM(lcCodCta),lnLen)
RETURN lcCodCta
ENDFUNC

*- Selecciono Longitud de Cuenta
FUNCTION Sel_Cuentas_Len_MovDet()
LOCAL lnLen
lnLen = 0
SELECT M.CodCta FROM MovDet M WHERE M.NroSec == 0 INTO CURSOR Tmp
SELE Tmp
lnLen = LEN(CodCta)
USE IN Tmp
RETURN lnLen
ENDFUNC

*- Formato de Cuenta Saldos
FUNCTION Fun_Cuentas_Form_Saldos(lcCodCta)
LOCAL lnLen
lnLen = Sel_Cuentas_Len_Saldos()
lcCodCta = PADR(ALLTRIM(lcCodCta),lnLen)
RETURN lcCodCta
ENDFUNC

FUNCTION Sel_Cuentas_Len_Saldos()
LOCAL lnLen
lnLen = 0
SELECT M.CodCta FROM Saldos M WHERE M.CodCta == "" INTO CURSOR Tmp
SELE Tmp
lnLen = LEN(CodCta)
USE IN Tmp
RETURN lnLen
ENDFUNC

FUNCTION SEL_DocCab_Sec_Tmp_Reg(lnNroSec,lcFileTmp)
SELECT * FROM DocCab WHERE NroSec == lnNroSec INTO CURSOR (lcFileTmp)
RETURN _TALLY
ENDFUNC

FUNCTION SEL_DocCab_OpePer_Tmp_Reg_(lcTipOpe,lcPeriodo,lcFileTmp)
SELECT * FROM DocCab WHERE TipOpe == lcTipOpe AND Periodo == lcPeriodo INTO CURSOR (lcFileTmp)
RETURN _TALLY 
ENDFUNC

FUNCTION ReduceMemory()
  DECLARE INTEGER SetProcessWorkingSetSize ;
    IN kernel32 AS SetProcessWorkingSetSize ;
    INTEGER hProcess , ;
    INTEGER dwMinimumWorkingSetSize , ;
    INTEGER dwMaximumWorkingSetSize
  DECLARE INTEGER GetCurrentProcess ;
    IN kernel32 AS GetCurrentProcess
  nProc = GetCurrentProcess()
  bb = SetProcessWorkingSetSize(nProc,-1,-1)
ENDFUNC

FUNCTION FunSitCot(lnIndSit)
LOCAL lcDesSit
lcDesSit = ""
DO CASE
	CASE lnIndSit == 1
		lcDesSit = "Pendiente"
	CASE lnIndSit == 4
		lcDesSit = "Aceptada"
	CASE lnIndSit == 6
		lcDesSit = "Rechazada"
	CASE lnIndSit == 9 
		lcDesSit = "Anulada"
ENDCASE
RETURN lcDesSit
ENDFUNC

**********************
FUNCTION EXP_Tmp_XLS(lcFileExp,lcNomExp)
lcNomExp = IIF(EMPTY(lcNomExp) OR ISNULL(lcNomExp),"",lcNomExp)
LOCAL lcRuta
lcRuta = PUTFILE("Archivo a Exportar", lcNomExp, "XLS")
lcRuta = ALLTRIM(lcRuta)
IF EMPTY(lcRuta)
	MESSAGEBOX("No se Exporto Informacion",0+64,"Exportacion a Excel")
ELSE
	SELE (lcFileExp)
	COPY TO (lcRuta) TYPE XL5
	MESSAGEBOX('Proceso de Exportacion Termino Correctamente',0+64,"Exportacion a Excel")
ENDIF
RETURN .T.
ENDFUNC

FUNCTION VER_EXP_Tmp_(lcFileExp,lcMsj,lcNomExp)
lcNomExp = IIF(EMPTY(lcNomExp) OR ISNULL(lcNomExp),"",lcNomExp)
DO FORM &gRuta\forms\frmMov_Ver_Tmp with lcFileExp,lcMsj,lcNomExp
RETURN
ENDFUNC

FUNCTION EXP_Tmp_XLS_(lcFileExp,lcNomExp)
lcNomExp = IIF(EMPTY(lcNomExp) OR ISNULL(lcNomExp),"",lcNomExp)
LOCAL lcRuta,lcFile,lnInt,lnMod,lnIni,lnFin,I,lnPos,lnReg
STORE "" TO lcRuta,lcFile
STORE 0 TO lnInt,lnMod,lnIni,lnFin,I,lnPos,lnReg
lcRuta = PUTFILE("Archivo a Exportar", lcNomExp, "XLS")
lcRuta = ALLTRIM(lcRuta)
IF EMPTY(lcRuta)
	MESSAGEBOX("No se Exporto Informacion",0+64,"Exportacion a Excel")
ELSE
	SELECT RECNO() AS Nro, * FROM (lcFileExp) INTO CURSOR TmpWrk
	IF _TALLY > 15000
		lnInt = INT(_TALLY / 15000)
		lnMod = MOD(_TALLY,15000)
		STORE 0 TO lnIni,lnFin
		lnPos = AT(".",lcRuta)
		lcRuta = SUBS(lcRuta,1,(lnPos - 1))
		FOR I = 1 TO lnInt
			lnReg = lnReg + 1
			lcFile = lcRuta + "_" + ALLTRIM(STR(lnReg))
			lnIni = lnFin + 1 
			lnFin = lnFin + 15000
			SELECT * FROM TmpWrk WHERE BETWEE(Nro,lnIni,lnFin) INTO CURSOR Tmp
			SELE Tmp
			COPY TO (lcFile) TYPE XL5
			USE IN Tmp
		ENDFOR
		IF lnMod > 0
			lnReg = lnReg + 1 
			lcFile = lcRuta + "_" + ALLTRIM(STR(lnReg))
			SELECT * FROM TmpWrk WHERE Nro > lnFin INTO CURSOR Tmp
			SELE Tmp
			COPY TO (lcFile) TYPE XL5
			USE IN Tmp
		ENDIF
	ELSE
		SELE (lcFileExp)
		COPY TO (lcRuta) TYPE XL5
	ENDIF
	USE IN TmpWrk
	MESSAGEBOX('Proceso de Exportacion Termino Correctamente',0+64,"Exportacion a Excel")
ENDIF
RETURN .T.
ENDFUNC

*- ALINES
FUNCTION FUN_ALINES(aFilas,lcTexto,lcChr)
LOCAL lcLinea,I,lnPos
STORE 0 TO I,lnPos
lcTexto = ALLTRIM(lcTexto)
DO WHILE .T.
	IF EMPTY(lcTexto)
		EXIT
	ENDIF
	lnPos = AT(lcChr,lcTexto)
	lcLinea = IIF(lnPos > 0,SUBS(lcTexto,1,lnPos),lcTexto)
	lcTexto = IIF(lnPos > 0,SUBS(lcTexto,(lnPos + 1)),"") 
	I = I + 1
	DIMENSION aFilas(I)
	aFilas[I] = lcLinea
ENDDO
RETURN I

FUNCTION Limpia_Texto_Chr(lcTexto)
lcTexto = CHRTRAN(ALLTRIM(lcTexto),CHR(09),"")
lcTexto = CHRTRAN(ALLTRIM(lcTexto),CHR(10),"")
lcTexto = CHRTRAN(ALLTRIM(lcTexto),CHR(12),"")
lcTexto = CHRTRAN(ALLTRIM(lcTexto),CHR(13),"")
lcTexto = CHRTRAN(ALLTRIM(lcTexto),CHR(160),"")
RETURN lcTexto
ENDFUNC

********************************

FUNCTION SEL_TabAux_Tip_Tmp_Reg(lcTipAux,lcFileTmp)
SELECT * FROM TabAux WHERE TipAux == lcTipAux INTO CURSOR (lcFileTmp)
RETURN _TALLY
ENDFUNC

FUNCTION SEL_TabAux_TipCod_Tmp_Reg(lcTipAux,lcCodAux,lcFileTmp)
lcTipAux = PADR(ALLTRIM(lcTipAux),02)
lcCodAux = PADR(ALLTRIM(lcCodAux),04)
SELECT * FROM TabAux WHERE TipAux == lcTipAux AND CodAux == lcCodAux INTO CURSOR (lcFileTmp)
RETURN _TALLY
ENDFUNC

FUNCTION SEL_TabAux_TipCod_Reg(lcTipAux,lcCodAux)
LOCAL lnReg
lcTipAux = PADR(ALLTRIM(lcTipAux),02)
lcCodAux = PADR(ALLTRIM(lcCodAux),04)
SELECT M.TipAux, M.CodAux FROM TabAux M WHERE M.TipAux+M.CodAux == lcTipAux+lcCodAux INTO CURSOR Tmp
lnReg = _TALLY
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION DEL_TABAUX(lcTipAux,lcCodAux)
LOCAL llSigue,lnReg
STORE 0 TO lnReg
STORE .F. TO llSigue
IF lcCodAux == "0000"
	MESSAGEBOX("No se Puede Eliminar",0+64,"Validacion")
	RETURN .F.
ENDIF
lnReg = SEL_DocCab_Aux_Reg(lcTipAux,lcCodAux)
IF lnReg > 0
	MESSAGEBOX("No se Puede Eliminar Tine Movimientos",0+64,"Validacion")
	RETURN .F.
ENDIF
ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
BEGIN TRANSACTION
llSigue = DEL_TabAux_TipCod(lcTipAux,lcCodAux)
IF !llSigue
	ROLLBACK
ELSE
	END TRANSACTION
ENDIF
ON ERROR
RETURN llSigue
ENDFUNC

FUNCTION DEL_TabAux_TipCod(lcTipAux,lcCodAux)
LOCAL lnRegSel,lnRegDel
STORE 0 TO lnRegSel,lnRegDel
lnRegSel = SEL_TabAux_TipCod_Reg(lcTipAux,lcCodAux)
IF lnRegSel > 0
	lnRegDel = DEL_TabAux_TipCod_Reg(lcTipAux,lcCodAux)
	IF !(lnRegSel == lnRegDel)
		MESSAGEBOX("PROBLEMAS al ELIMINAR el Registro en TabAux",0+64,"Actualizacion")
		RETURN .F.
	ENDIF
ENDIF
RETURN .T.
ENDFUNC

FUNCTION DEL_TabAux_TipCod_Reg(lcTipAux,lcCodAux)
DELETE FROM TabAux WHERE TipAux+CodAux = lcTipAux+lcCodAux
RETURN _TALLY
ENDFUNC

FUNCTION DEL_TABAUX_ACT(lcTIPAUX,lcCODAUX)
LOCAL lnReg,lnRegEli
ON ERROR DO Err_Actualiza WITH ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
BEGIN TRANSACTION
	IF !DEL_TABAUX(lcTIPAUX,lcCODAUX)
		ROLLBACK
		ON ERROR
		RETURN .F.
	ENDIF
	lnReg = SEL_AuxAct_TipCod_Reg(lcTipAux,lcCodAux)
	IF lnReg > 0
		lnRegEli = DEL_AuxAct_TipCod_Reg(lcTIPAUX,lcCODAUX)
		IF !(lnReg == lnRegEli)
			MESSAGEBOX("PROBLEMAS al ELIMINAR en AuxAct",0+64,"Actualizacion")
			ROLLBACK
			ON ERROR
			RETURN .F.
		ENDIF
	ENDIF		
END TRANSACTION
UNLOCK ALL
ON ERROR
RETURN  .T.
ENDFUNC

FUNCTION DEL_AuxAct_TipCod(lcTipAux,lcCodAux)
lcTipAux = PADR(ALLTRIM(lcTipAux),02)
lcCodAux = PADR(ALLTRIM(lcCodAux),04)
DELETE FROM AuxAct WHERE TipAux+CodAux = lcTipAux+lcCodAux
IF !(_TALLY == 1)
	MESSAGEBOX("PROBLEMAS al ELIMINAR el Registro en TabAux",0+64,"Actualizacion")
	RETURN .F.
ENDIF
RETURN .T.
ENDFUNC

FUNCTION DEL_AuxAct_TipCod_Reg(lcTipAux,lcCodAux)
LOCAL lnReg
DELETE FROM AuxAct WHERE TipAux+CodAux = lcTipAux+lcCodAux
lnReg = _TALLY
RETURN lnReg
ENDFUNC

FUNCTION SEL_AuxAct_TipCod_Reg(lcTipAux,lcCodAux)
LOCAL lnReg
lcTipAux = PADR(ALLTRIM(lcTipAux),02)
lcCodAux = PADR(ALLTRIM(lcCodAux),04)
SELECT TipAux, CodAux FROM AuxAct WHERE TipAux+CodAux == lcTipAux+lcCodAux INTO CURSOR Tmp
lnReg = _TALLY
USE IN Tmp
RETURN lnReg
ENDFUNC

FUNCTION SEL_DocCab_Aux_Reg(lcTipAux,lcCodAux)
LOCAL lnReg
lcTipAux = PADR(ALLTRIM(lcTipAux),02)
lcCodAux = PADR(ALLTRIM(lcCodAux),04)
SELECT M.TipAux, M.CodAux FROM DocCab M WHERE M.TipAux+M.CodAux == lcTipAux+lcCodAux INTO CURSOR Tmp
lnReg = _TALLY
USE IN Tmp
RETURN lnReg
ENDFUNC

*******************************
*- Indicador de Saldo Almacen
FUNCTION SEL_TabPar_IndSldAlm()
LOCAL lnIndSldAlm
lnIndSldAlm = 0
SELECT M.IndSldAlm FROM TabPar M INTO CURSOR Tmp
IF _TALLY > 0
	lnIndSldAlm = Tmp.IndSldAlm
ENDIF
USE IN Tmp
RETURN lnIndSldAlm
ENDFUNC

FUNCTION FUN_Valida_IndSldAlm()
LOCAL llReturn,lnIndSldAlm
llReturn = .F.
lnIndSldAlm = SEL_TabPar_IndSldAlm()
DO CASE
	CASE  lnIndSldAlm = 1  && * Continua
		llReturn = .T.
	CASE  lnIndSldAlm = 2  && *- Muestra Mensaje
		MESSAGEBOX("Articulo No tiene Saldos",0,"Validacion")
		llReturn = .T.
	CASE  lnIndSldAlm = 3  && *- Preguntar
		IF MESSAGEBOX('Articulo No tiene Saldos .... Desea Continuar',4+32+256,'Validacion') = 6
			llReturn = .T.
		ENDIF
	CASE  lnIndSldAlm = 4   && *- No Continuar	
		MESSAGEBOX("Articulo No tiene Saldos",0,"Validacion")
		llReturn = .F.
ENDCASE
RETURN llReturn
ENDFUNC

*- Saldo por Almacen / articulo
FUNCTION SEL_ArtSld_SLD(lcCodAlm,lcCodArt)
lcCodArt = PADR(ALLTRIM(lcCodArt),20)
lcCodAlm = PADR(ALLTRIM(lcCodAlm),03)
LOCAL lnSldArt
STORE 0 TO lnSldArt
SELECT CodAlm, CodArt, CanArt FROM ArtSld WHERE CodAlm+CodArt == lcCodAlm+lcCodArt INTO CURSOR Tmp
IF _TALLY > 0
	lnSldArt = Tmp.CanArt 
ENDIF
USE IN Tmp
RETURN lnSldArt
ENDFUNC
