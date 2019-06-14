library(bigsnpr)
snp_readBed("../POPRES_data/POPRES_allchr_QC_norel.bed", "backingfiles/POPRES")
popres <- snp_attach("backingfiles/POPRES.rds")
G <- popres$genotypes
CHR <- popres$map$chromosome
POS <- popres$map$physical.pos
NCORES <- nb_cores()

svd <- snp_autoSVD(G, CHR, POS, ncores = NCORES)

library(ggplot2)
plot(svd) + scale_y_log10()

pop <- popres$fam$family.ID
pop2 <- dplyr::case_when(
  pop %in% c("Portugal", "Spain") ~ "SW Europe",
  pop %in% c("?orway", "Finland", "Sweden", "Denmark") ~ "Scandinavia",
  pop %in% c("Hungary", "Slovakia", "Czech", "Austria", "Slovenia",
             "Croatia") ~ "Central Europe",
  pop %in% c("Russian", "Latvia", "Ukraine", "Poland") ~ "Eastern Europe",
  pop %in% c("Greece", "Turkey", "Serbia", "Cyprus", "Albania", "Kosovo",
             "Bosnia", "Macedonia,",  "Romania", "Bulgaria") ~ "SE Europe",
  pop %in% c("Swiss-German", "Swiss-French", "Swiss-Italian") ~ "Switzerland",
  pop == "?etherlands" ~ "Netherlands",
  pop %in% c("United", "Scotland", "Ireland") ~ "Anglo-Irish Isles",
  TRUE ~ pop
)


# svd$u[, 1] <- -svd$u[, 1]; svd$v[, 1] <- -svd$v[, 1]

{
  colors <- sample(
    c("#ED90A4", "#E19B79", "#C6A856", "#A0B454", "#6ABD74", "#03C19E",
      "#00BFC4", "#53B6E1", "#9DA7EC", "#CE96E4", "#E88ECA", "#ED90A4"))

  plot(svd, type = "scores", scores = 3:4) +
    aes(alpha = I(0.5), color = pop2) +
    stat_ellipse(geom = "polygon", alpha = 0.5, aes(fill = pop2)) +
    scale_color_manual(values = colors) +
    scale_fill_manual(values = colors) +
    labs(color = "Population", fill = "Population") +
    coord_fixed()
}
