## \file InputParameters.py
# \author Naveen Muralidharan
# \brief Provides the function for reading inputs and the function for checking the physical constraints on the input
## \brief Reads input from a file with the given file name
# \param filename name of the input file
# \return Set-Point: The desired value that the control system must reach. This also knows as reference variable
# \return Proportional Gain: Gain constant of the proportional controller
# \return Step time: Simulation step time (s)
# \return Simulation time: Total execution time of the PD simulation (s)
# \return absolute tolerance
# \return relative tolerance
def get_input(filename):
    infile = open(filename, "r")
    infile.readline()
    r_t = float(infile.readline())
    infile.readline()
    K_d = float(infile.readline())
    infile.readline()
    K_p = float(infile.readline())
    infile.readline()
    t_step = float(infile.readline())
    infile.readline()
    t_sim = float(infile.readline())
    infile.readline()
    A_tol = float(infile.readline())
    infile.readline()
    R_tol = float(infile.readline())
    infile.close()
    
    return r_t, K_d, t_step, t_sim, A_tol, R_tol

## \brief Verifies that input values satisfy the physical constraints
# \param r_t Set-Point: The desired value that the control system must reach. This also knows as reference variable
# \param K_d Proportional Gain: Gain constant of the proportional controller
# \param t_step Step time: Simulation step time (s)
# \param t_sim Simulation time: Total execution time of the PD simulation (s)
def input_constraints(r_t, K_d, t_step, t_sim):
    if (not(r_t > 0)) :
        print("Warning: ", end="")
        print("r_t has value ", end="")
        print(r_t, end="")
        print(", but is suggested to be ", end="")
        print("above ", end="")
        print(0, end="")
        print(".")
    if (not(K_d > 0)) :
        print("Warning: ", end="")
        print("K_d has value ", end="")
        print(K_d, end="")
        print(", but is suggested to be ", end="")
        print("above ", end="")
        print(0, end="")
        print(".")
    if (not(1.0 / 100.0 <= t_step and t_step <= 1)) :
        print("Warning: ", end="")
        print("t_step has value ", end="")
        print(t_step, end="")
        print(", but is suggested to be ", end="")
        print("between ", end="")
        print(1.0 / 100.0, end="")
        print(" ((1)/(100))", end="")
        print(" and ", end="")
        print(1, end="")
        print(".")
    if (not(1 <= t_sim and t_sim <= 60)) :
        print("Warning: ", end="")
        print("t_sim has value ", end="")
        print(t_sim, end="")
        print(", but is suggested to be ", end="")
        print("between ", end="")
        print(1, end="")
        print(" and ", end="")
        print(60, end="")
        print(".")
