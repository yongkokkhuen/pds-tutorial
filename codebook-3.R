# Install package
install.packages('dataReporter')

# Load package
library(dataReporter)

# Check on cars dataset
head(cars)

# Create codebook
makeCodebook(cars)
