
use base64::{prelude::BASE64_URL_SAFE, Engine};
use rocket::{form::Form, post, http::Status, request::{FromRequest, Outcome}, routes, serde::{self, json::{self, Json, Value}}, FromForm, Request, Route, State};
use rocket::serde::{Deserialize, Serialize};

use crate::token::{criar_chave_hmac, criar_token, verificar_chave_jwt, JwtClaims};

pub fn rotas() -> Vec<Route> {
    routes![login]
}

#[derive(Debug)]
pub struct UsuarioLogado {
    email: String
}

#[derive(FromForm)]
pub struct Login<'r> {
    username: &'r str,
    password: &'r str,
}

#[post("/login", data="<formulario>")]
pub async fn login(formulario: Form<Login<'_>>) -> (Status, Option<String>) {
    let db_user = dotenv!("DB_USER");
    let db_pass = dotenv!("DB_PASS");
    let db_email = dotenv!("DB_USER_EMAIL");

    if formulario.username == db_user && formulario.password == db_pass {
        //retornar uma token JWT com o email do usuário

        let Ok(chave_hmac) = criar_chave_hmac() else {
            return (Status::InternalServerError, None);
        };
    
        let claims = JwtClaims {
            email: db_email.to_string(),
        };
    
        let Ok(token) = criar_token(claims, chave_hmac) else {
            return (Status::InternalServerError, None);
        };

        let token_str = token.as_str();

        //let token_encodificada = BASE64_URL_SAFE.encode(token_str);

        let resposta = Some(token_str.to_owned());
    
        return (Status::Ok, resposta);

    }

    (Status::Forbidden, None)
}

#[derive(Debug)]
pub enum ErroAutenticacao {
    AreaProibida,
    TamanhoTokenInvalida,
    ConversaoNivel,
    Desconhecido,
    TOKENINAUTHHEADERTEST,
    DesconhecidoJwt(jwt::Error),
}

#[rocket::async_trait]
impl<'operacao> FromRequest<'operacao> for UsuarioLogado {
    type Error = ErroAutenticacao;

    async fn from_request(request: &'operacao Request<'_>) -> Outcome<UsuarioLogado, Self::Error> {
        let Some(header_authorization) = request.headers().get_one("Authorization") else {
            return Outcome::Error((Status::Unauthorized, ErroAutenticacao::AreaProibida));
        };

        let token_jwt = header_authorization.replace("Bearer", "");

        let Ok(chave_hmac) = criar_chave_hmac() else {
            return Outcome::Error((
                Status::Unauthorized,
                ErroAutenticacao::TamanhoTokenInvalida,
            ));
        };

        let processo_token_jwt = verificar_chave_jwt(token_jwt.as_str(), chave_hmac);

        if let Err(e) = processo_token_jwt {
            return Outcome::Error((
                Status::Unauthorized,
                ErroAutenticacao::DesconhecidoJwt(e),
            ));
        }

        let Ok(token) = processo_token_jwt else {
            return Outcome::Error((Status::Unauthorized, ErroAutenticacao::Desconhecido));
        };

        let claims = token.claims();

        let owned_email = claims.email.to_owned();
        let resultado = UsuarioLogado {
            email:  owned_email,
        };
        

        return Outcome::Success(resultado);
    }
}