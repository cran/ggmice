## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7.2,
  fig.height = 4
)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----setup, warning = FALSE, message = FALSE----------------------------------
library(mice)
library(ggplot2)
library(ggmice)

## ----data---------------------------------------------------------------------
dat <- boys

## ----imp, results = "hide"----------------------------------------------------
imp <- mice(dat, m = 3, method = "pmm")

## ----gg, eval=FALSE-----------------------------------------------------------
#  ggplot(dat, aes(x = age))
#  ggmice(dat, aes(x = age))

## ----inc-con------------------------------------------------------------------
ggmice(dat, aes(age, hgt)) +
  geom_point()

## ----inc-cat------------------------------------------------------------------
ggmice(dat, aes(reg, hgt)) +
  geom_point()

## ----inc-clus-----------------------------------------------------------------
ggmice(dat, aes(wgt, hgt)) +
  geom_point() +
  facet_wrap(~ reg == "city", labeller = label_both)

## ----inc-trans----------------------------------------------------------------
ggmice(dat, aes(wgt * 2.20, hgt / 2.54)) +
  geom_point() +
  labs(x = "Weight (lbs)", y = "Height (in)")

## -----------------------------------------------------------------------------
# continuous variable
ggmice(dat, aes(age)) +
  geom_density() +
  facet_wrap(~ factor(is.na(hgt) == 0, labels = c("observed height", "missing height")))
# categorical variable
ggmice(dat, aes(reg)) +
  geom_bar(fill = "white") +
  facet_wrap(~ factor(is.na(hgt) == 0, labels = c("observed height", "missing height")))

## ----imp-same-----------------------------------------------------------------
ggmice(imp, aes(age, hgt)) +
  geom_point()
ggmice(imp, aes(reg, hgt)) +
  geom_point()
ggmice(imp, aes(wgt, hgt)) +
  geom_point() +
  facet_wrap(~ reg == "city", labeller = label_both)
ggmice(imp, aes(wgt * 2.20, hgt / 2.54)) +
  geom_point() +
  labs(x = "Weight (lbs)", y = "Height (in)")

## ----imp-strip----------------------------------------------------------------
ggmice(imp, aes(x = .imp, y = hgt)) +
  geom_jitter(height = 0, width = 0.25) +
  labs(x = "Imputation number")

## ----imp-box------------------------------------------------------------------
ggmice(imp, aes(x = .imp, y = hgt)) +
  geom_jitter(height = 0, width = 0.25) +
  geom_boxplot(width = 0.5, size = 1, alpha = 0.75, outlier.shape = NA) +
  labs(x = "Imputation number")

## ----facet--------------------------------------------------------------------
purrr::map(c("wgt", "hgt", "bmi"), ~ {
  ggmice(imp, aes(x = .imp, y = .data[[.x]])) +
    geom_boxplot() +
    labs(x = "Imputation number")
}) %>%
  patchwork::wrap_plots()

## ----pattern------------------------------------------------------------------
# create missing data pattern plot
plot_pattern(dat)

# specify optional arguments
plot_pattern(
  dat,
  square = TRUE,
  rotate = TRUE,
  npat = 3,
  cluster = "reg"
)

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
  diagonal = TRUE,
  rotate = TRUE
)

## ----predictormatrix----------------------------------------------------------
# create predictor matrix
pred <- quickpred(dat)

# create predictor matrix plot
plot_pred(pred)

# specify optional arguments
plot_pred(
  pred,
  label = FALSE,
  square = FALSE,
  rotate = TRUE,
  method = "pmm"
)

## ----convergence--------------------------------------------------------------
# create traceplot for one variable
plot_trace(imp, "hgt")

## ----session, class.source = 'fold-hide'--------------------------------------
sessionInfo()

