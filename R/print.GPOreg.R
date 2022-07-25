
print.GPOreg <- function(x, ...){
  cat("Call:\n")
  dput(x$call)
  cat("\n")
  if(is.null(x$converge)){
    result <- cbind(x$coef, sqrt(diag(x$var)), x$z.value, x$p.value)
    colnames(result) <- c("Estimate", "StdErr", "z value", "Pr(>|z|)")
    print(round(result, 4))
  }else{
    result <- cbind(x$coef, x$StdErr, x$z.value, x$p.value)
    colnames(result) <- c("Estimate", "StdErr", "z value", "Pr(>|z|)")
    print(round(result, 4))
  }
  invisible(x)
}
