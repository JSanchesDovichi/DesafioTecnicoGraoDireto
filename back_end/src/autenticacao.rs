
use rocket::{form::Form, get, http::Status, routes, serde::{self, json::{self, Json, Value}}, FromForm, Route, State};
use rocket::serde::{Deserialize, Serialize};

pub fn rotas() -> Vec<Route> {
    routes![login]
}

#[derive(FromForm)]
pub struct Login<'r> {
    username: &'r str,
    password: &'r str,
}

#[get("/login", data="<formulario>")]
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
    
        /*
        let resposta = json!({
            "token": token.as_str(),
        });
        */

        /* 
        let resposta = Json(
            token.as_str()
        );
        */

        let token_str = token.as_str();

        let resposta = Some(token_str.to_owned());
    
        return (Status::Ok, resposta);

        //return Status::Ok;
    }

    //Status::Forbidden
    (Status::Forbidden, None)
}

use hmac::{digest::{InvalidLength, KeyInit}, Hmac};
use jwt::{Token, Header, Verified, VerifyWithKey, AlgorithmType, SignWithKey, token::Signed};
//use recursos_genericos::SECRET_KEY;
use sha2::Sha384;

//use super::claims::JwtClaims;

#[derive(Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct JwtClaims {
    pub email: String,
}

#[inline(always)]
pub fn criar_chave_hmac() -> Result<Hmac<Sha384>, InvalidLength> {
    Hmac::new_from_slice(SECRET_KEY.as_bytes())
}

#[inline(always)]
pub fn verificar_chave_jwt(token_jwt: &str, chave_hmac: Hmac<Sha384>) -> Result<Token<Header, JwtClaims, Verified>, jwt::Error> {
    VerifyWithKey::verify_with_key(token_jwt, &chave_hmac)
}

#[inline(always)]
pub fn criar_token(claims: JwtClaims, chave_hmac: Hmac<Sha384>) -> Result<Token<Header, JwtClaims, Signed>, jwt::Error>{
    let header = Header {
        algorithm: AlgorithmType::Hs384,
        ..Default::default()
    };

    Token::new(header, claims).sign_with_key(&chave_hmac)
}