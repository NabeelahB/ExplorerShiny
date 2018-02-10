ui <- dashboardPage(skin="black",
                    
                    dashboardHeader(title = "EXPLORER",titleWidth = 180
                    ),##End of dashboard header
                    dashboardSidebar(
                      width = 180,
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
                      fluidPage(responsive = T,
                                
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
                                          h3("Shows correlations between variables"),
                                          column(7,wellPanel(
                                            h4("Correlogram"),
                                            selectInput("DataFrame", "Select the database to work with", choices = c("mtcars","iris"),
                                                        selected ="mtcars" ,multiple = F),
                                            conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                                                             h6("Generating graph.."),
                                                             tags$img(src="busy.gif")
                                            ),
                                            plotlyOutput("heat",width = "100%",height = "100%")
                                          )),#end of column
                                          column(5,wellPanel(
                                            tags$style(type="text/css",
                                                       ".shiny-output-error { visibility: hidden; }",
                                                       ".shiny-output-error:before { visibility: hidden; }"),
                                            h4("Click on a cell in the heatmap to show scatterplot"),
                                            
                                            plotlyOutput("scatterplot",width = "100%",height = "100%"),
                                            verbatimTextOutput("selectedDat") 
                                          ))#end of column
                                          
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
                                                                      h6("Generating graph.."),
                                                                      tags$img(src="busy.gif")
                                                     ),
                                                     conditionalPanel(condition="!$('html').hasClass('shiny-busy')",
                                                                      h5("Percentage of visits which begin with this sequence of pages"),
                                                                      sunburstOutput("sunburst",width = "100%",height = "100%")
                                                     ),
                                                     
                                                     
                                                     textOutput("selection")
                                                   ))
                                          )#End of fluidPage
                                          
                                  )##end of results tab content
                                  
                                  
                                )##End of Tabitems
                                
                      )#End of FluidPage
                      
                    )###End of dashboardBody
)##End of dashboardPage
