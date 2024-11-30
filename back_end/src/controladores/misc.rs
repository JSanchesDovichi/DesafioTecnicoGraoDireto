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
    restaurantes: Vec<Restaurante>,
    items: Vec<ItemCardapio>
}

//TODO: Sehouver tempo, refazer para usar a busca na query do bancod e dados. Talvez com paginação?
#[get("/?<busca>")]
pub async fn busca_textual(busca: String, _usuario: UsuarioLogado,
    database: &State<Database>) -> Option<Json<ResultadoBusca>>  {

        let mut lista_teste: Vec<Restaurante> = vec![];
        let mut lista_itens: Vec<ItemCardapio> = vec![];
    
        let colecao_restaurantes = database.collection::<RestauranteComCardapio>("restaurantes");
    
        let query = doc! {};

        match colecao_restaurantes.find(query).await {
            Ok(mut resultados) => {
                while let Some(Ok(restaurante)) = resultados.next().await {
                    //lista_teste.push(doc);
                    if restaurante.nome.contains(&busca) {
                        lista_teste.push(Restaurante {
                            avaliacoes: restaurante.avaliacoes,
                            pontuacao: restaurante.pontuacao,
                            categoria: restaurante.categoria,
                            codigo_zip: restaurante.codigo_zip,
                            endereco: restaurante.endereco,
                            nome: restaurante.nome,
                            id: restaurante.id,
                            posicao: restaurante.posicao,
                            lat: restaurante.lat,
                            lng: restaurante.lng
                        });
                    }

                    for item in restaurante.cardapio {
                        if item.nome.contains(&busca) {
                            lista_itens.push(item);
                        }
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
                items: lista_itens
            };

            return Some(Json(resultado))
        }
    
        None
}