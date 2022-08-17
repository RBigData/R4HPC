source("flexiblas_setup.R")
memuse::howbig(5e4, 2e3)
parallel::detectCores()

x = matrix(rnorm(1e8), nrow = 5e4, ncol = 2e3)
beta = rep(1, ncol(x))
err = rnorm(nrow(x))
y = x %*% beta + err
data = as.data.frame(cbind(y, x))
names(data) = c("y", paste0("x", 1:ncol(x)))

setback("OPENBLAS")
# qr --------------------------------------
for(i in 0:4) {
  setthreads(2^i, "qr")
  print(system.time((qr(x, LAPACK = TRUE))))
}

# prcomp --------------------------------------
for(i in 0:5) {
  setthreads(2^i, "prcomp")
  print(system.time((prcomp(x))))
}

# princomp --------------------------------------
for(i in 0:6) {
  setthreads(2^i, "princomp")
  print(system.time((princomp(x))))
}

# crossprod --------------------------------------
for(i in 0:7) {
  setthreads(2^i, "crossprod")
  print(system.time((crossprod(x))))
}

# %*% --------------------------------------------
for(i in 0:7) {
  setthreads(2^i, "%*%")
  print(system.time((t(x) %*% x)))
}
