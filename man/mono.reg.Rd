\name{mono.reg}
\alias{mono.reg}
\title{Monotonic index model for the global percentile outcome.}
\description{
  \loadmathjax{}
  Estimation of the monotonic index model for the global percentile outcome (GPO), where the GPO are transformed using the quantile function of the truncated standard normal distribution at -3 and 3.
}
\usage{
mono.reg(formula, data, ninit = 20, nresamp = 200, C0 = 0.5, seed = 1234)
}
\arguments{
  \item{formula}{a formula with multiple individual outcomes and a list of covariates, e.g., \code{cbind(Y1, Y2) ~ Z1 + Z2}. Note that individual outcomes should be in the same direction (e.g., the higher of the value, the worse of the outcome for all individual outcomes).}
  \item{data}{a data set contains the variables.}
  \item{ninit}{an integer specifying the number of initial values used in the maximization.}
  \item{nresamp}{an integer specifying the number of perturbation re-samplings to obtain the standard errors of the estimator.}
  \item{C0}{a numeric number specifying the bandwidth parameter for a smoothed objective function, where an extremely small number (e.g., 0.0001) yields the indicator version of the objective function (see more details in the reference).}
  \item{seed}{an integer specifying the random seed.}
}
\details{
The monotonic index model for GPO is
\mjsdeqn{
\mathcal{P}_i=\zeta(\boldsymbol{X}_i^\top\boldsymbol{\beta}_0,\varepsilon_i).
}
where \mjseqn{\varepsilon_i} is
an iid error term, whose distribution is left unspecified,
and \mjseqn{\zeta(a_1,a_2)} is an unspecified bivariate function that is monotonically increasing
in both arguments.

The unknown parameters can be obtained by maximizing the following objective function:
\mjsdeqn{
	G_n(\boldsymbol{\beta})=\frac{1}{n(n-1)} \sum_{k \neq i} g(\widehat{\mathcal{P}}_i) I(\boldsymbol{X}_i^\top\boldsymbol{\beta} \ge \boldsymbol{X}_k^\top\boldsymbol{\beta})
}
or a smoothed kernal objective function:
\mjsdeqn{
	K_n(\boldsymbol{\beta})=\frac{1}{n(n-1)} \sum_{{k \neq i}} g(\widehat{\mathcal{P}}_i) \Phi \{ (\boldsymbol{X}_i-\boldsymbol{X}_k)\boldsymbol{\beta} / C_n \}
}
}
\value{
A list is returned with the following components:
  \item{coef}{the estimated coefficients of the covariates.}
  \item{StdErr}{the perturbation-based standard errors of the covariates.}
  \item{z.value}{the z-values.}
  \item{p.value}{the two-sided p-value for the hypothesis testing of the coefficient being 0.}
  \item{converge}{a number specifying the convergence status, value 0 means the optimize procedure is converged; more details can be found in the \code{convergence} value of the function \code{optim}.}
  \item{objVal}{the objective function value of the model.}
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
# set nresamp to a large integer (e.g., 200) for real application
mono.reg(cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, data = simda, ninit = 20, nresamp = 5)
}
