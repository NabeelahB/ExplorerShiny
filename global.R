# Date - 08-02-2018
# Author - Nabeelah Bijapur
# Purpose - Exploring data trends using R, shiny, Plotly & d3js charts

#Loading all required libraries
library(dplyr)
library(shinydashboard)
library(shiny)
library(shinyjs)
library(htmlwidgets)
library(plotly)
library(shiny)
library(sunburstR)



##Reading the data containing the sequences of visitor paths to website
sequences <- read.csv("Data//visit-sequences1.csv",header=F,stringsAsFactors = FALSE)


