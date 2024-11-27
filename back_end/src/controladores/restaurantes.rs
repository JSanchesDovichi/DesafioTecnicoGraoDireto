use mongodb::{
    bson::doc, Database
};
use rocket::{futures::StreamExt, get, routes, serde::json::Json, Route, State};

use crate::models::restaurante::Restaurante;

pub fn rotas() -> Vec<Route> {
    routes![listar_restaurantes]
}

#[get("/?<page>")]
pub async fn listar_restaurantes(
    database: &State<Database>,
    page: Option<u64>,
) -> Option<Json<Vec<Restaurante>>> {
    let restaurantes_por_pagina: u64 = 20;
    let mut pagina_atual: u64 = 1;

    if let Some(pagina_selecionada) = page {
        pagina_atual = pagina_selecionada;
    };

    let mut lista_teste: Vec<Restaurante> = vec![];

    let colecao_restaurantes = database.collection::<Restaurante>("restaurantes");

    let query = doc! {};

    match colecao_restaurantes.find(query).skip(restaurantes_por_pagina * pagina_atual).limit(restaurantes_por_pagina as i64).await {
        Ok(mut resultados) => {
            while let Some(Ok(doc)) = resultados.next().await {
                lista_teste.push(doc);
            }

            return Some(Json(lista_teste));
        }
        Err(e) => {
            println!("Erro: {e}");
        }
    }

    None
}