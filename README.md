# Como executar

## Dependências
* Rust (https://www.rust-lang.org/tools/install)
* Flutter (https://docs.flutter.dev/get-started/install)
* Python 3.12 (https://www.python.org/downloads/)
* Poetry (https://python-poetry.org/docs/#installation)
* Docker (https://docs.docker.com/engine/install/)
* Docker Compose (https://docs.docker.com/compose/install/)
* Navegador Chromium (https://www.chromium.org/getting-involved/download-chromium/)

## Passo a passo para executar

Após instalar as dependências, siga os passos a baixo:

* Baixe os arquivos do dataset de restaurantes e cardápios disponível em https://www.kaggle.com/discussions/general/327845
* Extraia o arquivo -> Dois arquivos devem existir: restaurant-menus.csv e restaurants.csv -> mova eles para o diretório datasets dentro de dataset_importer.
* A estrutura deve ficar assim: raiz_do_projeto/dataset_importer/datasets/restaurants.csv e raiz_do_projeto/dataset_importer/datasets/restaurant-menus.csv.
* Na raiz do projeto, crie um arquivo chamado .env com os seguintes atributos:
```env
DB_USER=""
DB_PASS=""
DB_USER_EMAIL=""
DB_NAME="desafio_tecnico"
SECRET_KEY=""
```
* Altere os valores seguindo as regras a seguir:
* DB_USER: Chave criptografada do nome de usuário de testes. NOTA: A CHAVE DEVE SER UMA CHAVE SHA-512 COM LETRAS EM MAIÚSCULO. NÃO USE CARACTERES ESPECIAIS PARA ESTE ATRIBUTO.
* DB_PASS: Chave criptografada da senha do usuário de testes. NOTA: A CHAVE DEVE SER UMA CHAVE SHA-512 COM LETRAS EM MAIÚSCULO. 
* DB_USER_EMAIL: email (em texto normal) para o usuário de testes. Usado apenas para identificação dentro do aplicativo.
* DB_NAME: Nome da seção do banco de dados. MANTENHA COMO "desafio_tecnico".
* SECRET_KEY: Chave de segurança para criptografia na API do projeto. Use o comando 'openssl rand -base64 32' para gerar essa chave.

*  Na raiz do projeto execute o comando 'docker compose up -d --build', com isso, o banco de dados do projeto será iniciado, e ficará rodando em segundo plano.
* Entre na pasta back_end e execute o comando 'cargo run' para iniciar a API do projeto.
* Entre na pasta front_end e execute os comandos para iniciar o front end: 
```sh
  export CHROME_EXECUTABLE=/usr/bin/chromium
  flutter run -d chrome --web-hostname 127.0.0.1 --web-port 8027
```

* Para usar o sistema use o nome de usuário e senha no login: LEMBRE-SE de anotar esses dados, já que o front end envia esses dados criptografados para a API para realizar a autenticação.

## Estado das Features requisitadas

| Feature  | Estado |
| ------------- | ------------- |
| Portal Web Responsivo  | Funcional - Incompleto  |
| Autenticação por e-mail e senha criptografados  | Funcional  |
| Tela inicial com uma lista dos restaurantes  | Funcional  |
| Paginação da lista dos restaurantes  | Funcional - Implementação incompleta no Front-end  |
| A tela deve possuir um campo de busca livre, que filtra os restaurantes cujo NOME DO RESTAURANTE, NOME OU DESCRIÇÃO DO PRATO possuam os caracteres digitados;  | Funcional - Implementação incompleta no Front-end  |
| Ao clicar em um restaurante na lista, a plataforma deve ir para a tela de detalhe do restaurante e cardápio  | Funcional  |
| Tela com detalhe do restaurante, mostrando nome, telefone e endereço, além da lista de itens do cardápio (nome, descrição e preço).  | Funcional - Front-end incompleto  |

## Critérios do MVP

| Critério  | Estado |
| ------------- | ------------- |
| Portal ou aplicativo  | Portal com suporte futuro a ser aplicativo  |
| Tela de login e autenticação (criar um usuário "fred@graodireto.com.br e senha "123Fred")  | Implementado com sucesso  |
| Backend respondendo a chamadas API REST  | Implementado com sucesso  |
| Repositório de dados contendo informações dos
usuários, restaurantes e itens do cardápio  | Implementado com sucesso - Gerenciado pelo próprio banco de dados  |