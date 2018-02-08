LOCAL lcMainClassLib, lcMainProcedure
LOCAL lcLastSetTalk,lcLastSetPath,lcLastSetClassLib,lcOnShutdown

*-- Save and configure environment.
lcLastSetTalk=SET("TALK")
SET TALK OFF
lcLastSetPath=SET("PATH")
PUBLIC gRuta, gRutDat, gRutCon, gRutTemp
gRuta   = "\VOLTA\Almacen"
gRutDat = "\VOLTA\APLIDAT"
gRutTemp= "\VOLTA\Almacen\Temp"
gRutCon = "\VOLTA\APLICON"
CD &gRuta
SET PATH TO ;&gRutDat;INCLUDE;FORMS;GRAPHICS;HELP;LIBS;MENUS;PROGS;REPORTS
lcMainProcedure=gRuta+"\Progs\ApliLib.fxp"
SET PROCEDURE TO (lcMainProcedure) ADDITIVE
PUSH MENU _msysmenu
lcLastSetClassLib=SET("CLASSLIB")
lcMainClassLib=gRuta+"\libs\ApliAdmi"
SET CLASSLIB TO (lcMainClassLib) ADDITIVE
lcOnShutdown="ShutDown()"
ON SHUTDOWN &lcOnShutdown
ON ERROR ErrorHandler(ERROR(),PROGRAM(),LINENO())
_shell="DO Cleanup IN &gRuta\progs\Almacen"

*-- Instantiate application object.
RELEASE goApp
PUBLIC goApp,gNomApp,gCodApl,gCodUsu,gNomUsu,gCodEmp,gNomEmp,gRutEmp,gDBConta,gDatos,gNomFrm

goApp=CREATEOBJECT("cApplication")
gNomApp = "Almacen"
gCodApl = "ALMACEN"
gNomUsu = SPACE(01)

*-- Configure application object.
goApp.SetCaption(gNomApp)
goApp.cStartupMenu=gRuta+"\menus\MenuAlma"
*goApp.cStartupForm="Forms\frmConxxx"

goApp.ReleaseToolBars()
_Screen.WindowState = 2

*-- Pide Password
OPEN DATABASE &gRutDat\COMUN.DBC SHARED
lPasswordOk = .F.
DO FORM &gRuta\FORMS\frmPassword TO lPasswordOk
IF lPasswordOk
	lPasswordOk = .F.
	*DO FORM &gRuta\FORMS\frmEmpresas TO lPasswordOk
	*IF lPasswordOk
	*	goApp.Show
	*ENDIF
	CgaDatEmp("001","VOLTA CENTER E.I.R.L.")
	goApp.Show
ENDIF

*-- Release application.
RELEASE goApp

*-- Restore default menu.
POP MENU _msysmenu

*-- Restore environment.
ON ERROR
ON SHUTDOWN
IF NOT lcLastSetClassLib==SET("classlib")
	RELEASE CLASSLIB (lcMainClassLib)
ENDIF
IF EMPTY(lcLastSetPath)
	SET PATH TO
ELSE
	SET PATH TO &lcLastSetPath
ENDIF
IF lcLastSetTalk=="ON"
	SET TALK ON
ELSE
	SET TALK OFF
ENDIF
*QUIT
RETURN

FUNCTION ErrorHandler(nError,cMethod,nLine)
LOCAL lcErrorMsg,lcCodeLineMsg
WAIT CLEAR
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)
lcErrorMsg=lcErrorMsg+"Method:    "+cMethod
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,10000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:         "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
IF MESSAGEBOX(lcErrorMsg,17,_screen.Caption)#1
	ON ERROR
	RETURN .F.
ENDIF
ENDFUNC

FUNCTION ShutDown
IF TYPE("goApp")=="O" AND NOT ISNULL(goApp)
	RETURN goApp.OnShutDown()
ENDIF
Cleanup()
*QUIT
ENDFUNC

FUNCTION Cleanup
IF CNTBAR("_msysmenu")=7
	RETURN
ENDIF
ON ERROR
ON SHUTDOWN
SET CLASSLIB TO
SET PATH TO
CLEAR ALL
CLOSE ALL
POP MENU _msysmenu
RETURN