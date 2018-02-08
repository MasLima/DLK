FUNCTION ActualizaSaldosAlmacen(pTipo)
LOCAL lnOldSele
lnOldSele = SELECT()

*- Verifica Cabecera de Guia
IF !SEEK(GuiDet.NroSec,"GuiCab","NroSec")
	MESSAGEBOX("ERROR FATAL Guia No Tiene Cabecera",0+48,"Validacion")
	SELE (lnOldSele)
	RETURN .F.
ENDIF

*- Actualizas Saldos del Mes
SELE SldMes
SET ORDER TO CodAlm
SEEK GuiCab.CodAlm+GuiDet.CodArt+GuiCab.Periodo
IF EOF()
	IF GuiCab.TipMov == "2" OR pTipo = "-"
		MESSAGEBOX("ERROR FATAL Articulo No Tiene Saldos",0+48,"Validacion")
		SELE (lnOldSele)
		RETURN .F.
	ENDIF
	APPEND BLANK
	REPLACE CodAlm  WITH GuiCab.CodAlm, ;
			CodArt  WITH GuiDet.CodArt, ;
			Periodo WITH GuiCab.Periodo
			
ENDIF
IF GuiCab.TipMov == "1"
	REPLACE CanIng WITH CanIng + IIF(pTipo == "+",GuiDet.CanArt,-1*GuiDet.CanArt)
ELSE
	REPLACE CanSal WITH CanSal + IIF(pTipo == "+",GuiDet.CanArt,-1*GuiDet.CanArt)
ENDIF

*- Actualiza Saldo Actual
SELE SldAct
SET ORDER TO CodAlm
SEEK GuiCab.CodAlm+GuiDet.CodArt
IF EOF()
	IF GuiCab.TipMov == "2" OR pTipo = "-"
		MESSAGEBOX("ERROR FATAL Articulo No Tiene Saldos",0+48,"Validacion")
		SELE (lnOldSele)
		RETURN .F.
	ENDIF
	APPEND BLANK
	REPLACE CodAlm  WITH GuiCab.CodAlm, ;
			CodArt  WITH GuiDet.CodArt
ENDIF
IF GuiCab.TipMov == "1"
	REPLACE SldAct WITH SldAct + IIF(pTipo == "+",GuiDet.CanArt,-1*GuiDet.CanArt)
ELSE
	REPLACE SldAct WITH SldAct - IIF(pTipo == "+",GuiDet.CanArt,-1*GuiDet.CanArt)
ENDIF

*- Actualiza Costo Promedio
*IF SEEK(GuiCab.TipMov+GuiCab.TipTsc,"TabTsc","TipTsc")
*IF TabTsc.IndCosPrm = 1
IF GuiCab.IndCosPrm = 1
	IF TTOD(GuiCab.FecDoc) >= FecCos
		REPLACE SldAct.FecCos WITH TTOD(GuiCab.FecDoc), ;
				SldAct.ImpCos WITH GuiDet.ImpCos
	ENDIF
ENDIF

SELE (lnOldSele)
RETURN .T.
ENDFUNC

FUNCTION ModificaSaldosAlmacen()
LOCAL lnOldSele

IF OLDVAL("CanArt","GuiDet") == GuiDet.CanArt
	RETURN
ENDIF
lnOldSele = SELECT()

*- Verifica Cabecera de Guia
IF !SEEK(GuiDet.NroSec,"GuiCab","NroSec")
	MESSAGEBOX("ERROR FATAL Guia No Tiene Cabecera",0+48,"Validacion")
	SELE (lnOldSele)
	RETURN .F.
ENDIF

*- Actualizas Saldos del Mes
SELE SldMes
SET ORDER TO CodAlm
SEEK GuiCab.CodAlm+GuiDet.CodArt+GuiCab.Periodo
IF EOF()
	MESSAGEBOX("ERROR FATAL Articulo No Tiene Saldos",0+48,"Validacion")
	SELE (lnOldSele)
	RETURN .F.
ENDIF
IF GuiCab.TipMov == "1"
	REPLACE CanIng WITH CanIng - OLDVAL("CanArt","GuiDet") + GuiDet.CanArt
ELSE
	REPLACE CanSal WITH CanSal - OLDVAL("CanArt","GuiDet") + GuiDet.CanArt
ENDIF

*- Actualiza Saldo Actual
SELE SldAct
SET ORDER TO CodAlm
SEEK GuiCab.CodAlm+GuiDet.CodArt
IF EOF()
	MESSAGEBOX("ERROR FATAL Articulo No Tiene Saldos",0+48,"Validacion")
	SELE (lnOldSele)
	RETURN .F.
ENDIF
IF GuiCab.TipMov == "1"
	REPLACE SldAct WITH SldAct - OLDVAL("CanArt","GuiDet") + GuiDet.CanArt
ELSE
	REPLACE SldAct WITH SldAct + OLDVAL("CanArt","GuiDet") - GuiDet.CanArt
ENDIF

*- Actualiza Costo Promedio
*IF SEEK(GuiCab.TipMov+GuiCab.TipTsc,"TabTsc","TipTsc")
*IF TabTsc.IndCosPrm = 1
IF GuiCab.IndCosPrm = 1
	IF TTOD(GuiCab.FecDoc) >= FecCos
		REPLACE SldAct.FecCos WITH TTOD(GuiCab.FecDoc), ;
				SldAct.ImpCos WITH GuiDet.ImpCos
	ENDIF
ENDIF

SELE (lnOldSele)
RETURN .T.
ENDFUNC