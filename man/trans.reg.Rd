\name{trans.reg}
\alias{trans.reg}
\title{Transformed linear model for the global percentile outcome.}
\description{
  \loadmathjax{}
  Estimation of the transformed linear model for the global percentile outcome (GPO).
}
\usage{
trans.reg(formula, data, trans = TRUE)
}
\arguments{
  \item{formula}{a formula with multiple individual outcomes and a list of covariates, e.g., \code{cbind(Y1, Y2) ~ Z1 + Z2}.}
  \item{data}{a data set contains the variables.}
  \item{trans}{a logic value specifying whether transform GPO, default is \code{TRUE}, where the GPO are transformed using the quantile function of the truncated standard normal distribution at -3 and 3.}
}
\details{
  The transformed linear model for GPO is
  \mjsdeqn{h(\mathcal{P}_i)=\boldsymbol{X}_i^\top\boldsymbol{\beta}_{L0}+\varepsilon_i,}
  where \mjseqn{h(\cdot)} is a pre-specified function.
  
  The unknown parameters can be estimated using the following
  estimating equation,
  \mjsdeqn{
  \frac{1}{n} \sum_{i=1}^n \boldsymbol{X}_i \{ h(\widehat{\mathcal{P}}_i) - \widetilde{\boldsymbol{X}}  _i^\top\boldsymbol{\beta}_{L} \} = 0.
  }
}
\value{
A list is returned with the following components:
  \item{coef}{the estimated coefficients of the covariates.}
  \item{var}{the covariance matrix of the covariates.}
  \item{z.value}{the z-values.}
  \item{p.value}{the two-sided p-value for the hypothesis testing of the coefficient being 0.}
  \item{call}{the matched call.}
}
\references{
Xiangyu Liu, Jing Ning, Xuming He, Barbara C. Tilley, Ruosha Li,
Semiparametric regression modeling of the global percentile outcome,
Journal of Statistical Planning and Inference,
Volume 222,
2023,
Pages 149-159,
ISSN 0378-3758,
https://doi.org/10.1016/j.jspi.2022.06.009.
}
\author{Xiangyu Liu, Jing Ning, Ruosha Li}
\examples{
trans.reg(cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, data = simda)
}
