use mongodb::{options::ClientOptions, Client, Database};

pub async fn criar_conexao() -> Result<Database, mongodb::error::Error> {
    let client_options = ClientOptions::parse(
        "mongodb://root:example@localhost:27017/",
    )
    .await?;
    let client = Client::with_options(client_options)?;
    let database = client.database("desafio_tecnico");
    // do something with database

    //Ok(())
    Ok(database)
}