server <- function(input, output,session) {
  
  #Reactive function to read the selected dataframe
  inputDF <- reactive({
    input$DataFrame
    
  })
  
  
  #function to generate heatmap
  output$heat <- renderPlotly({
    
    inputData <- inputDF()
    correlation <- if(is.null(inputData) | inputData == "mtcars") round(cor(mtcars), 3) else  round(cor(iris[-5]), 3)
    
    nms <- if(is.null(inputData) | inputData == "mtcars") names(mtcars) else  names(iris[-5])
    
    p <- plot_ly(x = nms, y = nms, z = correlation, 
                 key = correlation, type = "heatmap", source = "heatplot") %>%
      layout(xaxis = list(title = ""), 
             yaxis = list(title = ""))
    p$elementId <- NULL
    p
  })
  
  #Function to display correlation values to textbox
  output$selectedDat <- renderPrint({
    
    s <- event_data("plotly_click",source = "heatplot")
    if (length(s) == 0) {
      cat("Click on a cell \nin the heatmap \nto display a scatterplot")
    } else {
      
      cat(paste0("Showing correlation \nbetween: \n\n",s$x," and ", s$y,"\n","The correlation is ",s$z))
    }
  })
  
  #function to display scatterplot
  output$scatterplot <- renderPlotly({
    inputData <- inputDF()
    print(inputData)
    #assign the selected dataframe to df
    df = eval(parse(text = inputData))
    s <- event_data("plotly_click", source = "heatplot")
    print(s)
    if (length(s)) {
      vars <- c(s[["x"]], s[["y"]])
      print(vars)
      d <- setNames(df[vars], c("x", "y"))
      yhat <- fitted(lm(y ~ x, data = d))
      p <- plot_ly(d, x = ~x) %>%
        add_markers(y = ~y) %>%
        add_lines(y = ~yhat) %>%
        layout(xaxis = list(title = s[["x"]]),
               yaxis = list(title = s[["y"]]),
               showlegend = FALSE)
      p$elementId <- NULL
      p
    } else {
      plotly_empty(type = "scatter")
    }
  })
  
  #function to display sunburst
  output$sunburst <- renderSunburst({
    # invalidateLater(1000, session)
    # 
    # sequences <- sequences[sample(nrow(sequences),1000),]
    # 
    add_shiny(sunburst(sequences))
    ##Displays the legend
    htmlwidgets::onRender(
      sunburst(sequences, withD3 = T),
      "
      function(el,x){
      d3.select(el).select('.sunburst-togglelegend').property('checked', true);
      d3.select(el).select('.sunburst-legend').style('visibility', '');
      document.getElementsByClassName('sunburst-sidebar')[0].childNodes[2].nodeValue = 'Pages';
      }
      "
    )
  })
  
  
  selection <- reactive({
    input$sunburst_mouseover
  })
  
  output$selection <- renderText(selection())
  
  
}##End of server