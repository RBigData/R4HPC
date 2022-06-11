### Least Squares Fit wia Normal Equations (see lm.fit for a better way)
library( pbdMPI, quiet = TRUE )

comm.set.seed( seed = 12345, diff = TRUE )

## 10 rows and 3 columns of data per process
my.X <- matrix( rnorm(10*3), ncol = 3 )
my.y <- matrix( rnorm(10*1), ncol = 1 )

## Form the Normal Equations components
my.Xt <- t( my.X )
XtX <- allreduce( my.Xt %*% my.X, op = "sum" )
Xty <- allreduce( my.Xt %*% my.y, op = "sum" )

## Everyone solve the Normal Equations
ols <- solve( XtX, Xty )

comm.print( ols )

finalize()
