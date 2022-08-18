# EviewsR 0.1.4

What's new?

* Removed R 4.X features (thanks, @yihui #2)

* Updated vignettes

# EviewsR 0.1.3

What's new?


* `eviews`  chunk  now imports EViews equation, graph, series and table objects automatically into R markdown or Quarto document.

* New chunk options:  `class`, `equation`, `graph`, ` page`, `series`, `table`, `graph_procs`, `save_options`

* New functions: `export_dataframe()`, `import_equation()`, `import_graph()`,  `import_kable()`, `import_series()`, `import_table()` and `import_workfile()`

* `eviews_graph()` function now supports both dataframe and `xts` object 

* `rwalk()` function got new argument `class`, which takes `df` for dataframe or `xts` for extendable time series.

* `import()` and `export()` functions will no longer be maintained. They are kept to ensure backward compatibility. 

* `import_table()` function changed to `import_kable()`.  Change of argument names in `import_kable()` function from `table_name` to `table`, and from `table_range` to `range`.

* Updated examples to be self-contained

* Updated Vignettes

* Updated demo

* Updated example files

* Bug fixes

# EviewsR 0.1.2

What's new?

* Updated examples to be self-contained

* Updated Vignettes

* Updated demo

* Created example files

* Bug fixes

# EviewsR 0.1.1


What's new?

* EviewsR is platform-independent now

* EviewsR can be used with both base R and R Markdown

* Demo files are accessible via demo(package="EviewsR")

* Template for R Markdown is created. Go to `file->New File->R Markdown-> From Template->EviewsR`.

* New functions `create_object`, `eviews_graph`, `eviews_import`, `eviews_pagesave`, `eviews_wfcreate`, `eviews_wfsave`, `exec_commands`, `export`, `import`, `import_table`, `rwalk` and `set_eviews_path` are created



