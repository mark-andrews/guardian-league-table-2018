library(shiny)
library(dplyr)
library(ggplot2)
library(lazyeval)
library(RColorBrewer)

source('utils.R')
load('data/glt2018.Rda') 

evaluation.factors <- list(sat.teaching = list(variable = 'sat.teaching', 
                                               label = 'Percentage of students satisfied with teaching', 
                                               title = 'Satisfaction with teaching',
                                               y.min = 0, 
                                               y.max = 100, 
                                               y.step = 10),
                           sat.course = list(variable = 'sat.course', 
                                             label = 'Percentage of students satisfied with the course', 
                                             title = 'Satisfaction with course',
                                             y.min = 0, 
                                             y.max = 100, 
                                             y.step = 10),
                           sat.assess = list(variable = 'sat.assess', 
                                             label = 'Percentage of students satisfied with their assessment', 
                                             title = 'Satisfaction with assessment',
                                             y.min = 0, 
                                             y.max = 100, 
                                             y.step = 10),
                           expend = list(variable = 'expend', 
                                         label = 'Average expenditure per student', 
                                         title = 'Average expenditure',
                                         y.min = 0, 
                                         y.max = 10, 
                                         y.step = 2),
                           ss.ratio = list(variable = 'ss.ratio', 
                                           label = 'Number of students per each member of teaching staff', 
                                           title = 'Staff student ratio',
                                           y.min = 0, 
                                           y.max = 50, 
                                           y.step = 5),
                           prospects = list(variable = 'prospects', 
                                            label = 'Percentage of students in graduate level jobs (or further study) after 6 months', 
                                            title = 'Graduate Prospects',
                                            y.min = 0, 
                                            y.max = 100, 
                                            y.step = 10),
                           value = list(variable = 'value', 
                                        label = 'Student degree results compared to entry qualifications', 
                                        title = 'Value added',
                                        y.min = 0, 
                                        y.max = 10, 
                                        y.step = 2),
                           tariff = list(variable = 'tariff', 
                                         label = 'Average UCAS scores of students', 
                                         title = 'Entry tariff',
                                         y.min = 50, 
                                         y.max = 250, 
                                         y.step = 25),
                           score = list(variable = 'score', 
                                         label = 'Overall Guardian score', 
                                         title = 'Overall score',
                                         y.min = 0, 
                                         y.max = 100, 
                                         y.step = 10)
)




ui <- fluidPage(
  titlePanel("Guardian's University League Tables 2018"),
  fluidRow(
    column(3,
           helpText("The ",
		    a('Guardian university league tables',
		     href="https://www.theguardian.com/education/universityguide",
		    target='_blank'),
		    "provide evaluation scores of 54 university degree subjects provided across 149 different institutions in the UK.",
		    "These scores are based on aggregations of 8 different variables:
		    Graduate prospects, student satisfaction with course,
		    student satisfaction with teaching, student satisfaction with assessement, staff-student ratio, expenditure per
		    student, entry tariff, and value added.",
		    "This app allows you to select each one the these variables (and also the overall aggregate score), and view its distribution, grouped either by the degree subject or by the institution.",
                    "All code for this demo can be found on",
                    a("GitHub.",
                      href="https://github.com/lawsofthought/guardian-league-table-2018",
                      target='_blank')
           ),
             selectInput("variable", "Choose a variable:",
                         c('Graduate prospects' = 'prospects',
                           "Satisfaction with course" = "sat.course",
                           "Satisfaction with teaching" = "sat.teaching",
                           "Satisfaction with assessment" = "sat.assess",
                           "Staff student ratio" = 'ss.ratio',
                           "Expenditure per student" = 'expend',
                           "Entry tariff" = 'tariff',
                           'Value added' = 'value',
                           'Overall score' = 'score')),
             radioButtons("group_by", "Group values by:",
                          c("Subject" = "subject",
                            "Institution" = "institution"))
    ),
    column(4,
           mainPanel(
             plotOutput("glt2018plot")
           ))
  )
 
)

server <- function(input, output) {
   
   output$glt2018plot <- renderPlot({
     
     plot.params <- evaluation.factors[[input$variable]]
     
     if (input$group_by == 'subject'){
       boxplot.by.subject(glt2018.Df,
                          plot.params$variable,
                          plot.params$label,
                          plot.params$title,
                          plot.params$y.min,
                          plot.params$y.max,
                          plot.params$y.step)
     } else {
       boxplot.by.institution(glt2018.Df,
                              plot.params$variable,
                              plot.params$label,
                              plot.params$title,
                              plot.params$y.min,
                              plot.params$y.max,
                              plot.params$y.step)
     }

   }, height=exprToFunction(ifelse(input$group_by == 'subject', 800, 1500)), width=800)
}


shinyApp(ui = ui, server = server)
