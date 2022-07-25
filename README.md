README
================

## Introduction

Suppose there are
![M](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;M "M")
outcomes
![Y\_{1},\\ldots, Y\_{M}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Y_%7B1%7D%2C%5Cldots%2C%20Y_%7BM%7D "Y_{1},\ldots, Y_{M}"),
each with marginal CDF
![F_m(y)=P(Y\_{m}\\leq y), m=1,2,\\ldots,M](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;F_m%28y%29%3DP%28Y_%7Bm%7D%5Cleq%20y%29%2C%20m%3D1%2C2%2C%5Cldots%2CM "F_m(y)=P(Y_{m}\leq y), m=1,2,\ldots,M").
Without loss of generality, suppose that higher values are worse for all
outcomes. Then, Global Percentile Outcome (GPO) can be defined as

![
\\mathcal{P}\_i=M^{-1}\\{F_1(Y\_{i1})+F_2(Y\_{i2})+\\ldots+F_M(Y\_{iM})\\},
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Cmathcal%7BP%7D_i%3DM%5E%7B-1%7D%5C%7BF_1%28Y_%7Bi1%7D%29%2BF_2%28Y_%7Bi2%7D%29%2B%5Cldots%2BF_M%28Y_%7BiM%7D%29%5C%7D%2C%0A "
\mathcal{P}_i=M^{-1}\{F_1(Y_{i1})+F_2(Y_{i2})+\ldots+F_M(Y_{iM})\},
")

which represents the composite percentile for subject
![i (i=1,2,\\ldots,n)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%20%28i%3D1%2C2%2C%5Cldots%2Cn%29 "i (i=1,2,\ldots,n)").

In practice, We can derive an estimated
![\\widehat{\\mathcal{P}}\_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cwidehat%7B%5Cmathcal%7BP%7D%7D_i "\widehat{\mathcal{P}}_i")
as

![
\\widehat{\\mathcal{P}}\_i = M^{-1}\\{\\widehat{F}\_{1n}(Y\_{i1})+\\widehat{F}\_{2n}(Y\_{i2})+\\ldots+\\widehat{F}\_{Mn}(Y\_{iM})\\}
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Cwidehat%7B%5Cmathcal%7BP%7D%7D_i%20%3D%20M%5E%7B-1%7D%5C%7B%5Cwidehat%7BF%7D_%7B1n%7D%28Y_%7Bi1%7D%29%2B%5Cwidehat%7BF%7D_%7B2n%7D%28Y_%7Bi2%7D%29%2B%5Cldots%2B%5Cwidehat%7BF%7D_%7BMn%7D%28Y_%7BiM%7D%29%5C%7D%0A "
\widehat{\mathcal{P}}_i = M^{-1}\{\widehat{F}_{1n}(Y_{i1})+\widehat{F}_{2n}(Y_{i2})+\ldots+\widehat{F}_{Mn}(Y_{iM})\}
")

where
![\\widehat{F}\_{mn}(\\cdot)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cwidehat%7BF%7D_%7Bmn%7D%28%5Ccdot%29 "\widehat{F}_{mn}(\cdot)")
denotes the empirical CDF of
![Y\_{m},m=1,2,\\ldots,M](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Y_%7Bm%7D%2Cm%3D1%2C2%2C%5Cldots%2CM "Y_{m},m=1,2,\ldots,M").

This package can fit two semiparametric modelling strategies for the
Global Percentile Outcome: transformed linear model and monotonic index
model. More details can be found in the reference or help document of
each function.

## Installation

You can install the development version of GROreg using:

``` r
library(devtools)
```

    ## Loading required package: usethis

``` r
install_github("liuxiangyu127/GPOreg", quiet = TRUE)
```

## Example

``` r
library(GPOreg)
trans.reg(cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, data = simda)
```

    ## Call:
    ## trans.reg(formula = cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, 
    ##     data = simda)
    ## 
    ##             Estimate StdErr z value Pr(>|z|)
    ## (Intercept)  -0.1572 0.0824 -1.9070   0.0565
    ## Z1            0.5289 0.0783  6.7537   0.0000
    ## Z2           -0.5224 0.0842 -6.2014   0.0000
    ## Z3            0.0463 0.0398  1.1625   0.2450
    ## Z4            0.3427 0.0648  5.2868   0.0000

``` r
# set nresamp to a large integer (e.g., 200) for real application
mono.reg(cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, data = simda, ninit = 20, nresamp = 5)
```

    ## [1] "Resampling in progress"
    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5

    ## Call:
    ## mono.reg(formula = cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, 
    ##     data = simda, ninit = 20, nresamp = 5)
    ## 
    ##    Estimate StdErr z value Pr(>|z|)
    ## Z1   0.6250 0.0742  8.4179   0.0000
    ## Z2  -0.5514 0.0914 -6.0320   0.0000
    ## Z3   0.0625 0.0522  1.1958   0.2318
    ## Z4   0.5490 0.1316  4.1713   0.0000

## Reference

Xiangyu Liu, Jing Ning, Xuming He, Barbara C. Tilley, Ruosha Li,
Semiparametric regression modeling of the global percentile outcome,
Journal of Statistical Planning and Inference, Volume 222, 2023, Pages
149-159, ISSN 0378-3758, <https://doi.org/10.1016/j.jspi.2022.06.009>.
