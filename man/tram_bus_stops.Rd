% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tram_bus_stops.R
\name{tram_bus_stops}
\alias{tram_bus_stops}
\title{tram_bus_stops Function}
\format{\describe{
\item{ID}{factor; ID of stop.}
\item{Stop_Zone}{factor; Zone in which stop is placed.}
\item{Route_Type}{factor; Shows route type on which stop is placed.}
\item{Stop_Headsign}{factor; Shows which trams and buses departure from stop.}
\item{Stop_Name}{factor; Name of stop.}
\item{Longitude}{numeric; Longitude of stop.}
\item{Latitude}{numeric; Latitude of stop.}
}}
\usage{
tram_bus_stops()
}
\description{
This function download data about stops in Poznań
}
\examples{

Stops <- tram_bus_stops() 


}
\keyword{keyword}
