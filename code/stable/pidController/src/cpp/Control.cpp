/** \file Control.cpp
    \author Naveen Muralidharan
    \brief Controls the flow of the program
*/
#include <string>
#include <vector>

#include "Calculations.hpp"
#include "InputParameters.hpp"
#include "OutputFormat.hpp"

using std::string;
using std::vector;

/** \brief Controls the flow of the program
    \param argc Number of command-line arguments
    \param argv List of command-line arguments
    \return exit code
*/
int main(int argc, const char *argv[]) {
    string filename = argv[1];
    double r_t;
    double K_d;
    double t_step;
    double t_sim;
    double A_tol;
    double R_tol;
    get_input(filename, r_t, K_d, t_step, t_sim, A_tol, R_tol);
    input_constraints(r_t, K_d, t_step, t_sim);
    vector<double> y_t = func_y_t(r_t, K_d, t_sim, A_tol, R_tol, t_step);
    write_output(y_t);
    
    return 0;
}
