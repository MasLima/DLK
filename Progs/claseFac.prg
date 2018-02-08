**************************************************
*-- Class:        frmfactura (e:\aplivf\apliadmicopeal\libs\baseform.vcx)
*-- ParentClass:  frmmov (e:\aplivf\apliadmicopeal\libs\baseform.vcx)
*-- BaseClass:    form
*
DEFINE CLASS frmfacturaNew AS frmmov


	Top = 0
	Left = 1
	Height = 446
	Width = 686
	DoCreate = .T.
	Caption = "Registro de Facturas"
	BackColor = RGB(150,180,160)
	Name = "frmfactura"
	Shpbase2.Top = 346
	Shpbase2.Left = 14
	Shpbase2.Height = 31
	Shpbase2.Width = 299
	Shpbase2.ZOrderSet = 6
	Shpbase2.Name = "Shpbase2"
	Shpbase1.Top = 0
	Shpbase1.Left = 1
	Shpbase1.Height = 31
	Shpbase1.Width = 684
	Shpbase1.ZOrderSet = 7
	Shpbase1.Name = "Shpbase1"
	cmdFiltrar.Top = 4
	cmdFiltrar.TabIndex = 1
	cmdFiltrar.ZOrderSet = 8
	cmdFiltrar.Name = "cmdFiltrar"
	cmdInicio.Top = 4
	cmdInicio.TabIndex = 3
	cmdInicio.ZOrderSet = 9
	cmdInicio.Name = "cmdInicio"
	cmdRecalcular.Top = 4
	cmdRecalcular.TabIndex = 14
	cmdRecalcular.ZOrderSet = 10
	cmdRecalcular.Name = "cmdRecalcular"
	grdDetalle.ColumnCount = 7
	grdDetalle.Column1.ControlSource = "docdet.detalle"
	grdDetalle.Column1.Width = 325
	grdDetalle.Column1.ReadOnly = .T.
	grdDetalle.Column1.BackColor = RGB(255,255,255)
	grdDetalle.Column1.Name = "colDetalle"
	grdDetalle.Column2.Alignment = 2
	grdDetalle.Column2.ColumnOrder = 2
	grdDetalle.Column2.ControlSource = "docdet.codund"
	grdDetalle.Column2.Width = 32
	grdDetalle.Column2.ReadOnly = .T.
	grdDetalle.Column2.BackColor = RGB(255,255,255)
	grdDetalle.Column2.Name = "colUND"
	grdDetalle.Column3.Alignment = 1
	grdDetalle.Column3.ColumnOrder = 3
	grdDetalle.Column3.ControlSource = "docdet.canart"
	grdDetalle.Column3.Width = 72
	grdDetalle.Column3.ReadOnly = .T.
	grdDetalle.Column3.Format = "Z"
	grdDetalle.Column3.InputMask = "999,999.99"
	grdDetalle.Column3.BackColor = RGB(255,255,255)
	grdDetalle.Column3.Name = "colCantidad"
	grdDetalle.Column4.Alignment = 5
	grdDetalle.Column4.ColumnOrder = 4
	grdDetalle.Column4.ControlSource = "docdet.imppre"
	grdDetalle.Column4.Width = 71
	grdDetalle.Column4.ReadOnly = .T.
	grdDetalle.Column4.Format = "Z"
	grdDetalle.Column4.InputMask = "999999.999999"
	grdDetalle.Column4.BackColor = RGB(255,255,255)
	grdDetalle.Column4.Name = "colPrecio"
	grdDetalle.Column5.Alignment = 1
	grdDetalle.Column5.ColumnOrder = 6
	grdDetalle.Column5.ControlSource = "docdet.totART"
	grdDetalle.Column5.CurrentControl = "Text1"
	grdDetalle.Column5.Width = 72
	grdDetalle.Column5.ReadOnly = .T.
	grdDetalle.Column5.Format = "Z"
	grdDetalle.Column5.InputMask = "9999,999.99"
	grdDetalle.Column5.BackColor = RGB(255,255,255)
	grdDetalle.Column5.Name = "colImpTot"
	grdDetalle.Column6.Alignment = 5
	grdDetalle.Column6.ColumnOrder = 5
	grdDetalle.Column6.ControlSource = "DocDet.PcjDes"
	grdDetalle.Column6.Width = 46
	grdDetalle.Column6.ReadOnly = .T.
	grdDetalle.Column6.Format = "Z"
	grdDetalle.Column6.InputMask = "999.99"
	grdDetalle.Column6.BackColor = RGB(255,255,255)
	grdDetalle.Column6.Name = "colPcjDes"
	grdDetalle.Column7.ColumnOrder = 7
	grdDetalle.Column7.ControlSource = "DocDet.IndIna"
	grdDetalle.Column7.CurrentControl = "chkIndIna"
	grdDetalle.Column7.Width = 1
	grdDetalle.Column7.ReadOnly = .T.
	grdDetalle.Column7.Sparse = .F.
	grdDetalle.Column7.Visible = .F.
	grdDetalle.Column7.Name = "colIndIna"
	grdDetalle.HeaderHeight = 24
	grdDetalle.Height = 117
	grdDetalle.Left = 14
	grdDetalle.Panel = 1
	grdDetalle.ReadOnly = .T.
	grdDetalle.RecordSource = "docdet"
	grdDetalle.TabIndex = 51
	grdDetalle.Top = 230
	grdDetalle.Width = 654
	grdDetalle.GridLineColor = RGB(120,170,180)
	grdDetalle.ZOrderSet = 11
	grdDetalle.Name = "grdDetalle"
	cmdAdiDetalle.Top = 350
	cmdAdiDetalle.Left = 25
	cmdAdiDetalle.TabIndex = 37
	cmdAdiDetalle.ZOrderSet = 12
	cmdAdiDetalle.Name = "cmdAdiDetalle"
	cmdEliDetalle.Top = 350
	cmdEliDetalle.Left = 73
	cmdEliDetalle.TabIndex = 39
	cmdEliDetalle.ZOrderSet = 13
	cmdEliDetalle.Name = "cmdEliDetalle"
	cmdModDetalle.Top = 350
	cmdModDetalle.Left = 49
	cmdModDetalle.TabIndex = 38
	cmdModDetalle.ZOrderSet = 14
	cmdModDetalle.Name = "cmdModDetalle"
	cmdVerDetalle.Top = 350
	cmdVerDetalle.Left = 97
	cmdVerDetalle.TabIndex = 40
	cmdVerDetalle.ZOrderSet = 15
	cmdVerDetalle.Name = "cmdVerDetalle"
	cmdVisualizar.Top = 4
	cmdVisualizar.TabIndex = 2
	cmdVisualizar.ZOrderSet = 16
	cmdVisualizar.Name = "cmdVisualizar"
	cmdAnterior.Top = 4
	cmdAnterior.TabIndex = 4
	cmdAnterior.ZOrderSet = 17
	cmdAnterior.Name = "cmdAnterior"
	cmdSiguiente.Top = 4
	cmdSiguiente.TabIndex = 5
	cmdSiguiente.ZOrderSet = 18
	cmdSiguiente.Name = "cmdSiguiente"
	cmdBuscar.Top = 4
	cmdBuscar.TabIndex = 7
	cmdBuscar.ZOrderSet = 19
	cmdBuscar.Name = "cmdBuscar"
	cmdFinal.Top = 4
	cmdFinal.TabIndex = 6
	cmdFinal.ZOrderSet = 20
	cmdFinal.Name = "cmdFinal"
	cmdAdicionar.Top = 4
	cmdAdicionar.TabIndex = 8
	cmdAdicionar.ZOrderSet = 21
	cmdAdicionar.Name = "cmdAdicionar"
	cmdEliminar.Top = 4
	cmdEliminar.TabIndex = 9
	cmdEliminar.ZOrderSet = 22
	cmdEliminar.Name = "cmdEliminar"
	cmdModificar.Top = 4
	cmdModificar.TabIndex = 10
	cmdModificar.ZOrderSet = 24
	cmdModificar.Name = "cmdModificar"
	cmdGrabar.Top = 4
	cmdGrabar.TabIndex = 11
	cmdGrabar.ZOrderSet = 25
	cmdGrabar.Name = "cmdGrabar"
	cmdImprimir.Top = 4
	cmdImprimir.TabIndex = 12
	cmdImprimir.ZOrderSet = 26
	cmdImprimir.Name = "cmdImprimir"
	cmdSalir.Top = 4
	cmdSalir.Left = 656
	cmdSalir.TabIndex = 17
	cmdSalir.ZOrderSet = 28
	cmdSalir.Name = "cmdSalir"
	cmdDeshacer.Top = 4
	cmdDeshacer.TabIndex = 13
	cmdDeshacer.ZOrderSet = 27
	cmdDeshacer.Name = "cmdDeshacer"
	lblTotal.AutoSize = .T.
	lblTotal.BorderStyle = 0
	lblTotal.Caption = "TOTAL"
	lblTotal.Height = 18
	lblTotal.Left = 527
	lblTotal.Top = 404
	lblTotal.Width = 45
	lblTotal.TabIndex = 63
	lblTotal.ZOrderSet = 23
	lblTotal.Name = "lblTotal"
	fecant = .F.


	ADD OBJECT shpbase8 AS shpbase WITH ;
		Top = 91, ;
		Left = 456, ;
		Height = 129, ;
		Width = 212, ;
		BackColor = RGB(117,152,107), ;
		ZOrderSet = 0, ;
		Name = "Shpbase8"


	ADD OBJECT shpbase7 AS shpbase WITH ;
		Top = 377, ;
		Left = 14, ;
		Height = 54, ;
		Width = 300, ;
		BackColor = RGB(160,188,163), ;
		ZOrderSet = 1, ;
		Name = "Shpbase7"


	ADD OBJECT shpbase6 AS shpbase WITH ;
		Top = 346, ;
		Left = 313, ;
		Height = 85, ;
		Width = 355, ;
		ZOrderSet = 2, ;
		Name = "Shpbase6"


	ADD OBJECT shpbase5 AS shpbase WITH ;
		Top = 32, ;
		Left = 14, ;
		Height = 55, ;
		Width = 437, ;
		BackColor = RGB(117,152,107), ;
		ZOrderSet = 3, ;
		Name = "Shpbase5"


	ADD OBJECT shpbase4 AS shpbase WITH ;
		Top = 32, ;
		Left = 456, ;
		Height = 55, ;
		Width = 212, ;
		BackColor = RGB(193,194,131), ;
		ZOrderSet = 4, ;
		Name = "Shpbase4"


	ADD OBJECT shpbase3 AS shpbase WITH ;
		Top = 91, ;
		Left = 14, ;
		Height = 129, ;
		Width = 437, ;
		SpecialEffect = 0, ;
		BackColor = RGB(143,173,141), ;
		ZOrderSet = 5, ;
		Name = "Shpbase3"


	ADD OBJECT cmdanular AS cmdbase WITH ;
		Top = 4, ;
		Left = 426, ;
		Height = 24, ;
		Width = 24, ;
		FontBold = .T., ;
		Caption = "\<A", ;
		TabIndex = 15, ;
		ToolTipText = "Anular", ;
		ZOrderSet = 29, ;
		Name = "cmdAnular"


	ADD OBJECT txtimpafe AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "doccab.impafe", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "9999,999.99", ;
		Left = 575, ;
		TabIndex = 48, ;
		Top = 351, ;
		Width = 75, ;
		BackColor = RGB(255,255,255), ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 30, ;
		Name = "txtImpAfe"


	ADD OBJECT txtimptot AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "doccab.imptot", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "9999,999.99", ;
		Left = 575, ;
		TabIndex = 50, ;
		Top = 401, ;
		Width = 75, ;
		BackColor = RGB(255,255,255), ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 31, ;
		Name = "txtImpTot"


	ADD OBJECT txtimpigv AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "doccab.impigv", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "9999,999.99", ;
		Left = 575, ;
		TabIndex = 49, ;
		Top = 376, ;
		Width = 75, ;
		BackColor = RGB(255,255,255), ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 32, ;
		Name = "txtImpIgv"


	ADD OBJECT label12 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		Alignment = 1, ;
		BackStyle = 0, ;
		Caption = "Sub Total", ;
		Height = 18, ;
		Left = 509, ;
		Top = 354, ;
		Width = 63, ;
		TabIndex = 55, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 33, ;
		Name = "Label12"


	ADD OBJECT label15 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		Alignment = 1, ;
		BackStyle = 0, ;
		Caption = "IGV", ;
		Height = 18, ;
		Left = 475, ;
		Top = 379, ;
		Width = 25, ;
		TabIndex = 56, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 34, ;
		Name = "Label15"


	ADD OBJECT txtpcjigv AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "doccab.pcjigv", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "999.99", ;
		Left = 504, ;
		TabIndex = 47, ;
		Top = 376, ;
		Width = 50, ;
		BackColor = RGB(255,255,255), ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 35, ;
		Name = "txtPcjIgv"


	ADD OBJECT label17 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		Alignment = 1, ;
		BackStyle = 0, ;
		Caption = "%", ;
		Height = 18, ;
		Left = 555, ;
		Top = 379, ;
		Width = 12, ;
		TabIndex = 57, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 36, ;
		Name = "Label17"


	ADD OBJECT txtnomaux AS txtbase WITH ;
		Alignment = 0, ;
		ControlSource = "doccab.nomaux", ;
		Enabled = .F., ;
		Height = 24, ;
		Left = 72, ;
		TabIndex = 21, ;
		Top = 123, ;
		Width = 367, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 37, ;
		Name = "txtNomAux"


	ADD OBJECT label14 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Señor(es)", ;
		Left = 15, ;
		Top = 127, ;
		TabIndex = 67, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 38, ;
		Name = "Label14"


	ADD OBJECT label6 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "RUC", ;
		Height = 16, ;
		Left = 48, ;
		Top = 103, ;
		Width = 24, ;
		TabIndex = 74, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 39, ;
		Name = "Label6"


	ADD OBJECT lblson AS label WITH ;
		FontBold = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		WordWrap = .T., ;
		BackStyle = 0, ;
		Caption = "SON", ;
		Height = 39, ;
		Left = 25, ;
		Top = 385, ;
		Width = 278, ;
		TabIndex = 73, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 40, ;
		Name = "lblSon"


	ADD OBJECT txtdessit AS txtbase WITH ;
		Alignment = 0, ;
		ControlSource = "indsitdoc.dessit", ;
		Enabled = .F., ;
		Height = 24, ;
		Left = 364, ;
		TabIndex = 33, ;
		Top = 51, ;
		Width = 75, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 41, ;
		Name = "txtDesSit"


	ADD OBJECT label1 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .F., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Situacion", ;
		Left = 377, ;
		Top = 39, ;
		TabIndex = 79, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 42, ;
		Name = "Label1"


	ADD OBJECT cbocodvdd AS cbobase WITH ;
		FontSize = 10, ;
		BoundColumn = 2, ;
		RowSourceType = 3, ;
		RowSource = "SELECT V.NomAux, V.CodAux FROM TabAux V WHERE V.TipAux = DocCab.TipAuxVdd ORDER BY V.NomAux INTO CURSOR cCodVdd", ;
		ControlSource = "doccab.codauxvdd", ;
		Height = 24, ;
		Left = 511, ;
		Style = 2, ;
		TabIndex = 28, ;
		Top = 184, ;
		Width = 139, ;
		ZOrderSet = 43, ;
		DisabledForeColor = RGB(0,0,0), ;
		Name = "cboCodVdd"


	ADD OBJECT label21 AS label WITH ;
		AutoSize = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Vendedor", ;
		Left = 461, ;
		Top = 192, ;
		TabIndex = 70, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 44, ;
		Name = "Label21"


	ADD OBJECT label9 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Serie", ;
		Left = 478, ;
		Top = 55, ;
		TabIndex = 66, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 45, ;
		Name = "Label9"


	ADD OBJECT txtsecdoc AS txtbase WITH ;
		FontSize = 11, ;
		ControlSource = "doccab.secdoc", ;
		Enabled = .T., ;
		Height = 24, ;
		Left = 576, ;
		TabIndex = 35, ;
		Top = 51, ;
		Width = 74, ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 46, ;
		Name = "txtSecDoc"


	ADD OBJECT txtserdoc AS txtbase WITH ;
		FontSize = 11, ;
		ControlSource = "doccab.serdoc", ;
		Height = 24, ;
		Left = 511, ;
		MaxLength = 3, ;
		TabIndex = 34, ;
		Top = 51, ;
		Width = 38, ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 47, ;
		Name = "TxtSerDoc"


	ADD OBJECT label11 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		BackStyle = 0, ;
		Caption = "No", ;
		Left = 554, ;
		Top = 54, ;
		TabIndex = 72, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 48, ;
		Name = "Label11"


	ADD OBJECT txtdireccion AS txtbase WITH ;
		FontSize = 8, ;
		Alignment = 0, ;
		ControlSource = "doccab.direccion", ;
		Height = 36, ;
		Left = 72, ;
		MaxLength = 60, ;
		TabIndex = 22, ;
		Top = 148, ;
		Width = 224, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 49, ;
		Name = "txtDireccion"


	ADD OBJECT label2 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Direccion", ;
		Left = 19, ;
		Top = 152, ;
		TabIndex = 65, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 50, ;
		Name = "Label2"


	ADD OBJECT lbltelefono AS label WITH ;
		AutoSize = .T., ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Periodo", ;
		Left = 248, ;
		Top = 39, ;
		TabIndex = 62, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 51, ;
		Name = "lblTelefono"


	ADD OBJECT txtperiodo AS txtbase WITH ;
		FontSize = 10, ;
		ControlSource = "doccab.periodo", ;
		Enabled = .F., ;
		Format = "R", ;
		Height = 24, ;
		InputMask = "9999-99", ;
		Left = 245, ;
		MaxLength = 6, ;
		TabIndex = 30, ;
		Top = 51, ;
		Width = 55, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 52, ;
		Name = "txtPeriodo"


	ADD OBJECT txtnrocom AS txtbase WITH ;
		ControlSource = "doccab.nrocom", ;
		Enabled = .F., ;
		Height = 24, ;
		Left = 323, ;
		MaxLength = 6, ;
		TabIndex = 32, ;
		Top = 51, ;
		Width = 41, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 53, ;
		Name = "txtNroCom"


	ADD OBJECT label10 AS label WITH ;
		AutoSize = .T., ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Comprobante", ;
		Left = 301, ;
		Top = 39, ;
		TabIndex = 80, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 54, ;
		Name = "Label10"


	ADD OBJECT txttipcom AS txtbase WITH ;
		ControlSource = "doccab.tipcom", ;
		Enabled = .F., ;
		Height = 24, ;
		Left = 301, ;
		MaxLength = 2, ;
		TabIndex = 31, ;
		Top = 51, ;
		Width = 22, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 55, ;
		Name = "txtTipCom"


	ADD OBJECT label5 AS label WITH ;
		FontSize = 8, ;
		Caption = "Vencmto", ;
		Height = 23, ;
		Left = 298, ;
		Top = 186, ;
		Width = 67, ;
		TabIndex = 58, ;
		ForeColor = RGB(0,0,0), ;
		ZOrderSet = 56, ;
		Name = "Label5"


	ADD OBJECT txtfecven AS txtbase WITH ;
		ControlSource = "doccab.fecven", ;
		Enabled = .T., ;
		Height = 24, ;
		Left = 364, ;
		TabIndex = 26, ;
		Top = 184, ;
		Width = 75, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 57, ;
		Name = "txtFecVen"


	ADD OBJECT label3 AS label WITH ;
		AutoSize = .T., ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Fecha", ;
		Left = 479, ;
		Top = 103, ;
		TabIndex = 59, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 56, ;
		Name = "Label3"


	ADD OBJECT txtfecdoc AS txtbase WITH ;
		ControlSource = "doccab.fecdoc", ;
		Enabled = .T., ;
		Height = 24, ;
		Left = 511, ;
		TabIndex = 18, ;
		Top = 99, ;
		Width = 75, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 57, ;
		Name = "txtFecDoc"


	ADD OBJECT label19 AS label WITH ;
		AutoSize = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Condicion", ;
		Left = 23, ;
		Top = 182, ;
		TabIndex = 71, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 44, ;
		Name = "Label19"


	ADD OBJECT txtimpcam AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "doccab.impcam", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "9999.999", ;
		Left = 587, ;
		MaxLength = 0, ;
		TabIndex = 36, ;
		Top = 123, ;
		Width = 63, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 59, ;
		Name = "txtImpCam"


	ADD OBJECT label20 AS label WITH ;
		AutoSize = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Pago", ;
		Left = 46, ;
		Top = 191, ;
		TabIndex = 69, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 44, ;
		Name = "Label20"


	ADD OBJECT cbotipmnd AS cbobase WITH ;
		FontSize = 11, ;
		BoundColumn = 2, ;
		RowSourceType = 3, ;
		RowSource = "SELECT TipMnd.Simbol, TipMnd.TipMnd FROM TipMnd ORDER BY TipMnd.Simbol INTO CURSOR cTipMnd", ;
		ControlSource = "doccab.tipmnd", ;
		Enabled = .T., ;
		Height = 24, ;
		Left = 511, ;
		Style = 2, ;
		TabIndex = 19, ;
		Top = 123, ;
		Width = 75, ;
		ZOrderSet = 61, ;
		DisabledForeColor = RGB(0,0,0), ;
		Name = "cboTipMnd"


	ADD OBJECT cbocodcdd AS cbobase WITH ;
		FontSize = 8, ;
		BoundColumn = 2, ;
		RowSourceType = 3, ;
		RowSource = "SELECT TabCdd.DesCdd, TabCdd.CodCdd FROM TabCdd WHERE TabCdd.CodPais = DocCab.CodPais ORDER BY TabCdd.DesCdd INTO CURSOR cCodCdd", ;
		ControlSource = "doccab.CodCdd", ;
		Height = 20, ;
		Left = 337, ;
		Style = 2, ;
		TabIndex = 23, ;
		Top = 148, ;
		Width = 102, ;
		ZOrderSet = 64, ;
		DisabledForeColor = RGB(0,0,0), ;
		Name = "cboCodCdd"


	ADD OBJECT lbldocumento AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		BackStyle = 0, ;
		Caption = "F A C T U R A", ;
		Left = 517, ;
		Top = 36, ;
		TabIndex = 64, ;
		ZOrderSet = 62, ;
		Name = "lblDocumento"


	ADD OBJECT txtnroruc AS txtbase WITH ;
		Alignment = 0, ;
		ControlSource = "doccab.nroruc", ;
		Height = 24, ;
		Left = 72, ;
		MaxLength = 11, ;
		TabIndex = 20, ;
		Top = 99, ;
		Width = 119, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 63, ;
		Name = "txtNroRuc"


	ADD OBJECT cbocodpos AS cbobase WITH ;
		FontSize = 8, ;
		BoundColumn = 2, ;
		RowSourceType = 3, ;
		RowSource = "SELECT D.DesPos, D.CodPostal FROM TabDtt D WHERE D.CodPais = DocCab.CodPais AND D.CodCdd = DocCab.CodCdd ORDER BY D.DesPos INTO CURSOR cCodPos", ;
		ControlSource = "doccab.codpostal", ;
		Height = 20, ;
		Left = 337, ;
		Style = 2, ;
		TabIndex = 24, ;
		Top = 164, ;
		Width = 102, ;
		ZOrderSet = 64, ;
		DisabledForeColor = RGB(0,0,0), ;
		Name = "cboCodPos"


	ADD OBJECT cmdcancelar AS cmdbase WITH ;
		Top = 4, ;
		Left = 450, ;
		Height = 24, ;
		Width = 24, ;
		FontBold = .T., ;
		Caption = "\<C", ;
		TabIndex = 16, ;
		ToolTipText = "Cancelar", ;
		ZOrderSet = 65, ;
		Name = "cmdCancelar"


	ADD OBJECT cboconvta AS cbobase WITH ;
		FontSize = 10, ;
		BoundColumn = 2, ;
		RowSourceType = 3, ;
		RowSource = "SELECT P.DesTipPgo, P.TipPgo FROM TipPgo P ORDER BY P.DesTipPgo INTO CURSOR cConVta", ;
		ControlSource = "doccab.convta", ;
		Height = 24, ;
		Left = 72, ;
		Style = 2, ;
		TabIndex = 25, ;
		Top = 184, ;
		Width = 224, ;
		ZOrderSet = 66, ;
		DisabledBackColor = RGB(175,200,200), ;
		DisabledForeColor = RGB(0,0,0), ;
		Name = "cboConVta"


	ADD OBJECT label4 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .F., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Remision", ;
		Left = 466, ;
		Top = 172, ;
		TabIndex = 77, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 67, ;
		Name = "Label4"


	ADD OBJECT txtnroguia AS txtbase WITH ;
		Alignment = 0, ;
		ControlSource = "doccab.nroguia", ;
		Height = 24, ;
		Left = 511, ;
		MaxLength = 30, ;
		TabIndex = 27, ;
		Top = 161, ;
		Width = 139, ;
		DisabledForeColor = RGB(0,0,0), ;
		ZOrderSet = 68, ;
		Name = "txtNroGuia"


	ADD OBJECT cmdrefped AS cmdbase WITH ;
		AutoSize = .F., ;
		Top = 350, ;
		Left = 190, ;
		Height = 24, ;
		Width = 24, ;
		FontBold = .T., ;
		FontSize = 9, ;
		Caption = "\<PD", ;
		TabIndex = 43, ;
		ToolTipText = "Referencia de Pedidos", ;
		ZOrderSet = 70, ;
		Name = "cmdRefPed"


	ADD OBJECT txtimpina AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "doccab.impina", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "9999,999.99", ;
		Left = 393, ;
		TabIndex = 46, ;
		Top = 401, ;
		Visible = .F., ;
		Width = 75, ;
		BackColor = RGB(255,255,255), ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 71, ;
		Name = "txtImpIna"


	ADD OBJECT txtimpdes AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "doccab.impdes", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "9999,999.99", ;
		Left = 393, ;
		TabIndex = 45, ;
		Top = 376, ;
		Width = 75, ;
		BackColor = RGB(255,255,255), ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 72, ;
		Name = "txtImpDes"


	ADD OBJECT label18 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		Alignment = 1, ;
		BackStyle = 0, ;
		Caption = "EXONERAC", ;
		Height = 18, ;
		Left = 318, ;
		Top = 404, ;
		Visible = .F., ;
		Width = 73, ;
		TabIndex = 52, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 73, ;
		Name = "Label18"


	ADD OBJECT cmdrefguirem AS cmdbase WITH ;
		AutoSize = .F., ;
		Top = 350, ;
		Left = 143, ;
		Height = 24, ;
		Width = 24, ;
		FontBold = .T., ;
		FontSize = 9, ;
		Caption = "\<GR", ;
		TabIndex = 41, ;
		ToolTipText = "Referencia de Guias de Remision", ;
		ZOrderSet = 74, ;
		Name = "cmdRefGuiRem"


	ADD OBJECT label25 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		Alignment = 1, ;
		BackStyle = 0, ;
		Caption = "DESCTO", ;
		Height = 18, ;
		Left = 336, ;
		Top = 379, ;
		Width = 55, ;
		TabIndex = 53, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 75, ;
		Name = "Label25"


	ADD OBJECT txtimpbto AS txtbase WITH ;
		Alignment = 1, ;
		ControlSource = "DocCab.impbto", ;
		Enabled = .F., ;
		Height = 24, ;
		InputMask = "9999,999.99", ;
		Left = 393, ;
		TabIndex = 44, ;
		Top = 351, ;
		Width = 75, ;
		BackColor = RGB(255,255,255), ;
		DisabledBackColor = RGB(235,200,130), ;
		DisabledForeColor = RGB(255,0,0), ;
		ZOrderSet = 76, ;
		Name = "txtImpBto"


	ADD OBJECT cmdrefalmsal AS cmdbase WITH ;
		AutoSize = .F., ;
		Top = 350, ;
		Left = 167, ;
		Height = 24, ;
		Width = 24, ;
		FontBold = .T., ;
		FontSize = 9, ;
		Caption = "\<GS", ;
		TabIndex = 42, ;
		ToolTipText = "Referencia de Guias de Salida de Almacen", ;
		ZOrderSet = 77, ;
		Name = "cmdRefAlmSal"


	ADD OBJECT label22 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 10, ;
		Alignment = 1, ;
		BackStyle = 0, ;
		BorderStyle = 0, ;
		Caption = "IMP BTO", ;
		Height = 18, ;
		Left = 334, ;
		Top = 354, ;
		Width = 57, ;
		TabIndex = 54, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 78, ;
		Name = "Label22"


	ADD OBJECT cbotipvta AS cbobase WITH ;
		FontSize = 10, ;
		BoundColumn = 2, ;
		RowSourceType = 3, ;
		RowSource = "SELECT P.DesVta, P.TipVta FROM TipVta P ORDER BY P.DesVta INTO CURSOR cTipVta", ;
		ControlSource = "doccab.tipvta", ;
		Height = 24, ;
		Left = 72, ;
		Style = 2, ;
		TabIndex = 29, ;
		Top = 51, ;
		Width = 173, ;
		ZOrderSet = 79, ;
		DisabledBackColor = RGB(175,200,200), ;
		DisabledForeColor = RGB(0,0,0), ;
		Name = "cboTipVta"


	ADD OBJECT lbltipventa AS label WITH ;
		AutoSize = .T., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Tipo de Venta", ;
		Left = 76, ;
		Top = 39, ;
		TabIndex = 68, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 80, ;
		Name = "lblTipVenta"


	ADD OBJECT chkindexp AS chkbase WITH ;
		Top = 7, ;
		Left = 529, ;
		Height = 18, ;
		Width = 42, ;
		BackStyle = 0, ;
		Caption = "EXP", ;
		ControlSource = "DocCab.IndExp", ;
		TabIndex = 81, ;
		Visible = .F., ;
		ZOrderSet = 81, ;
		Name = "chkIndExp"


	ADD OBJECT label13 AS label WITH ;
		AutoSize = .T., ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Moneda", ;
		Left = 471, ;
		Top = 126, ;
		TabIndex = 60, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 56, ;
		Name = "Label13"


	ADD OBJECT label8 AS label WITH ;
		AutoSize = .T., ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Cambio", ;
		Left = 592, ;
		Top = 111, ;
		TabIndex = 61, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 56, ;
		Name = "Label8"


	ADD OBJECT label29 AS label WITH ;
		FontBold = .F., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		Alignment = 1, ;
		Caption = "Distto  ", ;
		Height = 18, ;
		Left = 298, ;
		Top = 167, ;
		Width = 40, ;
		TabIndex = 76, ;
		ForeColor = RGB(0,0,0), ;
		ZOrderSet = 46, ;
		Name = "Label29"


	ADD OBJECT label26 AS label WITH ;
		FontBold = .F., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		Alignment = 1, ;
		Caption = "Ciudad  ", ;
		Height = 18, ;
		Left = 298, ;
		Top = 149, ;
		Width = 40, ;
		TabIndex = 75, ;
		ForeColor = RGB(0,0,0), ;
		ZOrderSet = 46, ;
		Name = "Label26"


	ADD OBJECT label7 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .F., ;
		FontName = "Arial", ;
		FontSize = 8, ;
		BackStyle = 0, ;
		Caption = "Guia", ;
		Left = 487, ;
		Top = 160, ;
		TabIndex = 78, ;
		ForeColor = RGB(255,255,255), ;
		ZOrderSet = 67, ;
		Name = "Label7"


	ADD OBJECT frmfactura.grddetalle.coldetalle.descripcion AS header WITH ;
		FontBold = .T., ;
		Alignment = 0, ;
		Caption = "Descripcion", ;
		Name = "Descripcion"


	ADD OBJECT frmfactura.grddetalle.coldetalle.text1 AS textbox WITH ;
		BorderStyle = 0, ;
		ControlSource = "docdet.detalle", ;
		Margin = 0, ;
		ReadOnly = .T., ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"


	ADD OBJECT frmfactura.grddetalle.colund.und AS header WITH ;
		FontBold = .T., ;
		Alignment = 2, ;
		Caption = "UND", ;
		Name = "UND"


	ADD OBJECT frmfactura.grddetalle.colund.text1 AS textbox WITH ;
		Alignment = 2, ;
		BorderStyle = 0, ;
		ControlSource = "docdet.codund", ;
		Margin = 0, ;
		ReadOnly = .T., ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"


	ADD OBJECT frmfactura.grddetalle.colcantidad.cantidad AS header WITH ;
		FontBold = .T., ;
		Alignment = 2, ;
		Caption = "Cantidad", ;
		Name = "Cantidad"


	ADD OBJECT frmfactura.grddetalle.colcantidad.text1 AS textbox WITH ;
		Alignment = 1, ;
		BorderStyle = 0, ;
		ControlSource = "docdet.canart", ;
		Format = "Z", ;
		InputMask = "999,999.99", ;
		Margin = 0, ;
		ReadOnly = .T., ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"


	ADD OBJECT frmfactura.grddetalle.colprecio.precio AS header WITH ;
		FontBold = .T., ;
		Alignment = 2, ;
		Caption = "Precio", ;
		Name = "Precio"


	ADD OBJECT frmfactura.grddetalle.colprecio.text1 AS textbox WITH ;
		Alignment = 1, ;
		BorderStyle = 0, ;
		ControlSource = "docdet.imppre", ;
		Format = "Z", ;
		InputMask = "999999.999999", ;
		Margin = 0, ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"


	ADD OBJECT frmfactura.grddetalle.colimptot.venta AS header WITH ;
		FontBold = .T., ;
		Alignment = 2, ;
		Caption = "Total", ;
		Name = "Venta"


	ADD OBJECT frmfactura.grddetalle.colimptot.text1 AS textbox WITH ;
		Alignment = 1, ;
		BorderStyle = 0, ;
		Format = "Z", ;
		InputMask = "9999,999.99", ;
		Margin = 0, ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"


	ADD OBJECT frmfactura.grddetalle.colimptot.chkbase1 AS chkbase WITH ;
		Top = 34, ;
		Left = 10, ;
		Name = "Chkbase1"


	ADD OBJECT frmfactura.grddetalle.colpcjdes.descto AS header WITH ;
		FontBold = .T., ;
		Alignment = 2, ;
		Caption = "%Dscto", ;
		Name = "Descto"


	ADD OBJECT frmfactura.grddetalle.colpcjdes.text1 AS textbox WITH ;
		Alignment = 1, ;
		BorderStyle = 0, ;
		Format = "Z", ;
		InputMask = "999.99", ;
		Margin = 0, ;
		Visible = .T., ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"


	ADD OBJECT frmfactura.grddetalle.colindina.ina AS header WITH ;
		FontBold = .T., ;
		Alignment = 2, ;
		Caption = "Ina", ;
		Name = "Ina"


	ADD OBJECT frmfactura.grddetalle.colindina.text1 AS textbox WITH ;
		BorderStyle = 0, ;
		Margin = 0, ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"


	ADD OBJECT frmfactura.grddetalle.colindina.chkindina AS chkbase WITH ;
		Top = 34, ;
		Left = 5, ;
		Visible = .F., ;
		Name = "chkIndIna"


	PROCEDURE final
		LOCAL lnOldReg
		SELE DocCab
		lnOldReg = RECNO()
		SET ORDER TO NroDoc DESCENDING
		SEEK TabOpeDoc.TipOpe+TabOpeDoc.TipDoc
		IF FOUND()
			SET ORDER TO NroDoc ASCENDING
			WITH ThisForm
				.cmdFinal.Enabled=.F.
				.cmdSiguiente.Enabled=.F.
				.cmdAnterior.Enabled=.T.
				.cmdInicio.Enabled=.T.
				.Refresh
			ENDWITH
		ELSE
			WAIT WINDOW "No se Encontro el Final" NOWAIT
			SET ORDER TO NroDoc ASCENDING
			ThisForm.Inicio
		ENDIF
	ENDPROC


	PROCEDURE anterior
		SELE DocCab
		IF BOF() .OR. DocCab.TipOpe+DocCab.TipDoc <> TabOpeDoc.TipOpe+TabOpeDoc.TipDoc
			ThisForm.Inicio
			RETURN
		ENDIF
		SKIP -1
		IF BOF() .OR. DocCab.TipOpe+DocCab.TipDoc <> TabOpeDoc.TipOpe+TabOpeDoc.TipDoc
			ThisForm.Inicio
			RETURN
		ENDIF
		WITH ThisForm
			.cmdInicio.Enabled=.T.
			.cmdAnterior.Enabled=.T.
			.cmdSiguiente.Enabled=.T.
			.cmdFinal.Enabled=.T.
			.Refresh
		ENDWITH
	ENDPROC


	PROCEDURE siguiente
		SELE DocCab
		IF EOF() .OR. DocCab.TipOpe+DocCab.TipDoc <> TabOpeDoc.TipOpe+TabOpeDoc.TipDoc
			ThisForm.Final
			RETURN
		ENDIF
		SKIP 
		IF EOF() .OR. DocCab.TipOpe+DocCab.TipDoc <> TabOpeDoc.TipOpe+TabOpeDoc.TipDoc
			ThisForm.Final
			RETURN
		ENDIF
		WITH ThisForm
			.cmdInicio.Enabled=.T.
			.cmdAnterior.Enabled=.T.
			.cmdSiguiente.Enabled=.T.
			.cmdFinal.Enabled=.T.
			.Refresh
		ENDWITH
	ENDPROC


	PROCEDURE inicio
		SELE DocCab
		SEEK TabOpeDoc.TipOpe+TabOpeDoc.TipDoc
		WITH ThisForm
			.cmdInicio.Enabled=.F.
			.cmdAnterior.Enabled=.F.
			.cmdSiguiente.Enabled=.T.
			.cmdFinal.Enabled=.T.
			.Refresh
		ENDWITH
	ENDPROC


	PROCEDURE ubicaperiodo
		PARAMETERS lcTipOpe, lcTipDoc
		SELE TabOpeDoc
		IF !SEEK(lcTipOpe+lcTipDoc,"TabOpeDoc","TipDoc")
			MESSAGEBOX("No se Ubico Documento en Tabla de Docmtos x Operacion",0+48,"Validacion")
			RETURN .F.
		ENDIF
		SELE DocCab
	ENDPROC


	PROCEDURE desactivacontroles
		WITH ThisForm
			.LockScreen = .T.
			.ActivaBotones
			.cmdFiltrar.Enabled = .F.
			.cmdVisualizar.Enabled = .F.
			.cmdCancelar.Enabled = .T.
			.cmdAnular.Enabled = .T.
			.txtNroRuc.Enabled = .F.
			.txtDireccion.Enabled = .F.
			.cboCodPos.Enabled = .F.
			.cboCodCdd.Enabled = .F.
			.txtSerDoc.Enabled = .F.
			.txtSecDoc.Enabled = .F.
			.txtFecDoc.Enabled = .F.
			.cboTipMnd.Enabled = .F.
			.txtNroGuia.Enabled = .F.
			.cboCodVdd.Enabled = .F.
			.cboConVta.Enabled = .F.
			.cboTipVta.Enabled = .F.
			.txtFecVen.Enabled = .F.
			.chkIndExp.Enabled = .F.
			.cmdAdiDetalle.Enabled = .F.
			.cmdEliDetalle.Enabled = .F.
			.cmdModDetalle.Enabled = .F.
			.cmdVerDetalle.Enabled = .F.
			.cmdRefGuiRem.Enabled = .T.
			.cmdRefAlmSal.Enabled = .F.
			.cmdRefPed.Enabled = .F.
			.grdDetalle.colDetalle.ReadOnly = .T.
			.grdDetalle.colCantidad.ReadOnly = .T.
			.grdDetalle.colPrecio.ReadOnly = .T.
			.grdDetalle.colPcjDes.ReadOnly = .T.
			.grdDetalle.colUnd.ReadOnly = .T.
			.grdDetalle.colIndIna.Enabled = .F.
			.grdDetalle.BackColor = RGB(175,200,200)
			.grdDetalle.ForeColor = RGB(0,0,0)
			.Refresh
			.LockScreen = .F.
		ENDWITH
	ENDPROC


	PROCEDURE buscar
		SELE TabOpeDoc
		DO FORM &gRuta\forms\frmBusFac

		SELE DocCab
		ThisForm.Refresh
	ENDPROC


	PROCEDURE Init
		LOCAL lcTipOpe, lcTipDoc
		FrmMov::Init()
		*- Valores Iniciales
		lcTipOpe  = "1"
		lcTipDoc  = "01"
		*- Operacion Documento
		IF !SEEK(lcTipOpe+lcTipDoc,"TabOpeDoc","TipDoc")
			MESSAGEBOX("Tipo de Documento No Registrado en TabOpeDoc",0+64,"Validacion")
			RETURN .F.
		ENDIF
		SELE DocCab
		ThisForm.FecAnt = DATE()
		ThisForm.Tag = ""
		ThisForm.DesActivaControles
		ThisForm.Final
	ENDPROC


	PROCEDURE Refresh
		LOCAL lcSituacion,lActivo
		ThisForm.CboCodPos.Requery
		ThisForm.lblTotal.Caption = "TOTAL  "+DocCab.Simbol
		ThisForm.lblSon.Caption = "SON "+ALLTRIM(FunImpLetras(DocCab.ImpTot,IIF(SEEK(DocCab.TipMnd,"TipMnd","TipMnd"),TipMnd.DesMnd,"")))
		IF !EMPTY(ThisForm.Tag)
			RETURN
		ENDIF
		IF DocCab.IndSit == 1
			lActivo = .T.
		ELSE
			lActivo = .F.
		ENDIF
		WITH ThisForm
			.cmdModificar.Enabled = lActivo
			.cmdEliminar.Enabled = IIF(DocCab.IndSit == 9,.T.,lActivo)
			.cmdRecalcular.Enabled = lActivo
			.cmdCancelar.Enabled = lActivo
			.cmdAnular.Enabled = lActivo
			.cmdRefGuiRem.Enabled = lActivo
		ENDWITH
	ENDPROC


	PROCEDURE activacontroles
		WITH ThisForm
			.LockScreen = .T.
			.DesActivaBotones
			.cmdVisualizar.Enabled = .F.
			.cmdAnular.Enabled = .F.
			.cmdCancelar.Enabled = .F.
			.txtDireccion.Enabled = .T.
			.cboCodPos.Enabled = .T.
			.cboCodCdd.Enabled = .T.
			.txtNroRuc.Enabled = .T.
			.txtSerDoc.Enabled = .T.
			.txtSecDoc.Enabled = .T.
			.txtFecDoc.Enabled = .T.
			.cboTipMnd.Enabled = .T.
			.txtNroGuia.Enabled = .T.
			.cboCodVdd.Enabled = .T.
			.cboConVta.Enabled = .T.
			.cboTipVta.Enabled = .T.
			.txtFecVen.Enabled = .T.
			.chkIndExp.Enabled = .T.
			.cmdAdiDetalle.Enabled = .T.
			.cmdEliDetalle.Enabled = .T.
			.cmdModDetalle.Enabled = .F.
			.cmdVerDetalle.Enabled = .F.
			.cmdRefGuiRem.Enabled = .F.
			.cmdRefAlmSal.Enabled = .F.
			.cmdRefPed.Enabled = .F.
			.grdDetalle.colDetalle.ReadOnly = .F.
			.grdDetalle.colCantidad.ReadOnly = .F.
			.grdDetalle.colPrecio.ReadOnly = .F.
			.grdDetalle.colPcjDes.ReadOnly = .F.
			.grdDetalle.colUnd.ReadOnly = .F.
			.grdDetalle.colIndIna.Enabled = .T.
			.grdDetalle.BackColor = RGB(255,255,255)
			.grdDetalle.ForeColor = RGB(0,0,0)
			.Refresh
			.LockScreen = .F.
		ENDWITH
	ENDPROC


	PROCEDURE adicionar
		LOCAL lnOldSele, lcTipDoc, lnNroSec, lcNroSecDoc, lcNroSer
		lnOldSele = SELECT()
		lcTipDoc = TabOpeDoc.TipDoc
		lcNroSer = "001"

		*- Secuencia del Registro
		lnNroSec = 0
		lnNroSec = GenNroSec("01","DOCCAB")
		IF EMPTY(lnNroSec)
			MESSAGEBOX("No se pudo Obter la secuencia del registro para DOCCAB",0+64,"Validacion")
			SELE (lnOldSele)
			RETURN .F.
		ENDIF

		*- Secuencia de Documneto
		lcNroSecDoc = SPACE(01)
		lcNroSecDoc = GenNroDoc(lcTipDoc,lcNroSer)
		IF EMPTY(lcNroSecDoc)
			MESSAGEBOX("No se pudo Obter la secuencia del Documento",0+64,"Validacion")
			SELE (lnOldSele)
			RETURN .F.
		ENDIF

		*- Adiciono Registro
		SELE DocCab
		APPEND BLANK
		REPLACE NroSec  WITH lnNroSec, ;
				TipOpe  WITH TabOpeDoc.TipOpe, ;
				Periodo WITH SUBS(DTOS(ThisForm.FecAnt),1,6), ;
				TipCom  WITH TabOpeDoc.TipCom, ;
				CodCta  WITH TabOpeDoc.CodCta, ;
				TipDoc  WITH TabOpeDoc.TipDoc, ;
				SerDoc WITH lcNroSer, ;
				SecDoc WITH lcNroSecDoc, ;
				NroDoc WITH ALLTRIM(SerDoc)+ALLTRIM(SecDoc), ;
				FecDoc 	WITH ThisForm.FecAnt, ;
				FecVen 	WITH ThisForm.FecAnt, ;
				TipAux 	WITH "02", ;
				TipAuxVdd  WITH "06", ;
				IndRegVta  WITH TabOpeDoc.IndRegVta, ;
				IndSig  WITH TabOpeDoc.IndSig, ;
				pcjIgv 	WITH TabPar.PcjIgv, ;
				TipMnd 	WITH "U", ;
				TipCam 	WITH "2", ;
				CodMnd 	WITH TipMnd+TipCam, ;
				Simbol  WITH "US$", ;
				TipVta 	WITH "01", ;
				IndSit 	WITH 1, ;
				FecSit 	WITH DATE()

		IF SEEK("U"+DTOS(DocCab.FecDoc),"Cambio","TipMnd")
			REPLACE DocCab.ImpCam WITH Cambio.ImpVta
		ENDIF

		ThisForm.Tag = "A"
		ThisForm.cboCodVdd.Requery
		ThisForm.ActivaControles

		IF EMPTY(DocCab.ImpCam)
			MESSAGEBOX("Fecha No Registra Tipo de Cambio",0+64,"Validacion")
			ThisForm.txtFecDoc.SetFocus
		ENDIF
		ThisForm.txtNroRuc.SetFocus
	ENDPROC


	PROCEDURE deshacer
		LOCAL lnOldReg

		IF ALLTRIM(DocCab.SerDoc) == ALLTRIM(TabSecDoc.NroSer) AND VAL(DocCab.SecDoc) == TabSecDoc.NroSec
			IF RLOCK("TabSecDoc")
				REPLACE TabSecDoc.NroSec WITH TabSecDoc.NroSec - 1
				UNLOCK IN TabSecDoc
			ENDIF
		ENDIF

		SELE ArtMovCab
		TableRevert(.T.)

		SELE GuiCab
		TableRevert(.T.)

		SELE PedCab
		TableRevert(.T.)

		SELE DocDet
		TableRevert(.T.)

		SELE DocCab
		lnOldReg = RECNO()
		TableRevert()
		IF ThisForm.Tag == "A"
			ThisForm.UbicaPeriodo(TabOpeDoc.TipOpe,TabOpeDoc.TipDoc)
		ELSE
			GO (lnOldReg)
		ENDIF
		UNLOCK ALL
		ThisForm.Tag = ""
		ThisForm.DesActivaControles
	ENDPROC


	PROCEDURE eliminar
		LOCAL lnOldSele
		lnOldSele = SELECT()

		IF EOF("DocCab")
			MESSAGEBOX("No Existe Informacion",0+64,"Validacion")
			RETURN .F.
		ENDIF
		IF DocCab.IndSit <> 1 AND DocCab.IndSit <> 9
			MESSAGEBOX("Documento No se Encuentra Pendiente",0+48,"Validacion")
			RETURN .F.
		ENDIF
		IF DocCab.IndCon == 1
			MESSAGEBOX("Documento Ya Fue Contabilizado",0+48,"Validacion")
			RETURN .F.
		ENDIF

		IF SEEK(DocCab.TipDoc+STR(DocCab.NroSec,10),"RefCab","SecDoc")
			MESSAGEBOX("Documento Tiene Referencia, Eliminelas",0+48,"Validacion")
			RETURN .F.
		ENDIF

		IF MESSAGEBOX('Esta Seguro de Eliminar el Registro',36,'Eliminacion') = 7
			RETURN .F.
		ENDIF

		*IF SEEK(DocCab.NroSec,"DocDet","NroSec")
		*	IF MESSAGEBOX('El Registro Tiene Detalles Desea Eliminar el Registro y sus Detalles',36,'Eliminacion') = 7
		*		RETURN
		*	ENDIF
		*ENDIF

		IF !RLOCK("DocCab")
			MESSAGEBOX('Registro se Encuentra en Uso',0+64,'Bloqueo')
			RETURN .F.
		ENDIF
		*-

		BEGIN TRANSACTION
		*- Elimina Detalle
		SELE DocDet
		SEEK DocCab.NroSec
		SCAN WHILE !EOF() AND NroSec = DocCab.NroSec
			DELETE
		ENDSCAN
		DO WHILE !TableUpDate(.T.,.F.,'DocDet')
			IF MESSAGEBOX('El Registro de DocDet No se Pudo Actualizar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				SELE DocCab
				RETURN
			ENDIF
		ENDDO

		*- Elimina Cabecera
		SELE DocCab
		DELETE
		DO WHILE !TableUpDate(.F.,.F.,'DocCab')
			IF MESSAGEBOX('El Registro de DocCab No se Pudo Actualizar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				SELE DocCab
				RETURN
			ENDIF
		ENDDO
		*-
		END TRANSACTION
		UNLOCK ALL

		SELE DocCab
		ThisForm.cmdSiguiente.Click
	ENDPROC


	PROCEDURE grabar
		LOCAL lnOldSele, lnNroCom, llOk

		lnOldSele = SELECT()

		*-Validacion
		IF !ThisForm.Validar()
			RETURN
		ENDIF

		*- Verifica Detalle
		*IF !SEEK(DocCab.NroSec,"DocDet","NroSec")
		*	MESSAGEBOX("No se Tiene Detalle",0+64,"Validacion")
		*	RETURN
		*ENDIF

		*- Verifica No de Documento
		IF SEEK(DocCab.TipOpe+DocCab.TipDoc+DocCab.NroDoc,"DocCab1","NroDoc")
			IF DocCab.NroSec <> DocCab1.NroSec
				MESSAGEBOX("Documento Ya Registrado",0+48,"Validacion")
				RETURN .F.
			ENDIF
		ENDIF

		*-Recalculo
		ThisForm.Recalcular

		*- Secuencia de Comprobante
		IF EMPTY(DocCab.NroCom) && OR  OLDVAL("TipCom","DocCab") <> DocCab.TipCom
			lnNroCom = 0
			lnNroCom = GenNroCom(DocCab.Periodo,DocCab.TipCom)
			IF EMPTY(lnNroCom)
				MESSAGEBOX("No se pudo Obter la secuencia del Comprobante",0+64,"Validacion")
				SELE (lnOldSele)
				RETURN .F.
			ENDIF
			SELE DocCab
			REPLACE NroCom WITH lnNroCom
		ENDIF

		*-Actualiza
		BEGIN TRANSACTION
		SELE DocCab
		IF ThisForm.Tag == "A"
			REPLACE UsuAdd WITH gCodUsu, ;
					FecAdd WITH DATETIME()
		ENDIF
		REPLACE UsuAct WITH gCodUsu, ;
				FecAct WITH DATETIME()

		SELE DocDet
		DO WHILE !TableUpDate(.F.,.F.,'DocCab')
			IF MESSAGEBOX('El Registro de DocCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO

		DO WHILE !TableUpDate(.T.,.F.,'DocDet')
			IF MESSAGEBOX('El Registro de DocDet No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO

		DO WHILE !TableUpDate(.T.,.F.,'GuiCab')
			IF MESSAGEBOX('El Registro de GuiCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO

		DO WHILE !TableUpDate(.T.,.F.,'PedCab')
			IF MESSAGEBOX('El Registro de PedCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO

		DO WHILE !TableUpDate(.T.,.F.,'ArtMovCab')
			IF MESSAGEBOX('El Registro de ArtMovCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO

		END TRANSACTION
		UNLOCK ALL

		SELE DocCab
		ThisForm.FecAnt = DocCab.FecDoc
		ThisForm.Tag = ""
		ThisForm.DesActivaControles
		ThisForm.cmdAdicionar.SetFocus
	ENDPROC


	PROCEDURE imprimir
		LOCAL lnOldSele, lnNroSec,lcDireccion,lcVendedor,lcCondicion,lcGuiaRemision,lcSimbol
		lnOldSele= SELECT()
		lnNroSec = DocCab.NroSec
		lcDireccion= ALLTRIM(Direccion)+" "+ALLTRIM(ThisForm.cboCodPos.List(ThisForm.cboCodPos.ListIndex))
		lcVendedor = ALLTRIM(ThisForm.cboCodVdd.List(ThisForm.cboCodVdd.ListIndex))
		lcCondicion= ALLTRIM(ThisForm.cboConVta.List(ThisForm.cboConVta.ListIndex))
		lcSimbol   = ALLTRIM(cTipMnd.Simbol)
		*-
		lcGuiaRemision=""
		*IF SEEK(DocCab.TipDoc+STR(DocCab.NroSec,10),"RefCab","SecDoc")
		*	SELE RefCab
		*	SET ORDER TO SecDoc
		*	SCAN WHILE !EOF() AND RefCab.TipDoc = DocCab.TipDoc AND RefCab.SecDoc = DocCab.NroSec
		*		IF RefCab.TipRef == "GR"
		*			lcGuiaRemision = lcGuiaRemision + RIGHT(ALLTRIM(RefCab.NroRef),6)+" "
		*		ENDIF
		*	ENDSCAN
		*	SELE DocCab
		*ENDIF
		*-
		SELECT C.NroSec, C.TipDoc, C.NroDoc, C.FecDoc, C.NroRuc, C.NomAux, lcDireccion As Direccion, ;
		       C.NroTlf, C.OrdCom, C.NroGuia, lcVendedor As Vendedor, lcCondicion As Condicion, ;
		       C.TipMnd, lcSimbol As Simbol, C.PcjIgv, C.ImpBto, C.ImpDes, C.ImpAfe, C.ImpIgv, C.ImpTot, ;
			   D.CodArt, D.Detalle, D.CodUnd, D.CanArt, D.ImpPre, D.PcjDes, D.ImpDes As Descto, D.ImpArt, ;
			   D.ImpAfe As ValVta, D.ImpTot As PreVta ;
		FROM DocCab C INNER JOIN DocDet D ON C.NroSec = D.NroSec ;
		WHERE C.NroSec = lnNroSec ;
		INTO CURSOR TmpFac

		SELECT C.NroSec, C.TipDoc, C.NroDoc, C.FecDoc, C.NroRuc, C.NomAux, C.Direccion, ;
		       C.NroTlf, C.OrdCom, C.NroGuia, C.Vendedor, C.Condicion, C.TipMnd, M.Simbol, M.DesMnd, ;
		       C.PcjIgv, C.ImpBto, C.ImpDes, C.ImpAfe, C.ImpIgv, C.ImpTot, ;
			   C.CodArt, C.Detalle, C.CodUnd, C.CanArt, C.ImpPre, C.PcjDes, C.Descto, C.ImpArt, C.ValVta, C.PreVta ;
		FROM TmpFac C LEFT OUTER JOIN TipMnd M ON C.TipMnd = M.TipMnd ;
		INTO CURSOR TmpRep
		USE IN TmpFac

		SELE TmpRep
		Do &gRuta\Progs\RepFormato
		USE IN TmpRep
		SELE DocCab
	ENDPROC


	PROCEDURE modificar
		IF EOF("DocCab")
			MESSAGEBOX("No Existe Informacion",0+64,"Validacion")
			RETURN
		ENDIF
		IF !(DocCab.IndSit == 1 OR DocCab.IndSit == 9)
			MESSAGEBOX("Documento No se Encuentra Pendiente",0+48,"Validacion")
			RETURN
		ENDIF
		IF DocCab.IndCon == 1
			MESSAGEBOX("Documento Ya Fue Contabilizado",0+48,"Validacion")
			RETURN
		ENDIF
		IF !RLOCK("DocCab")
			MESSAGEBOX("Documento se encuentra en Uso por Otro",0+64,"Bloqueo")
			RETURN
		ENDIF
		ThisForm.Tag = "M"
		ThisForm.ActivaControles
		IF SEEK(DocCab.TipDoc+STR(DocCab.NroSec,10),"RefCab","SecDoc")
			ThisForm.txtNroRuc.Enabled = .F.
			ThisForm.cboTipMnd.Enabled = .F.
		ENDIF
		ThisForm.grdDetalle.SetFocus
	ENDPROC


	PROCEDURE validar
		IF EMPTY(ThisForm.txtSecDoc.Value)
			MESSAGEBOX('Ingrese Nro de Documento',0+64,'Validacion')
			ThisForm.txtSecDoc.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(ThisForm.txtFecDoc.Value)
			MESSAGEBOX('Ingrese Fecha de Emision del Documento',0+64,'Validacion')
			ThisForm.txtFecDoc.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(ThisForm.cboTipMnd.Value)
			MESSAGEBOX('Seleccione Moneda',0+64,'Validacion')
			ThisForm.cboTipMnd.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(DocCab.ImpCam)
			MESSAGEBOX('No se Tiene Tipo de cambio',0+64,'Validacion')
			ThisForm.txtFecDoc.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(ThisForm.txtNroRuc.Value)
			MESSAGEBOX("Ingrese Ruc",0+64,'Validacion')
			ThisForm.txtNroRuc.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(ThisForm.cboCodVdd.Value)
			MESSAGEBOX('Seleccione Vendedor',0+64,'Validacion')
			ThisForm.cboCodVdd.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(ThisForm.cboTipVta.Value)
			MESSAGEBOX('Seleccione Tipo de Venta',0+64,'Validacion')
			ThisForm.cboTipVta.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(ThisForm.cboConVta.Value)
			MESSAGEBOX('Seleccione Condiciones de Pago',0+64,'Validacion')
			ThisForm.cboConVta.SetFocus
			RETURN .F.
		ENDIF
		IF EMPTY(ThisForm.txtFecVen.Value)
			MESSAGEBOX('Ingrese Fecha de Vencimiento del Documento',0+64,'Validacion')
			ThisForm.txtFecVen.SetFocus
			RETURN .F.
		ENDIF
		IF ThisForm.txtFecVen.Value < ThisForm.txtFecDoc.Value
			MESSAGEBOX('Fecha de Vencimiento No puede ser Menor',0+64,'Validacion')
			ThisForm.txtFecVen.SetFocus
			RETURN .F.
		ENDIF
	ENDPROC


	PROCEDURE recalcular
		LOCAL lnOldSele, lnOldRecno, lnImpAfeCal, lnImpBtoCal, lnImpTotCal, lnImpInaCal, lnTotArtCal

		lnOldSele = SELECT()
		STORE 0 TO lnTotArtCal,lnImpBtoCal,lnImpAfeCal,lnImpTotCal,lnImpInaCal,lnImpIgvCal

		SELE DocDet
		SEEK DocCab.NroSec
		SCAN WHILE !EOF() AND DocDet.NroSec = DocCab.NroSec
			REPLACE ImpDes WITH ROUND(ImpPre*(PcjDes/100),6), ;
					ImpArt WITH (ImpPre - ImpDes), ;
					TotArt WITH ROUND(CanArt*ImpArt,2)

			IF 	DocCab.IndIgv == 1 && PRECIOS INCLUYEN IGV
				IF IndIna == 1  && INAFECTOS AL IGV
					REPLACE	ImpTot WITH TotArt, ;
							ImpIna WITH ImpTot, ;
							ImpAfe WITH 0.00, ;
							ImpIgv WITH 0.00, ;
							ImpTotDol WITH IIF(DocCab.TipMnd = "U",ImpTot,IIF(DocCab.ImpCam > 0,ROUND(ImpTot/DocCab.ImpCam,2),0.00)), ;
							ImpInaDol WITH ImpTotDol, ;
				 			ImpAfeDol WITH 0.00, ;
							ImpIgvDol WITH 0.00, ;
							ImpTotSol WITH IIF(DocCab.TipMnd = "P",ImpTot,ROUND(ImpTot*DocCab.ImpCam,2)), ;
							ImpInaSol WITH ImpTotSol, ;
							ImpAfeSol WITH 0.00, ;
							ImpIgvSol WITH 0.00
				ELSE  && AFECTOS AL IGV
					REPLACE	ImpTot WITH TotArt, ;
							ImpAfe WITH ROUND((ImpTot)/((100 + DocCab.PcjIgv)/100),2), ;
							ImpIgv WITH (ImpTot - ImpAfe), ;
							ImpIna WITH 0.00, ;
							ImpTotDol WITH IIF(DocCab.TipMnd = "U",ImpTot,IIF(DocCab.ImpCam > 0,ROUND(ImpTot/DocCab.ImpCam,2),0.00)), ;
				 			ImpAfeDol WITH ROUND((ImpTotDol)/((100 + DocCab.PcjIgv)/100),2), ;
							ImpIgvDol WITH (ImpTotDol - ImpAfeDol), ;
							ImpInaDol WITH 0.00, ;
							ImpTotSol WITH IIF(DocCab.TipMnd = "P",ImpTot,ROUND(ImpTot*DocCab.ImpCam,2)), ;
							ImpAfeSol WITH ROUND((ImpTotSol)/((100 + DocCab.PcjIgv)/100),2), ;
							ImpIgvSol WITH (ImpTotSol - ImpAfeSol), ;
							ImpInaSol WITH 0.00
				ENDIF
			ELSE  && PRECIOS SIN IGV
				IF IndIna == 1  && INAFECTOS AL IGV
					REPLACE ImpAfe WITH 0.00, ;
							ImpIgv WITH 0.00, ;
							ImpIna WITH TotArt, ;
							ImpAfeDol WITH 0.00, ;
							ImpIgvDol WITH 0.00, ;
							ImpInaDol WITH IIF(DocCab.TipMnd = "U",ImpIna,IIF(DocCab.ImpCam > 0,ROUND(ImpIna/DocCab.ImpCam,2),0.00)), ;
							ImpAfeSol WITH 0.00, ;
							ImpIgvSol WITH 0.00, ;
							ImpInaSol WITH IIF(DocCab.TipMnd = "P",ImpIna,ROUND(ImpIna*DocCab.ImpCam,2))
				ELSE && AFECTOS AL IGV
					REPLACE ImpAfe WITH TotArt, ;
							ImpIgv WITH ROUND(ImpAfe*(DocCab.PcjIgv/100),2), ;
							ImpIna WITH 0.00, ;
							ImpAfeDol WITH IIF(DocCab.TipMnd = "U",ImpAfe,IIF(DocCab.ImpCam > 0,ROUND(ImpAfe/DocCab.ImpCam,2),0.00)), ;
							ImpIgvDol WITH ROUND(ImpAfeDol*(DocCab.PcjIgv/100),2), ;
							ImpInaDol WITH 0.00, ;
							ImpAfeSol WITH IIF(DocCab.TipMnd = "P",ImpAfe,ROUND(ImpAfe*DocCab.ImpCam,2)), ;
							ImpIgvSol WITH ROUND(ImpAfeSol*(DocCab.PcjIgv/100),2), ;
							ImpInaSol WITH 0.00
				ENDIF
				REPLACE ImpTot WITH (ImpAfe + ImpIgv + ImpIna), ;
						ImpTotDol WITH (ImpAfeDol + ImpIgvDol + ImpInaDol), ;
						ImpTotSol WITH (ImpAfeSol + ImpIgvSol + ImpInaSol)
			ENDIF
			lnTotArtCal	= lnTotArtCal + TotArt
			lnImpBtoCal = lnImpBtoCal + ROUND(CanArt*ImpPre,2)
			lnImpTotCal = lnImpTotCal + ImpTot
			lnImpAfeCal = lnImpAfeCal + ImpAfe
			lnImpInaCal = lnImpInaCal + ImpIna
			lnImpIgvCal = lnImpIgvCal + ImpIgv
		ENDSCAN

		SELE DocCab
		IF 	IndIgv == 1 && PRECIOS INCLUYEN IGV
		REPLACE ImpBto    WITH lnImpBtoCal, ;
				ImpTot 	  WITH lnImpTotCal, ;
				ImpIna    WITH lnImpInaCal, ;
				ImpAfe 	  WITH ROUND((ImpTot - ImpIna)/((100 + PcjIgv)/100),2), ;
				ImpIgv 	  WITH (ImpTot - ImpIna - ImpAfe), ;
				ImpDes    WITH (ImpBto - lnTotArtCal), ;
				ImpTotDol WITH IIF(TipMnd = "U",ImpTot,IIF(ImpCam > 0,ROUND(ImpTot/ImpCam,2),0.00)), ;
				ImpTotSol WITH IIF(TipMnd = "P",ImpTot,ROUND(ImpTot*ImpCam,2)), ;
				ImpInaDol WITH IIF(TipMnd = "U",ImpIna,IIF(ImpCam > 0,ROUND(ImpIna/ImpCam,2),0.00)), ;
				ImpInaSol WITH IIF(TipMnd = "P",ImpIna,ROUND(ImpIna*ImpCam,2)), ;
				ImpAfeDol WITH ROUND((ImpTotDol - ImpInaDol)/((100 + PcjIgv)/100),2), ;
				ImpIgvDol WITH (ImpTotDol - ImpInaDol - ImpAfeDol), ;
				ImpAfeSol WITH ROUND((ImpTotSol - ImpInaSol)/((100 + PcjIgv)/100),2), ;
				ImpIgvSol WITH (ImpTotSol - ImpInaSol - ImpAfeSol)
		ELSE  && PRECIOS SIN IGV
		REPLACE ImpBto    WITH lnImpBtoCal, ;
				ImpAfe    WITH lnImpAfeCal, ;
				ImpIna    WITH lnImpInaCal, ;
				ImpDes    WITH (ImpBto - lnTotArtCal), ;
				ImpIgv 	  WITH ROUND(ImpAfe*(PcjIgv/100),2), ;
				ImpTot 	  WITH ImpAfe + ImpIgv + ImpIna, ;
				ImpAfeDol WITH IIF(TipMnd = "U",ImpAfe,IIF(ImpCam > 0,ROUND(ImpAfe/ImpCam,2),0.00)), ;
				ImpIgvDol WITH ROUND(ImpAfeDol*(PcjIgv/100),2), ;
				ImpInaDol WITH IIF(TipMnd = "U",ImpIna,IIF(ImpCam > 0,ROUND(ImpIna/ImpCam,2),0.00)), ;
				ImpTotDol WITH (ImpAfeDol + ImpIgvDol + ImpInaDol), ;
				ImpAfeSol WITH IIF(TipMnd = "P",ImpAfe,ROUND(ImpAfe*ImpCam,2)), ;
				ImpIgvSol WITH ROUND(ImpAfeSol*(PcjIgv/100),2), ;
				ImpInaSol WITH IIF(TipMnd = "P",ImpIna,ROUND(ImpIna*ImpCam,2)), ;
				ImpTotSol WITH (ImpAfeSol + ImpIgvSol + ImpInaSol)
		ENDIF
		ThisForm.Refresh
		SELE (lnOldSele)
		RETURN
	ENDPROC


	PROCEDURE cmdRecalcular.Click
		*-
		IF EOF("DocCab") OR BOF("DocCab")
			MESSAGEBOX("No Existe Informacion",0+64,"Validacion")
			RETURN
		ENDIF
		IF DocCab.IndSit <> 1
			MESSAGEBOX("Documento No se Encuentra Pendiente",0+64,"Validacion")
			RETURN
		ENDIF
		IF DocCab.IndCon == 1
			MESSAGEBOX("Documento Ya Fue Contabilizado",0+48,"Validacion")
			RETURN
		ENDIF
		IF !RLOCK("DocCab")
			MESSAGEBOX('Registro se Encuentra en Uso por Otro',0+64,'Bloqueo')
			RETURN
		ENDIF
		*-
		ThisForm.Recalcular
		*-
		*-Actualiza
		SELE DocDet
		BEGIN TRANSACTION
		llOk = TableUpDate(.F.,.F.,'DocCab')
		IF !llOk
			DO WHILE MESSAGEBOX('El Registro de DocCab No se Pudo Grabar Continuar',4+64+256,'Actualizacion') = 7
			ENDDO
			ROLLBACK
			RETURN
		ENDIF
		llOk = TableUpDate(.T.,.F.,'DocDet')
		IF !llOk
			DO WHILE MESSAGEBOX('El Registro de DocDet No se Pudo Grabar Continuar',4+64+256,'Actualizacion') = 7
			ENDDO
			ROLLBACK
			RETURN
		ENDIF
		END TRANSACTION
		UNLOCK ALL
		SELE DocCab
		ThisForm.Refresh
	ENDPROC


	PROCEDURE cmdAdiDetalle.Click
		SELE Doccab
		REPLACE NroSecDet WITH NroSecDet + 1

		SELE DocDet
		APPEND BLANK
		REPLACE NroSec    WITH DocCab.NroSec, ;
				NroSecDet WITH DocCab.NroSecDet

		SELE Doccab
		ThisForm.grdDetalle.Refresh
		ThisForm.grdDetalle.SetFocus
	ENDPROC


	PROCEDURE cmdEliDetalle.Click
		IF EOF("DocDet")
			MESSAGEBOX("No se Selecciono Registro",0+64,"Validacion")
			RETURN
		ENDIF
		IF !EMPTY(DocDet.NroDocRef)
			MESSAGEBOX("Detalle Pertenece a Referencia, Elimine la Referencia",0+64,"Validacion")
			RETURN .F.
		ENDIF
		*IF !EMPTY(DocDet.CodArt)
		*	MESSAGEBOX("Detalle Pertenece a Referencia, Elimine la Referencia",0+64,"Validacion")
		*	RETURN
		*ENDIF
		IF MESSAGEBOX('Esta Seguro de Eliminar el Registro',36,'Eliminacion') = 7
			RETURN
		ENDIF

		SELE DocDet
		DELETE
		IF RECNO() < 0
			TableRevert(.F.)
			SELE DocDet
			SEEK DocCab.NroSec
		ELSE
			SKIP
			IF EOF() OR DocCab.NroSec <> DocDet.NroSec
				SELE DocDet
				SEEK DocCab.NroSec
			ENDIF
		ENDIF

		ThisForm.Recalcular
		SELE DocCab
		ThisForm.grdDetalle.Refresh
		ThisForm.grdDetalle.SetFocus
	ENDPROC


	PROCEDURE cmdanular.Click
		LOCAL lnOldSele
		lnOldSele = SELECT()

		IF EOF("DocCab")
			MESSAGEBOX("No Existe Informacion",0+64,"Validacion")
			RETURN
		ENDIF
		IF DocCab.IndSit <> 1
			MESSAGEBOX("Documento No se Encuentra Pendiente",0+48,"Validacion")
			RETURN
		ENDIF
		IF DocCab.IndCon == 1
			MESSAGEBOX("Documento Ya Fue Contabilizado",0+48,"Validacion")
			RETURN
		ENDIF

		IF SEEK(DocCab.TipDoc+STR(DocCab.NroSec,10),"RefCab","SecDoc")
			MESSAGEBOX("Documento Tiene Referencia, Eliminelas",0+48,"Validacion")
			RETURN
		ENDIF

		IF MESSAGEBOX('Esta Seguro de Anular el Registro',36,'Eliminacion') = 7
			RETURN
		ENDIF

		IF !RLOCK("DocCab")
			MESSAGEBOX('Registro se Encuentra en Uso',0+64,'Bloqueo')
			RETURN
		ENDIF
		*-

		BEGIN TRANSACTION
		*- Elimina Referencia
		SELE RefCab
		SET ORDER TO SecDoc
		SEEK DocCab.TipDoc+STR(DocCab.NroSec,10)
		SCAN WHILE !EOF() AND RefCab.TipDoc = DocCab.TipDoc AND RefCab.SecDoc = DocCab.NroSec
			DO CASE
				CASE RefCab.TipRef == "GR"
					IF SEEK(RefCab.SecRef,"GuiCab","NroSec")
						SELE GuiCab
						IF !RLOCK()
							MESSAGEBOX('Registro se Encuentra en Uso',0+64,'Bloqueo')
							ROLLBACK
							UNLOCK ALL
							SELE DocCab
							RETURN
						ENDIF
						REPLACE IndSit WITH 1, ;
								FecSit WITH FecDoc
					ENDIF
				CASE RefCab.TipRef == "GS"
					IF SEEK(RefCab.SecRef,"ArtMovCab","NroSec")
						SELE ArtMovCab
						IF !RLOCK()
							MESSAGEBOX('Registro se Encuentra en Uso',0+64,'Bloqueo')
							ROLLBACK
							UNLOCK ALL
							SELE DocCab
							RETURN
						ENDIF
						REPLACE IndSit WITH 1, ;
								FecSit WITH TTOD(FecDoc)
					ENDIF
				CASE RefCab.TipRef == "PD"
					IF SEEK(RefCab.SecRef,"PedCab","NroSec")
						SELE PedCab
						IF !RLOCK()
							MESSAGEBOX('Registro se Encuentra en Uso',0+64,'Bloqueo')
							ROLLBACK
							UNLOCK ALL
							SELE DocCab
							RETURN
						ENDIF
						REPLACE IndFac WITH 1, ;
								FecFac WITH FecDoc
					ENDIF
			ENDCASE
			SELE RefCab
			DELETE
		ENDSCAN

		IF DocCab.TipDocRef == "PD"
		IF SEEK(DocCab.TipDoc+STR(DocCab.NroSec,10),"RefCab","SecRef")
			SELE RefCab
			DELETE
		ENDIF
		ENDIF

		DO WHILE !TableUpDate(.T.,.F.,'RefCab')
			IF MESSAGEBOX('El Registro de RefCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO

		DO WHILE !TableUpDate(.T.,.F.,'PedCab')
			IF MESSAGEBOX('El Registro de PedCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		DO WHILE !TableUpDate(.T.,.F.,'GuiCab')
			IF MESSAGEBOX('El Registro de GuiCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		DO WHILE !TableUpDate(.T.,.F.,'ArtMovCab')
			IF MESSAGEBOX('El Registro de ArtMovCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO

		*- Cabecera
		SELE DocCab
		REPLACE	IndSit WITH 9, ;
				FecSit WITH DATE(), ;
				UsuAct WITH gCodUsu, ;
				FecAct WITH DATETIME()
		DO WHILE !TableUpDate(.F.,.F.,'DocCab')
			IF MESSAGEBOX('El Registro de DocCab No se Pudo Actualizar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				SELE DocCab
				RETURN
			ENDIF
		ENDDO
		*-
		END TRANSACTION
		UNLOCK ALL

		SELE DocCab
		GO (RECNO())
		ThisForm.Refresh
	ENDPROC


	PROCEDURE txtdessit.KeyPress
		LPARAMETERS nKeyCode, nShiftAltCtrl
		IF nKeyCode = -1
			This.RightClick
		ENDIF
	ENDPROC


	PROCEDURE txtdessit.GotFocus
		This.Tag = This.Value
	ENDPROC


	PROCEDURE txtdessit.RightClick
		LOCAL lcNroRuc
		lcNroRuc = SPACE(11)
		DO FORM &gRutCon\forms\frmBusAux WITH ThisForm.txtTipAux.Value,"2" TO lcNroRuc
		IF EMPTY(lcNroRuc)
			RETURN 0
		ENDIF
		This.SetFocus
		KEYBOARD lcNroRuc
	ENDPROC


	PROCEDURE txtdessit.Valid
		LOCAL lnOldRecno, lnOldSele, lcCodCta, lcTipAux, lcCodAux, lcTipRef, lcTipMnd, lnReturn
		IF EMPTY(This.Value)
			ThisForm.txtCodAux.Value = SPACE(04)
			ThisForm.txtNomAux.Value = SPACE(40)
			ThisForm.txtNomAux.Refresh
			ThisForm.txtCodAux.Enabled = .T.
			ThisForm.txtCodAux.Refresh
			RETURN
		ENDIF
		IF This.Tag = This.Value
			RETURN
		ENDIF
		IF LEN(ALLTRIM(This.Value)) < 8
		    MESSAGEBOX("RUC : "+PADR(This.Value,12)+" No puede ser Menor de 8 Digitos",48,"Validacion")
			RETURN 0
		ENDIF
		IF !SEEK(ThisForm.txtTipAux.Value+PADR(This.Value,12),"TabAux","NroRuc")
			IF MESSAGEBOX("RUC : "+PADR(This.Value,12)+" No Registrado Desea Ingresarlo",36,"Validacion") = 7
				RETURN 0
			ENDIF
			DO FORM &gRutaCon\forms\frmDetAddAux WITH ThisForm.txtTipAux.Value,PADR(This.Value,12)
			RETURN 0
		ENDIF
		ThisForm.txtCodAux.Value = TabAux.CodAux
		ThisForm.txtNomAux.Value = TabAux.NomAux
		ThisForm.txtNomAux.Refresh
		ThisForm.txtCodAux.Enabled = .F.
		ThisForm.txtCodAux.Refresh
	ENDPROC


	PROCEDURE txtdessit.mantenimiento
		DO FORM &gRutCon\forms\frmMntAux
	ENDPROC


	PROCEDURE txtdessit.When
		IF EMPTY(ThisForm.txtTipAux.Value)
			MESSAGEBOX("Ingrese Tipo de Auxiliar",0+64,"Validacion")
			RETURN .F.
		ENDIF
	ENDPROC


	PROCEDURE cbocodvdd.Destroy
		IF USED("cCodVdd")
			USE IN cCodVdd
		ENDIF
	ENDPROC


	PROCEDURE cbocodvdd.RightClick
		This.Requery
	ENDPROC


	PROCEDURE cbocodvdd.GotFocus
		This.Tag = This.Value
	ENDPROC


	PROCEDURE txtsecdoc.When
		IF EMPTY(ThisForm.txtSerDoc.Value)
			RETURN .F.
		ENDIF
	ENDPROC


	PROCEDURE txtsecdoc.Valid
		IF EMPTY(This.Value)
			RETURN
		ENDIF
		IF ALLTRIM(This.Tag) == ALLTRIM(This.Value)
			RETURN
		ENDIF
		REPLACE	DocCab.NroDoc WITH ALLTRIM(ThisForm.txtSerDoc.Value)+ALLTRIM(ThisForm.txtSecDoc.Value)
		IF SEEK(DocCab.TipOpe+DocCab.TipDoc+ALLTRIM(ThisForm.txtSerDoc.Value)+ALLTRIM(ThisForm.txtSecDoc.Value),"DocCab1","NroDoc")
			MESSAGEBOX("Documento Ya Registrado",0+48,"Validacion")
			RETURN 0
		ENDIF
	ENDPROC


	PROCEDURE txtsecdoc.GotFocus
		This.Tag = This.Value
	ENDPROC


	PROCEDURE txtserdoc.GotFocus
		This.Tag = This.Value
	ENDPROC


	PROCEDURE txtserdoc.Valid
		LOCAL lcTipDoc,lcNroSer,lcNroSecDoc,lnOldSele
		lnOldSele = SELECT()
		IF EMPTY(This.Value)
			RETURN
		ENDIF
		IF ALLTRIM(This.Tag) == ALLTRIM(This.Value)
			RETURN
		ENDIF
		lcNroSer = ALLTRIM(This.Value)
		IF LEN(lcNroSer) <> 3
			MESSAGEBOX("Nro de Serie no puede ser diferente de 3 Digitos",0+64,"Validacion")
			RETURN 0
		ENDIF
		lcTipDoc = DocCab.TipDoc
		IF EMPTY(lcTipDoc)
			MESSAGEBOX("No se Tiene Tipo de Documento",0+64,"Validacion")
			RETURN 0
		ENDIF
		IF ALLTRIM(This.Tag) == ALLTRIM(TabSecDoc.NroSer) AND VAL(DocCab.SecDoc) == TabSecDoc.NroSec
			IF RLOCK("TabSecDoc")
				REPLACE TabSecDoc.NroSec WITH TabSecDoc.NroSec - 1
				UNLOCK IN TabSecDoc
			ENDIF
		ENDIF
		lcNroSecDoc = SPACE(01)
		lcNroSecDoc = GenNroDoc(lcTipDoc,lcNroSer)
		IF EMPTY(lcNroSecDoc)
			MESSAGEBOX("No se pudo Obter la secuencia del Documento",0+64,"Validacion")
			SELE (lnOldSele)
			RETURN 0
		ENDIF
		ThisForm.txtSecDoc.Value = lcNroSecDoc
		ThisForm.txtSecDoc.Refresh

		IF SEEK(lcTipDoc+lcNroSer+lcNroSecDoc,"DocCab1","NroDoc")
			MESSAGEBOX("Documento Ya Registrado",0+48,"Validacion")
			RETURN 1
		ENDIF

		REPLACE DocCab.SecDoc WITH lcNroSecDoc, ;
				DocCab.NroDoc WITH lcNroSer+lcNroSecDoc
	ENDPROC


	PROCEDURE txtperiodo.Valid
		IF EMPTY(This.Value)
			RETURN 0
		ENDIF
		IF This.Tag = This.Value
			RETURN
		ENDIF
		pcPeriodo = This.Value
		IF VAL(SUBS(pcPeriodo,1,4)) < 1999
			MESSAGEBOX("Periodo No Puede ser Menor a 1999",0+48,"Validacion")
			RETURN 0
		ENDIF
		IF !BETWEEN(VAL(SUBS(pcPeriodo,5,2)),01,12)
			MESSAGEBOX("Mes del Periodo incorrecto",0+48,"Validacion")
			RETURN 0
		ENDIF
		ThisForm.UbicaPeriodo
		ThisForm.Refresh
	ENDPROC


	PROCEDURE txtperiodo.GotFocus
		This.Tag = This.Value
	ENDPROC


	PROCEDURE txtfecven.Valid
		IF EMPTY(This.Value)
			RETURN
		ENDIF
		IF This.Value < ThisForm.txtFecDoc.Value
			MESSAGEBOX("Fecha de Vencimiento No Puede ser Menor",0+64,"Valiadcion")
			RETURN 0
		ENDIF
	ENDPROC


	PROCEDURE txtfecdoc.Valid
		IF EMPTY(This.Value)
			RETURN
		ENDIF
		IF !EMPTY(DocCab.NroCom)
			IF SUBS(DTOS(This.Value),1,6) <> DocCab.Periodo
				MESSAGEBOX("Fecha Fuera del Periodo "+TRANSFORM(DocCab.Periodo,"@R 9999-99"),0+64,"Valiadcion")
				RETURN 0
			ENDIF
		ENDIF
		IF !SEEK("U"+DTOS(This.Value),"Cambio","TipMnd")
			MESSAGEBOX("Tipo de Cambio No Registrado para la Fecha",0+64,"Valiadcion")
			RETURN 0
		ENDIF
		REPLACE DocCab.Periodo WITH SUBS(DTOS(This.Value),1,6), ;
				DocCab.FecVen  WITH This.Value, ;
				DocCab.ImpCam  WITH Cambio.ImpVta
		ThisForm.txtPeriodo.Refresh
		ThisForm.txtImpCam.Refresh

		IF !EMPTY(DocCab.ConVta)
			IF SEEK(DocCab.ConVta,"TipPgo","TipPgo")
				REPLACE DocCab.FecVen WITH DocCab.FecDoc + TipPgo.Dias
				ThisForm.txtFecVen.Refresh
			ENDIF
		ENDIF
	ENDPROC


	PROCEDURE cbotipmnd.Valid
		IF EMPTY(This.Value)
			RETURN
		ENDIF
		IF !SEEK(This.Value,"TipMnd","TipMnd")
			MESSAGEBOX("No se tiene registrada la Moneda",0+64,"Validacion")
			RETURN
		ENDIF
		REPLACE DocCab.CodMnd WITH This.Value+DocCab.TipCam, ;
				DocCab.Simbol WITH TipMnd.Simbol
		ThisForm.lblTotal.Caption = "TOTAL  "+DocCab.Simbol
	ENDPROC


	PROCEDURE cbotipmnd.RightClick
		This.Requery
	ENDPROC


	PROCEDURE cbotipmnd.Destroy
		IF USED("cTipMnd")
			USE IN cTipMnd
		ENDIF
	ENDPROC


	PROCEDURE cbocodcdd.Destroy
		IF USED("cCodCdd")
			USE IN cCodCdd
		ENDIF
	ENDPROC


	PROCEDURE cbocodcdd.RightClick
		This.Requery
	ENDPROC


	PROCEDURE cbocodcdd.Valid
		ThisForm.cboCodPos.Value = ""
		ThisForm.cboCodPos.Refresh
		ThisForm.cboCodPos.Requery
	ENDPROC


	PROCEDURE txtnroruc.GotFocus
		This.Tag = This.Value
	ENDPROC


	PROCEDURE txtnroruc.RightClick
		LOCAL lcNroRuc
		lcNroRuc = SPACE(11)
		DO FORM &gRuta\forms\frmBusAux WITH DocCab.TipAux,"2" TO lcNroRuc
		IF EMPTY(lcNroRuc)
			RETURN 0
		ENDIF
		lcNroRuc = ALLTRIM(lcNroRuc)
		This.SetFocus
		KEYBOARD lcNroRuc
	ENDPROC


	PROCEDURE txtnroruc.Valid
		IF ALLTRIM(This.Tag) == ALLTRIM(This.Value)
			RETURN
		ENDIF
		IF EMPTY(This.Value)
			REPLACE DocCab.CodAux WITH SPACE(04), ;
					DocCab.NomAux WITH SPACE(40), ;
					DocCab.Direccion WITH SPACE(50), ;
					DocCab.CodPais WITH SPACE(03), ;
					DocCab.CodCdd WITH SPACE(03), ;
					DocCab.CodPostal WITH SPACE(03)
			ThisForm.txtNomAux.Refresh
			ThisForm.txtDireccion.Refresh
			ThisForm.cboCodCdd.Requery
			ThisForm.cboCodPos.Requery
			ThisForm.cboCodCdd.Refresh
			ThisForm.cboCodPos.Refresh
			RETURN
		ENDIF
		IF LEN(ALLTRIM(This.Value)) <> 11 AND LEN(ALLTRIM(This.Value)) <> 8
		    MESSAGEBOX("RUC : "+ALLTRIM(This.Value)+" No de Digitos Incorrecto",48,"Validacion")
			RETURN 0
		ENDIF
		IF !SEEK(DocCab.TipAux+PADR(This.Value,12),"TabAux","NroRuc")
			IF MESSAGEBOX("RUC : "+PADR(This.Value,12)+" No Registrado Desea Ingresarlo",36,"Validacion") = 7
				RETURN 0
			ENDIF
			DO FORM &gRuta\forms\frmDetAddAux WITH DocCab.TipAux,PADR(This.Value,12)
			RETURN 0
		ENDIF
		REPLACE DocCab.CodAux WITH TabAux.CodAux, ;
				DocCab.NomAux WITH TabAux.NomAux, ;
				DocCab.Direccion WITH TabAux.Direccion, ;
				DocCab.CodPais WITH TabAux.CodPais, ;
				DocCab.CodCdd WITH TabAux.CodCdd, ;
				DocCab.CodPostal WITH TabAux.CodPostal

		ThisForm.txtNomAux.Refresh
		ThisForm.txtDireccion.Refresh
		ThisForm.cboCodCdd.Requery
		ThisForm.cboCodPos.Requery
		ThisForm.cboCodCdd.Refresh
		ThisForm.cboCodPos.Refresh
	ENDPROC


	PROCEDURE txtnroruc.mantenimiento
		*DO FORM &gRuta\forms\frmMntAux
	ENDPROC


	PROCEDURE cbocodpos.RightClick
		This.Requery
	ENDPROC


	PROCEDURE cbocodpos.Destroy
		IF USED("cCodPos")
			USE IN cCodPos
		ENDIF
	ENDPROC


	PROCEDURE cmdcancelar.Click
		IF EOF("DocCab") OR BOF("DocCab")
			MESSAGEBOX("No Existe Informacion",0+64,"Validacion")
			RETURN
		ENDIF
		IF DocCab.IndSit <> 1
			MESSAGEBOX("Documento No se Encuentra Pendiente",0+64,"Validacion")
			RETURN
		ENDIF

		DO form &gRuta\Forms\frmMovCajCan WITH DocCab.NroSec

		SELE DocCab
		UNLOCK
		GO (RECNO())
		ThisForm.Refresh
	ENDPROC


	PROCEDURE cboconvta.Destroy
		IF USED("cConVta")
			USE IN cConVta
		ENDIF
	ENDPROC


	PROCEDURE cboconvta.RightClick
		This.Requery
	ENDPROC


	PROCEDURE cboconvta.Valid
		IF !SEEK(This.Value,"TipPgo","TipPgo")
			RETURN
		ENDIF
		REPLACE DocCab.FecVen WITH DocCab.FecDoc + TipPgo.Dias
		ThisForm.txtFecVen.Refresh
	ENDPROC


	PROCEDURE cmdrefped.Click
		IF EOF("DocCab") OR BOF("DocCab")
			MESSAGEBOX("No se Tiene Informacion",0+64,"Validacion")
			RETURN
		ENDIF

		DO form &gRuta\Forms\frmRefPed_Fac WITH DocCab.TipDoc, DocCab.NroDoc, DocCab.NroSec
		UNLOCK ALL
		SELE DocCab

		IF DocCab.IndSit <> 1
			SELE DocCab
			ThisForm.Refresh
			ThisForm.grdDetalle.SetFocus
			RETURN
		ENDIF

		ThisForm.Recalcular

		SELE DocDet
		BEGIN TRANSACTION
		DO WHILE !TableUpDate(.F.,.F.,'DocCab')
			IF MESSAGEBOX('El Registro de DocCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		DO WHILE !TableUpDate(.T.,.F.,'DocDet')
			IF MESSAGEBOX('El Registro de DocDet No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		END TRANSACTION
		UNLOCK ALL

		SELE DocCab
		ThisForm.Refresh
		ThisForm.grdDetalle.SetFocus
		RETURN
	ENDPROC


	PROCEDURE cmdrefguirem.Click
		IF EOF("DocCab") OR BOF("DocCab")
			MESSAGEBOX("No se Tiene Informacion",0+64,"Validacion")
			RETURN
		ENDIF

		DO form &gRuta\Forms\frmRefGuiRem_Fac WITH DocCab.TipDoc, DocCab.NroDoc, DocCab.NroSec, DocCab.TipDocRef, DocCab.NroDocRef, DocCab.NroSecref
		UNLOCK ALL
		SELE DocCab

		IF DocCab.IndSit <> 1
			SELE DocCab
			ThisForm.Refresh
			ThisForm.grdDetalle.SetFocus
			RETURN
		ENDIF

		ThisForm.Recalcular

		SELE DocDet
		BEGIN TRANSACTION
		DO WHILE !TableUpDate(.F.,.F.,'DocCab')
			IF MESSAGEBOX('El Registro de DocCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		DO WHILE !TableUpDate(.T.,.F.,'DocDet')
			IF MESSAGEBOX('El Registro de DocDet No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		END TRANSACTION
		UNLOCK ALL

		SELE DocCab
		ThisForm.Refresh
		ThisForm.grdDetalle.SetFocus
		RETURN
	ENDPROC


	PROCEDURE cmdrefalmsal.Click
		IF EOF("DocCab") OR BOF("DocCab")
			MESSAGEBOX("No se Tiene Informacion",0+64,"Validacion")
			RETURN
		ENDIF

		DO form &gRuta\Forms\frmRefAlmSal_Fac WITH DocCab.TipDoc, DocCab.NroDoc, DocCab.NroSec
		UNLOCK ALL
		SELE DocCab

		IF DocCab.IndSit <> 1
			SELE DocCab
			ThisForm.Refresh
			ThisForm.grdDetalle.SetFocus
			RETURN
		ENDIF

		ThisForm.Recalcular

		SELE DocDet
		BEGIN TRANSACTION
		DO WHILE !TableUpDate(.F.,.F.,'DocCab')
			IF MESSAGEBOX('El Registro de DocCab No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		DO WHILE !TableUpDate(.T.,.F.,'DocDet')
			IF MESSAGEBOX('El Registro de DocDet No se Pudo Grabar',5+48+0,'Actualizacion') = 2
				ROLLBACK
				RETURN
			ENDIF
		ENDDO
		END TRANSACTION
		UNLOCK ALL

		SELE DocCab
		ThisForm.Refresh
		ThisForm.grdDetalle.SetFocus
		RETURN
	ENDPROC


	PROCEDURE cbotipvta.RightClick
		This.Requery
	ENDPROC


	PROCEDURE cbotipvta.Destroy
		IF USED("cTipVta")
			USE IN cTipVta
		ENDIF
	ENDPROC


	PROCEDURE text1.When
		IF !EMPTY(DocDet.NroDocRef)
			RETURN .F.
		ENDIF
	ENDPROC


	PROCEDURE text1.When
		IF !EMPTY(DocDet.NroDocRef)
			RETURN .F.
		ENDIF
	ENDPROC


	PROCEDURE text1.GotFocus
		ThisForm.ValAnterior = This.Value
		This.InputMask = "999999.99"
	ENDPROC


	PROCEDURE text1.Valid
		LOCAL lnOldReg
		This.InputMask = "999,999.99"
		IF ThisForm.ValAnterior = This.Value
			RETURN
		ENDIF
		lnOldReg = RECNO("DocDet")
		ThisForm.Recalcular
		GO (lnOldReg) IN DocDet
	ENDPROC


	PROCEDURE text1.When
		IF !EMPTY(DocDet.NroDocRef)
			RETURN .F.
		ENDIF
	ENDPROC


	PROCEDURE text1.When
		*IF !EMPTY(DocDet.NroDocRef)
		*	RETURN .F.
		*ENDIF
	ENDPROC


	PROCEDURE text1.Valid
		LOCAL lnOldReg
		This.InputMask = "999999.999999"
		IF ThisForm.ValAnterior = This.Value
			RETURN
		ENDIF
		lnOldReg = RECNO("DocDet")
		ThisForm.Recalcular
		GO (lnOldReg) IN DocDet
	ENDPROC


	PROCEDURE text1.GotFocus
		ThisForm.ValAnterior = This.Value
		This.InputMask = "999999.999999"
	ENDPROC


	PROCEDURE text1.Valid
		LOCAL lnOldReg
		IF ThisForm.ValAnterior = This.Value
			RETURN
		ENDIF
		IF This.Value > 100.00
			This.Value = ThisForm.ValAnterior
			RETURN
		ENDIF
		lnOldReg = RECNO("DocDet")
		ThisForm.Recalcular
		GO (lnOldReg) IN DocDet
	ENDPROC


	PROCEDURE text1.GotFocus
		ThisForm.ValAnterior = This.Value
	ENDPROC


ENDDEFINE
*
*-- EndDefine: frmfactura
**************************************************
