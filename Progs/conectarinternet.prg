
*_screen.image = "\ApliVF\ApliAdmiCopeal\BITMAPS\cielo.jpg"

*_screen.addobject("oImg", "image")
*_screen.oImg.picture = "\ApliVF\ApliAdmiDisan\BITMAPS\cielo.jpg"
*_screen.oImg.visible = .T.
*_screen.oImg.stretch = 1
*_screen.oImg.width = 640
*_screen.oImg.height = 400

*Logo en pantalla principal

*Efectivamente como dice Alex, @ ... SAY es conveniente no usarlo. Si no quieres usar

*_screen.image = "d:\MiArchivo.jpg"

*puedes controlar el tamaño y la posición con:

*_screen.addobject("oImg", "image")
*_screen.oImg.picture = "d:\consulta\dv.jpg"
*_screen.oImg.visible = .T.
*_screen.oImg.stretch = 1
*_screen.oImg.width = 640
*_screen.oImg.height = 400


*loExplorer = CreateObject("InternetExplorer.Application")
*loExplorer.Navigate("http://www.apesoft.org")
*loExplorer.Visible=.T.
**Release.loExplorer 

*Memoria. Limitar en VFP

*Debes chequear la funcion SYS(3050), resulta que VFP usa la memoria virtual de windows, por lo tanto esta usando mas ram de la que posee fisicamente, y en consecuencia el uso es 'indiscriminado'.

*Con esta funcion puedes setear tanto en foreground como en background. Y segun cuentan se deberia probar mas o menos al tercio de lo que te informa la primera vez...

*Pero la recomendacion es que seteas tu necesidad o vayas bajando de a un k para ir probando la performance.

*Ademas de lograr un mejor control de memoria, tendras un mejor aprovechamiento que redundara en mayor velocidad de ejecucion.



*Tamaño del ejecutable. Reducir

*. Excluir los formularios
*. Excluir los reportes y las tablas.
*. No poner imágenes muy pesadas. Si estás en VFP convierte los BMP's a JPG's ó GIF's
*. Si incluyes una Base de Datos (solo de vistas o conexiones) hazle un PACK DATABASE
*. Menú 'proyecto' - Limpiar proyecto
*. Menú 'Proyecto' - 'Información del proyecto' - Quitar marca 'informar de depuración.
*. Limpiar bibliotecas de clases (vcx)



*Hacer un cursor modificable

*Para hacer el cursor modificable te vale la siguiente funcion:

*FUNCTION hazmodificable
*LPARAMETERS tcalias
*USE DBF(tcalias) IN 0 AGAIN alias xxTemp
*USE DBF("xxTemp") IN (tcalias) AGAIN ALIAS (tcalias)
*USE IN xxTemp


*Imprimir texto DOS desde VFP

*set printer to lpt1
*set device to print
*copy file NomArchivo.prn to lpt1
*set printer to
*set device to screen


*Enviar un email por Outlook

*strProfile = "nombredeusuarioperfil"
*strPassword = "passwordperfil"
*strRecipient = "aquien@dominio.com"
*strSubject = "Asunto"
*strBody = "Este es el mensaje..."

*theApp = CreateObject("Outlook.Application")
*theNameSpace = theApp.GetNameSpace("MAPI")
*theNameSpace.Logon(strProfile , strPassword)
*theMailItem = theApp.CreateItem(0)

*theMailItem.Recipients.Add( strRecipient )
*theMailItem.Subject = strSubject
*theMailItem.Body = strBody
*theMailItem.Send
*theNameSpace.Logoff

*Fax. Envio desde VFP

*Winfax funciona muy bien. (http://www.delrina.com/)

*Lo puedes manejar facilmente a través de COM:

*oWinFax = CreateObject("WinFax.SDKSend")
*oWinFax.SetSubject("Test Fax")
*oWinFax.SetNumber("1234567")
*oWinFax.SetAreaCode("555")
*oWinFax.SetCompany("Alguna Compañía")
*oWinFax.AddRecipient()  && requerido
*oWinFax.SetPrintFromApp(1)
*oWinFax.AddAttachmentFile("")  && aqui va archivo si quieres
*oWinFax.Send(1)

*SET PRINTER TO NAME winfax
*REPORT FORM MyReport TO PRINT NOCONSOLE
*SET PRINTER TO
*RELEASE oWinFax

*HTH

*--
*Alex Feldstein - MCP Visual FoxPro
