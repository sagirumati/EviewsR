k=paste0("X",1:100)
for (i in k){
  assign(i,runif(100),envir = .GlobalEnv)
}

for (i in (1:100L)){
  assign(paste0("x",i),runif(100))
}


function (x, format, digits = getOption("digits"), row.names = NA,
          col.names = NA, align, caption = NULL, label = NULL, format.args = list(),
          escape = TRUE, table.attr = "", booktabs = FALSE, longtable = FALSE,
          valign = "t", position = "", centering = TRUE,
          vline = getOption("knitr.table.vline", if (booktabs) "" else "|"),
          toprule = getOption("knitr.table.toprule", if (booktabs) "\\toprule" else "\\hline"),
          bottomrule = getOption("knitr.table.bottomrule", if (booktabs) "\\bottomrule" else "\\hline"),
          midrule = getOption("knitr.table.midrule", if (booktabs) "\\midrule" else "\\hline"),
          linesep = if (booktabs) c("", "", "", "",
                                    "\\addlinespace") else "\\hline", caption.short = "",
          table.envir = if (!is.null(caption)) "table", ...)
{
  if (!missing(align) && length(align) == 1L && !grepl("[^lcr]",
                                                       align)) {
    align <- strsplit(align, "")[[1]]
  }
  if (missing(format) || is.null(format)) {
    if (knitr::is_latex_output()) {
      format <- "latex"
      out <- knitr::kable(x = x, format = format, digits = digits,
                          row.names = row.names, col.names = col.names,
                          align = align, caption = caption, label = label,
                          format.args = format.args, escape = escape, booktabs = booktabs,
                          longtable = longtable, valign = valign, position = position,
                          centering = centering, vline = vline, toprule = toprule,
                          bottomrule = bottomrule, midrule = midrule, linesep = linesep,
                          caption.short = caption.short, table.envir = table.envir,
                          ...)
      table_info <- magic_mirror(out)
      if (is.null(col.names)) {
        table_info$position_offset <- 0
      }
      return(out)
    }
    else {
      format <- "html"
      out <- knitr::kable(x = x, format = format, digits = digits,
                          row.names = row.names, col.names = col.names,
                          align = align, caption = caption, label = label,
                          format.args = format.args, escape = escape, table.attr = table.attr,
                          ...)
      if (!"kableExtra" %in% class(out))
        class(out) <- c("kableExtra", class(out))
      return(out)
    }
  }
  else {
    if (format == "latex") {
      out <- knitr::kable(x = x, format = format, digits = digits,
                          row.names = row.names, col.names = col.names,
                          align = align, caption = caption, label = label,
                          format.args = format.args, escape = escape, booktabs = booktabs,
                          longtable = longtable, valign = valign, position = position,
                          centering = centering, vline = vline, toprule = toprule,
                          bottomrule = bottomrule, midrule = midrule, linesep = linesep,
                          caption.short = caption.short, table.envir = table.envir,
                          ...)
      table_info <- magic_mirror(out)
      if (is.null(col.names)) {
        table_info$position_offset <- 0
      }
      return(out)
    }
    if (format == "html") {
      out <- knitr::kable(x = x, format = format, digits = digits,
                          row.names = row.names, col.names = col.names,
                          align = align, caption = caption, label = label,
                          format.args = format.args, escape = escape, table.attr = table.attr,
                          ...)
      if (!"kableExtra" %in% class(out))
        class(out) <- c("kableExtra", class(out))
      return(out)
    }
    return(knitr::kable(x = x, format = format, digits = digits,
                        row.names = row.names, col.names = col.names, align = align,
                        caption = caption, label = label, format.args = format.args,
                        escape = escape, ...))
  }
}
