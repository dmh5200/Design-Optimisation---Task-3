README
Optimiser Master
Overview
optimiser_master.m is a MATLAB script designed to perform multi-objective optimization for wind turbine arrays. The script uses a genetic algorithm to optimize the positions, radii, and heights of wind turbines to achieve a balance between cost and power output. The results are visualized through various plots, including Pareto fronts and wind turbine array representations.

Features
Multi-objective optimization using a genetic algorithm (gamultiobj).
Visualization of Pareto fronts.
Representation of wind turbine arrays for different quartiles of the Pareto front.
Convergence plots to show the optimization process.
Scatter plots and box plots to analyze the distribution of input variables.
Requirements
MATLAB with Optimization Toolbox.
MATLAB with Parallel Computing Toolbox (optional for parallel execution).
Usage
Define Inputs: The script requires the following inputs:

z_norm: Normalized decision variables.
fval: Objective function values.
lb_orig: Original lower bounds for the decision variables.
ub_orig: Original upper bounds for the decision variables.
Run the Script: Execute optimiser_master.m in MATLAB.

View Results: The script generates various plots to visualize the optimization results.

Functions
optimiser_master.m
This is the main script that performs the optimization and generates the plots.

Key Sections
Input Normalization: Normalize the decision variables.
Genetic Algorithm Setup: Configure and run the genetic algorithm.
Result Extraction: Extract and sort the Pareto front solutions.
Plotting: Generate various plots to visualize the results.
plots.m
This script contains functions to generate different plots for visualizing the optimization results.

draw_wind_turbine_array.m
This function draws a representation of wind turbine arrays for the lower quartile, median, and upper quartile of the Pareto front.

Usage
