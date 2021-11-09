# Tutorial 3 - Web scraping with R

# Install packages
install.packages('selectr')
install.packages('xml2')
install.packages('rvest')
install.packages('stringr')
install.packages('jsonlite')

# Load packages
library(xml2)
library(rvest)
library(stringr)
library(jsonlite)

# URL for iPhone 13 in Amazon
scrapped_url <- 'https://www.amazon.in/Apple-iPhone-13-256GB-Blue/dp/B09G93H3BR'
# Read HTML from URL
webpage <- read_html(scrapped_url)

# Reusable function for scraping
get_product_details <- function(selector) {
  details_html <- html_nodes(webpage, selector)
  details <- html_text(details_html)
  details <- str_replace_all(details, '[\r\n]', '')
  details <- str_trim(details)
  return(details)
}

# Scrape title
title <- get_product_details('h1#title')
head(title)

# Scrape price
price <- get_product_details('span#priceblock_ourprice')
head(price)

# Scrape description
desc <- get_product_details('div#feature-bullets')
head(desc)

# Scrape rating
rate <- get_product_details('span#acrPopover')
head(rate)

# Scrape size
size <- get_product_details('div#variation_size_name span.selection')
head(size)

# Scrape color
color <- get_product_details('div#variation_color_name span.selection')
head(color)

# Create data frame
product_data <- data.frame(Title = title,
                           Price = price,
                           Description = desc,
                           Rating = rate,
                           Size = size,
                           Color = color)
str(product_data)

# Store data in JSON
json_data <- toJSON(product_data)
cat(json_data)
