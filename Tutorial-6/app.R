library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)

min_wt <- floor(min(mtcars$wt))
max_wt <- ceiling(max(mtcars$wt))

ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Motor Trend Car Road Tests"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "cyl",
        label = "Number of cylinders",
        choices = list("All" = "All", "4" = 4, "6" = 6, "8" = 8),
        selected = "All"
      ),
      sliderInput(
        inputId = "wt",
        label = "Weight (1000 lbs)",
        min = min_wt,
        max = max_wt,
        value = c(min_wt, max_wt)
      )
    ),
    mainPanel(
      plotOutput(outputId = "plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    min_wt <- input$wt[1]
    max_wt <- input$wt[2]

    df <- mtcars %>%
      filter(
        input$cyl == "All" | cyl == input$cyl,
        wt >= min_wt & wt <= max_wt
      )

    p <- ggplot(
      data = df,
      aes(
        x = hp,
        y = mpg,
        color = factor(am),
        shape = factor(vs)
      )
    ) +
      geom_point(
        size = 5,
        alpha = 0.5
      )

    p +
      ggtitle("Fuel Consumption vs Gross Horsepower") +
      xlab("Gross horsepower") +
      ylab("Miles/(US) gallon") +
      theme_bw(base_size = 16) +
      scale_color_discrete(
        name = "Transmission",
        labels = c("Automatic", "Manual")
      ) +
      scale_shape_discrete(
        name = "Engine",
        labels = c("V-shaped", "Straight")
      )
  })
}

shinyApp(ui = ui, server = server)
