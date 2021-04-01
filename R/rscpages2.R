library(htmltools)

#' Add a project's title and details to project page
#'
#' @param title Project title
#' @param details One or two sentence description of project
#'
#' @return Creates a div with the title and details
rsc_project_info <- function(title, details){
  div(class = "container",
      div(class="p-1 row mx-md-n5",
          h1(title)
      ),
      div(class="p-1 row mx-md-n5",
          p(details)
      )
  )
}

#' Create a RSC project page
#'
#' @return HTML head matter for a RSC project page
rsc_project_page <- function() {
  HTML(glue::glue('
        <html lang="en">
          <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
          </head>                
      ')
  )
}

#' Add navbar & logo to RSC project page
#'
#' @param logo Path to logo image, should be a 50 x 50 px image
#'
#' @return Creates a div with the navbar
rsc_navbar <- function(logo){
  HTML(
    glue::glue('
      <nav class="navbar fixed-top navbar-light bg-light">
          <img src="{logo}" width="50" height="50">
      </nav>
      <div class="container" id="home" style="padding-top:100px;">'
    )
  )
}

#' Create content tile
#'
#' @param c 1 row of content details returned from connectapi::get_content
#'
#' @details Preferred use is rsc_tiles
#' @return Creates a card div with content details
rsc_tile <- function(c) {
  title <- ifelse(is.na(c$title), c$name, c$title)
  div(class="card",
      img(src=paste0("./",c$image), class="card-img-top", width = 30),
      div(class="card-body",
          h5(a(href=c$url, class="bg stretched-link", title)),
          p(class="card-text", c$description),
          
      )
  )
}

#' Create content tiles
#'
#' @param content Content data frame from connectapi::get_content
#' @param cards_per_row Number of cards in each row, default 4
#' @return Tag list containing rows of card decks
rsc_tiles <- function(content, cards_per_row = 4) {
  card_holder <- tagList()
  rows <- ceiling(nrow(content) / cards_per_row)
  for(r in 1:rows) {
    row <- div(class="p-3 card-deck")
    for(c in 1:cards_per_row){
      content_row <- cards_per_row*(r-1) + c
      if (content_row > nrow(content)) {
        break
      }
      row <- tagAppendChild(row, rsc_tile(content[content_row,]))  
    }
    card_holder <- tagAppendChild(card_holder, row)
  }
  card_holder
}

#' Get content image for RSC Page
#'
#' @param client RSC client from connectapi::connect()
#' @param guid Content GUID
#' @param default Path to a default image if none exists for the content
#'
#' @return Path to use for image in RSC Page
rsc_save_image <- function(client, guid, default) {
  content <- connectapi::content_item(client, guid)
  img_path <- paste0(guid, ".png")
  get_image(content, img_path)
  if(file.exists(img_path)) {
    return(img_path)
  } else {
    default
  }
}