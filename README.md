# Application of Mathematical Modeling in Student Fatigue-Recovery Analysis

## Overview 
This project examines the student fatigue and recovery using Structural Equation Modeling (SEM) and a time-based mathematical model, based on survey data collected from 274 BS Mathematics students at the College of Science, Bulacan State University.

## Project Structure 
- `data/` - contains the dataset used (`student_fatigue_dataset.xlsx`)
- `docs/` - contains the written paper (PDF), LaTex file, and references
- `src/` - contains the codes used for analysis (MATLAB and R)

## Methods Used 
- Mean computation using R
- Structural Equation Modeling (SEM) to determine parameter values used in the model
- Time-based fatigue modeling using MATLAB

## Methodology 
Structural Equation Modeling (SEM) was used to analyze the relationships between variables affecting student fatigue. The resulting parameter values from SEM were then incorporated into the model (`fatigueovertime.m`) to simulate fatigue trends over time.


### How to Run
1. Open the dataset in the `data/` folder
2. Run `mean_computation.R` to compute average values.
3. Run `fatigueovertime.m` in MATLAB to model fatigue over time.

## Outputs
- Final Paper: `docs/Group1_FCO.pdf`
- Video Presentation: https://drive.google.com/file/d/1bC9skQmil6cCUlnJt9KUvVxR2bpZ4jf9/view?usp=sharing
  
