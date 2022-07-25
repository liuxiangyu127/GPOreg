## Installation
You can install the development version of GROreg using:

library(devtools)
install_github("liuxiangyu127/GPOreg", force = TRUE)


## Example
trans.reg(cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, data = simda)
mono.reg(cbind(Y1, Y2, Y3, Y4) ~ Z1 + Z2 + Z3 + Z4, data = simda, ninit = 20, nresamp = 5)

## Reference
Xiangyu Liu, Jing Ning, Xuming He, Barbara C. Tilley, Ruosha Li,
Semiparametric regression modeling of the global percentile outcome,
Journal of Statistical Planning and Inference,
Volume 222,
2023,
Pages 149-159,
ISSN 0378-3758,
https://doi.org/10.1016/j.jspi.2022.06.009.
