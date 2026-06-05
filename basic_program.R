# This R program tracks my sleep and presents the data to analyze my sleep habits.
# It asks me the time I go to bed, the time I wake up, the quality of my sleep, and the date.
# The program then uses this data to analyze my sleep habits and presents the data to me in 2 graphs.
# This program must be run in interactive mode with the command: source("basic_program.R")

library(tidyr)
library(dplyr)

# This function loads the file containing the data about sleep.
# The sleep.csv file will have four columns: sleep, wake, quality, and date.
# Each row will be an entry for a period of sleep and the date will track the
# day that I went to sleep, not when I woke up.
load_Sleep_Data <- function() {
  # this makes sure the file exists before loading and returns NULL otherwise.
  if (!file.exists("sleep.csv")) {
    print("NO SLEEP FILE YET")
    return(NULL)
  }

  data <- read.csv("sleep.csv")

  return(data)
}

# This function takes a df that it assumes has been formatted correctly
# and adds it to the sleep.csv as a row.
add_Sleep_Entry <- function(sleep_entry) {
  # this makes sure the file exists before loading and creates the file otherwise.
  if (!file.exists("sleep.csv")) {
    header_boolean <- TRUE
  } else {
    header_boolean <- FALSE
  }

  # this appends to the sleep.csv file a new sleep entry
  write.table(
    sleep_entry,
    file = "sleep.csv",
    sep = ",",
    append = TRUE,
    col.names = header_boolean,
    row.names = FALSE,
    quote = FALSE
  )

  # default return value to make the compiler happy
  TRUE
}

# This function takes 5 numbers as the info needed for a sleep entry as input and
# outputs a properly formatted dataframe containing that info.
# 1. sleepTime and must be a number from 0 to 2359 in the format HHMM for 24 hour time with the last 2 digits being a number from 0 to 59
# 2. wakeTime also must be a number from 0 to 2359 in the format HHMM for 24 hour time with the last 2 digits being a number from 0 to 59
# 3. quality must be a number from 0 to 10
# 4. date must be an eight digit number in the format "YYYYMMDD" with no punctuation
# 5. hours_slept must be a number and is calculated before being passed from the user_input function
create_Sleep_Entry <- function(sleepTime, wakeTime, quality, date, hours_slept) {
  sleepTime <- as.numeric(sleepTime)
  wakeTime <- as.numeric(wakeTime)
  quality <- as.numeric(quality)
  hours_slept <- as.numeric(hours_slept)
  date <- as.Date(date, format = "%Y-%m-%d")

  # valuecheck <- c(sleepTime, wakeTime, quality, date, hours_slept)
  # typesofthings <- sapply(valuecheck, typeof)
  # print(typesofthings)
  # print(hours_slept)

  new_Entry <- data.frame(
    sleep = sleepTime,
    wake = wakeTime,
    quality = quality,
    date = date,
    hours_slept = hours_slept
  )

  new_Entry
}

# this was all inside the above function until I realized it wouldn't work here...
# # this confirms the correct variable input type for all inputs
# if (!is.double("sleepTime") || !is.double("wakeTime") || !is.double("quality") || !is.double("date")) {
#   print("INVALID INPUT: All input must be numbers.")
#   return(NULL)
# }

# # this normalizes the input and prevents second accuracy in results as it
# # is not needed and introduces errors.
# sleepTime <- floor(sleepTime)
# wakeTime <- floor(wakeTime)
# date <- floor(date)

# # this is used to make sure the last 2 digits in sleepTime and wakeTime are from 00 to 59.
# sleepMinutes <- sleepTime %% 100
# wakeMinutes <- wakeTime %% 100

# # checks sleepTime for valid number
# if (sleepTime < 0 || sleepTime > 2359 || sleepMinutes > 59 || sleepMinutes < 0) {
#   print("INVALID sleep time entered.  Format time as 4 digit number of 24 hour time such as: '0905' for 9:05 AM or '1738' for 5:38 PM.")
#   print("The last 2 digits must be from 00 to 59.")
#   return(NULL)
# }

# # checks wakeTime for valid number
# if (wakeTime < 0 || wakeTime > 2359 || wakeMinutes > 59 || wakeMinutes < 0) {
#   print("INVALID wake time entered.  Format time as 4 digit number of 24 hour time such as: '0905' for 9:05 AM or '1738' for 5:38 PM")
#   print("The last 2 digits must be from 00 to 59.")
#   return(NULL)
# }

# # checks quality for valid number
# if (quality < 0 || quality > 10) {
#   print("INVALID quality entered.  Enter number from 1 to 10")
#   return(NULL)
# }

# # checks date for valid number, does not support dates before 2026/01/01 or after 9999/12/31.
# if (date < 20260101 || date > 99991231) {
#   print("INVALID date entered.  Format date as 8 digit number in format YYYYMMDD such as: '20261009' for October 9th 2026 or '20300301' for March 1st 2030.")
#   print("Only dates AFTER January 1st 2026 and BEFORE December 31 9999 are permitted.")
#   return(NULL)
# }

# print("sleeptime:")
# print(sleepTime)
# print("is.na(sleepTime)):")
# print(is.na(sleepTime))
# print("as.double(sleepTime):")
# print(as.double(sleepTime))
# print("is.na(as.double(sleepTime)):")
# print(is.na(as.double(sleepTime)))
# print("waketime:")
# print(wakeTime)
# print("is.na(wakeTime):")
# print(is.na(wakeTime))
# print("as.double(wakeTime):")
# print(as.double(wakeTime))
# print("is.na(as.double(waketime)):")
# print(is.na(as.double(wakeTime)))
# these are leftover from trying to figure out where the NA was crashing the program


# these functions check the different inputs from the user to make sure they are formatted correctly
check_Time <- function(sleepTime = -1, wakeTime = -1) {
  if (is.na(as.double(sleepTime)) || is.na(as.double(wakeTime))) {
    print("")
    print("")
    print("INVALID TIME: TRY AGAIN.")
    print("")
    print("Examples: 7:31 AM = '735', 12:19 AM = '19', 8:56 PM = '2056'")
    print("")
    return(FALSE)
  } else {
    print("")
  }

  # if one number is passed, it is sleepTime
  # but if two are passed, it is wakeTime and will need to be checked to make sure it is past the sleep time
  if (sleepTime != -1 && wakeTime == -1) {
    sleepTime <- as.double(sleepTime)
    # this normalizes the input and prevents second accuracy in results as it
    # is not needed and introduces errors.
    sleepTime <- floor(sleepTime)

    # this is used to make sure the last 2 digits in sleepTime are from 00 to 59.
    sleepMinutes <- sleepTime %% 100

    # checks sleepTime for valid number
    if (sleepTime < 0 || sleepTime > 2359 || sleepMinutes > 59 || sleepMinutes < 0) {
      print("INVALID sleep time entered.  Format time as 24 hour time such as: '905' for 9:05 AM or '1738' for 5:38 PM.")
      print("The last 2 digits must be from 00 to 59.")
      Sys.sleep(2)

      return(FALSE)
    }
    return(TRUE)
  } else if (sleepTime == -1 && wakeTime != -1) {
    wakeTime <- as.double(wakeTime)

    # this normalizes the input and prevents second accuracy in results as it
    # is not needed and introduces errors.
    wakeTime <- floor(wakeTime)

    # this is used to make sure the last 2 digits in wakeTime are from 00 to 59.
    wakeMinutes <- wakeTime %% 100

    # checks wakeTime for valid number
    if (wakeTime < 0 || wakeTime > 2359 || wakeMinutes > 59 || wakeMinutes < 0) {
      print("INVALID wake time entered.  Format time as 24 hour time such as: '905' for 9:05 AM or '1738' for 5:38 PM")
      print("The last 2 digits must be from 00 to 59.")
      Sys.sleep(2)

      return(FALSE)
    }

    return(TRUE)
  } else {
    print("WRONG TIME PARAMETERS")
    Sys.sleep(2)

    return(FALSE)
  }
}

# checks quality for valid number
check_Quality <- function(quality = NULL) {
  if (is.na(as.double(quality))) {
    print("")
    print("")
    print("INVALID QUALITY: TRY AGAIN.")
    print("")
    print("Examples: Best sleep of your life = '10', Worst sleep of your life = '0'")
    print("")
    return(FALSE)
  }

  if (!is.null(quality)) {
    numberQuality <- as.double(quality)

    if (numberQuality < 0 || numberQuality > 10) {
      print("")
      print("INVALID quality entered.  Enter number from 0 to 10")
      print("")
      Sys.sleep(2)
      return(FALSE)
    }
    return(TRUE)
  } else {
    print("")
    print("I need a number you silly goose.")
    print("")
    Sys.sleep(2)

    return(FALSE)
  }
}

# checks date for valid number, does not support dates before 2026/01/01 or after 9999/12/31.
check_Date <- function(dateGiven = NULL) {
  if (is.na(as.double(dateGiven))) {
    print("")
    print("")
    print("INVALID DATE: TRY AGAIN.")
    print("")
    print("Examples: July 4th 2026 AD = '20260704', November 23st 2029 AD = '20291123, January 2nd 4535 AD = 45350102")
    print("")
    return(FALSE)
  }

  if (!is.null(dateGiven)) {
    numberDate <- as.double(dateGiven)

    if (is.na(as.Date(numberDate))) {
      print("INVALID date entered.  Format date as 8 digit number in format YYYYMMDD such as: '20261009' for October 9th 2026 or '20300301' for March 1st 2030.")
      print("Only dates AFTER January 1st 2026 and BEFORE December 31 9999 are permitted.")
    }


    if (numberDate < 20260101 || numberDate > 99991231) {
      print("INVALID date entered.  Format date as 8 digit number in format YYYYMMDD such as: '20261009' for October 9th 2026 or '20300301' for March 1st 2030.")
      print("Only dates AFTER January 1st 2026 and BEFORE December 31 9999 are permitted.")
      Sys.sleep(2)
      return(FALSE)
    }
    return(TRUE)
  } else {
    print("")
    print("I need a date you stinker.")
    print("")
    Sys.sleep(2)
    return(FALSE)
  }
}

# This displays 2 graphs in a 2x1 grid:
# 1. line graph of hours of sleep per entry over time
# 2. scatter plot of correlation between sleep quality and hours slept
display_Sleep_Data <- function() {
  # loads the data first
  data <- load_Sleep_Data()
  if (is.null(data)) {
    print("NO DATA")
    stop("NO DATA: check the file or add data.")
  }
  # else {
  #   print("FOUND IT")
  # }

  data$date <- as.Date(trimws(data$date), format = "%Y-%m-%d")
  data$hours_slept <- as.numeric(data$hours_slept)
  # print(data)
  # print(str(data))

  # sets the 2x2 grid
  par(mfrow = c(2, 1))

  plot(x = data$date, y = data$hours_slept, type = "l", lwd = 3, ann = TRUE, ylim = c(0, 12), col = "blue", xlab = "Date", ylab = "Hours Slept", main = "Hours slept on each night")
  plot(data$quality, data$hours_slept, pch = 23, lwd = 1, col = "black", bg = "cyan", cex = 1, xlim = c(0, 10), ylim = c(0, 12), xlab = "Sleep Quality", ylab = "Hours Slept", main = "Correlation between hours slept and sleep quality")

  # reverts the grid
  par(mfrow = c(1, 1))
}

# this is the function that will take in the user input
user_input <- function() {
  # this will stop the function from contnuing if the input is not correct
  proceed <- FALSE

  # this is a continuous loop that checks the users input and will ask again if given invalid input
  # this is repeated for all the user inputs
  while (!proceed) {
    print("What time did you go to sleep?  Enter time in 'HHMM' format, for example: 6:15AM = 615 and 2:45PM = 1445")
    userSleep <- as.character(readline(prompt = "I went to sleep at: "))

    if (!check_Time(userSleep)) {
      print("Try again...")
      print("")
      print("")
      Sys.sleep(2)
    } else {
      # this breaks the loop to continue
      proceed <- TRUE
    }
  }
  # this saves value in a dedicated variable and resets the loop boolean for the user input
  var1 <- userSleep
  proceed <- FALSE

  if (as.numeric(userSleep) > 2215 || as.numeric(userSleep) < 1200) {
    print("")
    Sys.sleep(1)
    print(paste(userSleep, "huh?"))
    print("")
    Sys.sleep(1)
    print("You need to get to bed earlier...")
    print("")
    Sys.sleep(2)
  } else {
    print("")
    print(paste0(userSleep, "... Alright."))
    Sys.sleep(1.5)
  }
  print(".")
  print(".")
  print(".")

  while (!proceed) {
    print("What time did you wake up?  Enter time in 'HHMM' format, for example: 6:15AM = 615 and 2:45PM = 1445")
    userWake <- as.character(readline(prompt = "I woke up at: "))

    if (!check_Time(, userWake)) {
      print("Try again...")
      print("")
      print("")
      Sys.sleep(2)
    } else {
      proceed <- TRUE
    }
  }
  var2 <- userWake
  proceed <- FALSE

  if (as.numeric(userWake) > 700) {
    print("")
    Sys.sleep(1)
    print(paste0(userWake, "?"))
    print("")
    Sys.sleep(1)
    print("You need a better alarm clock...")
    print("")
    Sys.sleep(2)
  } else {
    print("")
    print(paste0(userWake, "... Ok."))
    Sys.sleep(1.5)
  }
  print(".")
  print(".")
  print(".")

  while (!proceed) {
    print("How would you rate the quality of your sleep on a scale from 0 to 10? (0 is worst, 10 is best)")
    userQuality <- as.character(readline(prompt = "I would rate my sleep: "))

    if (!check_Quality(userQuality)) {
      print("Try again...")
      print("")
      print("")
      Sys.sleep(2)
    } else {
      proceed <- TRUE
    }
  }
  var3 <- userQuality
  proceed <- FALSE

  print("")
  print(paste0(userQuality, " out of 10..."))
  print(".")
  print(".")
  print(".")
  Sys.sleep(1.5)

  while (!proceed) {
    print("What is todays date in the format YYYYMMDD?  (For example: October 13th 2026 = 20261013)")
    userDate <- as.character(readline(prompt = "Today's date is: "))

    if (!check_Date(userDate)) {
      print("Try again...")
      print("")
      print("")
      Sys.sleep(2)
    } else {
      proceed <- TRUE
    }
  }
  var4 <- as.Date(as.character(userDate), format = "%Y%m%d")
  proceed <- FALSE

  print("")
  print(paste0("It's ", as.Date(as.character(userDate), format = "%Y%m%d", "...")))
  print(".")
  print(".")
  print(".")
  Sys.sleep(1.5)

  # these are calculations to transform the base 60 time given by the user into
  # a decimal amount of hours for calculation, before switching back
  number_wake <- as.numeric(var2)
  number_sleep <- as.numeric(var1)

  wake_minutes <- (number_wake %% 100)
  sleep_minutes <- (number_sleep %% 100)

  number_wake <- ((number_wake - wake_minutes) + (wake_minutes / 0.6))
  number_sleep <- ((number_sleep - sleep_minutes) + (sleep_minutes / 0.6))

  # print(paste0("normalized wake: ", number_wake))
  # print("")
  # print(paste0("normalized sleep: ", number_sleep))
  # print("")
  # print("")
  # Sys.sleep(3)

  # this calculates the total time slept using the times given by the user
  if (number_wake > number_sleep) {
    hours_slept <- (number_wake - number_sleep)
  } else if (number_wake < number_sleep) {
    hours_slept <- ((2400 - number_sleep) + number_wake)
  } else {
    hours_slept <- 0
  }
  # print("")
  # print(paste("Hours slept", hours_slept))
  # print("")
  # print("")

  minutes_slept <- ceiling(((hours_slept %% 100) * 0.6))

  # print(paste("minutes slept", minutes_slept))
  # print("")
  # print("")

  # this is the final amount of time slept during the last sleep period in the "HHMM" format
  time_slept <- ((hours_slept - (hours_slept %% 100)) + minutes_slept)

  # print(paste("time slept", time_slept))
  # print("")
  # Sys.sleep(5)

  print("")
  print(paste0("You slept for ", ((hours_slept - (hours_slept %% 100)) / 100), " hours and ", minutes_slept, " minutes on ", as.Date(as.character(userDate), format = "%Y%m%d")))
  Sys.sleep(1)
  print("")
  print("Noted.")
  Sys.sleep(1.7)

  # gives the data to create_Sleep_Entry to make a df
  sleep_entry <- create_Sleep_Entry(var1, var2, var3, var4, (time_slept / 100))

  # returns the df
  sleep_entry
}

# the main function that calls the other functions and handles control flow
main_Function <- function() {
  loop <- TRUE

  while (loop) {
    print("")
    print("")
    print("")
    print("What would you like to do?")
    print("   1. Add new sleep entry.")
    print("   2. Look at sleep data.")
    print("   3. Quit.")
    print("")
    Sys.sleep(1)
    choice <- 0
    rawUserInput <- NULL
    rawUserInput <- as.numeric(readline(prompt = "Press 1, 2, or 3 and hit enter: "))
    print("")
    print("")
    print("")

    if (is.null(rawUserInput) || is.na(rawUserInput)) {
      print("")
      print("")
      Sys.sleep(0.4)
    } else {
      choice <- rawUserInput
    }

    if (choice == 1) {
      new_sleep_entry <- user_input()
      if (isFALSE(add_Sleep_Entry(new_sleep_entry))) {
        print("ADDING SLEEP ENTRY FAILED")
      }
    } else if (choice == 2) {
      display_Sleep_Data()
      loop <- FALSE
    } else if (choice == 3) {
      print("Bye Bye.")
      print("")
      Sys.sleep(1)
      loop <- FALSE
    } else {
      print("I need 1, 2, or 3 honey...")
      print("")
      Sys.sleep(1)
      print("Try again.")
      print("")
      Sys.sleep(2)
    }
  }
}

# this calls the main function only if the program is run interactive mode
if (interactive()) {
  main_Function()
}

# I tried using this to test the functions but found out that inputing numbers
# with leading zeros will break R
# day1 <- create_Sleep_Entry(2201 0630 6 20260528)
# day2 <- create_Sleep_Entry(2355, 0740, 3, 20260529)
# day3 <- create_Sleep_Entry(2122, 0600, 6.7, 20260530)
# day4 <- create_Sleep_Entry(0138, 0912, 6, 20260601)

# add_Sleep_Entry(day1)
# add_Sleep_Entry(day2)
# add_Sleep_Entry(day3)
# add_Sleep_Entry(day4)

# display_Sleep_Data()
