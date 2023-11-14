library(yarrr)
head(diamonds)
library("jsonlite")

diamonds.lm <- lm(formula = value ~ weight + clarity + color,
                  data = diamonds)
  
  
regtable <- summary(diamonds.lm)

assign(x='varnames', variable.names(diamonds.lm))

regtable <- append(regtable, list(varnames))

names(regtable)[12] <- "varnames"

write(toJSON(regtable, force=TRUE, pretty = TRUE),"../stats/Rreg_example.json")


