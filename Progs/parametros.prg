public gcodusu,gNomUsu,gNomApp,gCodApl,gcodEmp,gNomEmp, ;
	   gruta,gRutDat,gRutCon,gRutEmp,gRutTemp,gdbconta,gdbcomun,gtipauxvdd,gcodauxvdd

SET DELETE ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET CENTURY ON
SET DATE TO DMY
SET HOURS TO 24

SET SAFETY OFF
SET ESCAPE OFF
*SET COMPATIBLE OFF

gtipauxvdd = "06"
gcodauxvdd = "0002"

gcodusu  = "0010"
gNomusu  = "DAVID GUEVARA"
gCodApl  = "APLIADMI"
gNomApp  = "Aplicacion Administrativa"

gRuta    = "\APLIVF\DLK\ApliAdmi"
gRutDat  = "\APLIVF\DLK\ApliDat"
gRutCon  = "\APLIVF\DLK\ApliCon"
gRutTemp = "\APLIVF\DLK\Temp"

gcodemp  = "001"
gRutEmp  = gRutDat+"\DAT"+gcodemp
gdbconta = gRutEmp+"\conta.dbc"
gdbcomun = gRutDat+"\comun.dbc"
gNomEmp = "DLK SAC"

SET PATH TO ;&gRutDat;&gRutEmp

OPEN DATABASE &gdbcomun SHARED
OPEN DATABASE &gdbconta SHARED

lcProc   = gRuta+"\progs\ApliAdmi"
set procedure to (lcProc)
lcProc   = gRuta+"\progs\ApliLib.fxp"
set procedure to (lcProc) ADDITIVE
lcProc   = gRuta+"\progs\Actualizaciones"
set procedure to (lcProc) ADDITIVE