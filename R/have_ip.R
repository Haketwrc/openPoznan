#' have_ip Function
#'
#' This function check connection to internet. 
#' @keywords keyword
#' @export
#' @details Details of usage 
#' @format 
#' \describe{
#' }
#' @examples
#' have_ip()

have_ip <- function() {
  if (.Platform$OS.type == "windows") {
    ipmessage <- system("ipconfig", intern = TRUE)
  } else {
    ipmessage <- system("ifconfig", intern = TRUE)
  }
  validIP <- "((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)[.]){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
  any(grep(validIP, ipmessage))
}
