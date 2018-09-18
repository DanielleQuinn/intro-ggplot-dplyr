# ---- R is a Calculator ----
# This is a comment
5 + 5 # This is a comment too
5 + 5 / 7 * 4

# ---- Functions ----
# Find the square root of 81
sqrt(81)
sqrt("a")

# You can nest functions
sqrt(sqrt(81))

# Help!
?min

min(c(2, 3, 4))
max(c(2, 5, NA, 9), na.rm = TRUE)


# ---- Packages ----
# User-built functions to do things!
# First Time: Install
install.packages("ggplot2") # this won't run w/o internet

# Every Time: Load / Access
library(ggplot2)

# ---- Objects ----
# Objects are containers
# They hold things
# They have names
x <- 13
x # look inside
# SCALAR: 1 dimension and length of 1
y <- x + 16

sqrt(y)

z <- 18

# ---- Vectors ----
# 1 dimensional
# length > 1 (multiple elements)
nums <- 1:10
length(x) # one element, scalar
length(nums) # ten elements, vector
# vectors are atomic
# they can only contain one "class" of data
test <- c(4, 7, 2, 5, 9)
class(test)
test2 <- c("a", "b", "c")
class(test2)
test3 <- c("a", 15, 8, "h")
test3
class(test3)
as.character(test)
as.numeric(test3)

test + 100

# Challenge
# create a scalar object with your name
# create a vector object with your d m y of birth
# create a vector that has both

name <- "Danielle"
birthday <- c(17, 1, 1988)
both <- c(name, birthday)

# ---- Conditional Operators ----
# ask questions
odds <- seq(from = 1, to = 50, by = 2)
odds

# are values greater than 15?
odds > 15 # greater than
odds < 15 # less than
odds <= 15
odds > 12 & odds < 15 # AND; both conditions are TRUE
odds > 18 | odds < 5 # OR; either condition is TRUE
odds == 5 # is it equal to __ ?
# One = assigns
# Two == asks a question
answers <- odds %in% c(5, 11, 17) # does it equal any of these?
class(answers)

# ---- Indexing ----
# [] refers to indexing
odds[19] # 19 is our index

which(odds > 15) # produces a vector

odds[which(odds > 15)] # shows us values > 15
odds[odds > 15] # does the same thing

# find odds greater than or equal to 17 
  # OR equal to 5
mean(odds[odds >= 17 | odds == 5])

# find the average of your results

colours <- c("red","blue","green", 'orange')
colours[colours %in% c("blue","red")]

# ---- Functions ----
# build a function called add3
# take a value and add 3
add3 <- function(a = 5, b = 10) {
  return(a + b)
}

add3(a = 90, b = 95)
add3(a = 100)

# name <- function(argument) {
#   do this to argument}

# example: choose random x letters
# of your name

# example: convert USD to CAD

# example: calculate how many
# years between x and y

# extra challenge: add an optional
# argument with a default value

# tell me the shark species
# based on a number
# >15 : tiger
# <15: bull

sharks <- function(a) {
  if(a >= 15) return("tiger") else return("bull")
}

sharks(15)

# ---- Looping ----
# for each value in a vector
# add 4 and print the result
myvals <- seq(from = 1, to = 50, length = 3)
myvals

myvals + 4

for(i in myvals) {
  # do something
  print(paste("Current number is", i))
  print(i + 4)
}



