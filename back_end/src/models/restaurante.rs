use mongodb::bson::Document;
use rocket::serde::{Deserialize, Serialize};

use super::cardapio::ItemCardapio;

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]

pub struct Restaurante {
    id: i32,
    posicao: i32,
    pub nome: String,
    pontuacao: f32,
    avaliacoes: f32,
    categoria: String,
    endereco: String,
    codigo_zip: String,
    lat: f64,
    lng: f64,
}

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]

pub struct RestauranteComCardapio {
    id: i32,
    posicao: i32,
    pub nome: String,
    pontuacao: f32,
    avaliacoes: f32,
    categoria: String,
    endereco: String,
    codigo_zip: String,
    lat: f64,
    lng: f64,
    
    pub cardapio: Vec<ItemCardapio>
}
