pub mod database;

use database::criar_conexao;
use mongodb::{bson::{doc, Document}, Database};
use rocket::{futures::StreamExt, get, launch, routes, State};

#[macro_use]
extern crate dotenv_codegen;

#[get("/hello/<name>/<age>")]
fn hello(name: &str, age: u8) -> String {
    format!("Hello, {} year old named {}!", age, name)
}

#[get("/test_db")]
pub async fn db_test(database: &State<Database>) {
    let query = doc! {};

    match database.collection::<Document>("test_col").find(query).await {
        Ok(mut res) => {
            while let Some(doc) = res.next().await {
                println!("{}", doc.unwrap())
              }
        },
        Err(e) => {
            println!("Erro: {e}");
        }
    }
}

#[launch]
async fn rocket() -> _ {
    let Ok(database_connection) = criar_conexao().await else {
        std::process::exit(1);
    };

    rocket::build()
    .manage(database_connection)
    .mount("/", routes![db_test])
    .mount("/", routes![hello])

    
}
