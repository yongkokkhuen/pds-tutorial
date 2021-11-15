# List available datasets
data()

# Install package
install.packages('memisc')

# Load package
library(memisc)

# Load cars dataset
c <- data.set(cars)

# Check type
typeof(c)

# Print dataset
c

# Codebook
codebook(c)

# Summary
summary(c)
