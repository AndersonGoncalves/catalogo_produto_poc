# Catálogo de Produtos

Aplicativo de cadastro e gerenciamento de produtos, desenvolvido por Anderson Gonçalves como uma prova de conceito utilizando Flutter, Dart e Firebase.

## 📚 Descrição

Este app permite que usuários cadastrem, visualizem e gerenciem produtos. É possível adicionar até três fotos para cada produto e o acesso do usuário ao app pode ser feito de forma anônima ou autenticando-se via e-mail. Todos os dados de produtos e autenticação são gerenciados via Firebase.

## 🚀 Tecnologias Utilizadas

- *Frontend:*  
  - [Flutter](https://flutter.dev/)  
  - [Dart](https://dart.dev/)
  - [Provider](https://pub.dev/packages/provider)
- *Backend:*  
  - [Realtime Database](https://firebase.google.com/products/realtime-database) (armazenamento dos produtos)
  - [Firebase Authentication](https://firebase.google.com/products/auth) (autenticação anônima e por e-mail)  

## ⚙️ Funcionalidades

- Listagem de produtos cadastrados.
- Cadastro/edição de produto com os campos:
  - Nome
  - Descrição
  - Preço de Custo
  - Preço de Venda
  - Quantidade em Estoque
  - Codigo de Barras
  - Marca  
  - Fotos do produto
- Autenticação de usuário:
  - Login anônimo
  - Login com e-mail e senha
  - Login com google
  - Recuperação de senha
- Upload e exibição de fotos dos produtos.
- Integração em tempo real com Firebase.

## 🖼️ Exemplos de Tela
![home_page](https://github.com/user-attachments/assets/0e7247a7-65e4-4a83-9de2-c0ec707cc637)
![drawer](https://github.com/user-attachments/assets/e95c5e26-82ea-4570-9f01-98898be6f226)
![produto_form_1](https://github.com/user-attachments/assets/76f56561-fbeb-4701-9b30-e792b1166270)
![produto_form_2](https://github.com/user-attachments/assets/d357d933-5e67-43e9-a65e-84d9f535939b)
![produto_calculadora_preco](https://github.com/user-attachments/assets/e5cb8677-6edc-4e13-aab6-d97cab11db42)

## 📦 Estrutura do Projeto

- lib/ - Código principal do Flutter
- lib/app - Pasta onde contém o código da aplicação
- lib/app/core - Contém definições e utilitários centrais do projeto, que podem ser usados em qualquer parte da aplicação.
Exemplos: modelos de dados (models), constantes, ui, excpetions, widget, tema do app, etc.
- lib/app/modules - Agrupa funcionalidades ou telas por domínio ou recurso.
Cada módulo representa uma área da aplicação (produto e usuário).
- lib/app/repositories - Pasta que contém as classes de acesso a dados de cada módulo da aplicação.
O repositório implementa métodos para buscar, salvar, atualizar e remover dados, servindo de ponte entre a camada de dados e os services/controllers.
- lib/app/services - Contém a regra de negócio da aplicação e usa os repositórios para acessar dados e implementam as regras de negócio e validações. Os controllers acessam os services para manipular dados.
- android/, ios/, web/ e windows/ - Contém a compilação de cada plataforma.
- assets/ - Contém as imagens e icónes da aplicação.
- pubspec.yaml - Gerenciamento de dependências
- test/ - Contém todos os testes da aplicação, foi criado alguns testes para validar o conhecimento em testes.

## 🛠️ Instalação e Execução

1. *Clone este repositório*
   bash
   git clone https://github.com/AndersonGoncalves/catalogo_produto_poc.git
   cd catalogo_produto_poc   

2. *Instale as dependências*
   bash
   flutter pub get   

3. *Configure o Firebase*
   - Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
   - Baixe o arquivo google-services.json (Android) e/ou GoogleService-Info.plist (iOS) e coloque nas pastas correspondentes.
   - Habilite Firestore, Authentication (anônimo e e-mail/senha) e Storage.

4. *Execute o app*
   bash
   flutter run   

> Certifique-se de ter o Flutter instalado e um emulador/dispositivo conectado.

## 🤝 Como Contribuir

1. Faça um fork deste repositório
2. Crie uma branch: git checkout -b minha-feature
3. Faça suas alterações e commit: git commit -m 'Minha nova feature'
4. Faça push para sua branch: git push origin minha-feature
5. Abra um Pull Request
