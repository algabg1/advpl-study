#include 'Protheus.ch'
#include 'FWMVCDef.ch'
#include 'topconn.ch'
#include 'Tbiconn.ch'

Function U_ROT002() //user function
    Local a_Area := GetArea()
    Local oBrowse := Nil

    oBrowse := FWmBrowse():New()
    oBrowse:SetAlias("Z07") //tabela que vai puxar
    oBrowse:AddLegend("Z07->Z07_VALOR >= 100", "PINK", "maior que 100") //legendas logico
    oBrowse:AddLegend("Z07->Z07_VALOR >= 100", "BLUE", "menor que 100")
    oBrowse:SetDescription("Manutençao Regioes de Frete - Ana") //o titulo da pagina
    oBrowse:Activate()

    RestArea(a_Area)

Return

Static Function MenuDef() //menu superior

    Local aRotina := {} //aqui é padrão mesmo

    ADD OPTION aRotina TITLE '&Visualizar'  ACTION 'VIWEDEF.ROT002' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE '&Incluir'     ACTION 'VIWEDEF.ROT002' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE '&Alterar'     ACTION 'VIWEDEF.ROT002' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE '&Excluir'     ACTION 'VIWEDEF.ROT002' OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Im&primir'    ACTION 'VIWEDEF.ROT002' OPERATION 8 ACCESS 0
    ADD OPTION aRotina TITLE '&Copiar'      ACTION 'VIWEDEF.ROT002' OPERATION 9 ACCESS 0
    ADD OPTION aRotina TITLE '&Legenda'     ACTION 'U_FLEGENDA'     OPERATION 2 ACCESS 0

Return aRotina

Static Function ModelDef()  //define estrutura
    
    Local oStruZ07  := FWFormStruct(1, 'Z07') //1 pra model
    Local oModel    := MPFormModel():New('ROT002M', /*bPre*/, /*b_PosM*/) //esses cometários são opcionais

    oModel:AddFields('Z07MASTER', /*cOwner*/, oStruZ07, /*b_PreZ07*/, /*b_Pos*/) //esses cometários são opcionais
    oModel:SetDescription('Manutençao Regioes de Frete - Ana') //descrição do modelo de dados
    oModel:GetModel('Z07MASTER'):SetDescription('Manutençao Regioes de Frete - Ana') //nome para a descrição

    oModel:SetPrimaryKey( {"Z07_FILIAL", "Z07_COD"} ) //igual o que está no configurador

Return

Static Function ViewDef()   //mostra estrutura

    Local oModel    := FWLoadModel('ROT002')
    Local oStruZ07  := FWFormStruct(2, 'Z07') //2 pra view
    Local oView     := FWFormView():New()

    oView:SetModel(oModel)
    oView:AddFields('VIEW_Z07', oStruZ07, 'Z07MASTER')

    oView:CreateHorizontalBox('CABEC', 100) //cria a tela, ocupa 100% da tela
    oView:SetOwnerView('VIEW_Z07', 'CABEC')

Return oView

User Function FLEGENDA()
    
Local a_Cor := {}

AADD(a_Cor,{"BR_PINK", "maior que 100"})
AADD(a_Cor,{"BR_AZUL", "menor que 100"})

BrwLegenda("Valor do Frete", "Legenda", a_Cor)

Return(.T.)
