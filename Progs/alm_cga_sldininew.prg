Parameters lcCodAlm,lcAno
LOCAL lcPeriodo,lnAno,lcPeriodoAnt

*- Confirmacion
IF MESSAGEBOX("Continuar Con el Proceso",4+32,"Carga Saldos Iniciales") = 7
	RETURN
ENDIF

*- Periodos
lnAno = VAL(lcAno) + 1
lcPeriodo = ALLTRIM(STR(lnAno,4,0))+"00"
lcPeriodoAnt = lcAno+"12"

*- 
SELE 0
IF !FILE_USE("ArtSld","E")
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("ArtSldMes","E")
	USE IN ArtSld
	RETURN
ENDIF
*-
SELE 0
IF !FILE_USE("ArtCos","E")
	USE IN ArtSld
	USE IN ArtSldMes
	RETURN
ENDIF

*- Selecciono Costos del Periodo Anterior
SELE ArtCos
SET ORDER TO CodArt

SELECT M.CodAlm, M.Periodo, M.CodArt, M.DesArt, M.CodUnd, M.CanSld, M.ImpSld, M.TotSld, ;
       M.ImpSldDol, M.TotSldDol ;
FROM ArtCos M ;
WHERE M.Periodo = lcPeriodoAnt ;
ORDER BY M.CodArt ;
INTO CURSOR TmpCos
IF _TALLY < 1
	MESSAGEBOX("No se Tiene Costos para el Periodo : "+TRANSFORM("@R 9999-99",lcPeriodoAnt),0+64,"Validacion")
	USE IN TmpCos
	USE IN ArtSld
	USE IN ArtSldMes
	USE IN ArtCos
	RETURN
ENDIF

*-WHERE M.CodAlm+M.Periodo = lcCodAlm+lcPeriodoAnt ;
*- Elimina Costo del Periodo
SELE ArtCos 
DELETE FROM ArtCos WHERE Periodo == lcPeriodo
*WHERE CodAlm+Periodo = lcCodAlm+lcPeriodo
PACK 

*- Elimina Saldos del Periodo
SELE ArtSldMes
SET ORDER TO Periodo
DELETE FROM ArtSldMes ;
WHERE Periodo+CodAlm = lcPeriodo+lcCodAlm
PACK 

*- Elimina Saldo Actual
SELE ArtSld
SET ORDER TO CodArt
DELETE FROM ArtSld ;
WHERE CodAlm = lcCodAlm
PACK 

*- Carga Saldos Iniciales Año Siguiente
SELE ArtSldMes
SET ORDER TO CodArt

SELE TmpCos
GO TOP
SCAN WHILE !EOF()
	*- Adiciono Costo
	INSERT INTO ArtCos (CodAlm, Periodo, CodArt, DesArt, CodUnd, CanIni, ImpIni, TotIni, ;
	                    ImpIniDol, TotIniDol, CanSld, ImpSld, TotSld, ImpSldDol, TotSldDol) ;
    VALUES (lcCodAlm, lcPeriodo, TmpCos.CodArt, TmpCos.DesArt, TmpCos.CodUnd, TmpCos.CanSld, TmpCos.ImpSld, TmpCos.TotSld, ;
            TmpCos.ImpSldDol, TmpCos.TotSldDol, TmpCos.CanSld, TmpCos.ImpSld, TmpCos.TotSld, TmpCos.ImpSldDol, TmpCos.TotSldDol)
*	IF _TALLY < 1
*		MESSAGEBOX("ERROR al INSERTAR en ArtCos",0+64,"Adicionar")
*	ENDIF       

	*- Adiciono Saldo Mes
	INSERT INTO ArtSldMes (CodAlm, CodArt, Periodo, CanIng, CanSal, ImpCosSol, ImpCosDol) ;
    VALUES (lcCodAlm, ArtCos.CodArt, lcPeriodo, IIF(ArtCos.CanSld > 0,ArtCos.CanSld,0), ;
            IIF(ArtCos.CanSld < 0,-1*ArtCos.CanSld,0), ArtCos.ImpSld, ArtCos.ImpSldDol)
*	IF _TALLY < 1
*		MESSAGEBOX("ERROR al INSERTAR en ArtSldMes",0+64,"Adicionar")
*	ENDIF       
	
	SELE TmpCos
ENDSCAN
USE IN TmpCos

*- Actualizo Saldo Actual
SELE ArtSldMes
SET ORDER TO CodArt

SELECT S.CodAlm, S.CodArt, S.Periodo, S.CanIng, S.CanSal ;
FROM ArtSldMes S ;
WHERE S.CodAlm = lcCodAlm AND SUBS(S.Periodo,1,4) == SUBS(lcPeriodo,1,4) ;
INTO CURSOR TmpSldMes

SELECT S.CodAlm, S.CodArt, SUM(S.CanIng) As CanIng, SUM(S.CanSal) As CanSal ;
FROM TmpSldMes S ;
ORDER BY S.CodAlm, S.CodArt ;
GROUP BY S.CodAlm, S.CodArt ;
INTO CURSOR TmpSld
USE IN TmpSldMes

SELE TmpSld
GO TOP
SCAN WHILE !EOF()
	INSERT INTO ArtSld (CodAlm, CodArt, CanArt) ;
    VALUES (TmpSld.CodAlm, TmpSld.CodArt, (TmpSld.CanIng - TmpSld.CanSal))
*	IF _TALLY < 1
*		MESSAGEBOX("ERROR al INSERTAR",0+64,"Validacion")
*	ENDIF       
	SELE TmpSld
ENDSCAN
USE IN TmpSld

*- Indexa
SELE ArtSld
WAIT WINDOW "Indexado SldAct " NOWAIT
PACK
INDEX ON CodAlm+CodArt TAG CodArt
USE
*-
SELE ArtSldMes
WAIT WINDOW "Indexado SldMes " NOWAIT
PACK
INDEX ON CodAlm+CodArt+Periodo TAG CodArt 
INDEX ON Periodo+CodAlm+CodArt TAG Periodo
USE
*-
SELE ArtCos
WAIT WINDOW "Indexado ArtCos" NOWAIT
PACK
INDEX ON CodAlm+Periodo+CodArt TAG CodArt 
USE

*- Fin
MESSAGEBOX("Proceso Termino Correctamente",0)
RETURN