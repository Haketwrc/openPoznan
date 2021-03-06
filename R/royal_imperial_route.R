#' royal_imperial_route Function
#'
#' This function download data about Royal trakt in Poznan.
#' @keywords keyword
#' @export
#' @details Details of usage 
#' @importFrom jsonlite fromJSON 
#' @importFrom purrr map map2_df
#' @importFrom dplyr mutate
#' @format 
#' \describe{
#' }
#' @examples
#' Trakt <- royal_imperial_route()


# trakt 
royal_imperial_route <- function(){

if(have_ip() == T) {
  
  
    tryCatch({ # w przypadku baraku internetu wywoła wyjątek

    tr <- fromJSON("http://www.poznan.pl/mim/plan/map_service.html?mtype=tourism&co=trakt")
    }, error = function(err) {
    
    warning("You used bad link!")
  })
  
}else{
  
  warning("You lost connection to internet!")
  
}    
  tract <- tr$features$geometry
  
  tractcoord <- tract$coordinates
  
  tractcoord2d <- map(tractcoord, drop)
  
  tractcoord_df <- map(tractcoord2d, as.data.frame)
  
  tractcoord_id <- map2_df(tractcoord_df, tr$features$id, ~mutate(.x, id=.y))
  
  tractcoord_id <- data.frame(Longitude=tractcoord_id$V1,
                          Latitude=tractcoord_id$V2,
                          id=tractcoord_id$id)
}  
