% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/council_districts.R
\name{council_districts}
\alias{council_districts}
\title{council_districts  Function}
\format{\describe{
\item{ID}{numeric; ID of the polls.}
\item{Address}{factor; Address of Residence.}
\item{Residence}{factor; Residence of council districts in Poznan.}
\item{Electoral_District}{factor; Electoral district in Poznan.}
\item{AFDP}{factor; Adaptation for disabled pearson.}
\item{Venue_no}{numeric; Venue of council districts in Poznan.}
\item{Distroct_no}{numeric; District number in Poznan.}
\item{Longitude}{numeric; Longitude of the polls.}
\item{Latitude}{numeric; Latitude of the polls.}
}}
\usage{
council_districts()
}
\description{
This function download data about council districts in Poznan.
}
\examples{
the polls <- council_districts()
}
\keyword{keyword}
