% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/docs_mget.r
\name{docs_mget}
\alias{docs_mget}
\title{Get multiple documents via the multiple get API.}
\usage{
docs_mget(index = NULL, type = NULL, ids = NULL, type_id = NULL,
  index_type_id = NULL, source = NULL, fields = NULL, raw = FALSE,
  callopts = list(), verbose = TRUE, ...)
}
\arguments{
\item{index}{Index. Required.}

\item{type}{Document type. Required.}

\item{ids}{More than one document id, see examples.}

\item{type_id}{List of vectors of length 2, each with an element for type and id.}

\item{index_type_id}{List of vectors of length 3, each with an element for index,
type, and id.}

\item{source}{(logical) If \code{TRUE}, return source.}

\item{fields}{Fields to return from the response object.}

\item{raw}{If TRUE (default), data is parsed to list. If FALSE, then raw JSON.}

\item{callopts}{Curl args passed on to httr::POST.}

\item{verbose}{If TRUE (default) the url call used printed to console.}

\item{...}{Further args passed on to elastic search HTTP API as parameters.}
}
\description{
Get multiple documents via the multiple get API.
}
\details{
There are a lot of terms you can use for Elasticsearch. See here
   \url{http://www.elasticsearch.org/guide/reference/query-dsl/} for the documentation.

You can pass in one of three combinations of parameters:
\itemize{
 \item Pass in something for \code{index}, \code{type}, and \code{id}. This is the simplest,
 allowing retrieval from the same index, same type, and many ids.
 \item Pass in only \code{index} and \code{type_id} - this allows you to get multiple
 documents from the same index, but from different types.
 \item Pass in only \code{index_type_id} - this is so that you can get multiple documents
 from different indexes and different types.
}
}
\examples{
\dontrun{
# Same index and type
docs_mget(index="shakespeare", type="line", ids=c(9,10))
tmp <- docs_mget(index="mran", type="metadata", ids=c('plyr','ggplot2'), raw=TRUE)
es_parse(tmp)
docs_mget(index="mran", type="metadata", ids=c('plyr','ggplot2'), fields='description')
docs_mget(index="mran", type="metadata", ids=c('plyr','ggplot2'), source=TRUE)

library("httr")
docs_mget(index="twitter", type="tweet", ids=1:2, callopts=verbose())

# Same index, but different types
docs_mget(index="shakespeare", type_id=list(c("scene",1), c("line",20)))
docs_mget(index="shakespeare", type_id=list(c("scene",1), c("line",20)), fields='play_name')

# Different indices and different types
# pass in separately
docs_mget(index_type_id=list(c("shakespeare","line",1), c("plos","article",1)))
}
}

