## rscpages2

Example [project page](https://colorado.rstudio.com/rsc/dashboards/) produced by rscpages2:

<img src="project-page.png">


This repository shows an example of an additional page creation workflow for RStudio Connect. The code in this repository is not yet structured as a package. 

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

The heavy lifting function here is `rsc_tiles` which relies on boostrap v4 components, brought into the html page using `rsc_project_page`. This tile component is complementary to the existing `rscpages` package which provides a table component. This implementation relies on the existing `connectapi` package.

A few strategies showcased in the `page-generator.Rmd`:

- The example takes advantage of the connectapi package's ability to eagerly filter content *before* querying the API (e.g. filtering by tag)

- The example takes advantage of content images, descriptions, and titles from Connect 

- The example's tile component creates a "gallery", which is what many users expect after using Google Drive, Tableau, and Qlick which present content as cards.

- A main limitation of the current approach is search. I would recommend the tile component for projects with less than 20 content items.
