# Adds description of PheWAS code to the table.

add_phewas_description <- function(data, keep.unmatched.rows=F,for.plots=F) {
  if(class(data)[1] %in% c("character", "factor")) {data=data.frame(phenotype=data,stringsAsFactors=F)}
  names <- names(data)
  first_match <- grep("pheno|phewas",names,ignore.case=T)[1]
  if(is.na(first_match)) {
    warning("Name matching 'pheno' or 'phewas' not found, using the first column")
    name <- names[1]
  } else {
    name <- names[first_match]
  }
  if (class(data[[name]]) != "character") {
    if (class(data[[name]]) == "factor") {
      warning("Factor phenotype input mapped to characters")
      data[,name] <- as.character(data[,name])
    } else {
      stop("Non-character or non-factor phenotypes passed in, so an accurate phewas code mapping is not possible.")
    }
  }
  pd <- pheinfo
  if(for.plots) {
    names(pd) <- c("phenotype","description")
  }
  data=merge(pd,data,by.x=names(pd)[1],by.y=name,all.y=keep.unmatched.rows)

  # The merge renames the PheWAS code column to "phewas_code", but
  # we need it to be called "phenotype" for later functions, so
  # it gets renamed here.
  names(data)[names(data)=="phewas_code"] <- "phenotype"
  data
}
