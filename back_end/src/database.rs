use mongodb::{options::ClientOptions, Client, Database};

pub async fn criar_conexao() -> Result<Database, mongodb::error::Error> {
    dotenv::from_filename("../.env").ok();

    let db_user = dotenv!("DB_USER");
    let db_pass = dotenv!("DB_PASS");
    let db_name = dotenv!("DB_NAME");

    let conn_str = format!("mongodb://{db_user}:{db_pass}@localhost:27017/");

    let client_options = ClientOptions::parse(conn_str).await?;

    let client = Client::with_options(client_options)?;
    let database = client.database(&db_name);

    Ok(database)
}