source("flexiblas_setup.r")

x = matrix(rnorm(1e7), nrow = 1e4, ncol = 1e3)
memuse::howbig(1e4, 1e3)
beta = rep(1, ncol(x))
err = rnorm(nrow(x))
y = x %*% beta + err
data = as.data.frame(cbind(y, x))
names(data) = c("y", paste0("x", 1:ncol(x)))

elo = 0
ehi = 7 

# lm --------------------------------------
setback("NETLIB", "lm")
system.time((lm(y ~ ., data)))

setback("OPENBLAS", "lm")
for(i in elo:ehi) {
  setthreads(2^i, "lm")
  print(system.time((lm(y ~ ., data))))
}

# qr --------------------------------------
setback("NETLIB", "qr")
system.time((qr(x)))

setback("OPENBLAS")
for(i in 0:3) {
  setthreads(2^i, "qr")
  print(system.time((qr(x))))
}
for(i in elo:ehi) {
  setthreads(2^i, "qr")
  print(system.time((qr(x, LAPACK = TRUE))))
}

# prcomp --------------------------------------
setback("NETLIB", "prcomp")
system.time((prcomp(x)))

setback("OPENBLAS")
for(i in elo:ehi) {
  setthreads(2^i, "prcomp")
  print(system.time((prcomp(x))))
}

# princomp --------------------------------------
setback("NETLIB", "prcomp")
system.time((prcomp(x)))

setback("OPENBLAS")
for(i in elo:ehi) {
  setthreads(2^i, "princomp")
  print(system.time((princomp(x))))
}

# crossprod --------------------------------------
setback("NETLIB", "crossprod")
system.time((crossprod(x)))

setback("OPENBLAS")
for(i in elo:ehi) {
  setthreads(2^i, "crossprod")
  print(system.time((crossprod(x))))
}

# %*% --------------------------------------------
setback("NETLIB", "%*%")
system.time((t(x) %*% x))

setback("OPENBLAS")
for(i in elo:ehi) {
  setthreads(2^i, "%*%")
  print(system.time((t(x) %*% x)))
}
