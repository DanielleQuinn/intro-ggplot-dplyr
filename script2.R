# R at Sea, Sept 2018
# Danielle
# Code - along re: importing data, quality control

# ---- Load packages ----
library(lubridate)
library(tidyr)
library(dplyr)

# ---- Set Working Directory ----
# What folder (directory) do we want
# R to interact with?
# importing data, saving plots, etc.
setwd("C:/Users/Workshop/Desktop/miami-fieldschool")
list.files()

# ---- Import Data ----
# .txt file
# where is the file in relation to where we are now?
gapminder <- read.delim("data/gapminder.txt")

# ---- Data Frames ----
# 2 dimensional
# QAQC
class(gapminder)
View(gapminder)
str(gapminder)
glimpse(gapminder)
summary(gapminder)
head(gapminder)
tail(gapminder, n = 2)

gapminder[1, 4]  # row 1, column 4
gapminder[1, ] # row 1
gapminder[ , 2] # column 2

gapminder$continent

# Add a column of pop/lifeExp
gapminder$newcol <- gapminder$pop/gapminder$lifeExp
glimpse(gapminder)

# ---- Formatting Dates ----
# Step One: Import dataset (date_data.txt)
datedata <- read.delim("data/date_data.txt")
str(datedata)

# convert values to dates
class(ymd("2018-6-2"))

# goal: add a column to datedata containing
# formatted dates

datedata$date <- ymd(paste(datedata$year, datedata$month, datedata$day, 
      sep = "-"))
glimpse(datedata)

# Challenge:
# create a column called date time
# contain properlly formatted datetime ("POSIXct")
# hint: see ymd_hms()

# Extra challenge:
# build a function that prepares your data for
# ymd_hms()

# For each year:
for(i in unique(gapminder$year))
{
  # Do something:
  # For each continent this year:
  for(ii in unique(gapminder$continent))
  {
    # Do somthing:
    # print the year that was used (i)
    # print the continent that was used (ii)
    # find the average lifeExp
    print(mean(gapminder$lifeExp[gapminder$year == i & gapminder$continent == ii]))
  }
}

# ---- Day Two Setup ----
# load libraries
# set working directory
# import gapminder dataset

# ---- dplyr (tidyr) ----
# functions are verbs

# select() : selects columns
glimpse(gapminder)

head(select(gapminder, country, year, pop))
head(select(gapminder, -year, -pop))
head(select(gapminder, starts_with("c")))
# other select helpers: ends_with(), contains()

# only look at 1972
gapminder[gapminder$year == 1972,] # "base"
# filter(): choose what rows to look at
head(filter(gapminder, year == 1972))

head(filter(gapminder, year == 1972 &
         continent == "Europe"))

# pipes   %>%
# select year and continent
  ## filter year > 1990
subset1 <- select(gapminder, year, continent)
filter(subset1, year > 1990)

gapminder %>%
  select(year, continent) %>%
  filter(year > 1990)

# group_by(): groups by
# summarise(): summarises each group

# find the average lifeExp per year
gapminder %>%
  group_by(year) %>%
  summarise(mean(lifeExp))

# create a dataframe called table1
# average population by continent and year
# sd() population by continent and year
# only years < 2000

gapminder %>%
  filter(year < 2000) %>%
  group_by(continent, year) %>%
  summarise(averagepop = mean(pop),
            sdpop = sd(pop)) %>%
  filter(averagepop > 60000000)
  
# mutate(): create new columns based on old ones

# add a column in gapminder
  ## pop / lifeExp
gapminder <- gapminder %>% 
  mutate(newcol = pop/lifeExp)

glimpse(gapminder)

gapminder <- gapminder %>%
  mutate(newcol2 = pop/100000,
         newcol3 = round(lifeExp, 0))

glimpse(gapminder)


# ---- ggplot2 ----
library(ggplot2)

# colour based on continent
ggplot(gapminder) +
  geom_point(aes(x = year, y = lifeExp,
                 col = continent))

# colour = blue
ggplot(gapminder) +
  geom_point(aes(x = year, y = lifeExp),
             col = "blue")

# plot x = year, y = pop
# points
# colour by continent
# line for each country <<--

ggplot(gapminder) +
  geom_point(aes(x = year, y = pop, 
                 col = continent)) +
  geom_line(aes(x = year, y = pop, 
                col = continent,
                group = country))

ggplot(gapminder, aes(x= year, y = pop, 
                      col = continent)) +
  geom_point() +
  geom_line(aes(group = country))

# Change the axis labels
ggplot(gapminder, aes(x= year, y = pop, 
                      col = continent)) +
  geom_point() +
  geom_line(aes(group = country)) +
  ylab("Population") +
  xlab("Year") + # change the x axis label
  theme_bw(20) + # change the background
  facet_wrap(~continent, scales = "free")

# plots as objects
option1 <- ggplot(gapminder, aes(x= year, y = pop, 
                      col = continent)) +
  geom_point() +
  geom_line(aes(group = country)) +
  ylab("Population") +
  xlab("Year") + # change the x axis label
  theme_bw(20)
option1

option1 + 
  facet_wrap(~continent, scales = "free")

# continent on the x axis
# life expectancy on the y 
  ## axis
# only for 2007
# points (HINT: geom_jitter)
# boxplot
### HINT: order matters!
# visually pleasing :)
# colour based on gdp 
  ## per capita
# shape of the points are 
  ## triangles
### HINT: 17
# colour gradient where red
  ## is low & green is 
  ## high values
### HINT: scale_colour_gradient()

saveme <- ggplot(gapminder %>% filter(year == 2007),
       aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  geom_jitter(aes(col = gdpPercap), 
              shape = 17, width = 0.25) +
  ylab("Life Expectancy") +
  xlab("Continent") +
  theme_bw(18) +
  scale_colour_gradient(low = "red", high = "green",
                        name = "GDP per Capita")
ggsave(file = "myplot2.png", saveme)

# year vs pop
# continent europe

# option 1: create a subset
plotme <- gapminder %>% 
  filter(continent == "Europe")
ggplot(plotme)+
  geom_point(aes(x = year, y = pop))

# option 2: pipe into ggplot
gapminder %>% 
  filter(continent == "Europe") %>%
  ggplot()+
    geom_point(aes(x = year, y = pop))

# option 3: pipe inside ggplot
ggplot(gapminder %>% filter(continent == "Europe"))+
  geom_point(aes(x = year, y = pop))


# ---- Basic statistical tests ----
# in 2007 was there a difference between
# the pop of european countries and 
# african countries?

# x axis: continent
# y axis: lifeExp
# boxplot
# violin

ggplot(gapminder %>% 
         filter(year == 2007 &
                continent %in% c("Europe", "Africa", "Asia"))) +
  geom_boxplot(aes(x = continent, y = lifeExp))

eur <- gapminder %>% 
  filter(year == 2007 & continent == "Europe") %>%
  pull(lifeExp)

afr <- gapminder %>% 
  filter(year == 2007 & continent == "Africa") %>%
  pull(lifeExp)

asi <- gapminder %>% 
  filter(year == 2007 & continent == "Asia") %>%
  pull(lifeExp)

t.test(eur, afr) # parametric test (normal dist.)
wilcox.test(eur, afr) # non parametric test
# go back to this!
kruskal.test(gapminder$lifeExp, gapminder$continent)# non parametric test (> 2 groups)








