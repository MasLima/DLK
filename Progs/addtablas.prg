LOCAL lcFile,lnCampos,lnPos,ArrTmp

IF MESSAGEBOX("Continuar Con el Proceso",4+32,"Adicionar Tablas") = 7
	RETURN
ENDIF

CLOSE TABLES
SET SAFETY OFF

*IF DBUSED("Conta")
*	SET DATABASE TO Conta
*	CLOSE DATABASE
*ENDIF

*OPEN DATABASE &gDBConta
SET DATABASE TO &gdbconta
*-
lcFile = gRutEmp+'\ArtMovSer.DBF'
IF !FILE("&lcFile")
	RELEASE ALL LIKE ArrTmp
	DIMENSION ArrTmp(19,4)
	ArrTmp(1,1)="NroSec"
	ArrTmp(1,2)="I"
	ArrTmp(1,3)=4
	ArrTmp(1,4)=0
	ArrTmp(2,1)="CodArt"
	ArrTmp(2,2)="C"
	ArrTmp(2,3)=20
	ArrTmp(2,4)=0
	ArrTmp(3,1)="SerArt"
	ArrTmp(3,2)="C"
	ArrTmp(3,3)=20
	ArrTmp(3,4)=0
	ArrTmp(4,1)="FecMov"
	ArrTmp(4,2)="D"
	ArrTmp(4,3)=8
	ArrTmp(4,4)=0
	ArrTmp(5,1)="TipMov"
	ArrTmp(5,2)="C"
	ArrTmp(5,3)=1
	ArrTmp(5,4)=0
	ArrTmp(6,1)="TipTsc"
	ArrTmp(6,2)="C"
	ArrTmp(6,3)=02
	ArrTmp(6,4)=0
	ArrTmp(7,1)="CodAlm"
	ArrTmp(7,2)="C"
	ArrTmp(7,3)=03
	ArrTmp(7,4)=0
	ArrTmp(8,1)="Periodo"
	ArrTmp(8,2)="C"
	ArrTmp(8,3)=20
	ArrTmp(8,4)=0
	ArrTmp(9,1)="TipAux"
	ArrTmp(9,2)="C"
	ArrTmp(9,3)=2
	ArrTmp(9,4)=0
	ArrTmp(10,1)="CodAux"
	ArrTmp(10,2)="C"
	ArrTmp(10,3)=4
	ArrTmp(10,4)=0
	ArrTmp(11,1)="TipDoc"
	ArrTmp(11,2)="C"
	ArrTmp(11,3)=2
	ArrTmp(11,4)=0
	ArrTmp(12,1)="NroDoc"
	ArrTmp(12,2)="C"
	ArrTmp(12,3)=10
	ArrTmp(12,4)=0
	ArrTmp(13,1)="FecGar"
	ArrTmp(13,2)="D"
	ArrTmp(13,3)=8
	ArrTmp(13,4)=0
	ArrTmp(14,1)="IndSit"
	ArrTmp(14,2)="N"
	ArrTmp(14,3)=1
	ArrTmp(14,4)=0
	ArrTmp(15,1)="IndEst"
	ArrTmp(15,2)="N"
	ArrTmp(15,3)=1
	ArrTmp(15,4)=0
	ArrTmp(16,1)="UsuAdd"
	ArrTmp(16,2)="C"
	ArrTmp(16,3)=4
	ArrTmp(16,4)=0
	ArrTmp(17,1)="FecAdd"
	ArrTmp(17,2)="T"
	ArrTmp(17,3)=8
	ArrTmp(17,4)=0
	ArrTmp(18,1)="UsuAct"
	ArrTmp(18,2)="C"
	ArrTmp(18,3)=4
	ArrTmp(18,4)=0
	ArrTmp(19,1)="FecAct"
	ArrTmp(19,2)="T"
	ArrTmp(19,3)=8
	ArrTmp(19,4)=0

	CREATE TABLE &lcFile FROM ARRAY ArrTmp
	INDEX ON STR(NroSec,10)+CodArt+SerArt TAG SerArt
	INDEX ON CodArt+SerArt TAG CodArt
	USE 
ENDIF

lcFile = gRutEmp+'\ArtSer.DBF'
IF !FILE("&lcFile")
	RELEASE ALL LIKE ArrTmp
	DIMENSION ArrTmp(30,4)
	ArrTmp(1,1)="CodArt"
	ArrTmp(1,2)="C"
	ArrTmp(1,3)=20
	ArrTmp(1,4)=0
	ArrTmp(2,1)="SerArt"
	ArrTmp(2,2)="C"
	ArrTmp(2,3)=20
	ArrTmp(2,4)=0
	ArrTmp(3,1)="FecMovIni"
	ArrTmp(3,2)="D"
	ArrTmp(3,3)=8
	ArrTmp(3,4)=0
	ArrTmp(4,1)="TipMovIni"
	ArrTmp(4,2)="C"
	ArrTmp(4,3)=1
	ArrTmp(4,4)=0
	ArrTmp(5,1)="TipTscIni"
	ArrTmp(5,2)="C"
	ArrTmp(5,3)=02
	ArrTmp(5,4)=0
	ArrTmp(6,1)="CodAlmIni"
	ArrTmp(6,2)="C"
	ArrTmp(6,3)=03
	ArrTmp(6,4)=0
	ArrTmp(7,1)="PeriodoIni"
	ArrTmp(7,2)="C"
	ArrTmp(7,3)=20
	ArrTmp(7,4)=0
	ArrTmp(8,1)="TipAuxIni"
	ArrTmp(8,2)="C"
	ArrTmp(8,3)=2
	ArrTmp(8,4)=0
	ArrTmp(9,1)="CodAuxIni"
	ArrTmp(9,2)="C"
	ArrTmp(9,3)=4
	ArrTmp(9,4)=0
	ArrTmp(10,1)="TipDocIni"
	ArrTmp(10,2)="C"
	ArrTmp(10,3)=2
	ArrTmp(10,4)=0
	ArrTmp(11,1)="NroDocIni"
	ArrTmp(11,2)="C"
	ArrTmp(11,3)=10
	ArrTmp(11,4)=0
	ArrTmp(12,1)="SecMovIni"
	ArrTmp(12,2)="I"
	ArrTmp(12,3)=4
	ArrTmp(12,4)=0
	ArrTmp(13,1)="FecMov"
	ArrTmp(13,2)="D"
	ArrTmp(13,3)=8
	ArrTmp(13,4)=0
	ArrTmp(14,1)="TipMov"
	ArrTmp(14,2)="C"
	ArrTmp(14,3)=1
	ArrTmp(14,4)=0
	ArrTmp(15,1)="TipTsc"
	ArrTmp(15,2)="C"
	ArrTmp(15,3)=02
	ArrTmp(15,4)=0
	ArrTmp(16,1)="CodAlm"
	ArrTmp(16,2)="C"
	ArrTmp(16,3)=03
	ArrTmp(16,4)=0
	ArrTmp(17,1)="Periodo"
	ArrTmp(17,2)="C"
	ArrTmp(17,3)=20
	ArrTmp(17,4)=0
	ArrTmp(18,1)="TipAux"
	ArrTmp(18,2)="C"
	ArrTmp(18,3)=2
	ArrTmp(18,4)=0
	ArrTmp(19,1)="CodAux"
	ArrTmp(19,2)="C"
	ArrTmp(19,3)=4
	ArrTmp(19,4)=0
	ArrTmp(20,1)="TipDoc"
	ArrTmp(20,2)="C"
	ArrTmp(20,3)=2
	ArrTmp(20,4)=0
	ArrTmp(21,1)="NroDoc"
	ArrTmp(21,2)="C"
	ArrTmp(21,3)=10
	ArrTmp(21,4)=0
	ArrTmp(22,1)="SecMov"
	ArrTmp(22,2)="I"
	ArrTmp(22,3)=4
	ArrTmp(22,4)=0
	ArrTmp(23,1)="IndSit"
	ArrTmp(23,2)="N"
	ArrTmp(23,3)=1
	ArrTmp(23,4)=0
	ArrTmp(24,1)="IndEst"
	ArrTmp(24,2)="N"
	ArrTmp(24,3)=1
	ArrTmp(24,4)=0
	ArrTmp(25,1)="FecGarIni"
	ArrTmp(25,2)="D"
	ArrTmp(25,3)=8
	ArrTmp(25,4)=0
	ArrTmp(26,1)="FecGar"
	ArrTmp(26,2)="D"
	ArrTmp(26,3)=8
	ArrTmp(26,4)=0
	ArrTmp(27,1)="UsuAdd"
	ArrTmp(27,2)="C"
	ArrTmp(27,3)=4
	ArrTmp(27,4)=0
	ArrTmp(28,1)="FecAdd"
	ArrTmp(28,2)="T"
	ArrTmp(28,3)=8
	ArrTmp(28,4)=0
	ArrTmp(29,1)="UsuAct"
	ArrTmp(29,2)="C"
	ArrTmp(29,3)=4
	ArrTmp(29,4)=0
	ArrTmp(30,1)="FecAct"
	ArrTmp(30,2)="T"
	ArrTmp(30,3)=8
	ArrTmp(30,4)=0

	CREATE TABLE &lcFile FROM ARRAY ArrTmp
	INDEX ON CodArt+SerArt TAG CodArt
	INDEX ON SerArt TAG SerArt
	INDEX ON FecMov TAG FecMov
	INDEX ON IndSit TAG IndSit
	INDEX ON TipMov+TipTsc TAG TipTsc
	USE 
ENDIF

*-
IF FILE_USE("ArtMovDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UsuAdd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN UsuAdd C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecAdd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN FecAdd T(8)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UsuAct')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN UsuAct C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecAct')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN FecAct T(8)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIna')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN IndIna N(1)
	ENDIF
	USE
ENDIF
*- 
IF FILE_USE("ArtLin","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodLin')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
*	    ALTER TABLE ArtLin ADD COLUMN CodLin C(2)
	ELSE
		ALTER TABLE ArtLin ALTER COLUMN CodLin C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtLin ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtLin ADD COLUMN IndAlm N(1)
	ENDIF
	USE
ENDIF
*-
IF FILE_USE("ArtCla","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodLin')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
*	    ALTER TABLE ArtCla ADD COLUMN CodLin C(2)
	ELSE
		ALTER TABLE ArtCla ALTER COLUMN CodLin C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroSec')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
*	    ALTER TABLE ArtCla ADD COLUMN NroSec N(4)
	ELSE
		ALTER TABLE ArtCla ALTER COLUMN NroSec N(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtCla ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtCla ADD COLUMN IndAlm N(1)
	ENDIF
	USE
ENDIF
*-
IF FILE_USE("ArtArt","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodLin')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
*	    ALTER TABLE ArtArt ADD COLUMN CodLin C(2)
	ELSE
		ALTER TABLE ArtArt ALTER COLUMN CodLin C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodSec')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
*	    ALTER TABLE ArtArt ADD COLUMN CodSec C(4)
	ELSE
		ALTER TABLE ArtArt ALTER COLUMN CodSec C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodMod')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN CodMod C(4)
	ELSE
		ALTER TABLE ArtArt ALTER COLUMN CodMod C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIna')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN IndIna N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('PCJUTI')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN PCJUTI N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IMPUTI')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN IMPUTI N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('PRECOM')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN PRECOM N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('PRECOMSOL')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN PRECOMSOL N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('PRECOMDOL')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN PRECOMDOL N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IMPCAMCOM')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN IMPCAMCOM N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FECCOM')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN FECCOM D(8)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('MNDCOM')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN MNDCOM c(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('SBLCOM')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN SBLCOM c(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN IndAlm N(1)
	ENDIF
	USE
ENDIF
*-
*-
IF FILE_USE("ArtMod","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodLin')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMod ADD COLUMN CodLin C(2)
	ELSE
		ALTER TABLE ArtMod ALTER COLUMN CodLin C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodMar')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMod ADD COLUMN CodMar C(3)
	ELSE
		ALTER TABLE ArtMod ALTER COLUMN CodMar C(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodMod')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMod ADD COLUMN CodMod C(4)
	ELSE
		ALTER TABLE ArtMod ALTER COLUMN CodMod C(4)
	ENDIF
	INDEX ON CodLin+CodMar+CodMod TAG CodMod
	INDEX ON CodLin+CodMar+DesMod TAG DesMod
	USE
ENDIF
*-
*-
IF FILE_USE("ArtTsc","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSit')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtTsc ADD COLUMN IndSit N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndEst')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtTsc ADD COLUMN IndEst N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UltMov')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtTsc ADD COLUMN UltMov C(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UltTsc')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtTsc ADD COLUMN UltTsc C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UltSit')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtTsc ADD COLUMN UltSit N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UltEst')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtTsc ADD COLUMN UltEst N(1)
	ENDIF
	USE
ENDIF
*-
*-
IF FILE_USE("ArtMovCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('Simbol')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovCab ADD COLUMN Simbol C(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovCab ADD COLUMN TipOrd C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovCab ADD COLUMN NroOrd C(20)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('SecOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovCab ADD COLUMN SecOrd I(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovCab ADD COLUMN IndReg N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovCab ADD COLUMN TipReg N(1)
	ENDIF
	USE
ENDIF
*- 
*-
IF FILE_USE("PedCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedCab ADD COLUMN TipVta C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedCab ADD COLUMN IndReg N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedCab ADD COLUMN TipReg N(1)
	ENDIF
	USE
ENDIF
*- 
*-
IF FILE_USE("PedDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN TipVta C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ImpCos')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN ImpCos N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TotCos')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN TotCos N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ImpMar')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN ImpMar N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TotMar')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN TotMar N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipAuxPvd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN TipAuxPvd C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodAuxPvd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN CodAuxPvd C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('DiaEnt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN DiaEnt N(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecEnt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN FecEnt D(8)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('OrdTip')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN OrdTip C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('OrdNro')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN OrdNro C(20)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('OrdSec')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN OrdSec I(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('OrdItm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN OrdItm N(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodCta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN CodCta c(8)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN IndAlm N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIna')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE PedDet ADD COLUMN IndIna N(1)
	ENDIF
	USE
ENDIF
*- 
IF FILE_USE("DocDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN TipVta C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIgv')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN IndIgv N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIna')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN IndIna N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('faccon')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN faccon N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('undmed')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN undmed c(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('canmed')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN canmed N(15,3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('impmed')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN impmed N(15,6)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocDet ADD COLUMN IndAlm N(1)
	ENDIF
	USE
ENDIF
*- 
*- 
IF FILE_USE("GuiDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN TipVta C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIna')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN IndIna N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIgv')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN IndIgv N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN IndAlm N(1)
	ENDIF
	USE
ENDIF
*- 
IF FILE_USE("ArtMovDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN TipVta C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIna')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN IndIna N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIgv')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN IndIgv N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN IndAlm N(1)
	ENDIF
	USE
ENDIF
*- 
*- 
*-
IF FILE_USE("TabAux","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroAnx')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN NroAnx C(5)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TlfCel')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN TlfCel C(12)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('Cargo')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN Cargo C(40)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('Cargo1')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN Cargo1 C(40)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroTlf1')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos <> 0
	    ALTER TABLE TabAux ALTER COLUMN NroTlf1 C(16)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TlfCel1')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN TlfCel1 C(12)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipDoc')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN TipDoc C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroDoc')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN NroDoc C(15)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ConVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabAux ADD COLUMN ConVta C(2)
	ENDIF
	
	USE
ENDIF
*- 
*- 
IF FILE_USE("OrdComCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodPais')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN CodPais C(3)
	ENDIF
	USE
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodCdd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN CodCdd C(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodPaisEnt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN CodPaisEnt C(3)
	ENDIF
	USE
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodCddEnt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN CodCddEnt C(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('Simbol')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN Simbol C(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN IndReg N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('AplAct')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN AplAct C(15)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('MaqAct')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComCab ADD COLUMN MaqAct C(15)
	ENDIF
	
ENDIF
*- 
*-
IF FILE_USE("GuiCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiCab ADD COLUMN TipOrd C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiCab ADD COLUMN NroOrd C(20)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('SecOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiCab ADD COLUMN SecOrd I(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiCab ADD COLUMN IndReg N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiCab ADD COLUMN TipReg N(1)
	ENDIF
	USE
ENDIF
*- 
*-
IF FILE_USE("DocCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocCab ADD COLUMN IndReg N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipReg')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocCab ADD COLUMN TipReg N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroDet')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocCab ADD COLUMN NroDet C(20)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecDet')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE DocCab ADD COLUMN FecDet D(8)
	ENDIF
	USE
ENDIF
*- 
*- 
IF FILE_USE("OrdComDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TotArt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComDet ADD COLUMN TotArt N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIgv')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComDet ADD COLUMN IndIgv N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndIna')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComDet ADD COLUMN IndIna N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndSer')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComDet ADD COLUMN IndSer N(1)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('IndAlm')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComDet ADD COLUMN IndAlm N(1)
	ENDIF
	USE
ENDIF
*- 
*- 
IF FILE_USE("TabPar","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NomRep')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabPar ADD COLUMN NomRep C(30)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroNex')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabPar ADD COLUMN NroNex C(10)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecPcs')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE TabPar ADD COLUMN FecPcs D(8)
	ENDIF
	USE
ENDIF
*-
*- 
IF FILE_USE("GuiDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN TipVta C(2)
	ENDIF
	USE
ENDIF
*- 
IF FILE_USE("BcoDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecDoc')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE BcoDet ADD COLUMN FecDoc D(8)
	ENDIF
	USE
ENDIF
*-
*- 23/06/2006
*- 
IF FILE_USE("ArtMovDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TotArt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN TotArt N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN TipOrd C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN NroOrd C(20)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('SecOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN SecOrd I(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ItmOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovDet ADD COLUMN ItmOrd N(3)
	ENDIF
	USE
ENDIF
*-
IF FILE_USE("GuiDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TotArt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN TotArt N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN TipOrd C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN NroOrd C(20)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('SecOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN SecOrd I(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ItmOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN ItmOrd N(3)
	ENDIF
	USE
ENDIF
*-
IF FILE_USE("ArtMovSer","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('NroSecDet')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovSer ADD COLUMN NroSecDet I(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ItmOrd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovSer ADD COLUMN ItmOrd N(3)
	ENDIF
	USE
ENDIF
*-
IF FILE_USE("OrdComDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodCta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComDet ADD COLUMN CodCta c(8)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipVta')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE OrdComDet ADD COLUMN TipVta c(2)
	ENDIF
	USE
ENDIF
*- 
*-
*- 29/06/2006
*-
IF FILE_USE("ArtMovCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecVal')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtMovCab ADD COLUMN FecVal D(8)
	ENDIF
	USE
ENDIF
*-
*-
IF FILE_USE("ArtArt","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CanArt')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE ArtArt ADD COLUMN CanArt N(10,3)
	ENDIF
	USE
ENDIF
*-
*- 03/07/2006
*-
IF FILE_USE("GuiDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UsuAdd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN UsuAdd C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecAdd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN FecAdd T(8)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('UsuAct')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN UsuAct C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecAct')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiDet ADD COLUMN FecAct T(8)
	ENDIF
	USE
ENDIF
*-
*-
IF FILE_USE("GuiCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('FecVal')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE GuiCab ADD COLUMN FecVal D(8)
	ENDIF
	USE
ENDIF
*-
*-
*-
IF FILE_USE("LetCanCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('Simbol')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanCab ADD COLUMN Simbol C(3)
	ENDIF
	USE
ENDIF
*-
*-
IF FILE_USE("LetCanDet","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipAux')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanDet ADD COLUMN TipAux C(2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodAux')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanDet ADD COLUMN CodAux C(4)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('Simbol')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanDet ADD COLUMN Simbol C(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ImpSld')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanDet ADD COLUMN ImpSld N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ImpDeb')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanDet ADD COLUMN ImpDeb N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('ImpHab')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanDet ADD COLUMN ImpHab N(12,2)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('TipCto')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCanDet ADD COLUMN TipCto C(1)
	ENDIF
	USE
ENDIF
*-
*-
IF FILE_USE("LetCab","E")
	lnCampos = AFIELDS(laCampos)
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodPais')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCab ADD COLUMN CodPais C(3)
	ENDIF
	lnPos = 0
	FOR I = 1 TO lnCampos
		IF ALLTRIM(UPPER(laCampos[I,1])) == UPPER('CodCdd')
			lnPos = I
			EXIT
		ENDIF
	ENDFOR
	IF  lnPos = 0
	    ALTER TABLE LetCab ADD COLUMN CodCdd C(3)
	ENDIF
	USE
ENDIF
*-
*-
MESSAGEBOX('Proceso Termino Correctamente',0+64,"Adicion de Tablas")
RETURN