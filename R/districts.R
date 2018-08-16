#' districts  Function
#'
#' This function download data about districts  in Poznan.
#' @keywords keyword
#' @export
#' @param coords show basic data about districts in Poznań
#' @details Details of usage 
#' @importFrom jsonlite fromJSON 
#' @importFrom purrr map map2_df
#' @importFrom dplyr mutate
#' @format 
#' \describe{
#' \item{ID}{factor; ID of District.}
#' \item{Name}{factor; Name of District.}
#' }
#' @examples
#' District <- districts(coords = F)
#' District_coord <- districts(coords = T)

districts <- function(coords = F) {
  # samorzady pomocnicze 
  
  # wczytanie danych samorzadow pomocniczych 
  if(have_ip() == T) {
  
      tryCatch({ # w przypadku baraku internetu wywoła wyjątek
        
      s <- fromJSON("http://www.poznan.pl/mim/plan/map_service.html?mtype=local_gov&co=osiedla")
      
      }, error = function(err) {
    
      warning("You used bad link!")
      })
    
  }else{
    
      warning("You lost connection to internet!")
  }      
    
  district <- s$features
  # Oczyszczenie danych z niepotrzebnych informacji + nazwanie
  
  district_basic_info <- data.frame(ID=district$id,
                                          Name=district$properties$name)
  
  # z??czenie wszystkich kolumn
  
  district_final <- cbind(district_basic_info)
  
  districtcoord <- district$geometry$coordinates
  
  districtcoord2d <- map(districtcoord, drop)
  
  districtcoord_df <- map(districtcoord2d, as.data.frame)
  
  districtcoord_id <- map2_df(districtcoord_df, district$id, ~mutate(.x, id=.y))
  
  districtcoord_id <- data.frame(Longitude=districtcoord_id$V1,
                                 Latitude=districtcoord_id$V2,
                                 id=districtcoord_id$id)
  
  if(coords == T) {
    result <- districtcoord_id
  }else{
    result <- district_basic_info
  }
  return(result)
} 