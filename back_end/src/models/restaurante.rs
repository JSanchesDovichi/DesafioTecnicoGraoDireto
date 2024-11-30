use mongodb::bson::Document;
use rocket::serde::{Deserialize, Serialize};

use super::cardapio::ItemCardapio;

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]

pub struct Restaurante {
    pub id: i32,
    pub posicao: i32,
    pub nome: String,
    pub pontuacao: f32,
    pub avaliacoes: f32,
    pub categoria: String,
    pub endereco: String,
    pub codigo_zip: String,
    pub lat: f64,
    pub lng: f64,
}

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]

pub struct RestauranteComCardapio {
    pub id: i32,
    pub posicao: i32,
    pub nome: String,
    pub pontuacao: f32,
    pub avaliacoes: f32,
    pub categoria: String,
    pub endereco: String,
    pub codigo_zip: String,
    pub lat: f64,
    pub lng: f64,
    
    pub cardapio: Vec<ItemCardapio>
}