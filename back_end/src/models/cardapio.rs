use rocket::serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]

pub struct ItemCardapio {
    categoria: String,
    nome: String,
    //descricao: Option<String>,
    preco: String
    /*
    categoria: String,
    nome: String,
    descricao: String,
    preco: String
    */
}