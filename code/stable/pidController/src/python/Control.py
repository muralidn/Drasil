## \file Control.py
# \author Naveen Muralidharan
# \brief Controls the flow of the program
import sys

import Calculations
import InputParameters
import OutputFormat

filename = sys.argv[1]
r_t, K_d, t_step, t_sim, A_tol, R_tol = InputParameters.get_input(filename)
InputParameters.input_constraints(r_t, K_d, t_step, t_sim)
y_t = Calculations.func_y_t(r_t, K_d, t_sim, A_tol, R_tol, t_step)
OutputFormat.write_output(y_t)
