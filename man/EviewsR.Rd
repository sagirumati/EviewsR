\name{EviewsR}
\alias{EviewsR}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Package to Run Eviews Scripts from R Markdown
}
\description{
This package runs on top of knitr to facilitate communication with Eviews. Run Eviews scripts from R Markdown document.
}
\usage{
library(EviewsR)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
Bob Rudis (2015).Running Go language chunks in R Markdown (Rmd) files. Available at:  https://gist.github.com/hrbrmstr/9accf90e63d852337cb7
Yihui Xie (2019). knitr: A General-Purpose Package for Dynamic Report Generation in R. R package version 1.24.

Yihui Xie (2015) Dynamic Documents with R and knitr. 2nd edition. Chapman and Hall/CRC. ISBN 978-1498716963

Yihui Xie (2014) knitr: A Comprehensive Tool for Reproducible Research in R. In Victoria Stodden, Friedrich Leisch and Roger D. Peng, editors, Implementing Reproducible Computational Research. Chapman and Hall/CRC. ISBN 978-1466561595
}
\author{
Sagiru Mati,

Northwest University Kano, Nigeria

Foudation of African Researchers (FAR)
}
\note{

}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
}
\examples{
library(EviewsR)

Then create a chunk for Eviews

```{Eviews Chunk-name,eval=F,echo=T}
wfcreate(page=EviewsR) EviewsR m 1999 2019
for \%y Created By Sagiru Mati Northwest University Kano Nigeria
pagecreate(page={\%y}) EviewsR m 1999 2019
next
```
## The above chunk creates an Eviews program with the chunk's content, automatically open Eviews and run the program, which will create an Eviews workfile with monthly sample from 1999 to 2019,
Download EviewsR.Rmd from github.com/sagirumati/EviewsR/EviewsR.Rmd for a better explanation
}

\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
