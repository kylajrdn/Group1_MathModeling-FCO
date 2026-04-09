install.packages("tidyverse")
library(tidyverse)
library(readxl)
cleaned_mathmod <- read_excel("cleaned_mathmod.xlsx")
View(cleaned_mathmod)

df <- cleaned_mathmod

df$sl_average <- rowMeans(df[, c("SL3", "SL4")], na.rm = TRUE)
df$as_average <- rowMeans(df[, c("AS3", "AS4")], na.rm = TRUE)
df$sq_average <- rowMeans(df[, c("SQ2", "SQ4_REV")], na.rm = TRUE)

summary(df[, c("sl_average", "as_average", "sq_average")])
