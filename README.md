
# Mobile Arquitetura 02

Aplicação Flutter demonstrando arquitetura em camadas com:
- UI
- ViewModel
- Repository
- DataSource

A aplicação consome uma API de produtos e implementa:
- estado da interface (loading, erro, sucesso)
- tratamento de erros
- cache simples em memória

## Respostas

### 1
O mecanismo de cache foi implementado na camada Repository, pois essa camada decide de onde os dados devem ser obtidos.

### 2
O ViewModel não deve realizar chamadas HTTP diretamente porque sua responsabilidade é gerenciar o estado da interface.

### 3
Se a interface acessasse diretamente o DataSource haveria forte acoplamento entre UI e dados.

### 4
Essa arquitetura permite substituir facilmente a API por um banco local alterando apenas Repository ou DataSource.
