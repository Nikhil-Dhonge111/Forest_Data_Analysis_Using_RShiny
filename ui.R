dashboardPage(skin = "green",
  dashboardHeader(title = "Forest Cover in States/UTs in India in 2019",titleWidth = 450,
                  tags$li(class="dropdown",tags$a(href="https://www.linkedin.com/in/nikhil-dhonge/" ,icon("linkedin"), "My Profile", target="_blank")),
                  tags$li(class="dropdown",tags$a(href="https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_Rshiny", icon("github"), "Source Code", target="_blank"))
                  ),
  
  dashboardSidebar(
    sidebarMenu(id="sidebar",
      menuItem("Data",tabName = "data",icon = icon("table")),
      menuItem("Visualization",tabName = "viz",icon = icon("chart-line")),
      conditionalPanel("input.sidebar== 'viz' && input.t2 == 'state_trend'",selectInput("var1","Select Forest Type",choices = f1,selected = "Total Forest")),
      conditionalPanel("input.sidebar== 'viz' && (input.t2 == 'state_data' || input.t2 == 'state_forest')",selectInput("var2","Select State",choices = s1,selected = "Maharashtra")),
      conditionalPanel("input.sidebar== 'viz' && input.t2 == 'state_comparison'",
      selectInput("var3","Select State 1",choices = s1,selected = "Maharashtra"),
      selectInput("var4","Select State 2",choices = s1,selected = "Andhra Pradesh")),
      conditionalPanel("input.sidebar== 'viz' && input.t2 == 'zonal'",selectInput("var5","Select Zone",choices = z1,selected = "Central")),
      menuItem("Choropleth Map",tabName = "map",icon = icon("map"))
      
    )
  ),
  
  dashboardBody(
     tabItems(
      tabItem(tabName = "data",
        tabBox(id = "t1",width = 12,
               tabPanel("About",icon = icon("address-card"),
                        column(width = 5,
                               tags$br() ,
                               tags$img(src="india.jpg", width =400 , height = 550),
                               tags$br() ,
                               tags$a("Random Google Image"), align = "center"),
                        column(width = 7, tags$br() ,tags$br(),tags$br(),tags$br(), align = "center",
                               tags$h3("Source: Forest Survey of India, Dehradun. India State of Forest Report (2019). Volume 1"),
                               tags$p("Forest cover is the total geographical area declared as forest by the government. As of 2021, the total forest cover in India is 80.9 million hectares, which is 24.62 per cent of the total geographical area.There is a 1,540 sq.km increase in forest cover over 2019. Madhya Pradesh has the highest forest cover by area followed by Arunachal Pradesh. Mizoram has the highest forest cover in terms of percentage of total geographical area.",align="justify"),
                               tags$br(),
                               tags$p("NOTE: # Includes Jammu & Kashmir area outside LoC that is under illegal occupation of Pakistan and China.",align="left"),
                               tags$a(tags$b("Source : https://frienvis.nic.in/"),href="https://frienvis.nic.in/Database/Forest-Cover-in-States-UTs-2019_2478.aspx",target="_blank")
                              )
                ),
               tabPanel("Data",withSpinner(dataTableOutput("dataT")),icon = icon("table")),
               tabPanel("Structure",withSpinner(verbatimTextOutput("structure")),icon = icon("uncharted")),
               tabPanel("Summary",withSpinner(verbatimTextOutput("dataSumm")),icon = icon("chart-pie"))
        )
      ),

      tabItem(tabName = "viz",
              tabBox(id = "t2",width = 12,
                     tabPanel("Forest Data By State",value = "state_trend",icon = icon("database"),
                         fluidRow(
                           box(
                             title = "TOP 5 States (Area in sq. km)", status = "primary", solidHeader = TRUE,
                             collapsible = TRUE,align="center",
                             tableOutput("top5")
                           ),
                           box(
                             title = "BOTTOM 5 states (Area in sq. km)", status = "primary", solidHeader = TRUE,
                             collapsible = TRUE,align="center",
                             tableOutput("bottom5")
                           )
                         ),

                         withSpinner(plotlyOutput("bar"))

                        ),

                     tabPanel("State Wise Data",value = "state_data",icon = icon("chart-pie"),align="center",tableOutput("state_data"),
                       fluidRow(
                         box(
                           title = paste("Forest Vs Non Forest Area"), status = "primary", solidHeader = TRUE,withSpinner(plotlyOutput("forest_pie_chart1"))
                         ),
                         box(
                           title = paste("Types of Forest and Percentage"), status = "primary", solidHeader = TRUE,withSpinner(plotlyOutput("forest_pie_chart2"))
                         )
                       )
                     ),

                     tabPanel("State's Forest Bar Graph",value = "state_forest",icon = icon("chart-column"),withSpinner(plotlyOutput("bar_plot"))),
                     tabPanel("State Comparison",value = "state_comparison",icon = icon("globe"),
                              fluidRow(
                                column(12, align="center",tableOutput("state_data1"))
                              ),
                              fluidRow(
                                box(
                                  width=12, status = "primary",
                                  tags$br(),tags$br(),tags$br(),
                                  withSpinner(plotlyOutput("comp_bar_plot"))
                                )
                              )


                      ),
                     tabPanel("Zone Data",value = "zonal",icon = icon("table"),withSpinner(tableOutput("zonal_data"),color = "green"))

                     )
      ),
      
      tabItem(tabName  ="map",
              box(selectInput("forestType","Select Forest Type", choices = f1, selected="Total Forest", width = 250),
                        withSpinner(plotlyOutput("map_plot",height = 580),color = "green"), width = 12)

      )
    )
  )
)
