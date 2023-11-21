library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(maps)
library(ggplot2)
library(plotly)
library(shinycssloaders)
library(ggtext)
library(maptools)
library(rgeos)
library(ggmap)
library(scales)
library(RColorBrewer)
set.seed(8000)
library(sf)


df=read.csv("www/forestData2019.csv")

#rename the column names
df <- df %>% rename()
colnames(df) <- c("State","Land Area","Very Dense Forest","Mod Dense Forest","Open Forest","Total Forest","Forest/Land Percentage","Scrub","Zone")
df$Zone=factor(df$Zone)

# remove comma from numbers
df$`Land Area` <- as.numeric(gsub(",","",df$`Land Area`))
df$`Very Dense Forest` <- as.numeric(gsub(",","",df$`Very Dense Forest`))
df$`Mod Dense Forest` <- as.numeric(gsub(",","",df$`Mod Dense Forest`))
df$`Open Forest` <- as.numeric(gsub(",","",df$`Open Forest`))
df$`Total Forest` <- as.numeric(gsub(",","",df$`Total Forest`))
df$`Scrub` <- as.numeric(gsub(",","",df$`Scrub`))

#----filter choice ---------
f1 <- c("Very Dense Forest","Mod Dense Forest","Open Forest","Scrub","Total Forest") #Forest type dropdown
s1 <- unique(df$State) #State dropdown
z1 <- unique(df$Zone)  #Zone dropdown

#------- Choropleth Map -------------------------
shp <- read_sf('www/shapeFiles/Admin2.shp')

#plot(shp)
#names(shp)
shp <- shp %>% rename(State=ST_NM)
shp$State[3] <- "Arunachal Pradesh"
shp$State[1] <- "A & N Islands"


shp.f <- fortify(shp, region = "State")
map_df<-merge(shp.f,df, by="State", all.x=TRUE)
map_df<- map_df[rowSums(is.na(merge.shp.coef)) == 0, ]

