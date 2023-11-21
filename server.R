function(input,output){
  
  
  #---------- Data Tab-------------
  output$dataT <- renderDataTable(
    df
  )

  output$structure <- renderPrint(
    str(df)
  )

  output$dataSumm <- renderPrint(
    summary(df)
  )

  #----------- Visualization ------------
  #----------- TOP 5 States ------------
  output$top5 <-  renderTable({
    df %>%
      select(State,input$var1) %>%
      arrange(desc(get(input$var1))) %>%
      head(5)
  },bordered = TRUE,width = "auto")
  
  #----------- Bottom 5 States ------------
  output$bottom5 <-  renderTable({
    df %>%
      select(State,input$var1) %>%
      arrange(get(input$var1)) %>%
      head(5)
  },bordered = TRUE,width = "auto")
  
  #----------- StateWise Forest Bar Plot  ------------
  output$bar <-  renderPlotly({
    p <- df %>%
      plot_ly() %>%
      add_bars(x=~State,y=~log10(get(input$var1))) %>%
      layout(title = paste("Statewise Forest for", input$var1),
             xaxis = list(title = "State"),
             #yaxis = list(type = 'log',title = paste(input$var2, "Forest in area") ))
             yaxis = list(
               type = 'log', 
               title = paste("Log Scale - (Area in sq. km)"),
               rangemode = "tozero",
               tickvals = c(0, 1, 2, 3, 4), 
               ticktext = c('1', '10', '100', '1000', '10000')
             ))
  })

  #--------- state wise data ------------
  state_data <- reactive({
    data <- df[df$State == input$var2, ]
    return(data)

  })

  #--------- Zonal data -----------------
  zone_data <- reactive({
    data <- df[df$Zone == input$var5, ]
    return(data)

  })


  #----------- Display State Wise Data  ------------
  output$state_data <- renderTable({state_data()},bordered = TRUE,width = "auto")
  
  #----------- Forest and Non Forest Pie Chart  ------------
  output$forest_pie_chart1 <- renderPlotly({

    data1 <- state_data() %>% mutate("Non Forest Area"=`Land Area`-`Total Forest`) %>%
            rename("Forest Area"="Total Forest") %>%
            select("Forest Area","Non Forest Area")

    # Create a pie chart
    pie_chart <- plot_ly(
      labels = colnames(data1),
      values = as.numeric(unlist(data1)),
      type = 'pie'
    ) %>%
      layout(
        title = paste("Forest Cover in",input$var2),
        showlegend = TRUE
      )

    pie_chart
  })
  output$state_name <- renderText({
    paste(input$var2)
  })
  
  #----------- Types of forest Pie Chart  ------------
  output$forest_pie_chart2 <- renderPlotly({

    data2 <- state_data() %>%
            select("Very Dense Forest","Mod Dense Forest","Open Forest","Scrub")

    # Create a pie chart
    pie_chart <- plot_ly(
      labels = colnames(data2),
      values = as.numeric(unlist(data2)),
      type = 'pie'
    ) %>%
      layout(
        title = paste("Forest Cover in",input$var2),
        showlegend = TRUE
      )

    pie_chart
  })

  #----------- Types of forest in a States  Pir Chart ------------
  output$bar_plot <- renderPlotly({
    data2 <- state_data() %>%
      select("Very Dense Forest","Mod Dense Forest","Open Forest","Scrub")

    # Create a pie chart
    bar_plot1 <- plot_ly(
      x = colnames(data2),
      y = as.numeric(unlist(data2)),
      type = 'bar'
    ) %>% layout(title = paste("Types of Forest in",input$var2),
                 xaxis = list(title = "Types of Forest"),
                 yaxis = list(title = "Area in sq. km"))


    return(bar_plot1)
  })




  #------------ Compare two states Forest -----
  compare_state_data <- reactive({
    data <- df %>% filter(State %in% c(input$var3,input$var4)) %>%
      select("State","Very Dense Forest","Mod Dense Forest","Open Forest","Scrub")
    return(data)

  })

  output$state_data1 <- renderTable({compare_state_data()},bordered = TRUE,width = "auto")

  output$comp_bar_plot <- renderPlotly({

    state_1 <- compare_state_data() %>%
      filter(State== input$var3) %>%
      select("Very Dense Forest","Mod Dense Forest","Open Forest","Scrub")

    state_2 <- compare_state_data() %>%
      filter(State== input$var4) %>%
      select("Very Dense Forest","Mod Dense Forest","Open Forest","Scrub")

    # Create a pie chart
    bar_plot1 <- plot_ly(
      x = colnames(state_1),
      y = as.numeric(unlist(state_1)),
      type = 'bar',
      name = input$var3,
      marker = list(color = 'rgb(55, 83, 109)')
    )

    bar_plot1 <- bar_plot1 %>% add_trace(y=as.numeric(unlist(state_2)), name = input$var4,marker = list(color = 'rgb(26, 118, 255)')) %>%
      layout(title = paste("Types of Forest in",input$var3,"&",input$var4),
             xaxis = list(title = paste("Types of Forest in",input$var3,"&",input$var4)),
             yaxis = list(title = "Area in sq. km"))


    return(bar_plot1)
  })

  output$zonal_data <- renderTable({
    zone_data()
  },bordered = TRUE,width = "auto",hover = TRUE)



  # -----------Map Plot ------------
  # Choropleth map
  output$map_plot <- renderPlotly({


      z <- ggplot(map_df)+
      geom_sf(color = "#BABABA",aes(fill = get(input$forestType)))+
      geom_sf_text(color = "black",alpha=0.6,aes(label = State), size = 2) +
      scale_fill_gradient(low="#8AFF8A", high="#007500",name = paste(input$forestType,"in India \n (Area in sq. km)"))+
      theme_void()+
      labs(title = paste("Choropleth map of", input$forestType , "Cover in States/UTs in India in 2019")) +
      theme(
        plot.title = element_textbox_simple(face="bold",
                                            size=12,
                                            halign=0.5),
        
        panel.border = element_rect(color = "#454545", 
                                    fill = NA, 
                                    size = 5)
      )
      return(z)
  })

}
