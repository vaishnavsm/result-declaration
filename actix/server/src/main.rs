use actix_web::{web, App, HttpRequest, HttpServer, Responder};
use serde::Serialize;

#[derive(Serialize)]
struct Res {
    Message: String,
}

async fn greet(req: HttpRequest) -> impl Responder {
    // format!("Hello World!")
    return web::Json(Res{Message: "Hello World!".to_owned()})
}

#[actix_rt::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(greet))
    })
    .bind("127.0.0.1:8000")?
    .run()
    .await
}