use rocket::serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]

pub struct ItemCardapio {
    pub categoria: String,
    pub nome: String,
    //descricao: Option<String>,
    pub preco: String
    /*
    categoria: String,
    nome: String,
    descricao: String,
    preco: String
    */
}