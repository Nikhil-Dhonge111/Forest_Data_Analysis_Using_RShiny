# Exploratory Analysis of Forest Data in India using R Shiny
**Objective:**
The primary objective of this R Shiny project is to conduct an in-depth exploratory analysis of 2019 forest data in India. The project aims to create an interactive and user-friendly interface that allows stakeholders, researchers, and the general public to visualize, analyze, and interpret key insights from the diverse forest-related datasets available for India.

**Overview:**
This project focuses on the analysis of forest cover in different Indian states and Union Territories using data sourced from [FRIENVIS](https://frienvis.nic.in/Database/Forest-Cover-in-States-UTs-2019_2478.aspx). The dataset includes information on various types of forests such as Very Dense Forest, Moderately Dense Forest, Open Forest, Total Forest and Scrub.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/0b5b3fae-e208-4c24-89c0-dca1ef23159d)

**Tools and Technologies:**
The project is implemented using R programming language, and the interactive user interface is developed using R Shiny. Exploratory data analytics performed using R programming.

**R Shiny Dashboard:**
The project includes a user-friendly R Shiny Dashboard with three major tabs:

**1) Data**
This tab provides insights into the dataset through four subtabs:
    
a) About: Information about the dataset.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/93457e42-3d5f-45f6-9fe3-d16653ad770e)
    
b) Data: Display of the dataset.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/2a12d620-9af3-45fb-808c-2ee0f2efa127)
    
c) Structure: Structure of the dataset.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/bd5e8ff0-64ed-412c-b21b-f53087947666)
    
d) Summary: Summary statistics of the dataset.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/f18962f2-e4d2-4e1c-97a4-dc0b783cda5a)

**2) Visualization**
    This tab contains five subtabs:
    
a) Forest Data by Forest Type: Displays the top 5 and bottom 5 states with the selected forest type. Also, includes a bar plot for all states showing the selected forest type area.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/d4b96681-d6e7-4ec6-a379-beff18e610fd)
    
b) State-wise Data: Visualizes forest vs non-forest data for the selected state and a pie chart representing different types of forests in the selected state.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/18acdc17-81f7-4090-a9bd-2a09f64a1db6)
    
c) State Forest Bar Graph: Presents a bar column chart for different types of forests in the selected states.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/d641db3e-2ecc-4e12-8fbc-0b988c1d7651)
    
d) State Comparison: Compares two states by different types of forest using a column chart.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/4a230db5-8284-4182-b433-15864087cfdd)
    
e) Zonal Data: Displays data for the selected zone.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/b86c44bc-c303-49dc-9930-22d38e0c286d)

**3) Choropleth Map**
This tab includes a choropleth map that shows the distribution of the selected forest type across India.
![image](https://github.com/Nikhil-Dhonge111/Forest_Data_Analysis_Using_RShiny/assets/146107579/315f952b-7ad2-46d3-a175-5d581f93e44f)
    

**How to Run the Project:**
1. Clone this repository to your local machine.
2. Ensure you have R installed on your system.
3. Install the required R packages by running install.packages(c("shiny", "leaflet", "dplyr", "ggplot2", "plotly")).
4. Run the Shiny app by executing shiny::runApp("path/to/cloned/repository") in R console.
  
**Connect with Me**
- If you have any questions or suggestions, feel free to connect with me on LinkedIn.

*Feel free to explore the dataset and gain valuable insights into the forest cover in different regions of India. If you encounter any issues or have suggestions for improvement, please open an issue in the GitHub repository. Happy analyzing!*
