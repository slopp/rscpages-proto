## rscpages2

Example [project page](https://colorado.rstudio.com/rsc/dashboards/) produced by rscpages2:

<img src="project-page.png">


This repository shows an example of an alternative page creation workflow for RStudio Connect. The code in this repository is not yet structured as a package.

To get started, take a look at the `page-generator.Rmd` example. You will need the following packages:

```
remotes::install_github('rstudio/connectapi')
remotes::install_github('rstudio/bslib')
remotes::install_github('rstudio/rmarkdown')
```

You will also need to create a .Renviron file that contains:

```
CONNECT_SERVER  = "https://colorado.rstudio.com/rsc"
CONNECT_API_KEY = "<YOUR API KEY>"
```

From there, simply render `page-generator.Rmd`.

A few project goals showcased in the `page-generator.Rmd`:

- The project takes advantage of the connectapi package's ability to eagerly filter content *before* querying the API (e.g. filtering by tag)

- The project takes advantage of content images, descriptions, and titles from Connect 

- The project follows gallery standards from Google Drive, Tableau, and Qlick to present content in card / tile form