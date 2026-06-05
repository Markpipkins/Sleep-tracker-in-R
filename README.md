# Sleep-tracker-in-R
An R application designed to easily log sleep entries and track your sleep. Features built in data visualization to assist in analyzing sleep sessions and identify trends over time.  Made with no/minimal AI.

To use:
1. Start interactive mode in R.

2. Run the basic_program.R with: source("basic_program.R")

3. Select an option from the menu by typing the corresponding number and pressinng 'Enter', then follow onscreen prompts: 
  1. Add new sleep entry.  (Adds a new entry into sleep log, will create a file named "sleep.csv" if first entry)
  
  2. Look at sleep data.   (Graphs sleep entries if they exist and throws error if they don't.)
                           (Shows 2 graphs: hours slept per entry over time and quality of sleep per hours slept)
                           
  3. Quit.                 (Exits the program.)
