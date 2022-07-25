
bbeta.norm <- function(bbeta){ # input b2-b4, output normalized b1-b4
  if(sum(bbeta^2)>1) {b1.2 <- -100}
  if(sum(bbeta^2)<=1) {b1.2 <- sqrt(1-sum(bbeta^2))}
  return(c(b1.2, bbeta))
}


gen.init <- function(Zmat, phat, ninit, ptrg, bb.init = NULL) {
  lm.fit <- summary(lm(phat ~ Zmat))
  bb0 <- lm.fit$coefficients[-1, 1:2]
  grid <- matrix(c(t(outer(rep(ptrg, each = ninit), bb0[, 2]))), dim(bb0)[1])
  grid.pt <- grid * matrix(runif(length(grid), -1, 1), dim(grid)[1], dim(grid)[2])

  if (is.null(bb.init)) {
    bb.init1 <- bb0[, 1]
  } else {
    bb.init1 <- bb.init
  }
  b.init <- cbind(as.vector(bb.init1), as.vector(bb.init1) + grid.pt)
  gen.init <- apply(b.init, 2, function(x) x / sqrt(sum(x ^ 2)))
  return(gen.init)
}


mono_obj <- function(bbeta, Zmat, phat, wi, Cn) {
  # objective, kernel version, can set Cn extremely small to get indicator version
  Zb <- as.vector(Zmat %*% matrix(bbeta.norm(bbeta)))
  mono_obj <- -kernelC2(Zb, phat, wi, Cn)
  return(mono_obj)
}


optim.m <- function(par0, Zmat, phat, wi, Cn, control) {
  fit <- optim(par = par0, fn = mono_obj, Zmat = Zmat, phat = phat, wi = wi, Cn = Cn, control = control)
  optim.m <- c(fit$convergence, fit$value, fit$par)
}


find_sol <- function(init.mat, Zmat, phat, wi, C0, naive.sigma, ninit, ptrg) {
  Cn = naive.sigma * C0 * length(phat) ^ (-1 / 3)
  out0 = t(apply(init.mat, 2, optim.m, Zmat = Zmat, phat = phat, wi = wi, Cn = Cn, control = list(maxit = 1000)))
  out = out0[out0[, 1] == 0, ]
  bb.fit.k = out[which.min(out[, 2]), ]
  coef <- bbeta.norm(bb.fit.k[-c(1:2)])
  names(coef) <- colnames(Zmat)
  return(list(coef = coef, convVal = -bb.fit.k[c(1:2)]))
}

 
mono.reg.sub <- function(Ys, Zmat, wi, C0, ptrg, ninit, bb.init = NULL) {
  n = dim(Ys)[1]
  phat0 = rowMeans(apply(Ys, 2, myrank, wi = wi)) / n
  phat = truncnorm::qtruncnorm(pmin(pmax(phat0, 0), 1), -3, 3)
  init.mat = gen.init(Zmat, phat, ninit, ptrg, bb.init)[-1, ]
  naive.b = bbeta.norm(init.mat[, 1])
  naive.sigma = sd(Zmat %*% naive.b)
  fit05 = find_sol(init.mat, Zmat, phat, wi, C0, naive.sigma, ninit, ptrg)
  return(fit05)
}

mono.reg <- function(formula, data, ninit = 20, nresamp = 200, C0 = 0.5, seed = 1234){
  set.seed(seed)
  call <- match.call()
  formula <- as.formula(formula)
  mf <- model.frame(formula, data)
  Ys <- model.response(mf)
  Zmat <- model.matrix(formula, data)[, -1]
  nn <- dim(Zmat)[1]

  mono.est <- mono.reg.sub(Ys, Zmat, wi=rep(1,nn), C0, ptrg=1:4, ninit)
  # print(mono.est)

  print("Resampling in progress")
  bb.rmat <- matrix(NA, nrow = nresamp, ncol = ncol(Zmat))
  for(r.i in 1:nresamp){
    mono.r <- mono.reg.sub(Ys, Zmat, wi=rexp(nn), C0, ptrg=1:4, ninit=5, bb.init=mono.est$coef)
    bb.rmat[r.i, ] <- mono.r$coef
    if(r.i %% 10 == 0 | r.i <= 5) {print(r.i)}
  }
  set.seed(NULL)

  # out <- data.frame(coef=mono.est$coef)
  # out$SE <- apply(bb.rmat,2,sd)
  # out$Z <- out$coef/out$SE
  # out$p <- pnorm(-abs(out$Z))*2
  # return(list(out = out, convVal = mono.est$convVal))

  coefs <- mono.est$coef
  SE <- apply(bb.rmat,2,sd)
  z.value <- coefs/SE
  p.value <- 2*(1-pnorm(abs(z.value)))
  result <- list(coef = coefs, StdErr = SE, z.value = z.value, p.value = p.value,
                 converge = mono.est$convVa[1], objVal = mono.est$convVa[2], call = call)
  class(result) <- "GPOreg"
  return(result)
}

