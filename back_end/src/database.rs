use mongodb::{bson::{doc, Document}, options::{ClientOptions, Credential, ServerAddress}, Client, Database};
//use futures::stream::{StreamExt, TryStreamExt};
use rocket::{futures::StreamExt, http::hyper::server::conn};

pub async fn criar_conexao() -> Result<Database, mongodb::error::Error> {
    dotenv::from_filename("../.env").ok();

    let db_user = dotenv!("DB_USER");
    let db_pass = dotenv!("DB_PASS");
    let db_name = dotenv!("DB_NAME");

    /*
    let credenciais = Credential::builder()
            .username(db_user.to_string())
            .password(db_pass.to_string()).build();

    let endereco = ServerAddress::Tcp {
                host: "localhost".to_string(),
                port: Some(27017)
            };

    let client_options = ClientOptions::builder().credential(credenciais).hosts(vec![endereco]).build();
    */

    let conn_str = format!("mongodb://{db_user}:{db_pass}@localhost:27017/");

    let client_options = ClientOptions::parse(conn_str).await?;

    let client = Client::with_options(client_options)?;
    let database = client.database(&db_name);

    Ok(database)
}