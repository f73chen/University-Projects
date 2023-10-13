filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "fake_objective_fn_data.csv", sep="/")
xdata <- as.matrix(read.csv(filename, header=FALSE))
dimnames(xdata)[[2]] = NULL

# Generate heatmap and contour plot
create.rho.contour.fn <- function(data=NULL) {
  dd = apply(data,2,mean)
  function(alpha,beta) {
    v1 = dd[1]*alpha^4 + dd[2]*alpha^2 + dd[3]*alpha 
    v2 = dd[4]*beta^4  + dd[5]*beta^2  + dd[6]*beta 
    v1+v2
  }
}

# There are 4 local minima and a global minimum near (-3, -3)
rho.to.plot = create.rho.contour.fn(xdata)

aseq = bseq = seq(-5,5,length=100)
z = outer(aseq, bseq , FUN=rho.to.plot)

image(aseq, bseq, z, col = heat.colors(100) )
contour(aseq, bseq, z, add=T, levels=c(-75, -60,-40, -20, 0, 10, 50))

# Modify the rho contour function to accept a population and
# Return a function which takes in theta and returns the objective function
create.rho.fn <- function(pop=NULL) {
  dd = apply(pop,2,mean)
  function(theta) {
    v1 = dd[1]*theta[1]^4 + dd[2]*theta[1]^2 + dd[3]*theta[1] 
    v2 = dd[4]*theta[2]^4 + dd[5]*theta[2]^2 + dd[6]*theta[2]
    v1+v2
  }
}

# Modify createLeastSquaresGradient to calculate the gradient of the objective function
create.grad.fn <- function(data=NULL) {
  dd = apply(data,2,mean)
  function(ab) {
    g1 = 4*dd[1]*ab[1]^3 + 2*dd[2]*ab[1] + dd[3]
    g2 = 4*dd[4]*ab[2]^3 + 2*dd[5]*ab[2] + dd[6]
    c(g1,g2)
  }
}

# Use gradient descent to minimize a and b
# With initial values (0, 0), (1, 1), and (0, 3)
# Part 1: define standard functions
gradientDescent <- function(theta, 
                            rhoFn, gradientFn, lineSearchFn, testConvergenceFn,
                            maxIterations = 100,  
                            tolerance = 1E-6, relative = FALSE, 
                            lambdaStepsize = 0.01, lambdaMax = 0.5) {
  converged <- FALSE
  i <- 0
  while (!converged & i <= maxIterations) {
    g <- gradientFn(theta) ## gradient
    glength <-  sqrt(sum(g^2)) ## gradient direction
    if (glength > 0) g <- g /glength
    lambda <- lineSearchFn(theta, rhoFn, g,  
                           lambdaStepsize = lambdaStepsize, lambdaMax = lambdaMax)
    thetaNew <- theta - lambda * g
    converged <- testConvergenceFn(thetaNew, theta,
                                   tolerance = tolerance,
                                   relative = relative)
    theta <- thetaNew
    i <- i + 1
  }
  list(theta = theta, converged = converged, iteration = i, fnValue = rhoFn(theta)
  )
}

gridLineSearch <- function(theta, rhoFn, g, 
                           lambdaStepsize = 0.01, 
                           lambdaMax = 1) {
  lambdas <- seq(from = 0, by = lambdaStepsize,  to = lambdaMax)
  rhoVals <- Map(function(lambda) {rhoFn(theta - lambda * g)}, lambdas)
  lambdas[which.min(rhoVals)]
}

testConvergence <- function(thetaNew, thetaOld, tolerance = 1E-10, relative=FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) tolerance * sum(abs(thetaOld)) 
  else tolerance
}

# Part 2: create the object and gradient functions using function generators
grad.fn = create.grad.fn(xdata)
rho.fn = create.rho.fn(xdata)

# Part 3: Perform 3 minimizations with different starting points
Optim1 = gradientDescent(rhoFn = rho.fn, 
                         gradientFn = grad.fn, 
                         theta = c(0,0),
                         lineSearchFn = gridLineSearch,
                         testConvergenceFn = testConvergence)

Optim2 = gradientDescent(rhoFn = rho.fn, 
                         gradientFn = grad.fn, 
                         theta = c(1,1),
                         lineSearchFn = gridLineSearch,
                         testConvergenceFn = testConvergence)

Optim3 = gradientDescent(rhoFn = rho.fn, 
                         gradientFn = grad.fn, 
                         theta = c(0,3),
                         lineSearchFn = gridLineSearch,
                         testConvergenceFn = testConvergence)

# Part 4: display optimization results
# Therefore, there are different answers for different starting points
mat = matrix(NA, nrow=3, ncol=7)
mat[1,] = c(0,0, round(unlist(Optim1), 3) )
mat[2,] = c(1,1, round(unlist(Optim2), 3) )
mat[3,] = c(0,3, round(unlist(Optim3), 3) )

dimnames(mat)[[2]] = c("alpha0", "beta0", "alpha^*", "beta^*", "converged", "iteration", "fnValue")
mat

###################################################### COPIED
# Plot the path from the initial value to the solution
gradientDescentWithSolutionPath <- function(theta, 
                                            rhoFn, gradientFn, lineSearchFn, testConvergenceFn,
                                            maxIterations = 100,  
                                            tolerance = 1E-6, relative = FALSE, 
                                            lambdaStepsize = 0.01, lambdaMax = 0.5) {
  
  SolutionPath = matrix(NA,nrow = maxIterations, ncol = length(theta))
  SolutionPath[1,] = theta
  converged <- FALSE
  i <- 0
  
  while (!converged & i < (maxIterations-1) ) {
    g <- gradientFn(theta) ## gradient
    glength <-  sqrt(sum(g^2)) ## gradient direction
    if (glength > 0) g <- g /glength
    
    lambda <- lineSearchFn(theta, rhoFn, g,  
                           lambdaStepsize = lambdaStepsize, lambdaMax = lambdaMax)
    
    thetaNew <- theta - lambda * g
    converged <- testConvergenceFn(thetaNew, theta,
                                   tolerance = tolerance,
                                   relative = relative)
    theta <- thetaNew
    i <- i + 1
    SolutionPath[(i+1),] = theta
  }
  SolutionPath = SolutionPath[1:(i+1),]
  ## Return last value and whether converged or not
  list(theta = theta, converged = converged, iteration = i, fnValue = rhoFn(theta) , 
       SolutionPath = SolutionPath 
  )
}


Optim1 = gradientDescentWithSolutionPath(rhoFn = rho.fn, 
                                         gradientFn = grad.fn, 
                                         theta = c(0,0),
                                         lineSearchFn = gridLineSearch,
                                         testConvergenceFn = testConvergence)
Optim2 = gradientDescentWithSolutionPath(rhoFn = rho.fn, 
                                         gradientFn = grad.fn, 
                                         theta = c(1,1),
                                         lineSearchFn = gridLineSearch,
                                         testConvergenceFn = testConvergence)
Optim3 = gradientDescentWithSolutionPath(rhoFn = rho.fn, 
                                         gradientFn = grad.fn, 
                                         theta = c(0,3),
                                         lineSearchFn = gridLineSearch,
                                         testConvergenceFn = testConvergence)
param1 = Optim1$theta
param2 = Optim1$theta 
param3 = Optim3$theta 

image(aseq, bseq, z, col = heat.colors(100) )
contour(aseq, bseq, z, add=T)# , levels = seq(-20,70,by =5))

n.arrows = dim(Optim1$SolutionPath)[1]
for(i in 1:(n.arrows-1)){
  arrows(Optim1$SolutionPath[i,1],Optim1$SolutionPath[i,2],
         Optim1$SolutionPath[(i+1),1],Optim1$SolutionPath[(i+1),2],
         length = 0.12,angle = 15)
}
n.arrows = dim(Optim2$SolutionPath)[1]
for(i in 1:(n.arrows-1)){
  arrows(Optim2$SolutionPath[i,1],Optim2$SolutionPath[i,2],
         Optim2$SolutionPath[(i+1),1],Optim2$SolutionPath[(i+1),2],
         length = 0.12,angle = 15,col='blue')
}
n.arrows = dim(Optim3$SolutionPath)[1]
for(i in 1:(n.arrows-1)){
  arrows(Optim3$SolutionPath[i,1],Optim3$SolutionPath[i,2],
         Optim3$SolutionPath[(i+1),1],Optim3$SolutionPath[(i+1),2],
         length = 0.12,angle = 15,col='darkgreen')
}