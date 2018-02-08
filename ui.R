ui <- dashboardPage(skin="black",
                    
                    dashboardHeader(title = "EXPLORER"
                    ),##End of dashboard header
                    dashboardSidebar(
                      
                      sidebarMenu(id = "alltabs",
                                  menuItem("Introduction", tabName = "introduction", icon = icon("plus-square-o")),
                                  menuItem("Correlations", tabName = "inputs", icon = icon("th")),
                                  menuItem("Customer Journey", tabName = "results", icon = icon("dashboard"))
                                  
                      )##End of sidebar
                    ),
                    dashboardBody(
                      # Also add some custom CSS to make the title background area the same
                      # color as the rest of the header.
                      tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                      ),##End of css style header
                      
                      tabItems(
                        # First tab content
                        tabItem(tabName = "introduction",
                                h1("Introduction"),
                                fluidPage(
                                  p("The dashboard showcases ways of exploring data at hand"),
                                  p("It has two parts:"),
                                  p("1. Correlations Tab: This tab displays and highlights the correlation between different
                  variables in the form of a heatmap of the selected database."),
                                  p("2. Customer Journey Tab:This tab summarizess the navigation paths of users on a 
                  website.")
                                  
                                )
                                
                        ),
                        
                        # Second tab content
                        tabItem(tabName = "inputs",
                                fluidPage(
                                  h3("Shows correlations between variables"),
                                  column(6,wellPanel(
                                    h4("Correlogram"),
                                    selectInput("DataFrame", "Select the database to work with", choices = c("mtcars","iris"),
                                                selected ="mtcars" ,multiple = F),
                                    plotlyOutput("heat",height = "600px")
                                  )),#end of column
                                  column(4,wellPanel(
                                    tags$style(type="text/css",
                                               ".shiny-output-error { visibility: hidden; }",
                                               ".shiny-output-error:before { visibility: hidden; }"),
                                    h4("Click on a cell in the heatmap to show scatterplot"),
                                    plotlyOutput("scatterplot",height = "600px")
                                  )),#end of column
                                  br(),
                                  column(2,wellPanel(
                                    verbatimTextOutput("selectedDat")  
                                  ))#end of column
                                  
                                )##End of fluid row
                        ),##end of inputs tab
                        
                        tabItem(tabName = "results",
                                
                                fluidPage(
                                  column(10,
                                         wellPanel(
                                           h3("Consumer journey on a website"),
                                           p("The visualization allows you to see all possible paths taken by a user on your website"),
                                           p("And makes it easy to understand visits that start 
                            directly on a product page 
                            (e.g. after landing there from a search engine),
                           compared to visits where users arrive on the site's home page 
                           and navigate from there."),
                                           br(),
                                           
                                           conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                                                            p("Generating graph.."),
                                                            tags$img(src="busy.gif")
                                           ),
                                           h5("Percentage of visits which begin with this sequence of pages"),
                                           sunburstOutput("sunburst",height = "600px"),
                                           
                                           textOutput("selection")
                                         ))
                                )#End of fluidPage
                                
                        )##end of results tab content
                        
                        
                      )##End of Tabitems
                    )###End of dashboardBody
)##End of dashboardPage