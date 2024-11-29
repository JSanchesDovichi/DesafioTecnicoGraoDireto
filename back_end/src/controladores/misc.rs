use mongodb::{
    bson::{doc, Document}, Database
};
use rocket::{futures::StreamExt, get, routes, serde::{json::Json, Deserialize, Serialize}, Route, State};

use crate::{autenticacao::UsuarioLogado, models::{cardapio::ItemCardapio, restaurante::{self, Restaurante, RestauranteComCardapio}}};

pub fn rotas() -> Vec<Route> {
    routes![busca_textual]
}

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]

pub struct ResultadoBusca {
    restaurantes: Vec<RestauranteComCardapio>,
    items: Vec<ItemCardapio>
}

#[get("/?<busca>")]
pub async fn busca_textual(busca: String, _usuario: UsuarioLogado,
    database: &State<Database>) -> Option<Json<ResultadoBusca>>  {

        let mut lista_teste: Vec<RestauranteComCardapio> = vec![];
    
        let colecao_restaurantes = database.collection::<RestauranteComCardapio>("restaurantes");
    
        let query = doc! {};

        match colecao_restaurantes.find(query).await {
            Ok(mut resultados) => {
                while let Some(Ok(restaurante)) = resultados.next().await {
                    //lista_teste.push(doc);
                    if restaurante.nome.contains(&busca) {
                        lista_teste.push(restaurante);
                    }
                }

                //return Some(Json(lista_teste));
            }
            Err(e) => {
                println!("Erro: {e}");
            }
        }

        if !lista_teste.is_empty() {
            let resultado = ResultadoBusca{
                restaurantes: lista_teste,
                items: vec![]
            };

            return Some(Json(resultado))
        }
    
        None
}