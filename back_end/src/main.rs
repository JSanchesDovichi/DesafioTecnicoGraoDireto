pub mod database;

use database::{criar_conexao, test_query};
use mongodb::Database;
use rocket::{get, launch, routes};

#[macro_use]
extern crate dotenv_codegen;

#[get("/hello/<name>/<age>")]
fn hello(name: &str, age: u8) -> String {
    format!("Hello, {} year old named {}!", age, name)
}

#[launch]
async fn rocket() -> _ {
    let mut database: Option<Database> = None;
    
    match criar_conexao().await {
        Ok(conexao_criada) => {
            database = Some(conexao_criada);
        },
        Err(e) => {
            println!("Erro: {e}");
        }
    }

    test_query(database.unwrap()).await;


    rocket::build().mount("/", routes![hello])
}
