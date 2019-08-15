EviewsR Package created by Sagiru Mati
================

# About the Author

The author of this package, **Sagiru Mati**, is currently undergoing a
PhD Program in Economics in Near East University, North Cyprus. He works
at the Department of Economics, Yusuf Maitama Sule (Northwest)
University, Kano, Nigeria. Please visit his blog [SMATI
ACADEMY](https://smatiacademy.blogspot.com) for more details.

Please follow his publications with his **ORCID: 0000-0003-1413-3974**

# About EviewsR

EviewsR is an R package that can run Eviews program from R Markdown.

# Installation

EviewsR can be installed using the following commands in R.

``` r
devtools::install_github('sagirumati/EviewsR')

            OR
            
devtools::install_github('smatiacademy/EviewsR')
```

# Setup

To run the package successfully, you need to allow Eviews program to run
on Eviews startup. This can be set by clicking on `options, General
Options, window behaviour` and ticking `run program on Eviews startup`
as shown below:

![](tools/EviewsR.png)<!-- -->

# Usage

Please load the EviewsR package as
    follows:

    ```{r EviewsR}                                                                .
    library(EviewsR)
    ```

Then create a chunk for Eviews as shown
below:

```` 
```{Eviews EviewsR1,eval=T,echo=T,comment=NULL,results='hide'}                .
  'This program is created in R Markdown with the help of EviewsR package
  %path=@runpath
  cd %path
  wfcreate(page=EviewsR) EviewsR m 1999 2019
  for %y Created By Sagiru Mati Northwest University Kano Nigeria
  pagecreate(page={%y}) EviewsR m 1999 2019
  wfsave EviewsR
  next
```  
````

The above chunk creates an Eviews program with the chunk’s content, then
automatically open Eviews and run the program, which will create an
Eviews workfile with pages containing monthly sample from 1999 to 2019.
The program will also save an Eviews workfile named `EviewsR` in the
current directory.

Download
[EviewsR.Rmd](https://github.com/smatiacademy/EviewsR/example/EviewsR.Rmd)
for a better explanation
