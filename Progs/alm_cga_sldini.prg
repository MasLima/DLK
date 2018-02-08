Parameters lcCodAlm,lcAno
LOCAL lcCodArt,lnSldAct,lcPeriodo,lnAno
lnAno = VAL(lcAno) + 1
lcPeriodo = ALLTRIM(STR(lnAno,4,0))+"00"
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
*- Elimina Movimiento del Periodo
SELE ArtSldMes
SET ORDER TO Periodo
SEEK lcPeriodo+lcCodAlm
SCAN WHILE !EOF() AND Periodo+CodAlm = lcPeriodo+lcCodAlm
	DELETE 
ENDSCAN 
PACK 

SELECT M.CodAlm, M.CodArt, M.Periodo, M.CanIng, M.CanSal ;
FROM ArtSldMes M ;
WHERE SUBS(M.Periodo,1,4) = lcAno AND M.CodAlm = lcCodAlm ;
ORDER BY M.CodAlm, M.CodArt ;
INTO CURSOR TmpSldMes
IF _TALLY < 1
	MESSAGEBOX("No se Tiene Informacion",0+64,"Validacion")
	USE IN ArtSld
	USE IN ArtSldMes
	USE IN TmpSldMes
	RETURN
ENDIF

SELECT M.CodAlm, M.CodArt, SUM(M.CanIng) As CanIng , SUM(M.CanSal) As CanSal ;
FROM TmpSldMes M ;
GROUP BY M.CodAlm, M.CodArt ;
ORDER BY M.CodAlm, M.CodArt ;
INTO CURSOR TmpSldAno
USE IN TmpSldMes

*- Carga Saldos Ano Siguiente
SELE ArtSldMes
SET ORDER TO CodArt

SELE TmpSldAno
GO TOP
DO WHILE !EOF()
	SELE ArtSldMes
	SEEK lcCodAlm+TmpSldAno.CodArt+lcPeriodo
	IF EOF()
		APPEND BLANK 
		REPLACE CodAlm  WITH lcCodAlm, ;
				CodArt  WITH TmpSldAno.CodArt, ;
				Periodo WITH lcPeriodo
	ENDIF
	IF (TmpSldAno.CanIng - TmpSldAno.CanSal) >= 0
		REPLACE	CanIng  WITH (TmpSldAno.CanIng - TmpSldAno.CanSal)
	ELSE
		REPLACE	CanSal  WITH (TmpSldAno.CanSal - TmpSldAno.CanIng)
	ENDIF
	SELE TmpSldAno
	SKIP
ENDDO
USE IN TmpSldAno

*- Elimina Saldo Actual
SELE ArtSld
SET ORDER TO CodArt
SEEK lcCodAlm
SCAN WHILE !EOF() AND CodAlm = lcCodAlm
	DELETE 
ENDSCAN 
PACK

*- Actualizo Saldo Actual
SELE ArtSld
SET ORDER TO CodArt
SELE ArtSldMes
SET ORDER TO CodArt

SELE ArtSldMes
SEEK lcCodAlm
DO WHILE !EOF() AND CodAlm = lcCodAlm
	lcCodArt = CodArt
	lnSldAct = 0
	DO WHILE !EOF() AND CodAlm = lcCodAlm AND CodArt = lcCodArt
		IF SUBS(Periodo,1,4) == SUBS(lcPeriodo,1,4)
			lnSldAct = lnSldAct + (CanIng - CanSal)
		ENDIF
		SKIP
	ENDDO
	SELE ArtSld
	SEEK lcCodAlm+lcCodArt
	IF EOF()
		APPEND BLANK 
		REPLACE CodAlm  WITH lcCodAlm, ;
				CodArt  WITH lcCodArt
	ENDIF
	REPLACE CanArt WITH lnSldAct
	SELE ArtSldMes
ENDDO

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

*- Fin
MESSAGEBOX("Proceso Termino Correctamente",0)
RETURN