# Install package
install.packages('memisc')

# Load package
library(memisc)

# Load cars dataset
c <- data.set(cars)
class(cars)

# Create custom codebook
sapply(cars, class)
sapply(cars, min)
sapply(cars, max)
sapply(cars, range)

# Summary
summary(cars)
