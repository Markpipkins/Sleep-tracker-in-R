load_Sleep_Data <- function() {
  # this makes sure the file exists before loading and returns NULL otherwise.
  if (!file.exists("sleep.csv")) {
    return(NULL)
  }

  data <- read.csv("sleep.csv")

  data
}
  data <- load_Sleep_Data()
  print(data)
