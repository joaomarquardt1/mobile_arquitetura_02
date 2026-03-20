
# Loja de Produtos - Arquitetura em Camadas com Navegação

Um projeto Flutter que demonstra a implementação de navegação entre múltiplas telas em uma aplicação com Clean Architecture.

## 📱 Descrição do Projeto

Esta é uma evolução do projeto original de listagem de produtos. A aplicação agora possui um fluxo completo de navegação com três telas principais:

1. **Tela Inicial** - Ponto de entrada da aplicação
2. **Tela de Listagem de Produtos** - Exibe produtos da Fake API
3. **Tela de Detalhes do Produto** - Mostra informações completas do produto selecionado

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                              # Ponto de entrada da aplicação
├── data/
│   ├── datasource/
│   │   └── product_api_datasource.dart   # Consumo da API
│   └── repository/
│       └── product_repository_impl.dart  # Implementação do repositório
├── domain/
│   ├── entities/
│   │   └── product.dart                  # Modelo de dados
│   └── repository/
│       └── product_repository.dart       # Interface do repositório
└── presentation/
    ├── pages/
    │   ├── home_page.dart               # Tela inicial
    │   ├── product_list_page.dart       # Tela de listagem
    │   └── product_detail_page.dart     # Tela de detalhes
    └── viewmodel/
        └── product_viewmodel.dart       # Lógica de negócio
```

## 🔄 Fluxo da Navegação

```
Home Page (Tela Inicial)
    ↓
    └─→ [Botão "Ver Produtos"]
            ↓
        Product List Page (Listagem)
            ↓
            └─→ [Clique em um produto]
                    ↓
                Product Detail Page (Detalhes)
                    ↓
                    └─→ [Botão voltar ou gesto de swipe]
                        Retorna para a listagem
```

## 🎯 Funcionalidades

### ✅ Tela Inicial
- Exibição de bem-vindo com ícone e descrição
- Botão para acessar a listagem de produtos
- Design clean e intuitivo

### ✅ Tela de Listagem
- Carregamento automático de produtos da Fake API
- Exibição em formato de cards com:
  - Imagem do produto (thumbnail)
  - Nome do produto
  - Preço
  - Avaliação (rating)
- Indicador de carregamento
- Tratamento de erros
- Navegação ao clique em um produto

### ✅ Tela de Detalhes
- Imagem em destaque do produto
- Título completo
- Categoria
- Avaliação com estrelas
- Preço destacado
- Descrição completa
- Botão "Adicionar ao Carrinho"
- Navegação automática ao voltar

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK instalado
- Dart SDK instalado

### Passos

1. Clone ou abra o projeto:
```bash
cd mobile_arquitetura_02
```

2. Obtenha as dependências:
```bash
flutter pub get
```

3. Execute a aplicação:
```bash
flutter run
```

## 📡 API Utilizada

A aplicação consome dados da [Fake Store API](https://fakestoreapi.com/):
- **Endpoint**: `https://fakestoreapi.com/products`
- **Método**: GET
- **Retorno**: Lista de produtos com campos como título, preço, descrição, imagem, categoria e avaliação

## 🔧 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

## ❓ Questionário - Respostas

### 1. Qual era a estrutura do seu projeto antes da inclusão das novas telas?

**Resposta:**
O projeto original tinha uma estrutura bastante simples:
- Uma única página (`product_page.dart`) que servia como a aplicação em si
- Carregada diretamente no `main.dart` dentro de um `Scaffold` genérico
- Apenas exibia um `ListView` com nome e preço dos produtos
- Não havia navegação ou fluxo entre telas
- A entidade `Product` tinha apenas dois campos: `title` e `price`

### 2. Como ficou o fluxo da aplicação após a implementação da navegação?

**Resposta:**
A aplicação agora possui um fluxo bem definido:
1. **Inicialização**: O `main.dart` agora instancia a `HomePage`
2. **Home Page**: Tela inicial com botão para acessar produtos
3. **Product List Page**: Exibe produtos em cards interativos da API
4. **Product Detail Page**: Mostra detalhes completos ao clicar em um produto
5. **Volta**: O usuário pode voltar para a listagem e para a home usando o botão voltar ou swipe

O fluxo implementa o padrão Stack de navegação, onde cada tela é empilhada na pilha de navegação.

### 3. Qual é o papel do `Navigator.push()` no seu projeto?

**Resposta:**
`Navigator.push()` é responsável por **abrir novas telas** e empilhá-las na pilha de navegação. No projeto:

- **Home → Product List**: 
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ProductListPage(viewModel)),
);
```

- **Product List → Product Detail**:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ProductDetailPage(product)),
);
```

Cada `push()` adiciona uma nova rota na pilha, permitindo a navegação para frente.

### 4. Qual é o papel do `Navigator.pop()` no seu projeto?

**Resposta:**
`Navigator.pop()` é implementado **automaticamente** pelo Flutter quando o usuário:
- Clica no botão voltar nativo do Android
- Realiza um gesto de swipe para trás no iOS
- Clica no botão voltar da AppBar

O `pop()` remove a tela atual da pilha de navegação, retornando para a tela anterior. Não foi necessário criar botões explícitos de voltar porque o Flutter fornece isso automaticamente.

### 5. Como os dados do produto selecionado foram enviados para a tela de detalhes?

**Resposta:**
Os dados são enviados através de **passagem de parâmetros no construtor**:

1. Na `ProductListPage`, ao clicar em um produto:
```dart
final product = widget.viewModel.products[index];

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProductDetailPage(product),
  ),
);
```

2. O objeto `Product` completo é passado como argumento ao construtor da `ProductDetailPage`

3. Na `ProductDetailPage`, o produto é recebido e armazenado:
```dart
class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage(this.product, {super.key});
  // ...
}
```

Essa abordagem permite que a tela de detalhes tenha acesso a todos os dados do produto (título, preço, descrição, imagem, etc.).

### 6. Por que a tela de detalhes depende das informações da tela anterior?

**Resposta:**
A tela de detalhes depende das informações da tela anterior pelos seguintes motivos:

1. **Evita requisições desnecessárias**: O produto já foi carregado da API na tela de listagem, não há necessidade de fazer uma nova requisição na tela de detalhes
2. **Economia de dados e bateria**: Reutiliza os dados já em memória
3. **Melhor experiência do usuário**: Não há delay adicional ao abrir os detalhes
4. **Simplicidade arquitetural**: Seguindo o padrão de passagem de dados entre telas, é mais simples manter uma única lista em memória
5. **Coerência de dados**: Garante que o usuário vê exatamente as informações que ele selecionou da listagem

Se fossemos implementar um fetch por ID, teríamos complexidade adicional desnecessária neste contexto.

### 7. Quais foram as principais mudanças feitas no projeto original?

**Resposta:**
As principais mudanças foram:

1. **Entidade Product expandida**:
   - Adicionados campos: `id`, `description`, `image`, `category`, `rating`
   - Melhor parse do JSON da API

2. **Três novas páginas criadas**:
   - `home_page.dart` - Ponto de entrada
   - `product_list_page.dart` - Refatoração da antiga `product_page.dart`
   - `product_detail_page.dart` - Nova tela de detalhes

3. **main.dart refatorado**:
   - De Scaffold genérico para tela de home
   - Adicionado tema Material Design 3
   - Melhor configuração da aplicação

4. **Implementação de navegação**:
   - Uso de `Navigator.push()` e `Navigator.pop()`
   - Fluxo de telas bem definido

5. **Melhorias visuais**:
   - Cards na listagem com imagens
   - Design responsivo
   - Exibição de mais informações de produtos

### 8. Quais dificuldades você encontrou durante a adaptação do projeto para múltiplas telas?

**Resposta:**
As principais dificuldades foram:

1. **Organização do ciclo de vida das telas**:
   - Precisou gerenciar quando carregar dados (evitar múltiplos loads)
   - Usar `initState()` corretamente em StatefulWidgets

2. **Passagem de contexto entre viewmodels**:
   - Inicialmente pensava em múltiplos viewmodels
   - Decidido manter um único viewmodel compartilhado entre telas
   - Funcionou bem para este caso simples

3. **Tratamento de erro na tela de detalhes**:
   - Imagens que falham ao carregar
   - Necessário implementar `errorBuilder` para `Image.network()`

4. **Estado da aplicação**:
   - Garantir que os dados não sejam perdidos ao navegar entre telas
   - Usar `StatefulWidget` onde necessário e `StatelessWidget` onde possível

5. **Preservação de estado**:
   - Ao voltar da tela de detalhes para listagem, os produtos continuam carregados (bom)
   - Não havia necessidade de implementar cache mais sofisticado

## 📚 Conceitos Aprendidos

- ✅ Navigator e rotas no Flutter
- ✅ MaterialPageRoute
- ✅ Passagem de dados entre telas
- ✅ StatefulWidget vs StatelessWidget
- ✅ Scaffold e AppBar
- ✅ Layout responsivo
- ✅ Tratamento de imagens de rede
- ✅ Clean Architecture em Flutter

## 🔮 Possibilidades de Expansão

- [ ] Implementar rotas nomeadas (`Navigator.pushNamed()`)
- [ ] Adicionar animações de transição entre telas
- [ ] Implementar cache local (shared_preferences)
- [ ] Adicionar carrinho de compras
- [ ] Filtro de produtos por categoria
- [ ] Busca de produtos
- [ ] Favoritos/Wishlist
- [ ] Integração com banco de dados local (Hive/Sqflite)

## 📝 Autor

Projeto desenvolvido para aprendizado de navegação em Flutter com Clean Architecture.

## 📄 Licença

Este projeto é fornecido como exemplo educacional.
