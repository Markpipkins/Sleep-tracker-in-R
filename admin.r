# # %%
# x <- floor(rnorm(10000, 500, 100))
# y <- table(x)
# barplot(y)

# # %%
# print("Hello world")
# print("Hello again")

# %%
y <- 1:50
sample(y)
# %%
square <- function(x) x * x
print(square(5))
# %%

x <- c("Bob", "Sue", "John")
result <- "Bob" %in% x
print(result)
# %%

RSiteSearch("vector")
# %%
help.search("vector")
?matrix()
# %%

days <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
austin_high_temps <- c(62, 65, 72, 80, 87, 92, 96, 97, 91, 82, 71, 63)
austin_low_temps <- c(42, 45, 51, 59, 67, 72, 74, 75, 69, 61, 51, 42)
chicago_high_temps <- c(32, 36, 46, 59, 70, 81, 84, 82, 75, 63, 48, 36)
chicago_low_temps <- c(18, 21, 30, 41, 52, 63, 68, 66, 57, 46, 34, 23)

hdd_year <- function(high_temps, low_temps, days) {
  average_temps <- (high_temps + low_temps) / 2
  hdms <- 65 - average_temps
  hdms[hdms < 0] <- 0
  sum(hdms * days)
}

cdd_year <- function(high_temps, low_temps, days) {
  average_temps <- (high_temps + low_temps) / 2
  cdms <- average_temps - 65
  cdms[cdms < 0] <- 0
  sum(cdms * days)
}

austin_total <- 0.85 * cdd_year(austin_high_temps, austin_low_temps, days)
+0.20 * hdd_year(austin_high_temps, austin_low_temps, days)

chicago_total <- 0.85 * cdd_year(chicago_high_temps, chicago_low_temps, days)
+0.20 * hdd_year(chicago_high_temps, chicago_low_temps, days)

#If you were asking for one statement for both together,
#I would put these results in a list and name them

cost_dd_year <- function(high_temps, low_temps, hdd_cost, cdd_cost, days) {
  cdd_total <- cdd_year(high_temps, low_temps, days)
  hdd_total <- hdd_year(high_temps, low_temps, days)
  cdd_total * cdd_cost + hdd_total * hdd_cost
}

austin_cost <- cost_dd_year(
  austin_high_temps,
  austin_low_temps,
  0.20,
  0.85,
  days
)
chicago_cost <- cost_dd_year(
  chicago_high_temps,
  chicago_low_temps,
  0.20,
  0.85,
  days
)

austin_cost
chicago_cost

hdd_year(austin_high_temps, austin_low_temps, days)
cost_dd_year(austin_high_temps, austin_low_temps, 0.20, 0.85, days)

# %%

m <- matrix(c(10,20,30,40,50,60), nrow=2, ncol=3)

print(m)

# for (val in m) {
#   for (val2 in val) {
#     sum <- sum + val2
#   }
# }

# %%

v <- c(1:100)
v

w <- seq(0, 100, by = 5)
w

x <- c(v, w)
x

processStudents <- function(names, scores) {
  for (i in seq_along(names)) {
    printData(names[i], scores[i])
  }
}

# %%
library(tidyr)

wide <- data.frame(
  gym = c("Downtown", "Uptown", "Suburb"),
  Jan = c(1200, 900, 600),
  Feb = c(1300, 950, 650),
  Mar = c(1400, 1000, 700),
  Apr = c(1500, 1050, 750)
)

wide

long <- pivot_longer(
  wide,
  cols = 2:5,
  names_to = "month",
  values_to = "attendance"
)

long

# %%

students <- data.frame(
  student_id = c(101, 102, 103),
  math_midterm = c(78, 85, 90),
  math_final   = c(82, 88, 94),
  eng_midterm  = c(75, 80, 85),
  eng_final    = c(79, 83, 88)
)
students

long_students <- reshape(
  students,
  varying = c(
    "math_midterm", "math_final",
    "eng_midterm", "eng_final"
  ),
  v.names = "score",
  timevar = "exam",
  idvar = "student_id",
  direction = "long"
)
long_students

library(tidyr)

long_students <- pivot_longer(
  students,
  cols = c(math_midterm, math_final, eng_midterm, eng_final),
  names_to = "exam",
  values_to = "score"
)
long_students

# %%

sales <- data.frame(
  company = c("A", "B", "C"),
  Q1_US = c(100, 120, 140),
  Q2_US = c(110, 130, 150),
  Q3_US = c(115, 135, 155),
  Q4_US = c(120, 140, 160),
  Q1_EU = c(90, 100, 110),
  Q2_EU = c(95, 105, 115),
  Q3_EU = c(98, 108, 118),
  Q4_EU = c(102, 112, 122)
)
sales

long_sales <- reshape(
  sales,
  varying = c(
    "Q1_US","Q2_US","Q3_US","Q4_US",
    "Q1_EU","Q2_EU","Q3_EU","Q4_EU"
  ),
  v.names = "sales_amount",
  timevar = "period",
  idvar = "company",
  direction = "long"
)
long_sales

library(tidyr)

long_sales <- pivot_longer(
  sales,
  cols = c(Q1_US, Q2_US, Q3_US, Q4_US, Q1_EU, Q2_EU, Q3_EU, Q4_EU),
  names_to = "period",
  values_to = "sales_amount"
)
long_sales

library(tidyr)

long_sales2 <- pivot_longer(
  sales,
  cols = c(Q1_US, Q2_US, Q3_US, Q4_US, Q1_EU, Q2_EU, Q3_EU, Q4_EU),
  names_to = c("quarter", "region"),
  names_sep = "_",
  values_to = "sales_amount"
)
long_sales2


# %%
library(stringr)

paste(c('a','b'),1:10,sep = '_',collapse = ' and ')
paste0('df',1:6)
str_pad('pear', 1)

# %%


df <- data.frame(A=c(10, 2, NA, NA, NA, NA),
                 B=c(1, 45, NA, NA, NA, NA),
                 C=c(1, 45, NA, NA, NA, NA),
                 D=c(1, 45, NA, NA, NA, NA),
                 E=c(1, 1, NA, NA, NA, NA))
df

complete.cases(df)

df <- df[complete.cases(df), ]
df

df <- transform(df, A = -A)
df

# %%
library(dplyr)

# Creating dataframe aq
aq <- data.frame(
  Ozone   = c(41, 36, 12, 18),
  Solar.R = c(190, 118, 149, 313),
  Wind    = c(7.4, 8.0, 12.6, 11.5),
  Temp    = c(67, 72, 74, 62),
  Month   = c(5, 5, 5, 5),
  Day     = c(1, 2, 3, 4)
)

nums <- seq(length.out = 10)
nums
# %%
str(aq)
summary(aq)

stolen_bases <- strsplit('Ricky.Henderson.1406, R', '.', TRUE)
stolen_bases
# %%
# Printing aq 1st time
aq

# Transforming Solar.R without assigning or saving
transform(aq,Solar.R=-Solar.R)
# According to the exam, Solar.R should be
# saved as a negative value in the same column

# Printing aq 2nd time
aq

# Transforming Solar.R and assigning back to aq
aq=transform(aq,Solar.R=-Solar.R)

# Printing aq 3rd time
aq

# %%

batter <- 'Hanry Arron .305'
batter
batter <- strsplit(batter, ",")
batter
typeof(batter)

# pattern <- "Ar"
grep(batter, pattern)

# %%
print(100074 %% 100)

# %%