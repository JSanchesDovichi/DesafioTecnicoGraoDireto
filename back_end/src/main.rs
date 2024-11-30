pub mod database;
pub mod controladores;
pub mod models;
pub mod autenticacao;
pub mod token;

use database::criar_conexao;
use controladores::{cardapios, misc, restaurantes};
use rocket::launch;
use rocket_cors::{CorsOptions, AllowedOrigins};

#[macro_use]
extern crate dotenv_codegen;

#[launch]
async fn rocket() -> _ {
    let Ok(database_connection) = criar_conexao().await else {
        std::process::exit(1);
    };

    let mut cors_options = CorsOptions::default();
    cors_options.allow_credentials = true;
    cors_options.allowed_origins = AllowedOrigins::some_exact(&["http://127.0.0.1:8027"]);

    let Ok(cors) = cors_options.to_cors() else {
        std::process::exit(2);
    };

    rocket::build()
    .attach(cors)
    .manage(database_connection)
    .mount("/restaurantes", restaurantes::rotas())
    .mount("/restaurantes", cardapios::rotas())
    .mount("/restaurantes/busca", misc::rotas())
    .mount("/", autenticacao::rotas())
}