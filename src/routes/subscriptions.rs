use actix_web::{web, HttpResponse};
use sqlx::PgConnection;

#[derive(serde::Deserialize)]
pub struct FormData {
    pub email: String,
    pub name: String,
}

pub async fn subscribe(_form: web::Form<FormData>, _connection: web::Data<PgConnection>,) -> HttpResponse {
    HttpResponse::Ok().finish()
}
