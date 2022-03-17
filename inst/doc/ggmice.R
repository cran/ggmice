## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7.2,
  fig.height = 4
)
# TODO add to vignette:
# plotting conditional on missingness indicator
# adding jitter to categorical variables
# plotting a single imp
# plotting all variables

## ----install, echo=TRUE, eval=FALSE-------------------------------------------
#  install.packages("devtools")
#  devtools::install_github("amices/ggmice")

## ----setup--------------------------------------------------------------------
# load packages
library(mice)
library(ggplot2)
library(ggmice)

# load incomplete dataset 
dat <- boys

# generate imputations
imp <- mice(dat, method = "pmm", printFlag = FALSE)

## ----pattern------------------------------------------------------------------
# create missing data pattern plot
plot_pattern(dat)

# specify optional arguments  
plot_pattern(dat, square = TRUE, rotate = TRUE)

## ----flux---------------------------------------------------------------------
# create influx-outflux plot
plot_flux(dat)

# specify optional arguments  
plot_flux(
  dat, 
  label = FALSE, 
  caption = FALSE
)

## ----correlations-------------------------------------------------------------
# create correlation plot
plot_corr(dat)

# specify optional arguments  
plot_corr(
  dat,
  vrb = c("hgt", "wgt", "bmi"),
  label = TRUE,
  square = FALSE,
  diagonal = TRUE
)

## ----predictormatrix----------------------------------------------------------
# create predictor matrix
pred <- quickpred(dat)

# create predictor matrix plot
plot_pred(pred)

# specify optional arguments  
plot_pred(
  pred, 
  label = TRUE, 
  square = FALSE
)

## ----incomplete---------------------------------------------------------------
# create scatter plot with continuous variables
ggmice(dat, aes(age, bmi)) +
  geom_point()

# create scatter plot with a categorical variable
ggmice(dat, aes(gen, bmi)) +
  geom_point()

## ----convergence--------------------------------------------------------------
# create traceplot for one variable
plot_trace(imp, "bmi")

## ----imputed------------------------------------------------------------------
# create scatter plot with continuous variables
ggmice(imp, aes(age, bmi)) +
  geom_point()

# create scatter plot with a categorical variable
ggmice(imp, aes(gen, bmi)) +
  geom_point()

# create scatter plot with a transformed variable
ggmice(imp, aes(log(wgt), hgt)) +
  geom_point()

# create stripplot with boxplot overlay
ggmice(imp, aes(x = .imp, y = bmi)) + 
  geom_jitter(height = 0) +
  geom_boxplot(fill = "white", alpha = 0.75, outlier.shape = NA) +
  labs(x = "Imputation number")

## ----session, class.source = 'fold-hide'--------------------------------------
# this vignette was generated with R session
sessionInfo()

