#include <algorithm>
#include <iostream>
#include <fstream>
#include <iterator>
#include <string>
#include <math.h>
#include <sstream>
#include <limits>
#include <vector>

using std::string;
using std::vector;
using std::ifstream;
using std::ofstream;

#include "InputFormat.hpp"
#include "InputParameters.hpp"
#include "OutputFormat.hpp"

int main(int argc, const char *argv[]) {
    string inputfile = argv[1];
    double A_C = 0.0;
    double C_W = 0.0;
    double h_C = 0.0;
    double T_init = 0.0;
    double t_final = 0.0;
    double L = 0.0;
    double T_C = 0.0;
    double t_step = 0.0;
    double rho_W = 0.0;
    double D = 0.0;
    double A_tol = 0.0;
    double R_tol = 0.0;
    double T_W = 0.0;
    double E_W = 0.0;
    func_get_input(inputfile, A_C, C_W, h_C, T_init, t_final, L, T_C, t_step, rho_W, D, A_tol, R_tol, T_W, E_W);
    input_constraints(A_C, C_W, h_C, T_init, t_final, L, T_C, t_step, rho_W, D, T_W, E_W);
    write_output(T_W, E_W);
    return 0;
}
