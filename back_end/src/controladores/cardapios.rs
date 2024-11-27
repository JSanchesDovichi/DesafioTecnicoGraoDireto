use mongodb::{
    bson::{doc, Document},
    Database,
};
use rocket::{futures::StreamExt, get, routes, serde::json::Json, Route, State};

use crate::models::{cardapio::ItemCardapio, restaurante::{Restaurante, RestauranteComCardapio}};

pub fn rotas() -> Vec<Route> {
    routes![buscar_cardapio]
}

#[get("/cardapio/<id_restaurante>")]
pub async fn buscar_cardapio(id_restaurante: i32, database: &State<Database>) -> Option<Json<Vec<ItemCardapio>>> {
    let colecao_restaurantes = database.collection::<RestauranteComCardapio>("restaurantes");

    let query = doc! {
        "id": id_restaurante
    };

    match colecao_restaurantes.find(query).await {
        Ok(resultados) => {

            let mut lista_itens_encontrados = vec![];
            
            let map = resultados.map(|item| item);
            let itens_encontrados = map.collect::<Vec<_>>().await;

            for item_recuperado in itens_encontrados.into_iter().flatten() {
                //lista_itens_encontrados.push(item_recuperado.cardapio);
                lista_itens_encontrados = item_recuperado.cardapio;
            }

            return Some(Json(lista_itens_encontrados));
        }
        Err(e) => {
            println!("Erro: {e}");
        }
    }

    None
}
