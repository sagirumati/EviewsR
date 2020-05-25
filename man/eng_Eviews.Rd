\name{eng_Eviews}
\alias{eng_Eviews}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Package to Run Eviews Scripts from R Markdown
}
\description{
This package runs on top of knitr to facilitate communication with Eviews. Run Eviews scripts from R Markdown document.
}
\usage{
eng_Eviews(options)
}
\arguments{
\item{options}{Chunk options, as provided by \code{knitr} during chunk execution. Chunk option for this is \code{eviews}}
}
\value{
Set of \code{EViews} (Econometric Views) codes
}
\details{
The \code{eviews} can be activated via \preformatted{knitr::knit_engines$set(eviews = EviewsR::eng_Eviews)
}

This will be set within an R Markdown document's setup chunk.
}
%- maybe also 'usage' for other objects documented here.
\references{
Bob Rudis (2015).Running Go language chunks in R Markdown (Rmd) files. Available at:  https://gist.github.com/hrbrmstr/9accf90e63d852337cb7
Yihui Xie (2019). knitr: A General-Purpose Package for Dynamic Report Generation in R. R package version 1.24.

Yihui Xie (2015) Dynamic Documents with R and knitr. 2nd edition. Chapman and Hall/CRC. ISBN 978-1498716963

Yihui Xie (2014) knitr: A Comprehensive Tool for Reproducible Research in R. In Victoria Stodden, Friedrich Leisch and Roger D. Peng, editors, Implementing Reproducible Computational Research. Chapman and Hall/CRC. ISBN 978-1466561595
}
\author{
*Sagiru Mati, ORCID: 0000-0003-1413-3974, https://smati.com.ng

* Yusuf Maitama Sule (Northwest) University Kano, Nigeria

* SMATI Academy
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{
knitr::knit_engines$set(eviews = EviewsR::eng_Eviews)
\dontrun{

library(EviewsR)
# Create a chunk in R Markdown as follows

```{eviews EviewsR,eval=T,echo=T,comment=NULL,results='hide'}                .
    'This program is created in R Markdown with the help of EviewsR package
  \%path=@runpath
  cd \%path
  wfcreate(page=EviewsR) EviewsR m 1999 2020
  for \%y Created By Sagiru Mati Northwest University Kano Nigeria
  pagecreate(page=\{\%y\}) EviewsR m 1999 2020
  wfsave EviewsR
  next
  exit
```

}
}

\keyword{documentation}% use one of  RShowDoc("KEYWORDS")

