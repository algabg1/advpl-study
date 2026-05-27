#Include "TOTVS.CH"

************************
User Function ROT006()
************************
Local a_Area	:=GetArea()
Local a_AreaSE2	:=SE2->(GetArea())
Local c_Hist	:=""
Local c_NomFor	:=""
Local c_Portad	:=""
Local c_Tipo 	:=MVNOTAFIS
Local c_ChaveSF1:=xFilial("SE2")+SF1->F1_FORNECE+SF1->F1_LOJA+SF1->F1_PREFIXO+SF1->F1_DUPL

// SF1 = cabeçalho das notas de entrada | SE2 = contas a pagar
// SA2 = cadastro de fornecedores

c_NomFor:=Posicione("SA2",1,xFilial("SA2")+SF1->F1_FORNECE+SF1->F1_LOJA,"A2_NOME")       
c_Hist	:=""		//"Compra NF "+SF1->F1_DOC+" - "+c_NomFor

c_Portad:="TESTE"	//Posicione("SE4",1,xFilial("SE4")+SF1->F1_COND,"E4_FSPORT")  

If	!Empty(SF1->F1_DUPL) //se o num. duplicata não estiver vazio
	c_Hist:=U_HistTit()
	dbSeLectArea("SE2")
	dbSetOrder(6)
	dbSeek(c_ChaveSF1,.T.)

	//enquanto até o final com essa mesma chave
	While SE2->(Eof())=.F. .and. SE2->E2_FILIAL+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_PREFIXO+SE2->E2_NUM = c_ChaveSF1

		If 	SE2->E2_TIPO=c_Tipo // se o tipo for MVNOTAFIS
			RecLock("SE2",.F.) // block
				SE2->E2_PORTADO	:=c_Portad 
				SE2->E2_HIST	:=c_Hist
			MsUnLock() // libera
		Endif

		SE2->(dbSkip()) // próximo

	Enddo
Endif

//volta as tabelas
RestArea(a_AreaSE2)
RestArea(a_Area)

Return()

***********************               
User Function HistTit() // exibe janela pra digitar o histórico
************************           
Private nTamHist   := TamSX3("E2_HIST")[1]
Private cHist	   := Space(nTamHist)

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

// cria a janela
oDlg1      := MSDialog():New( 044,116,180,500,"Dados Financeiros",,,.F.,,,,,,.T.,,,.T. )
//cria um painel dentro da janela
oPanel1    := TPanel():New( 010,010,"",oDlg1,,.F.,.F.,,,190,060,.T.,.F. )

// Label da oDlg1 | texto do campo
oSay1      := TSay():New( 020,010,{||"Histórico: "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,040,008)

// Gets da oDlg1      | campo pra digitar o histórico   				não pode ser em branco
@ 020,040 MSGET oGET1 VAR cHist OF oPanel1  PIXEL SIZE 136,008 VALID !Empty(Alltrim(cHist))

// Botoes da oDlg1                       chama função HistDigi()
oSBtn1     := SButton():New( 040,150,1,{||HistDigi()},oPanel1,,"", )

oDlg1:Activate(,,,.T.) // abre a tela e aguarda o usuario interagir

Return(cHist)

**************************
Static Function HistDigi()  // função auxiliar da HistTit()
**************************
                                       
cHistTit := Upper(Alltrim(cHist)) // remove espaços, ceixa tudo maisculo
Close(oDlg1)

Return(cHist)   
