##  load packages ----

library(htmltools)
library(ambiorix)


home_get <- function(req, res) {
  html <- as.character(
   tagList(
     tags$h3("Who is running Ambiorix IN Shiny Server ?"),
    tags$form(
      action = "./submit",
      enctype = "multipart/form-data",
      method = "POST",
      p(
        tags$label(`for` = "first_name", "First Name"),
        tags$input(type = "text", name = "first_name")
      ),
      tags$input(type = "submit")
    )
  )
  )
  res$set_status(200L)$send(html)
}

submit <- function(req, res) {
  body <- parse_multipart(req)
  res$send(
    h1(body$first_name, " is running Ambiorix from Shiny server !")
    )
}

port <- Sys.getenv("SHINY_PORT", 8080L)

Ambiorix$
  new(port = port)$
  get("/", home_get)$
  post("/submit", submit)$
  start()