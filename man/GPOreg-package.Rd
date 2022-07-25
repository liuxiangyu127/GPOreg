\name{GPOreg-package}
\alias{GPOreg-package}
\docType{package}
\title{
Semiparametric Modelling and Estimation of the Global Percentile Outcome
}
\description{
\loadmathjax{}
Two semiparametric modelling strategies for the Global Percentile Outcome: transformed linear model and monotonic index model
}

\details{

\tabular{ll}{
Package: \tab GPOreg\cr
Type: \tab Package\cr
Version: \tab 1.0.0\cr
Date: \tab 2022-06-20\cr
License: \tab GPL (>= 2)\cr
LazyLoad: \tab yes\cr
}
Suppose there are \mjseqn{M} outcomes \mjseqn{Y_{1},\ldots, Y_{M}},
each with marginal CDF \mjseqn{F_m(y)=P(Y_{m}\leq y), m=1,2,\ldots,M}.
Without loss of generality,
suppose that higher values are worse for all outcomes.
Then, Global Percentile Outcome (GPO) can be defined as
\mjsdeqn{
\mathcal{P}_i=M^{-1}\{F_1(Y_{i1})+F_2(Y_{i2})+\ldots+F_M(Y_{iM})\},
}
which represents the composite percentile for subject \mjseqn{i (i=1,2,\ldots,n)}.

In practice, We can derive an estimated \mjseqn{\widehat{\mathcal{P}}_i} as
\mjsdeqn{
\widehat{\mathcal{P}}_i = M^{-1}\{\widehat{F}_{1n}(Y_{i1})+\widehat{F}_{2n}(Y_{i2})+\ldots+\widehat{F}_{Mn}(Y_{iM})\}
}
where \mjseqn{\widehat{F}_{mn}(\cdot)} denotes the empirical CDF of \mjseqn{Y_{m},m=1,2,\ldots,M}.

The definition and estimation of GPO can be adjusted to handle ties and ordinal outcomes.
}

\author{
Xiangyu Liu, Jing Ning, Ruosha Li <Ruosha.Li@uth.tmc.edu>
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

\keyword{package}
