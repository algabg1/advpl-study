## Anotações sobre ADVPL, Protheus, testes e demais ...

### ADVPL tradicional
- linguagem proprietária da TOTVS para o ERP TOTVS Protheus
- baseada em clipper
- contrução de telas, pontos de entrada, relatórios, entre outros
- os códigos podem ser escritos de forma procedural ou baseado em orientação a objetos
- fracamente tipada
- limitações quanto a quantidade de caracteres para nome de variáveis e funções

### ADVPL MVC
- atualização da linguagem advpl tradicional para construção de aplicações baseada na arquitetura MVC
- separa a aplicação em diferentes partes que seguem um modelo padrão definido
- os componentes podem ou não fazer parte do mesmo arquivo de código fonte
- componentes:
-> função principal (browse)
-> static function MENUDEF (estrutura de menu)
-> static function VIEWDEF (lógica de implementação da interface gráfica)
-> static function MODELDEF (lógica das regras da aplicação)
-> funções adicionais de apoio às regras do MODELDEF
- mudança na lógica de implementação dos pontos de entrada