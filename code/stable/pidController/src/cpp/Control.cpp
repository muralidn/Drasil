/** \file Control.cpp
    \author Naveen Ganesh Muralidharan
    \brief Controls the flow of the program
*/
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "Calculations.hpp"
#include "InputParameters.hpp"
#include "OutputFormat.hpp"

using std::ofstream;
using std::string;
using std::vector;

/** \brief Controls the flow of the program
    \param argc Number of command-line arguments
    \param argv List of command-line arguments
    \return exit code
*/
int main(int argc, const char *argv[]) {
    ofstream outfile;
    string filename = argv[1];
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'filename' assigned ";
    outfile << filename;
    outfile << " in module Control" << std::endl;
    outfile.close();
    double r_t;
    double K_d;
    double K_p;
    double t_step;
    double t_sim;
    get_input(filename, r_t, K_d, K_p, t_step, t_sim);
    input_constraints(r_t, K_d, K_p, t_step, t_sim);
    vector<double> y_t = func_y_t(r_t, K_p, K_d, t_sim, t_step);
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'y_t' assigned ";
    outfile << "[";
    for (int list_i1 = 0; list_i1 < (int)(y_t.size()) - 1; list_i1++) {
        outfile << y_t.at(list_i1);
        outfile << ", ";
    }
    if ((int)(y_t.size()) > 0) {
        outfile << y_t.at((int)(y_t.size()) - 1);
    }
    outfile << "]";
    outfile << " in module Control" << std::endl;
    outfile.close();
    write_output(y_t);
    
    return 0;
}
