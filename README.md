# Anotações sobre ADVPL, Protheus, testes e demais ...

## Sobre a linguagem
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
    - função principal (browse)
    - static function MENUDEF (estrutura de menu)
    - static function VIEWDEF (lógica de implementação da interface gráfica)
    - static function MODELDEF (lógica das regras da aplicação)
    - funções adicionais de apoio às regras do MODELDEF
- mudança na lógica de implementação dos pontos de entrada

### TOTVS Language Plus Plus (TLPP)
- evolução da linguagem ADVPL tradicional
- adiciona novos recursos à linguagem
- a declaração de funções, variáveis, atributor de classes e métodos passa a poder ser tipada de forma explicita
- possui tratamentos em tempo de compilação para prevenção de erros
- não é compatível com ADVPL MVC

## Escopos
### Escopo de funções
- Function: escopo das funções desenvolvidas pela equipe de desenvolvimento da TOTVS
- Main Function: escopo para funções principais que podem ser acionadas a partir da janela de parametros iniciais do smartclient (usada na construção de funções associadas a módulos, ex.: SIGAFAT)
- User Function: escopo de funções desenvolvidas por desenvolvedores de fora da equipe oficial da TOTVS. como alternativa, é possível declarar como "U_" antes do nome
    - ex.: User Function TESTE == Function U_TESTE
- Static Function: escopo destinado a funções de uso auxiliar para demais funções escritas no mesmo arquivo de código fonte

### Escopo de variáveis
- Local: determina que a variável poderá ser manipulada apenas na função em que foi declarada
- Private: determina que a variável declarada com este escopo ficará disponível no programa em que foi declarada e por todas as funções acionadas a partir dele e enquanto ele existir
- Static: utilizado para variáveis que podem ser acessadas por qualquer função em qualquer lugar do arquivo. são declaradas fora das funções
- Public: a variável continua existindo dentro da thread em que aquela função foi acionada

## Tipagem de variáveis
### ADVPL
```
xVar := nil                   valType() => U variant
cVar := 'Texto'               valType() => C Texto
dVar := date()                valType() => D Data
nVar := 99                    valType() => N Numerico
lVar := .T.                   valType() => L Logico
bVar := {|| alert('ok')}      valType() => B Bloco de código
oVar := fwJsonObject():new()  valType() => O Objeto
aVar := array(0)              valType() => A Array
```

### TLPP
```
xVarTipoVariant   as variant      o conteúdo pode mudar ao longo do programa
nVarTipoInteiro   as integer      inteiros
nVarTipoNumeric   as numeric      inteiros e pontos flutuantes
nVarTipoDouble    as double       ponto flutuante
nVarTipoDecimal   as decimal      número de casas decimais específico
lVarTipoLogico    as logical      para conteúdos do tipo lógico .T. ou .F.
cVarTipoTexto     as character    conteúdos do tipo texto, tanto caracter quanto string
dVarTipoData      as date         data
bVarTipoBloco     as codeblock    bloco de código
oVarTipoObject    as object       objeto
oVarTipoJson      as json         json
aVarTipoArray     as array        array
```

## Operadores
### Operdores comuns
```
numero := 10
numero := numero + 20     soma
numero := numero - 20     subtração
numero := numero * 10     multiplicação
numero := numero / 10     divisão
numero := numero ** 10    exponencial
numero := numero % 10     resto da divisão
```

### Operadores de atribuição
```
numero := 10      atribuição simples
numero += 20      soma e atribui
numero -= 20      subtrai e atribui
numero *= 10      multiplica e atribui
numero /= 10      divide e atribui
```

### Operadores lógicos
```
nome = 'ZZZZ'                           fora da declaração da variável, = é sinal de atribuição
lret := nome = 'ZZZ'                    retorna .T. ou .F., se existe
lret := nome == 'ZZZ'                   retorna .T. ou .F., comparação
lret := numero > 10                     maior que
lret := numero < 10                     menor que
lret := numero >= 10                    maior ou igual
lret := numero <= 10                    menor ou igual
lret := numero <> 10                    diferente
lret := numero != 10                    diferente
lret := ! numero = 10                   inverte resultado da operação
lret := .not. numero = 10               inverte resultado da operação
lret := numero > 10 .and. numero < 100  e
lret := numero > 10 .or. numero < 100   ou
```
### Operações com texto
```
varNome := 'nome '
varSobrenome := 'sobrenome'
nome_completo := varNome                'nome ' 
nome_completo += varSobrenome           'nome sobrenome'        
nome_completo := varNome                'nome '
nome_completo -= varSobrenome           'nomesobrenome '
lret := varNome $ nome_completo         pertencimento .F.
lret := varSobrenome $ nome_completo    pertencimento .T.
```

### Operadores com data
```
data_login := date()    retorna a data de hoje
data_login += 10        soma 10 dias
data_login -= 10        subtrai 10 dias
data_login > date()     .T.
data_login < date()     .F.
data_login >=
data_login <=
```

### Operadores incrementais (++) e decrementais (--)
#### Pósfixado
```
total  := 0
numero := 10
total  := numero++ + 10     numero == 11 | total == 20
total1 := numero-- - 10     numero == 10 | total == 20
```
#### Préfixado
```
total   := ++numero + 10    numero == 11 | total == 21
total1  := --numero - 10    numero == 10 | total == 0
```

### Operadores especiais
- -> operador de apelido: usado para relacionar um campo a uma tabela ou area de memoria
```
M->A1_COD := ''
```
- () operador de agrupamento ou função
```
(total1 := numero + paramento, total2 := numero - parametro * 2)
(p1,p2)
```
- $ operador de macrosubstituição
```
total := &('numero') + 10
```
- {} operador de matriz ou bloco de código
```
lista_numeros := {10,20,30}
bloco := {|| fwAlertInfo('ok')}
```
- @ passagem de parametro por referencia
```
numero := 10
paramento := 10
soma_numeros(@numero, parametro)

Static Function soma_numeros(p1,p2)
    p1 := p1 * p2   p1 modifica o valor guardado em numero, pois acessa a área de memória | numero == 100 p1 == 100
    p2 := p1        p2 recebe resultado de p1 sem alterar a área de memória de parametro | paramentro == 10 p2 == 100
```

## Estruturas de decisão
### If Else
```
Local primeiroNumero := 10 as integer
Local segundoNumero  := 20 as integer
Local somaNumeros    := 0

//estrutura normal
If primeiroNumero > segundoNumero
    somaNumeros := primeiroNumero + segundoNumero
Else
    somaNumeros := segundoNumero - primeiroNumero
EndIf

//usando o comando IF como função
somaNumeros := IF(primeiroNumero > segundoNumero, primeiroNumero + segundoNumero, segundoNumero - primeiroNumero)

//usando ElseIf
If primeiroNumero > segundoNumero
    fwAlertInfo('primeiroNumero é maior')
ElseIf primeiroNumero = segundoNumero
    fwAlertWarning('numeros iguais')
ElseIf segundoNumero < primeiroNumero
    fwAlertInfo('primeroNumero é menor')
Else
    fwAlertError('ERRO')
EndIf
```

### Do Case
```
DO CASE
    CASE primeiroNumero > segundoNumero
        fwAlertInfo('primeiroNumero é maior')
    CASE primeiroNumero = segundoNumero
        fwAlertWarning('numeros iguais')
    OTHERWISE
        fwAlertError('primerioNumero é menor')
```