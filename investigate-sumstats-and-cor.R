X <- scale(matrix(rnorm(200), 20), scale = TRUE)
y <- rnorm(20)

library(bigstatsr)
beta <- big_univLinReg(as_FBM(X), y)$estim
beta2 <- solve(cor(X), beta)


X2 <- cbind(1, X)
beta3 <- solve(crossprod(X2), crossprod(X2, y))
plot(beta2, beta3[-1]); abline(0, 1, col = "red")

X3 <- scale(X)
beta4 <- solve(crossprod(X3), crossprod(X3, y))
plot(beta4, beta3); abline(0, 1, col = "red")
plot(beta4, beta2)
