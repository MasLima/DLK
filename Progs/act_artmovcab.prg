SET DELETE ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET CENTURY ON
SET DATE TO DMY
SET HOURS TO 24

SET SAFETY OFF
SET ESCAPE OFF
SET COMPATIBLE OFF

sele 0
IF !FILE_USE("ArtMovCab","E")
	RETURN
ENDIF
*-
sele 0
IF !FILE_USE("ArtMovDet","E")
	RETURN
ENDIF
*-
sele 0
IF !FILE_USE("ArtMovSer","E")
	RETURN
ENDIF

sele 0
use \aplivf\dlk\restore\tmpcab EXCLU

select A.* from ArtMovDet A where a.nrosec not in (select nrosec from artmovcab) into cursor tmpDet

select distinct nrosec from tmpDet into cursor tmpDet
set step on
sele tmpDet
go top
do while !eof()
	lnNroSec = tmpDet.NroSec
	store 0 to 	lntottot,lnNroSecDet,lnNroItm,lnNroSecRef,lnSecOrd
	store "" to lcTipDocRef,lcNroDocRef,lcTipOrd,lcNroOrd, ;
	  	        lcCodAlm,lcPeriodo,lcTipMov,lcTipTsc,lcTipDoc,lcNroDoc,lcSerDoc,lcSecDoc,lcTipAux,lcCodAux,lcNroRuc,lcNomAux
	store ctod("") to ldFecDoc
	
	select * from ArtMovDet Where NroSec == lnNroSec into cursor tmpD
	if _TALLY > 0
	  lntottot = 0
	  lcTipDocRef = tmpD.TipDocRef
	  lcNroDocRef = tmpD.NroDocRef
	  lnNroSecRef = tmpD.NroSecRef
	  lcTipOrd = tmpD.TipOrd
	  lcNroOrd = tmpD.NroOrd
	  lnSecOrd = tmpD.SecOrd
	  sele tmpD
	  go top
	  scan while !eof()
	  	lnNroSecDet = tmpD.NroSecDet
	  	lnNroItm = tmpD.NroItm
		lntottot = lntottot + TotArt
	  endscan

	  select * from ArtMovSer Where NroSec == lnNroSec into cursor tmp2
	  if _TALLY > 0
	  	lcCodAlm = tmp2.CodAlm
	  	lcPeriodo = tmp2.Periodo
	  	lcTipMov = tmp2.TipMov
	  	lcTipTsc = tmp2.TipTsc
	    lcTipDoc = tmp2.TipDoc
	    lcNroDoc = tmp2.NroDoc
	   	lcSerDoc = subs(lcNroDoc,1,3)
	    lcSecDoc = subs(lcNroDoc,4)
	    ldFecDoc = tmp2.FecMov
	    lcTipAux = tmp2.TipAux
	    lcCodAux = tmp2.CodAux
	    store "" to lcNroRuc,lcNomAux
	    select TipAux, CodAux, NroRuc, NomAux from TabAux Where TipAux == lcTipAux AND CodAux == lcCodAux into cursor tmpAux
	    if _TALLY > 0
	        lcNroRuc = tmpAux.NroRuc
	    	lcNomAux = tmpAux.NomAux
	    endif
	    use in tmpAux
	  endif
	  use in tmp2

	  INSERT INTO TmpCAB (NroSec,CodAlm,Periodo,TipMov,TipTsc, ;
			TipDoc,SerDoc,SecDoc,NroDoc,FecDoc, ;
			TipDocRef,NroDocRef,NroSecRef,TipOrd,NroOrd,SecOrd, ;
			TipAux,CodAux,NroRuc,NomAux,IMPTOT, ;
			NroSecDet,NroItm,IndSit,FecSit, ;
			UsuAdd,FecAdd,UsuAct,FecAct,IndReg) ;
	  VALUES ( lnNroSec,lcCodAlm,lcPeriodo,lcTipMov,lcTipTsc, ;
			lcTipDoc,lcSerDoc,lcSecDoc,lcNroDoc,ldFecDoc, ;
			lcTipDocRef,lcNroDocRef,lnNroSecRef,lcTipOrd,lcNroOrd,lnSecOrd, ;
			lcTipAux,lcCodAux,lcNroRuc,lcNomAux,lntottot, ;
			lnNroSecDet,lnNroItm,4,ldFecDoc, ;
			gCodUsu,DATETIME(),gCodUsu,DATETIME(),1)
	endif
	use in tmpD  
	sele tmpDet
	skip
enddo
use in tmpDet
use in ArtMovCab
use in ArtMovDet
use in ArtMovSer
USE IN TmpCab
return

* TipDocRef = lcTipDoc, NroDocRef = lcNroDoc, NroSecRef = lnNroSec, ;
*				TIPMND = lcTIPMND, TIPCAM = lcTIPCAM, CODMND = lcCODMND, SIMBOL = lcSIMBOL, ;
*				IMPCAM = lnIMPCAM, PCJIGV = lnPCJIGV, IMPTOT = lnTotVal, ;		
*				IndSit = 4, FecSit = ldFecDoc, FecVal = ldFecDoc, ;
