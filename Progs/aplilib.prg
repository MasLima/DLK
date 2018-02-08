FUNCTION CgaDatEmp(lcCodEmp,lcNomEmp)
SET EXCLUSIVE OFF
SET DELETE ON
SET MULTILOCKS ON
SET CENTURY ON
SET DATE TO DMY
SET HOURS TO 24
SET SAFETY OFF
SET ESCAPE OFF
SET COMPATIBLE OFF

gCodEmp = lcCodEmp
gNomEmp = lcNomEmp
gRutEmp = gRutDat+"\DAT"+gCodEmp
gDBConta = gRutEmp+"\Conta.DBC"
gDatos = gRutEmp+"\Conta.DBC"
IF !FILE("&gDBConta")
	MESSAGEBOX("No se Tiene la Base de datos",0+64,"Validacion")
	FunAborta(lcNomEmp)
	RETURN
ENDIF
goApp.SetCaption(gNomApp+"   Empresa : "+gNomEmp+"   Usuario : "+gNomUsu)
IF DBUSED("Conta")
	SET DATABASE TO Conta
	CLOSE DATABASE
ENDIF

SET PATH TO &gRutDat;&gRutEmp;INCLUDE;FORMS;GRAPHICS;HELP;LIBS;MENUS;PROGS;REPORTS
OPEN DATABASE &gDBConta SHARED

lnOldSele = SELECT()
USE &gRutEmp\TabPar IN 0 ALIAS TmpVer AGAIN
IF EMPTY(TmpVer.NomEmp) OR EMPTY(TmpVer.OtraInf) OR (ALLTRIM(TmpVer.NomEmp) <> ALLTRIM(lcNomEmp))
	USE IN TmpVer
	SELE (lnOldSele)
	llRetorno = .F.
	DO Form &gRuta\Forms\frmMntVer TO llRetorno
	IF !llRetorno
		FunAborta(lcNomEmp)
	ENDIF
ELSE
	USE IN TmpVer
	SELE (lnOldSele)
ENDIF
funVerEmp()
RETURN
ENDFUNC

FUNCTION FunVerSer(lcNomEmp,lcNroRuc,lcNroVer)
IF !(ResNom(lcNomEmp) == lcNroVer)
*	MESSAGEBOX("Datos No Coresponden Verifique",0+64,"Validacion")
	RETURN .F.
ENDIF
SELE Tabpar
REPLACE NomEmp WITH lcNomEmp, ;
		NroRuc WITH lcNroRuc, ;
		OtraInf WITH funConVer(lcNroVer)
RETURN .T.
ENDFUNC


FUNCTION FunVerAdd(lcNomEmp,lcNroRuc,lcNroVer)
LOCAL lnCodEmp, lcCodEmp
IF !(ResNom(lcNomEmp) == lcNroVer)
	RETURN .F.
ENDIF
lnCodEmp = 0
lcCodEmp = SPACE(03)
USE &gRutDat\Empresas IN 0 AGAIN ALIAS TmpEmp
GO TOP
SCAN WHILE !EOF()
	IF ALLTRIM(TmpEmp.NomEmp) == ALLTRIM(lcNomEmp) 
		USE IN TmpEmp
		MESSAGEBOX("Empresa Ya se Encuentra Registrada",0+48,"Validacion")
		RETURN .F.
	ENDIF
	IF VAL(TmpEmp.CodEmp) > lnCodEmp
		lnCodEmp = VAL(TmpEmp.CodEmp)
	ENDIF
ENDSCAN
lnCodEmp = lnCodEmp + 1
IF lnCodEmp > 999
	USE IN TmpEmp
	MESSAGEBOX("No se Puede Crear Directorio",0+48,"Validacion")
	RETURN .F.
ENDIF
lcCodEmp = RIGHT('000'+ALLTRIM(STR(lnCodEmp)),3)
APPEND BLANK
REPLACE CodEmp WITH lcCodEmp, ;
		NomEmp WITH lcNomEmp
USE IN TmpEmp
gCodEmp = lcCodEmp
gNomEmp = lcNomEmp
gRutEmp = gRutDat+"\DAT"+gCodEmp
gDBConta = gRutEmp+"\Conta.DBC"
*gDatos  = gRutEmp+"\Planilla.DBC"
gDatos  = gRutEmp+"\Conta.DBC"
gRutEmp = gRutBas+"\DAT"+gCodEmp
MKDIR &gRutEmp
CHDIR &gRutEmp
*DO &gRuta\Progs\GenDatos
*DO &gRuta\Progs\Datos
COPY FILE &gRutBas TO &gRutEmp
IF !FILE("&gDBConta")
	MESSAGEBOX("No se Tiene la Base de datos",0+64,"Validacion")
	FunAborta(lcNomEmp)
	RETURN
ENDIF
goApp.SetCaption(gNomApp+"  "+gNomEmp)
IF DBUSED("Conta")
	SET DATABASE TO Conta
	CLOSE DATABASE
ENDIF
OPEN DATABASE &gDBConta
SET PATH TO ;&gRutDat;&gRutEmp;INCLUDE;FORMS;GRAPHICS;HELP;LIBS;MENUS;PROGS;REPORTS
USE &gRutEmp\TabPar IN 0 ALIAS TmpPar AGAIN
SELE TmpPar
GO TOP
IF EOF() OR BOF()
	APPEND BLANK
ENDIF
REPLACE NomEmp WITH lcNomEmp, ;
		NroRuc WITH lcNroRuc, ;
		OtraInf WITH funConVer(lcNroVer), ;
		CodEmp WITH lcCodEmp
USE IN TmpPar
USE &gRutEmp\Accesos IN 0 ALIAS TmpAcc AGAIN
APPEND BLANK
REPLACE CodUsu WITH gCodUsu, ;
		CodApl WITH gCodApl, ;
		CodEmp WITH lcCodEmp
USE IN TmpAcc
USE &gRutEmp\TabAux IN 0 ALIAS TmpAux AGAIN
APPEND BLANK
REPLACE TipAux WITH '02', ;
		CodAux WITH '0000', ;
		NomAux WITH 'VARIOS'
APPEND BLANK
REPLACE TipAux WITH '03', ;
		CodAux WITH '0000', ;
		NomAux WITH 'VARIOS'
APPEND BLANK
REPLACE TipAux WITH '99', ;
		CodAux WITH '9999', ;
		NomAux WITH 'VARIOS'
USE IN TmpAux
MESSAGEBOX("Proceso Termino Correctamente",0+64,"Validacion")
RETURN .T.
ENDFUNC

FUNCTION FunInicio()
SET EXCLUSIVE OFF
SET DELETE ON
SET MULTILOCKS ON
SET CENTURY ON
SET DATE TO DMY
SET HOURS TO 24
SET SAFETY OFF
SET ESCAPE OFF
SET COMPATIBLE OFF
funVerEmp()
RETURN
ENDFUNC

FUNCTION FunVerEmp()
LOCAL lnOldSele, lcNomEmp, lcOtraInf, lnCampos, lnPos, I, llRetorno
lnOldSele = SELECT()
USE &gRutEmp\TabPar IN 0 ALIAS TmpVer AGAIN
lcNomEmp = TmpVer.NomEmp
lcOtraInf = TmpVer.OtraInf
USE IN TmpVer
SELE (lnOldSele)
IF EMPTY(lcNomEmp)
	FunAborta(lcNomEmp)
ENDIF
IF EMPTY(lcOtraInf)
	FunAborta(lcNomEmp)
ENDIF
IF ResNom(lcNomEmp) == ResVer(lcOtraInf)
	RETURN .T.
ENDIF
FunAborta(lcNomEmp)
llRetorno = .F.
DO Form &gRuta\Forms\frmMntVer TO llRetorno
IF !llRetorno
	FunAborta(lcNomEmp)
ENDIF
ENDFUNC

FUNCTION FunAborta(lcNomEmp)
MESSAGEBOX("La Empresa : "+lcNomEmp+CHR(13)+CHR(13)+;
           "NO  ESTA  AUTORIZADA  PARA  EL  USO  DEL  PROGRAMA"+CHR(13)+;
           "!!.. PUEDE TENER PROBLEMAS CON SU INFORMACION ..!!"+CHR(13)+CHR(13)+;
           "comunicarse con David Guevara al 967-1457",0+48,"Autorizacion" )
*CLOSE ALL
lcFunShutdown="FunShutDown()"
ON SHUTDOWN &lcFunShutdown
QUIT
ENDFUNC

FUNCTION FunShutDown()
QUIT
ENDFUNC

FUNCTION ResNom(lcNombre)
LOCAL lnLen, lnNombre, lnAsc, lcResultado1, lcResultado2, lnResultado, I
lcNombre = ALLTRIM(lcNombre) && + ALLTRIM(lcNroRuc)
lnLen = LEN(lcNombre)
*-
lnNombre = 0
I = 0
FOR I=1 TO lnLen
	lnAsc = ASC(SUBS(lcNombre,I,1))
	lnAsc = lnAsc + 2
	IF lnAsc > 90
    	lnNombre = lnNombre + ABS(90 - (2*lnAsc))
    ELSE
    	lnNombre = lnNombre + ABS(80 - (2*lnAsc))
    ENDIF
ENDFOR
lnNombre = 86420 + (lnNombre+2468)*3
lcResultado1 = ALLTRIM(STR(lnNombre))
*-
lnNombre = 0
I = 0
FOR I=1 TO lnLen
	lnAsc = ASC(SUBS(lcNombre,I,1))
	lnAsc = lnAsc + 1
    lnNombre = lnNombre + (4*lnAsc)
ENDFOR
lnNombre = 97531  + lnNombre
lcResultado2 = ALLTRIM(STR(lnNombre))
lcResultado = lcResultado1+lcResultado2       
RETURN lcResultado
ENDFUNC

FUNCTION ResVer(lcVer)
LOCAL lcResultado, lnResultado
lcResultado = ALLTRIM(lcVer) && + ALLTRIM(lcNroRuc)
lcResultado = CHRTRAN(lcResultado, '@?*%}:#$!&+', '8462097531')
RETURN lcResultado
ENDFUNC

FUNCTION FunConVer(lcVer)
LOCAL lcResultado, lnResultado
lcResultado = ALLTRIM(lcVer)
lcResultado = CHRTRAN(lcResultado, '8462097531', '@?*%}:#$!&+')
RETURN lcResultado
ENDFUNC

FUNCTION FILE_USE(pFile,pModo)
ON ERROR CapturaError(ERROR(),MESSAGE())
LOCAL lReturn
DO WHILE .T.
	gSinError = .T.
	gMsjError = SPACE(01)
	IF pModo = 'E'
		USE &pFile EXCLUSIVE
	ELSE
		USE &pFIle SHARED
	ENDIF
	IF gSinError
		lReturn = .T.
		EXIT
	ENDIF
	IF MESSAGEBOX(gMsjError,5+32+0,gNomApp)=2
		lReturn = .F.
		EXIT
	ENDIF
ENDDO
ON ERROR ErrorHandler(ERROR(),PROGRAM(),LINENO())
RETURN (lReturn)
ENDFUNC
FUNCTION CapturaError(merror, mess)
gMsjError = mess
gSinError = .F.
ENDFUNC
		  
PROCEDURE ImprimeTexto(pFile,pProceso)
LOCAL lcFile, lcProceso
lcFile = gRutTemp+"\"+gcodusu+pFile+SUBS(SYS(2015),3,10)+".PRN"
lcProceso = pProceso
SET DEVICE  TO PRINTER
SET PRINTER TO &lcFile
&lcProceso
SET PRINTER TO
SET DEVICE  TO SCREEN
MODIFY FILE &lcFile NOEDIT 
*SET SYSMENU TO _MFILE, _MEDIT, _MWINDOW
*MODIFY FILE &lcFile NOEDIT IN SCREEN SAVE
*goApp.DoMenu(goApp.cStartupMenu)
*SET SYSMENU TO
RETURN
ENDPROC

PROCEDURE ImprimeTextoDos(pFile,pProceso)
LOCAL lcFile, lcProceso
lcFile = gRutTemp+"\"+gcodusu+pFile+SUBS(SYS(2015),3,10)+".PRN"
lcProceso = pProceso
SET DEVICE  TO PRINTER
SET PRINTER TO &lcFile
&lcProceso
SET PRINTER TO
SET DEVICE  TO SCREEN
*MODIFY FILE &lcFile NOEDIT
SET PRINTER TO LPT1
SET DEVICE  TO PRINTER
COPY FILE &lcFile TO LPT1
SET PRINTER TO
SET DEVICE  TO SCREEN
RETURN
ENDPROC

PROCEDURE ImprimeTextoDir(pFile,pProceso)
LOCAL lcFile, lcProceso
lcFile = gRutTemp+"\"+gcodusu+pFile+SUBS(SYS(2015),3,10)+".PRN"
lcProceso = pProceso
SET DEVICE  TO PRINTER
SET PRINTER TO &lcFile
&lcProceso
SET PRINTER TO
SET DEVICE  TO SCREEN
RUN TYPE &lcFile > PRN
*MODIFY COMMAND &lcFile NOEDIT
RETURN
ENDPROC

FUNCTION FUN_LETRAS
parameters n
q1="UN    DOS   TRES  CUATROCINCO SEIS  SIETE OCHO  NUEVE "
q2="DIEZ   ONCE   DOCE   TRECE  CATORCEQUINCE "
q3="VEINTI   TREINTI  CUARENTI CINCUENTISESENTI  SETENTI  OCHENTI  NOVENTI  "
q4="VEINTE   TREINTA  CUARENTA CINCUENTASESENTA  SETENTA  OCHENTA  NOVENTA  "
q5="C      DOC    TREC   CUATROCQUIN   SEISC  SETEC  OCHOC  NOVEC"
q6="MIL    BILLON MIL    MILLON MIL           "
n1= subs(str(n,21,2),1,18)
q=1
lt=""
if int(n)=0
   retu("CERO")
endif
do while q <> 7
   sub3=substr(n1,q*3-2,3)
   if sub3 <> space(3)
      if val(sub3)>199
         lt=lt+trim(substr(q5,val(substr(sub3,1,1))*7-6,7))+"IENTOS "
      endif
      if val(sub3)>=101 .and. val(sub3)<=199
         lt=lt+"CIENTO "
      endif
      sub2=substr(sub3,2,2)
      do case
         case sub3="100"
              lt=lt+"CIEN "
         case sub3="000".or. sub2="00"
         case val(sub2)<10
              lt=lt+trim(substr(q1,val(sub2)*6-5,6))+" "
         case val(sub2)<16
              lt=lt+trim(substr(q2,(val(substr(sub2,2,1))+1)*7-6,7))+" "
         case val(sub2)<20
              lt=lt+"DIECI"+trim(substr(q1,val(substr(sub2,2,1))*6-5,6))+" "
         case substr(sub2,2,1)="0"
              lt=lt+trim(substr(q4,(val(sub2)/10-1)*9-8,9))+" "
         other
              lt=lt+trim(substr(q3,(val(substr(sub2,1,1))-1)*9-8,9))+trim(;
              substr(q1,val(substr(sub2,2,1))*6-5,6))+" "
      endcase
      do case
         case substr(sub3,2,1) <> "1" .and. substr(sub3,3,1)="1" .and. q=6
              lt=trim(lt)+"O "
         case (val(sub3)=0 .and. val(substr(n1,(q-1)*3-2,3))>0 .and. q=int(q/;
              2)*2 .and. q<6 ) .or. (val(sub3)>1 .and. q=int(q/2)*2 .and. q<6)
              lt=lt+trim(substr(q6,q*7-6,7))+"ES "
         case (val(sub3)>0 .and. q <> int(q/2)*2 .and. q<6 ) .or. ;
              (val(sub3)>0 .and. q=int(q/2)*2 .and. q<6)
              lt=lt+trim(substr(q6,q*7-6,7))+" "
      endcase
   endif
   q=q+1
enddo
retu(lt)

*- Secuencia de Registro
FUNCTION GenNroSec(lcTipTab,lcNomTab)
LOCAL lnOldSele, lnNroSec
lnOldSele = SELECT()
lnNroSec  = 0
SELE TabTab
SEEK lcTipTab+PADR(lcNomTab,10)
IF EOF()
   IF RLOCK('0','TabTab')
      APPEND BLANK
      REPLACE TipTab WITH lcTipTab
      REPLACE CodTab WITH lcNomTab
      REPLACE DesTab WITH 'SECUENCIA DE '+lcNomTab
      UNLOCK
   ELSE   
      MESSAGEBOX('No se pudo bloquear Tabla de Secuencias',0,'Bloqueo')
      SELE (lnOldSele)
      RETURN lnNroSec
   ENDIF
ENDIF
IF RLOCK()
   REPLACE NroSec WITH NroSec + 1
   lnNroSec = NroSec
   UNLOCK
ELSE
   MESSAGEBOX('No se pudo bloquear Tabla de Secuencias',0,'Bloqueo')
   SELE (lnOldSele)
   RETURN lnNroSec
ENDIF
SELE (lnOldSele)
RETURN lnNroSec
ENDFUNC

*- Secuencia de Comprobante
FUNCTION GenNroCom(lcPeriodo,lcTipCom)
LOCAL lnOldSele, lnNroCom
lnOldSele = SELECT()
lnNroCom  = 0
IF !SEEK(lcPeriodo+lcTipCom,'TabSecCom','Periodo')
	SELE TabSecCom
	IF RLOCK('0','TabSecCom')
  		APPEND BLANK
   		REPLACE TipCom  WITH lcTipCom, ;
   				Periodo WITH lcPeriodo  
   		UNLOCK
	ELSE   
   		MESSAGEBOX('No se pudo bloquear Tabla de Secuencias de Compbtes',0+48,'Bloqueo')
   		SELE (lnOldSele)
   		RETURN lnNroCom
	ENDIF
ENDIF
SELE TabSecCom
IF RLOCK()
	REPLACE NroCom WITH NroCom + 1
	lnNroCom = NroCom
	UNLOCK
ELSE
 	MESSAGEBOX('No se pudo bloquear Tabla de Secuencias de Compbtes',0+48,'Bloqueo')
 	SELE (lnOldSele)
 	RETURN lnNroCom
ENDIF
SELE (lnOldSele)
RETURN lnNroCom
ENDFUNC

*- Secuencia de Documentos
FUNCTION GenNroDoc(lcTipDoc,lcNroSer)
LOCAL lnOldSele, lcNroSecDoc
lnOldSele = SELECT()
lcNroSecDoc = SPACE(01)
IF !SEEK(lcTipDoc+lcNroSer,"TabSecDoc","TipDoc")
	SELE TabSecDoc
	IF RLOCK('0','TabSecDoc')
		APPEND BLANK
		REPLACE TipDoc WITH lcTipDoc, ;
				NroSer WITH lcNroSer, ;
				NroDig WITH 6
		UNLOCK
	ELSE   
       MESSAGEBOX('No se pudo bloquear Tabla de Secuencia de Documentos',0+48,'Bloqueo')
       SELE (lnOldSele)
       RETURN lcNroSecDoc
    ENDIF
ENDIF
SELE TabSecDoc
IF !RLOCK()
   MESSAGEBOX('No se pudo bloquear Tabla de Secuencia de Documnetos',0+48,'Bloqueo')
   SELE (lnOldSele)
   RETURN lcNroSecDoc
ENDIF
REPLACE NroSec WITH NroSec + 1
lcNroSecDoc = PADL(NroSec,NroDig,"0")
UNLOCK
RETURN lcNroSecDoc
ENDFUNC

FUNCTION FunImpLetras(lnImpTot,lcDesMnd)
LOCAL lcLetras
lcLetras = UPPER(FUN_LETRAS(INT(lnImpTot)))+" Y "+ ;
           RIGHT('00'+ALLTRIM(STR((lnImpTot-INT(lnImpTot))*100)),2)+"/100 "+;
           ALLTRIM(lcDesMnd)
RETURN(lcLetras)
ENDFUNC

FUNCTION FunTipoCambio(lcTipMnd,lcTipCam,lnImpCam,lnImpOrg,lcImp,ldFecDoc)
IF lcTipMnd == "U"
	RETURN IIF(lcImp=="Dol",lnImpOrg,IIF(lcTipCam == "0",0.00,ROUND(lnImpOrg*lnImpCam,2)))
ELSE
	IF lcTipMnd == "P"
		RETURN IIF(lcImp=="Sol",lnImpOrg,IIF(lcTipCam == "0",0.00,;
		           IIF(EMPTY(lnImpCam),0.00,ROUND(lnImpOrg/lnImpCam,2))))
	ELSE
		IF !SEEK(lcTipMnd+DTOS(ldFecDoc),"Cambio","TipMnd")
			MESSAGEBOX('No se Tiene Registrado Tipo de Cambio para la Fecha y Moneda',0+64,'Validacion')
   			RETURN 0.00
		ENDIF
		RETURN IIF(lcImp=="Sol",ROUND(lnImpOrg*IIF(lcTipCam == "1",Cambio.ImpCom,Cambio.ImpVta),2),;
				   IIF(EMPTY(lnImpCam),0.00,;
				   ROUND((ROUND(lnImpOrg*IIF(lcTipCam == "1",Cambio.ImpCom,Cambio.ImpVta),2))/lnImpCam,2)))
	ENDIF
ENDIF
RETURN 0.00
ENDFUNC

FUNCTION FunObtengoCambio(lcTipCam,ldFecDoc)
IF EMPTY(ldFecDoc)
	MESSAGEBOX('No se Tiene Fecha de Cambio',0+64,'Validacion')
	RETURN 0.00
ENDIF
IF !SEEK("U"+DTOS(ldFecDoc),"Cambio","TipMnd")
	MESSAGEBOX('No se Tiene Registrado Tipo de Cambio para la Fecha : '+DTOC(ldFecDoc),0+64,'Validacion')
   	RETURN 0.00
ENDIF
RETURN IIF(lcTipCam == "1",Cambio.ImpCom,Cambio.ImpVta)
ENDFUNC

FUNCTION FunVerPass(lcPassWord)
LOCAL lcConvPass, lcRestPass
IF EMPTY(lcPassWord) AND EMPTY(ALLTRIM(TabUsu.Password))
	RETURN .T.
ENDIF
lcConvPass = FunConvPass(lcPassWord)
lcRestPass = FunRestPass(lcPassWord)
IF lcConvPass == lcRestPass
	RETURN .T.
ENDIF
RETURN .F.
ENDFUNC

FUNCTION FunConvPass(lcPassWord)
LOCAL lcNombre, lnLen, lnAsc, lcConvPass, I, lnNombre
lcNombre = ALLTRIM(lcPassWord)
lcConvPass = SPACE(01)
IF EMPTY(lcNombre)
	RETURN ALLTRIM(lcConvPass)
ENDIF
lnLen = LEN(lcNombre)
lnNombre = 0
I = 0
FOR I=1 TO lnLen
	lnAsc = ASC(SUBS(lcNombre,I,1))
	lnAsc = (lnAsc + 2)*3
	lnNombre = lnNombre + lnAsc
ENDFOR
lcConvPass = ALLTRIM(STR(lnNombre))
lcConvPass = CHRTRAN(lcConvPass, '9753184620', '@?*%&:#$!}')
RETURN lcConvPass
ENDFUNC

FUNCTION FunRestPass(lcPassWord)
LOCAL lcRestPass
lcRestPass = ALLTRIM(TabUsu.PassWord)
lcRestPass = CHRTRAN(lcRestPass, '@?*%&:#$!}', '9753184620')
RETURN lcRestPass
ENDFUNC

FUNCTION FunCodVdd()
LOCAL llReturn, lnOldSele
llReturn = .F.
lnOldSele = SELECT()
IF !FILE_USE("TabUsuVdd","S")
	RETURN .F.
ENDIF
SELECT A.CodUsu, A.TipAuxVdd, A.CodAuxVdd ;
FROM TabUsuVdd A ;
WHERE A.CodUsu = gCodUsu ;
INTO CURSOR TmpVdd
IF _TALLY > 0
	SELE TmpVdd
	GO TOP
	gTipAuxVdd = TmpVdd.TipAuxVdd
	gCodAuxVdd = TmpVdd.CodAuxVdd
	llReturn = .T.
ENDIF
USE IN TmpVdd
USE IN TabUsuVdd
SELE (lnOldSele)
RETURN llReturn
ENDFUNC

FUNCTION FunVerSldArt(lcCodAlm,lcCodArt,lnCanArt)
LOCAL llReturn, lnOldSele, lcDesAlm, lcDesArt
llReturn = .F.
lnOldSele = SELECT()

*- Obtengo Almacen
lcDesAlm = SPACE(30)
SELECT CodAlm, DesAlm FROM ArtAlm WHERE CodAlm = lcCodAlm INTO CURSOR TmpAlm
IF _TALLY > 0
	SELE TmpAlm
	GO TOP
	lcDesAlm = TmpAlm.DesAlm
ENDIF
USE IN TmpAlm

*- Obtengo Articulo
lcDesArt = SPACE(50)
SELECT CodArt, DesArt FROM ArtArt WHERE CodArt = lcCodArt INTO CURSOR TmpArt
IF _TALLY > 0
	SELE TmpArt
	GO TOP
	lcDesArt = TmpArt.DesArt
ENDIF
USE IN TmpArt

SELECT CodAlm+CodArt As Art, CanArt FROM ArtSld ;
WHERE CodAlm+CodArt = lcCodAlm+lcCodArt ;
INTO CURSOR TmpSld
IF _TALLY < 1
	MESSAGEBOX("Almacen  : "+lcDesAlm+CHR(13)+;
	           "Articulo : "+lcDesArt+CHR(13)+;
	           "Articulo No Registrado en Almacen"+lcCodAlm,0+64,"Validacion")
	llReturn = .F.
ELSE
	SELE TmpSld
	GO TOP
	IF TmpSld.CanArt < lnCanArt
		IF MESSAGEBOX("Almacen  : "+lcDesAlm+CHR(13)+;
			          "Articulo : "+lcDesArt+CHR(13)+;
			          "SALDO    : "+STR(TmpSld.CanArt,3)+CHR(13)+;
					  "Cantidad : "+STR(lnCanArt,3)+CHR(13)+;
                      "Saldo en Almacen es Menor"+CHR(13)+;
		           	  "Esta Seguro de Continuar",4+32+256,"Validacion") = 7
			llReturn = .F.
		ELSE
			llReturn = .T.
		ENDIF
	ELSE
		llReturn = .T.
	ENDIF
ENDIF
USE IN TmpSld
SELE (lnOldSele)
RETURN llReturn
ENDFUNC

FUNCTION FunSinDec(lcNumero)
*- Quita numero decimal que sehan cero por la izquierda
*- El Numero (lcNumero) debe ser caracter y con formato 
*- Ejm "999,999,999.999999"
LOCAL lnMax,lnPosDec
*-
IF EMPTY(lcNumero)
	RETURN (lcNumero)
ENDIF

*- Longitud
lnMax = LEN(lcNumero)
IF lnMax = 0
	*- sin no tiene datos
	RETURN (lcNumero)
ENDIF
*-	Verificar si numero tiene decimales
lnPosDec = AT(".",lcNumero)
IF lnPosDec = 0 
	*- sin no tiene decimales
	RETURN (lcNumero)
ENDIF

FOR i = lnMax TO 1 STEP -1
	*- si llega al punto decimal retrocede una posicion
	IF SUBS(lcNumero,i,1) == "."
		RETURN (SUBS(lcNumero,1,(i-1)))
	ENDIF
	*- si el decimal es diferente de cero termina
	IF SUBS(lcNumero,i,1) <> "0"
		RETURN (SUBS(lcNumero,1,i))
	ENDIF
ENDFOR
RETURN lcNumero
ENDFUNC

FUNCTION FunInputMask(lnNumero,lcPicture)
*- Devuelfe formato sin decimal que sehan cero por la izquierda
*- El Numero (lcNumero) debe ser caracter y con formato 
*- Ejm 123456.123400, "999,999,999.999999"
LOCAL lnMax,lnPosDec
*-
lcPicture = ALLTRIM(lcPicture)
IF EMPTY(lcPicture)
	RETURN (lcPicture)
ENDIF
lnLon = LEN(lcPicture)
lnPosDec = AT(".",lcPicture)
IF lnPosDec = 0
	RETURN (lcPicture)
ENDIF
lnDec = lnLon - lnPosDec
IF lnDec < 1
	RETURN (lcPicture)
ENDIF
*-
IF EMPTY(lnNumero)
	RETURN (lcPicture)
ENDIF
lcNumero = ALLTRIM(STR(lnNumero,lnLon,lnDec))
*- Longitud
lnMax = LEN(lcNumero)
IF lnMax = 0
	*- sin no tiene datos
	RETURN (lcPicture)
ENDIF
*-	Verificar si numero tiene decimales
lnPosDec = AT(".",lcNumero)
IF lnPosDec = 0 
	*- sin no tiene decimales
	RETURN (lcNumero)
ENDIF

FOR i = lnMax TO 1 STEP -1
	*- si llega al punto decimal retrocede una posicion
	IF SUBS(lcNumero,i,1) == "."
		RETURN (SUBS(lcPicture,1,(i-1)))
	ENDIF
	*- si el decimal es diferente de cero termina
	IF SUBS(lcNumero,i,1) <> "0"
		RETURN (SUBS(lcPicture,1,i))
	ENDIF
	lcPicDev = ""
ENDFOR
RETURN lcNumero
ENDFUNC

* ValidRucSunat("20372706288")

FUNCTION ValidRucSunat(lcNroRuc)
  IF LEN(ALLTRIM(lcNroRuc)) <> 11 THEN
    RETURN .F.
  ENDIF
  LOCAL aArrayRuc
  DIMENSION aArrayRuc(3,11)
  FOR i = 1 TO 11
    aArrayRuc(1,i)=VAL(SUBS(lcNroRuc,i,1))
  ENDFOR
  aArrayRuc(2,1)=5
  aArrayRuc(2,2)=4
  aArrayRuc(2,3)=3
  aArrayRuc(2,4)=2
  aArrayRuc(2,5)=7
  aArrayRuc(2,6)=6
  aArrayRuc(2,7)=5
  aArrayRuc(2,8)=4
  aArrayRuc(2,9)=3
  aArrayRuc(2,10)=2
  aArrayRuc(3,11)=0
  FOR i=1 TO 10
    aArrayRuc(3,i)  = aArrayRuc(1,i)  * aArrayRuc(2,i)
    aArrayRuc(3,11) = aArrayRuc(3,11) + aArrayRuc(3,i)
  ENDFOR
  lnResiduo   = MOD(aArrayRuc(3,11),11)
  lnUltDigito = 11 - lnResiduo
  DO CASE
    CASE lnUltDigito = 11 OR lnUltDigito=1
      lnUltDigito = 1
    CASE lnUltDigito = 10 OR lnUltDigito=0
      lnUltDigito = 0
  ENDCASE
  IF lnUltDigito = aArrayRuc(1,11) THEN
    RETURN .T.
  ELSE
    RETURN .F.
  ENDIF
ENDFUNC

FUNCTION FunValCtaAna(lcCodCta)
LOCAL lcCtaDev,lnLenCta
lcCtaDev = ""
lcCodCta = ALLTRIM(lcCodCta)
IF EMPTY(lcCodCta)
	RETURN lcCtaDev
ENDIF
lnLenCta = LEN(lcCodCta)
*- Obtengo Nivel Analitico
SELECT M.CodCta ;
FROM Cuentas M ;
WHERE SUBS(M.CodCta,1,lnLenCta) = lcCodCta AND M.IndAna = 1;
INTO CURSOR TmpCta
IF _TALLY < 1
	USE IN TmpCta
	MESSAGEBOX("Cuenta No Registra Analitica",0+64,"Validacion")
	RETURN lcCtaDev
ENDIF
SELE TmpCta
GO TOP
lcCodCta = ALLTRIM(TmpCta.CodCta)
USE IN TmpCta
*- Si Existe la Cuenta
lcCodCta = PADR(lcCodCta,8)
SELECT M.CodCta, M.DesCta, M.IndNiv, M.IndAna ;
FROM Cuentas M ;
WHERE M.CodCta = lcCodCta ;
INTO CURSOR TmpCta
IF _TALLY < 1
	USE IN TmpCta
	MESSAGEBOX("Cuenta No Registrada",0+64,"Validacion")
	lcCodCta = SPACE(08)
	RETURN .F.
ENDIF
SELE TmpCta
GO TOP
*- Si es de Nivel Analitico
IF TmpCta.IndAna <> 1
	MESSAGEBOX("Cuenta No es Analitica de Ingreso",0+64,"Validacion")
	USE IN TmpCta
	lcCodCta = SPACE(08)
	RETURN .F.
ENDIF
USE IN TmpCta
RETURN .F.
ENDFUNC

FUNCTION FunValCta(lcCodCta,lcDesCta)
*- Si se tiene Cuenta
*lcCodCta = ALLTRIM(lcCodCta)
IF EMPTY(lcCodCta)
	RETURN .F.
ENDIF
*- Si Existe la Cuenta
lcCodCta = PADR(lcCodCta,8)
SELECT M.CodCta, M.DesCta, M.IndNiv, M.IndAna ;
FROM Cuentas M ;
WHERE M.CodCta = lcCodCta ;
INTO CURSOR TmpCta
IF _TALLY < 1
	USE IN TmpCta
	MESSAGEBOX("Cuenta No Registrada",0+64,"Validacion")
	RETURN .F.
ENDIF
SELE TmpCta
GO TOP
*- Si es de Nivel Analitico
*IF TmpCta.IndAna <> 1
IF TmpCta.IndNiv <> 4
	MESSAGEBOX("Cuenta No es Analitica de Ingreso",0+64,"Validacion")
	USE IN TmpCta
	RETURN .F.
ENDIF
lcDesCta = TmpCta.DesCta
USE IN TmpCta
RETURN .T.
ENDFUNC

*- Tipo de Cambio
FUNCTION FunTipCam(lcTipCam,ldFecDoc)
LOCAL lcTipMnd,lnImpCam
lcTipMnd = "U"
lnImpCam = 0.00
IF EMPTY(ldFecDoc)
	MESSAGEBOX('No se Tiene Fecha de Cambio',0+64,'Validacion')
	RETURN lnImpCam
ENDIF
IF EMPTY(lcTipCam)
	MESSAGEBOX('No se Tiene el Parametro Tipo de Cambio Venta o Compra',0+64,'Validacion')
	RETURN lnImpCam
ENDIF
SELECT M.TipMnd, M.FecCam, M.ImpCom, M.ImpVta ;
FROM Cambio M ;
WHERE M.TipMnd+DTOS(M.FecCam) = lcTipMnd+DTOS(ldFecDoc) ;
INTO CURSOR Tmp
IF _TALLY < 1
	MESSAGEBOX('No se Tiene Registrado Tipo de Cambio para la Fecha : '+DTOC(ldFecDoc),0+64,'Validacion')
	USE IN Tmp	
   	RETURN lnImpCam
ENDIF
lnImpCam = IIF(lcTipCam == "1",Tmp.ImpCom,Tmp.ImpVta)
USE IN Tmp
RETURN lnImpCam
ENDFUNC

FUNCTION FunDesMnd(lcTipMnd,lnTipo)
LOCAL lcRetorno
lcRetorno = ""
IF EMPTY(lcTipMnd)
	MESSAGEBOX('No se Tiene Tipo de Moneda',0+64,'Validacion')
	RETURN lcRetorno
ENDIF
*-
SELECT M.TipMnd, M.DesMnd, M.Simbol ;
FROM TipMnd M ;
WHERE M.TipMnd == lcTipMnd ;
INTO CURSOR TmpMnd
IF _TALLY < 0
	MESSAGEBOX('No se Tiene Registrado el Tipo de Moneda : '+lcTipMnd,0+64,'Validacion')
	USE IN TmpMnd
	RETURN lcRetorno
ENDIF
lcRetorno = IIF(lnTipo = 1,TmpMnd.DesMnd,TmpMnd.Simbol)
USE IN TmpMnd
RETURN lcRetorno
ENDFUNC

*- 
*- SITUACION DE DOCUMENTOS
*-
*- GUIA DE REMISION
FUNCTION FunSitGR(lnIndSit)
LOCAL lcDesSit
lcDesSit = ""
DO CASE
	CASE lnIndSit == 1
		lcDesSit = "PENDIENTE"
	CASE lnIndSit == 3
		lcDesSit = "EN GUIA"
	CASE lnIndSit == 4
		lcDesSit = "FACTURADA"
	CASE lnIndSit == 9 
		lcDesSit = "ANULADA"
ENDCASE
RETURN lcDesSit
ENDFUNC

*- DOCUMENTO POR COBRAR
FUNCTION FunSitDocCob(lnIndSit)
LOCAL lcDesSit
lcDesSit = ""
DO CASE
	CASE lnIndSit == 1
		lcDesSit = "PENDIENTE"
	CASE lnIndSit == 4
		lcDesSit = "CANCELADA"
	CASE lnIndSit == 9 
		lcDesSit = "ANULADA"
ENDCASE
RETURN lcDesSit
ENDFUNC

FUNCTION FunFecVen(lcTipPgo,ldFecDoc)
RETURN (ldFecDoc + FunDiasVen(lcTipPgo))
ENDFUNC

FUNCTION FunDiasVen(lcTipPgo)
LOCAL lnDias
STORE 0 TO lnDias
SELECT TipPgo, Dias FROM TipPgo WHERE TipPgo == lcTipPgo INTO CURSOR Tmp
IF _TALLY > 0
	lnDias = Tmp.Dias
ELSE
	MESSAGEBOX("No se tiene Registrada la Condicion de Venta : " + lcTipPgo,0+64,"Validacion")
ENDIF
USE IN Tmp
RETURN lnDias
ENDFUNC


FUNCTION FunPerAlm(lcCodAlm,lcPeriodo,lcTipMov,lcTipTsc)
LOCAL lnOldSele
lnOldSele = SELECT()
SELE ArtMovPer
IF !SEEK(lcCodAlm+lcPeriodo+lcTipMov+lcTipTsc,"ArtMovPer","Periodo")
	SELE ArtMovPer
	IF RLOCK('0','ArtMovPer')
   		APPEND BLANK
   		REPLACE CodAlm  WITH lcCodAlm, ;
			   	Periodo WITH lcPeriodo, ;
		   		TipMov  WITH lcTipMov, ;
		   		TipTsc  WITH lcTipTsc
   		UNLOCK
	ELSE   
  		MESSAGEBOX('No se pudo bloquear Tabla de Almacenes',0+48,'Bloqueo')
   		SELE (lnOldSele)
   		RETURN .F.
   	ENDIF
ENDIF
SELE (lnOldSele)
RETURN .T.
ENDFUNC

FUNCTION FunDocRep(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc,lnNroSec)
*- Verifica si Documento ya se encuentra Registrado para el Auxiliar
*- *** FALTA Verificar que documento no se Repita en caso de las ventas
*- lnNroSec verifica si se trata de modificacion o adicion 
*- sera 0 para las adiciones y secuencia del registro para las modificaciones

SELECT M.TipAux+M.CodAux+M.TipDoc+M.NroDoc As Cod, ;
       M.Periodo, M.TipCom, M.NroCom, M.FecDoc, M.NroSec ;
FROM DocCab M ;
WHERE M.TipAux+M.CodAux+M.TipDoc+M.NroDoc = lcTipAux+lcCodAux+lcTipDoc+lcNroDoc ;
INTO CURSOR TmpDoc
IF _TALLY > 0
	*- Verifico NroSec
	IF lnNroSec <> TmpDoc.NroSec
		MESSAGEBOX("Documento Ya Registrado para el Auxiliar"+CHR(13)+;
				   "Fecha   : "+DTOC(TmpDoc.FecDoc)+CHR(13)+;
		           "Periodo : "+TRANSFORM(TmpDoc.Periodo,"@R 9999-99")+CHR(13)+;
		           "Compbte : "+TmpDoc.TipCom+"-"+ALLTRIM(STR(TmpDoc.NroCom)),0+64,"Validacion")
		USE IN TmpDoc
		RETURN .F.
	ENDIF
ENDIF
USE IN TmpDoc
RETURN .T.
ENDFUNC

*-------------------------------
*- Obtengo Mes
*---------------------------------
FUNCTION FunNomMes(lcCodMes)
lcNomMes = ""
SELECT M.CodMes, M.NomMes FROM Meses M WHERE M.CodMes == lcCodMes INTO CURSOR Tmp
IF _TALLY > 0
	lcNomMes = ALLTRIM(Tmp.NomMes)
ENDIF
USE IN Tmp
RETURN lcNomMes
ENDFUNC

*- Obtengo MONEDA
FUNCTION FunDesMndX(lcTipMnd)
lcDesMnd = ""
SELECT M.TipMnd, M.DesMnd FROM TipMnd M WHERE M.TipMnd == lcTipMnd INTO CURSOR Tmp
IF _TALLY > 0
	lcDesMnd = ALLTRIM(Tmp.DesMnd)
ENDIF
USE IN Tmp
RETURN lcDesMnd
ENDFUNC

*---------------------------------------
* FECHA DE PROCESO
*---------------------------------------
FUNCTION FunFecPcs()
*- Obtengo Fecha de Proceso
LOCAL ldFecPcs
ldFecPcs = CTOD("")
SELE M.FecPcs ;
FROM TabPar M ;
INTO CURSOR TmpPcs
IF _TALLY > 0
	ldFecPcs = TmpPcs.FecPcs
ELSE
	MESSAGEBOX("No se Tiene Informacion de la Fecha de Proceso en Parametros Generales",0+64,"Validacion Fecha de Proceso")
ENDIF
USE IN TmpPcs
RETURN ldFecPcs
ENDFUNC

*-------------------------------------------------------------------------------
*- Situacion de Documentos Cobrar / Pagar
*------------------------------------------------------------------------------
FUNCTION FunSitDoc(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc,ldFecMov,lnNroSecDoc, ;
                   lcNomAux,ldFecDoc,lcTipMnd,lcCodMnd,lcSimbol,lnImpTot,lnImpSld, ;
                   lcTipCto,lcCodCto,lcDesCto,lcGlosa,lcCodCta)
LOCAL llRetorno,lnRegSel
*- Situacion 
*- 1 Pendiente
*- 4 Cancelado
llRetorno = .F.

*- Selecciono Documento
lnRegSel = 0
DO CASE 
CASE lcTipDoc == "RI" OR lcTipDoc == "RE"
	lnRegSel = FunSelRcb(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
CASE lcTipDoc == "LT"	
	lnRegSel = FunSelLet(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
CASE lcTipDoc == "PC"
	lnRegSel = FunSelPlnCob(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
OTHER
	lnRegSel = FunSelDoc(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
ENDCASE
IF !USED("TmpDoc")
	MESSAGEBOX("No se pudo seleccionar Documentos",0+48,"Validacion")
	RETURN llRetorno
ENDIF
SELE TmpDoc
GO TOP

*- Ubicacion Documento
IF EMPTY(lnRegSel) OR lnRegSel = 0
	MESSAGEBOX("Documento No se Encuentra Provisionado",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Saldo del Documento
IF TmpDoc.ImpAmo > TmpDoc.ImpTot
	MESSAGEBOX("Importe de Amortizacion es Mayor que el Saldo del Documento",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Situacion del Documento
IF TmpDoc.IndSit <> 1
	MESSAGEBOX("Documento No se Encuentra Pendiente",0+48,"Validacion")
	RETURN llRetorno
ENDIF
*- Fecha de Emision del Documento
IF TmpDoc.FecDoc > ldFecMov
	MESSAGEBOX("Fecha de Emision del Documento es Mayor a Fecha de Amortizacion",0+48,"Validacion")
	RETURN llRetorno
ENDIF
*- Bloqueo Documento
*IF !RLOCK("RcbCab")
*	MESSAGEBOX("Documento se Encuentra en Uso por Otro",0+48,"Validacion")
*	RETURN llRetorno
*ENDIF

*- Carga Datos
lnNroSecDoc = TmpDoc.NroSec
lcNomAux = TmpDoc.NomAux
ldFecDoc = TmpDoc.FecDoc 
lcTipMnd = TmpDoc.TipMnd
lcCodMnd = TmpDoc.CodMnd
lcSimbol = TmpDoc.Simbol
lnImpTot = TmpDoc.ImpTot
lnImpSld = TmpDoc.ImpTot - TmpDoc.ImpAmo
lcCodCta = TmpDoc.CodCta
lnIndOpe = VAL(TmpDoc.TipOpe)
lcTipCto = TmpDoc.TipCto
lcCodCto = TmpDoc.CodCto
lcDesCto = IIF(EMPTY(TmpDoc.CodCto) AND EMPTY(TmpDoc.DesCto),TmpDoc.Glosa,TmpDoc.DesCto)
lcGlosa = TmpDoc.Glosa
llRetorno = .T.
RETURN llRetorno
ENDFUNC

*FUNCTION FunSit_Doc_Bco(lcTipOpe,lcTipAux,lcCodAux,lcTipDoc,lcNroDoc,ldFecMov,lnNroSecDoc, ;
*                       lcNomAux,ldFecDoc,lcTipMnd,lcCodMnd,lcSimbol,lnImpTot,lnImpSld, ;
*                        lcTipCto,lcCodCto,lcDesCto,lcGlosa,lcCodCta,lcIndSig)
FUNCTION FunSit_Doc_Bco(lcTipOpe,ldFecMov,lcDesCto,oDet)

LOCAL llRetorno,lnRegSel,lcTipAux,lcCodAux,lcTipDoc,lcNroDoc
*- Situacion 
*- 1 Pendiente
*- 4 Cancelado
llRetorno = .F.
lcTipAux = oDet.TipAux
lcCodAux = oDet.CodAux
lcTipDoc = oDet.TipDoc
lcNroDoc = oDet.NroDoc

*- Selecciono Documento
lnRegSel = 0
DO CASE 
CASE lcTipDoc == "RI" OR lcTipDoc == "RE"
	lnRegSel = FunSelRcb(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
CASE lcTipDoc == "LT"	
	lnRegSel = FunSelLet(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
CASE lcTipDoc == "PC"
	lnRegSel = FunSelPlnCob(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
OTHER
	lnRegSel = FunSelDoc(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
ENDCASE
IF !USED("TmpDoc")
	MESSAGEBOX("No se pudo seleccionar Documentos",0+48,"Validacion")
	RETURN llRetorno
ENDIF
SELE TmpDoc
GO TOP

*- Ubicacion Documento
IF EMPTY(lnRegSel) OR lnRegSel = 0
	MESSAGEBOX("Documento No se Encuentra Provisionado",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Saldo del Documento
IF TmpDoc.ImpAmo > TmpDoc.ImpTot
	MESSAGEBOX("Importe de Amortizacion es Mayor que el Saldo del Documento",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Situacion del Documento
IF TmpDoc.IndSit <> 1
	MESSAGEBOX("Documento No se Encuentra Pendiente",0+48,"Validacion")
	RETURN llRetorno
ENDIF
*- Fecha de Emision del Documento
IF TmpDoc.FecDoc > ldFecMov
	MESSAGEBOX("Fecha de Emision del Documento es Mayor a Fecha de Amortizacion",0+48,"Validacion")
	RETURN llRetorno
ENDIF
*- Bloqueo Documento
*IF !RLOCK("RcbCab")
*	MESSAGEBOX("Documento se Encuentra en Uso por Otro",0+48,"Validacion")
*	RETURN llRetorno
*ENDIF

*- Carga Datos
oDet.NroSecDoc = TmpDoc.NroSec
oDet.NomAux = TmpDoc.NomAux
oDet.FecDoc = TmpDoc.FecDoc 
oDet.MndDoc = TmpDoc.TipMnd
oDet.CodMnd = TmpDoc.CodMnd
oDet.SblDoc = TmpDoc.Simbol
oDet.ImpDoc = TmpDoc.ImpTot
oDet.ImpSld = TmpDoc.ImpTot - TmpDoc.ImpAmo
oDet.CodCta = TmpDoc.CodCta
oDet.TipCto = TmpDoc.TipCto
oDet.CodCto = TmpDoc.CodCto
oDet.Glosa = TmpDoc.Glosa
lcDesCto = IIF(EMPTY(TmpDoc.CodCto) AND EMPTY(TmpDoc.DesCto),TmpDoc.Glosa,TmpDoc.DesCto)

*- Signo
DO CASE
CASE lcTipDoc == "RI" OR lcTipDoc == "RE" OR lcTipDoc == "LT" OR lcTipDoc == "PC" 
	oDet.IndSig = IIF(lcTipOpe == TmpDoc.TipOpe,"+","-")
OTHER
	oDet.IndSig = IIF(lcTipOpe == TmpDoc.TipOpe,TmpDoc.IndSig,IIF(TmpDoc.IndSig == "+","-","+"))
ENDCASE

llRetorno = .T.
RETURN llRetorno
ENDFUNC

*-------------------------------------------------------------------------------
*- Situacion de Documentos Cobrar / Pagar
*------------------------------------------------------------------------------
FUNCTION FunSitDocOpe(lcTipOpe,lcTipDoc,lcNroDoc,ldFecMov, ;
	                  lnNroSecDoc,lcTipAux,lcCodAux,lcNomAux,ldFecDoc,;
	                  lcTipMnd,lcCodMnd,lcSimbol,lnImpTot,lnImpSld,lcCodCta)	                  
LOCAL llRetorno
*- Situacion 
*- 1 Pendiente
*- 4 Cancelado
llRetorno = .F.

*- Selecciono Documento
SELECT M.TipOpe, M.TipDoc, M.NroDoc, M.NroSec, M.TipAux, M.CodAux, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.CodMnd, M.Simbol, M.ImpTot, M.ImpAmo, M.IndSig, M.IndSit, M.CodCta ;
FROM DocCab M ;
WHERE M.TipOpe+M.TipDoc+M.NroDoc = lcTipOpe+lcTipDoc+lcNroDoc ;
INTO CURSOR TmpDoc
IF _TALLY < 1
	MESSAGEBOX("No se pudo seleccionar Documento",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
SELE TmpDoc
GO TOP

*- Saldo del Documento
IF TmpDoc.ImpAmo > TmpDoc.ImpTot
	MESSAGEBOX("Importe de Amortizacion es Mayor que el Total del Documento",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Situacion del Documento
IF TmpDoc.IndSit <> 1
	MESSAGEBOX("Documento No se Encuentra Pendiente",0+48,"Validacion")
	RETURN llRetorno
ENDIF
*- Fecha de Emision del Documento
IF TmpDoc.FecDoc > ldFecMov
	MESSAGEBOX("Fecha de Emision del Documento es Mayor a Fecha de Amortizacion",0+48,"Validacion")
	RETURN llRetorno
ENDIF

*- Carga Datos
lnNroSecDoc = TmpDoc.NroSec
lcTipAux = TmpDoc.TipAux
lcCodAux = TmpDoc.CodAux
lcNomAux = TmpDoc.NomAux
ldFecDoc = TmpDoc.FecDoc 
lcTipMnd = TmpDoc.TipMnd
lcCodMnd = TmpDoc.CodMnd
lcSimbol = TmpDoc.Simbol
lnImpTot = TmpDoc.ImpTot
lnImpSld = TmpDoc.ImpTot - TmpDoc.ImpAmo
lcCodCta = TmpDoc.CodCta
llRetorno = .T.
USE IN TmpDoc

RETURN llRetorno
ENDFUNC

*-----------------------------------------------------------------------------
*- AMORTIZA Documentos
*-----------------------------------------------------------------------------
FUNCTION FunAmoDoc(lnNroSecDoc,lnImpAmo,ldFecMov,lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
LOCAL llRetorno,lnRegSel
*- Situacion 
*- 1 Pendiente
*- 4 Cancelado
llRetorno = .F.

*- Selecciono Documento
lnRegSel = 0
DO CASE 
CASE lcTipDoc == "RI" OR lcTipDoc == "RE"
	lnRegSel = FunSel_RcbCab(lnNroSecDoc)
CASE lcTipDoc == "LT"	
	lnRegSel = FunSel_LetCab(lnNroSecDoc)
CASE lcTipDoc == "PC"
	lnRegSel = FunSel_PlnCab(lnNroSecDoc)
OTHER
	lnRegSel = FunSel_DocCab(lnNroSecDoc)
ENDCASE
IF !USED("TmpDoc")
	MESSAGEBOX("No se pudo seleccionar Documentos",0+48,"Validacion")
	RETURN llRetorno
ENDIF
SELE TmpDoc
GO TOP

*- Ubicacion Documento
IF EMPTY(lnRegSel) OR lnRegSel = 0
	MESSAGEBOX("Documento No se Encuentra Provisionado",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Saldo del Documento
IF TmpDoc.ImpAmo > TmpDoc.ImpTot
	MESSAGEBOX("Importe Amortizado es Mayor que el Saldo del Documento",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Situacion del Documento
*IF TmpDoc.IndSit <> 1
*	MESSAGEBOX("Documento No se Encuentra Pendiente",0+48,"Validacion")
*	RETURN llRetorno
*ENDIF
*- Fecha de Emision del Documento
IF TmpDoc.FecDoc > ldFecMov
	MESSAGEBOX("Fecha de Emision del Documento es Mayor a Fecha de Amortizacion",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Saldo del Documento
IF lnImpAmo > (TmpDoc.ImpTot - TmpDoc.ImpAmo)
	MESSAGEBOX("Importe de Amortizacion es Mayor que el Saldo del Documento",0+48,"Validacion")
	USE IN TmpDoc
	RETURN llRetorno
ENDIF
*- Descuento
IF lnImpAmo < 0
	IF TmpDoc.ImpAmo + lnImpAmo < 0
		MESSAGEBOX("Importe Amortizado a Descontar es Mayor que lo Amortizado",0+64,"Eliminacion")
		USE IN TmpDoc
		RETURN llRetorno
	ENDIF
ENDIF
USE IN TmpDoc
*- Bloqueo Documento
*IF !RLOCK("RcbCab")
*	MESSAGEBOX("Documento se Encuentra en Uso por Otro",0+48,"Validacion")
*	RETURN llRetorno
*ENDIF

*- Amortizo
DO CASE 
CASE lcTipDoc == "RI" OR lcTipDoc == "RE"
	IF !FunAmo_RcbCab(lnNroSecDoc,lnImpAmo,ldFecMov)
		RETURN llRetorno
	ENDIF
CASE lcTipDoc == "LT"	
	IF !FunAmo_LetCab(lnNroSecDoc,lnImpAmo,ldFecMov)
		RETURN llRetorno
	ENDIF
CASE lcTipDoc == "PC"
	IF !FunAmo_PlnCab(lnNroSecDoc,lnImpAmo,ldFecMov)
		RETURN llRetorno
	ENDIF
OTHER
	IF !FunAmo_DocCab(lnNroSecDoc,lnImpAmo,ldFecMov)
		RETURN llRetorno
	ENDIF
ENDCASE

llRetorno = .T.
RETURN llRetorno
ENDFUNC

*-------------------------------------------------------------------------------
*- Actualiza Amortizacion
*------------------------------------------------------------------------------
FUNCTION FunAmo_DocCab(lnNroSecDoc,lnImpAmo,ldFecMov)
LOCAL llRetorno
llRetorno = .F.
*-
UPDATE DocCab ;
	SET ImpAmo = (ImpAmo + lnImpAmo), ;
		IndSit = IIF(ImpTot = ImpAmo,4,1), ;
		FecSit = ldFecMov, ;
		UsuAct = gCodUsu, ;
		FecAct = DATETIME() ;
WHERE NroSec == lnNroSecDoc
IF _TALLY <> 1
	MESSAGEBOX("Problemas al Amortizar Registro en DocCab",0+64,"Eliminacion")
	RETURN .F.
ENDIF
llRetorno = .T.
RETURN llRetorno
ENDFUNC

FUNCTION FunAmo_RcbCab(lnNroSecDoc,lnImpAmo,ldFecMov)
LOCAL llRetorno
llRetorno = .F.
UPDATE RcbCab ;
	SET ImpAmo = (ImpAmo + lnImpAmo), ;
		ImpAmo = IIF(ImpAmo < 0,0.00,ImpAmo), ;
		ImpAmo = IIF(ImpAmo > ImpOrg,ImpOrg,ImpAmo), ;
		IndSit = IIF(ImpOrg = ImpAmo,4,1), ;
		FecSit = ldFecMov, ;
		UsuAct = gCodUsu, ;
		FecAct = DATETIME() ;
WHERE NroSec == lnNroSecDoc
IF _TALLY <> 1
	MESSAGEBOX("Problemas al Amortizar Registro en RcbCab",0+64,"Eliminacion")
	RETURN .F.
ENDIF
llRetorno = .T.
RETURN llRetorno
ENDFUNC

FUNCTION FunAmo_PlnCab(lnNroSecDoc,lnImpAmo,ldFecMov)
LOCAL llRetorno
llRetorno = .F.
UPDATE PlnCab ;
	SET ImpAmo = (ImpAmo + lnImpAmo), ;
		ImpAmo = IIF(ImpAmo < 0,0.00,ImpAmo), ;
		ImpAmo = IIF(ImpAmo > ImpOrg,ImpOrg,ImpAmo), ;
		IndSit = IIF(ImpOrg = ImpAmo,4,1), ;
		FecSit = ldFecMov, ;
		UsuAct = gCodUsu, ;
		FecAct = DATETIME() ;
WHERE NroSec == lnNroSecDoc
IF _TALLY <> 1
	MESSAGEBOX("Problemas al Amortizar Registro en PlnCab",0+64,"Eliminacion")
	RETURN .F.
ENDIF
llRetorno = .T.
RETURN llRetorno
ENDFUNC

FUNCTION FunAmo_LetCab(lnNroSecDoc,lnImpAmo,ldFecMov)
LOCAL llRetorno
llRetorno = .F.
UPDATE LetCab ;
	SET ImpAmo = (ImpAmo + lnImpAmo), ;
		ImpAmo = IIF(ImpAmo < 0,0.00,ImpAmo), ;
		ImpAmo = IIF(ImpAmo > ImpOrg,ImpOrg,ImpAmo), ;
		IndSit = IIF(ImpOrg = ImpAmo,4,1), ;
		FecSit = ldFecMov, ;
		UsuAct = gCodUsu, ;
		FecAct = DATETIME() ;
WHERE NroSec == lnNroSecDoc
IF _TALLY <> 1
	MESSAGEBOX("Problemas al Amortizar Registro en LetCab",0+64,"Eliminacion")
	RETURN .F.
ENDIF
llRetorno = .T.
RETURN llRetorno
ENDFUNC

*-------------------------------------------------------------------------------
*- SELECCION Documentos
*------------------------------------------------------------------------------
*- Seleccion Documento
FUNCTION FunSelDoc(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, M.NroSec, M.TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.CodMnd, M.Simbol, M.ImpTot, M.ImpAmo, M.IndSig, ;
	   M.IndSit, SPACE(01) As TipCto, SPACE(04) As CodCto, SPACE(40) As DesCto, M.CodCta, ;
	   PADR(IIF(M.TipOpe == "1","VENTA "+NVL(V.DesVta,""),"COMPRA"),40) As Glosa ;
FROM DocCab M LEFT OUTER JOIN TipVta V ON M.TipVta == V.TipVta ;
WHERE M.TipAux+M.CodAux+M.TipDoc+M.NroDoc = lcTipAux+lcCodAux+lcTipDoc+lcNroDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

*- Seleccion Recibo
FUNCTION FunSelRcb(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, M.NroSec, M.TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.CodMnd, M.Simbol, M.ImpOrg As ImpTot, M.ImpAmo, M.IndSig, ;
	   M.IndSit, M.TipCto, M.CodCto, M.Glosa As DesCto, M.CodCta, M.Glosa ;
FROM RcbCab M ;
WHERE M.TipAux+M.CodAux+M.TipDoc+M.NroDoc = lcTipAux+lcCodAux+lcTipDoc+lcNroDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

*- Seleccion Planilla Cobranza
FUNCTION FunSelPlnCob(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, M.NroSec, "1" As TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.CodMnd, M.Simbol, M.ImpOrg As ImpTot, M.ImpAmo, M.IndSig, ;
	   M.IndSit, SPACE(01) As TipCto, SPACE(04) As CodCto, SPACE(40) As DesCto, M.CodCta, ;
	   PADR("PLANILLA DE COBRANZA",40) As Glosa ;
FROM PlnCab M ;
WHERE M.TipAux+M.CodAux+M.TipDoc+M.NroDoc = lcTipAux+lcCodAux+lcTipDoc+lcNroDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

*- Seleccion Letra
FUNCTION FunSelLet(lcTipAux,lcCodAux,lcTipDoc,lcNroDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, M.NroSec, M.TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.CodMnd, M.Simbol, M.ImpOrg As ImpTot, M.ImpAmo, M.IndSig, ;
	   M.IndSit, SPACE(01) As TipCto, SPACE(04) As CodCto, SPACE(40) As DesCto, M.CodCta, ;
	   PADR("LETRAS",40) As Glosa ;
FROM LetCab M ;
WHERE M.TipAux+M.CodAux+M.TipDoc+M.NroDoc = lcTipAux+lcCodAux+lcTipDoc+lcNroDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

FUNCTION FunSel_DocCab(lnNroSecDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.NroSec, M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, M.TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.ImpTot, M.ImpAmo, M.IndSig, M.IndSit ; 
FROM DocCab M ;
WHERE M.NroSec == lnNroSecDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

*- Seleccion Recibo
FUNCTION FunSel_RcbCab(lnNroSecDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.NroSec, M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, M.TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.ImpOrg As ImpTot, M.ImpAmo, M.IndSig, M.IndSit ;
FROM RcbCab M ;
WHERE M.NroSec == lnNroSecDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

*- Seleccion Planilla Cobranza
FUNCTION FunSel_PlnCab(lnNroSecDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.NroSec, M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, "1" As TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.ImpOrg As ImpTot, M.ImpAmo, M.IndSig, M.IndSit ;
FROM PlnCab M ;
WHERE M.NroSec == lnNroSecDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

*- Seleccion Letra
FUNCTION FunSel_LetCab(lnNroSecDoc)
LOCAL llRetorno
llRetorno = 0
SELECT M.NroSec, M.TipAux, M.CodAux, M.TipDoc, M.NroDoc, M.TipOpe, M.NomAux, M.FecDoc, ;
	   M.TipMnd, M.ImpOrg As ImpTot, M.ImpAmo, M.IndSig, M.IndSit ;
FROM LetCab M ;
WHERE M.NroSec == lnNroSecDoc ;
INTO CURSOR TmpDoc
llRetorno = _TALLY
RETURN llRetorno
ENDFUNC

*----------------------------------
*- ACCESOS
*------------------------------------
FUNCTION FunMenuAcc(lcCodOpc)
LOCAL llReturn,lcCodUsu,lcCodApl,lnOldSele
lnOldSele = SELECT()
lcCodUsu = PADR(ALLTRIM(gCodUsu),4)
lcCodApl = PADR(ALLTRIM(gCodApl),10)
lcCodOpc = PADR(ALLTRIM(lcCodOpc),20)
llReturn = .F.
SELECT M.CodUsu, M.CodApl, M.CodOpc FROM TabAcc M ;
WHERE M.CodUsu+M.CodApl+M.CodOpc == lcCodUsu+lcCodApl+lcCodOpc ;
INTO CURSOR TmpAc
IF _TALLY > 0
	llReturn = .T.
ENDIF
USE IN TmpAc
SELE (lnOldSele)
RETURN llReturn
ENDFUNC

FUNCTION FunAcceso()
LOCAL llReturn, lnOldSele
llReturn = .F.
lnOldSele = SELECT()
IF !FILE_USE("Accesos","S")
	RETURN .F.
ENDIF
SELECT A.CodUsu, A.CodApl, A.CodEmp, A.CodPrg ;
FROM Accesos A ;
WHERE A.CodUsu = gCodUsu AND A.CodApl = gCodApl AND A.CodEmp = gCodEmp ;
INTO CURSOR TmpEmp
IF _TALLY > 0
	*goApp.cStartupMenu=gRuta+"\menus\"+ALLTRIM(TmpEmp.CodPrg)
	llReturn = .T.
ENDIF
USE IN TmpEmp
USE IN Accesos
SELE (lnOldSele)
RETURN llReturn
ENDFUNC

FUNCTION Fun_Log(lcTipo)
LOCAL llReturn, lnOldSele
IF EMPTY(gCodUsu) OR ISNULL(gCodUsu)
	RETURN
ENDIF
llReturn = .F.
lnOldSele = SELECT()
USE &gRutEmp\TabLog IN 0 AGAIN
APPEND BLANK
REPLACE CodUsu WITH gCodUsu, ;
		FecSis WITH DATETIME(), ;
		Tipo   WITH lcTipo
USE IN TabLog
SELE (lnOldSele)
llReturn = .T.
RETURN llReturn
ENDFUNC