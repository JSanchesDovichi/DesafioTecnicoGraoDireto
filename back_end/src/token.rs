use hmac::{digest::{InvalidLength, KeyInit}, Hmac};
use jwt::{Token, Header, Verified, VerifyWithKey, AlgorithmType, SignWithKey, token::Signed};
use rocket::serde::{Deserialize, Serialize};
use sha2::Sha384;

#[derive(Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct JwtClaims {
    pub email: String,
}

const SECRET_KEY: &str = dotenv!("SECRET_KEY");

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