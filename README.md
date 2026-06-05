# Sleep Tracker in R

An R application for logging sleep sessions, storing entries in a local CSV file, and visualizing sleep trends over time.

This project allows a user to:

- Add new sleep entries
- Store sleep session data in `sleep.csv`
- View saved sleep data with generated built-in visualizations.
- Use visulizations for sleep analysis
- Identify trends in hours slept and sleep quality

## Project Status

This is a simple interactive R program built for local use.

Development note: written with little to no AI assistance.

## Files

| File                | Purpose                                      |
| ------------------- | -------------------------------------------- |
| `basic_program.R` | Main R script for running the sleep tracker  |
| `sleep.csv`       | Sleep log file created after the first entry |
| `README.md`       | Project documentation                        |
| `LICENSE`         | Project license                              |

## Requirements

- R installed on your computer
- A terminal or R console
- The project files saved in the same directory

## How to Use

### 1. Start R interactive mode

Open R from your terminal, R console, or VS Code.

### 2. Run the program

From inside the project folder, run:

`source("basic_program.R")`

### 3. Select a menu option

The program will display a menu. Type the number for the option you want, then press `Enter`.

## Menu Options

### 1. Add New Sleep Entry

Adds a new sleep session to the sleep log.

If `sleep.csv` does not already exist, the program creates it automatically.

### 2. Look at Sleep Data

Displays stored sleep data and generates graphs if entries exist.

The visualizations show:

- Hours slept per entry over time
- Sleep quality compared with hours slept

If no sleep entries exist, the program will show an error instead.

### 3. Quit

Exits the program.

## Data Storage

Sleep entries are stored locally in:

`sleep.csv`

This file is created automatically after the first sleep entry.

## Purpose

The purpose of this project is to practice R programming while creating a useful tool for tracking sleep habits and reviewing trends over time.

## Example Graphs



<pre class="overflow-visible! px-0!" data-start="1313" data-end="1467"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="relative"><div class=""><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼs ͼ16"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span>![Example graphs of hours slept over time and sleep quality compared with hours slept](Images/sleep-graphs.png)</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>
