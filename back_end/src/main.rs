pub mod database;
pub mod controladores;
pub mod models;
pub mod autenticacao;
pub mod token;

use database::criar_conexao;
use controladores::{restaurantes, cardapios};
use rocket::launch;

#[macro_use]
extern crate dotenv_codegen;

#[launch]
async fn rocket() -> _ {
    let Ok(database_connection) = criar_conexao().await else {
        std::process::exit(1);
    };

    rocket::build()
    .manage(database_connection)
    .mount("/restaurantes", restaurantes::rotas())
    .mount("/restaurantes", cardapios::rotas())
    .mount("/", autenticacao::rotas())
}
