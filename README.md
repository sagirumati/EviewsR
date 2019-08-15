EviewsR Package created by Sagiru Mati
================

# About EviewsR

EviewsR is an R package that can run Eviews program from R Markdown. To
run the package successfully, you need to allow Eviews program to run on
Eviews startup. This can be set by clicking on `options, General
Options, window behaviour` and ticking `run program on Eviews startup`
as shown below:

![](tools/EviewsR.png)<!-- -->

Then load the EviewsR package as
    follows:

    ```{r EviewsR}                                                                .
    library(EviewsR)
    ```

Then create a chunk for Eviews as shown
below:

```` 
```{Eviews EviewsR1,eval=T,echo=T,comment=NULL,results='hide'}                .
  'This program is created in R Markdown with the help of EviewsR package
  wfcreate(page=EviewsR) EviewsR m 1999 2019
  for %y Created By Sagiru Mati Northwest University Kano Nigeria
  pagecreate(page={%y}) EviewsR m 1999 2019
  wfsave EviewsR
  exit
  next
```  
````

The above chunk creates an Eviews program with the chunk’s content, then
automatically open Eviews and run the program, which will create an
Eviews workfile with pages containing monthly sample from 1999 to 2019.
The program will also save an Eviews workfile named `EviewsR`

Download [EviewsR.Rmd](github.com/sagirumati/EviewsR/EviewsR.Rmd) for a
better explanation
