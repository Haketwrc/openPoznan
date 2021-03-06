#' local_spatial_dev_plans_passed Function
#'
#' This function download data about Passed Local Spatial Development Plans 
#' @keywords keyword
#' @export
#' @details Details of usage 
#' @importFrom jsonlite fromJSON 
#' @importFrom dplyr mutate
#' @importFrom purrr map map2_df
#' @format 
#' \describe{
#' \item{id}{factor; id.}
#' \item{lsdp_location_name}{factor; location name.}
#' \item{lsdp_adaptive_resolution}{factor; adaptive resolution.}
#' \item{lsdp_date_of_ar}{factor; date of adaptive resolution.}
#' \item{lsdp_approval_of_the_resolution}{factor; approval of the resolution.}
#' \item{lsdp_date_of_the_ar}{factor; date of the approval of the resolution.}
#' \item{lsdp_official_journal}{factor; official journal.}
#' \item{lsdp_date_of_oj}{factor; date of official journal.}
#' }
#' @examples
#' local_spatial_dev_plans_passed()

local_spatial_dev_plans_passed <- function (basic = TRUE) {
  
lsdp <- fromJSON('http://www.poznan.pl/mim/plan/map_service.html?mtype=urban_planning&co=mpzp')

lsdp_features <- lsdp$features

lsdp_basic_info<- data.frame(cbind(lsdp_features$id,
                                   lsdp_features$properties$nazwa,
                                   lsdp_features$properties$uchw_przyst,
                                   lsdp_features$properties$data_przyst,
                                   lsdp_features$properties$uchw_zatw,
                                   lsdp_features$properties$data_zatw,
                                   lsdp_features$properties$publ_dz_urz,
                                   lsdp_features$properties$data_dz_urz))



colnames(lsdp_basic_info)<-c("id",
                             "lsdp_location_name",
                             "lsdp_adaptive_resolution",
                             "lsdp_date_of_ar",
                             "lsdp_approval_of_the_resolution",
                             "lsdp_date_of_the_ar",
                             "lsdp_official_journal",
                             "lsdp_date_of_oj")

lsdp_coord <- lsdp_features$geometry$coordinates


lsdp_coord_2d <- map(lsdp_coord, drop)

lsdp_check <- map(lsdp_coord_2d,  is.list)

if (any(lsdp_check == T)) {   
  
  lsdp_coord_unlist <- list()
  lsdp_coord_list <- list()
  V1 <- list()
  V2 <- list()
  Data_frame_multipolygon <- list()
  
  for (i in 1:nrow(lsdp_features)){
    
    if (is.list(lsdp_coord_2d[[i]]) == T) {
      
      name <- paste('lsdp_coord',i,sep='_')
      
      lsdp_coord_unlist[[name]] <- unlist(lsdp_coord_2d[[i]]) 
      
      lsdp_coord_list[[name]] <- data.frame (lsdp_coord_unlist[[name]])
      
      V1[[name]] <- (lsdp_coord_list[[name]] [lsdp_coord_list[[name]] <18])
      V2[[name]] <- (lsdp_coord_list[[name]] [lsdp_coord_list[[name]] >48])
      
      Data_frame_multipolygon[[name]] <- data.frame(V1[[name]],V2[[name]])
      
      lsdp_coord_2d[[i]] <- Data_frame_multipolygon[[name]]
      
      
    } 
  }
}else {
  lsdp_coord_df <- map(lsdp_coord_2d, 
                       as.data.frame)
}

if (exists("lsdp_coord_df") == F) {
  lsdp_coord_df <- map(lsdp_coord_2d,
                       as.data.frame)
}

lsdp_coord_id <- map2_df(lsdp_coord_df,
                         lsdp_features$id,
                         ~mutate(.x, id=.y))


colnames(lsdp_coord_id) <- c("Longitude",
                             "Latitude",
                             "ID",
                             "Added_1",
                             "Added_2")

lsdp_coord_id$Longitude <-ifelse(is.na(lsdp_coord_id$Longitude),
                                 lsdp_coord_id$Added_1,
                                 lsdp_coord_id$Longitude)

lsdp_coord_id$Latitude <- ifelse(is.na(lsdp_coord_id$Latitude),
                                 lsdp_coord_id$Added_2,
                                 lsdp_coord_id$Latitude)

lsdp_coord_id <- subset(lsdp_coord_id, select = -c(Added_1,
                                                   Added_2))


if(basic == TRUE){
  return(lsdp_basic_info)
}
else{
  return(lsdp_coord_id)
}
}

