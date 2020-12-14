#include "ODE.hpp"

#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using std::ofstream;
using std::string;
using std::vector;

ODE::ODE(double K_p, double K_d, double r_t) : K_p(K_p), K_d(K_d), r_t(r_t) {
    ofstream outfile;
    outfile.open("log.txt", std::fstream::app);
    outfile << "function ODE called with inputs: {" << std::endl;
    outfile << "  K_p = ";
    outfile << K_p;
    outfile << ", " << std::endl;
    outfile << "  K_d = ";
    outfile << K_d;
    outfile << ", " << std::endl;
    outfile << "  r_t = ";
    outfile << r_t << std::endl;
    outfile << "  }" << std::endl;
    outfile.close();
}

void ODE::operator()(vector<double> y_t, vector<double> &dy_t, double t) {
    ofstream outfile;
    outfile.open("log.txt", std::fstream::app);
    outfile << "function operator() called with inputs: {" << std::endl;
    outfile << "  y_t = ";
    outfile << "[";
    for (int list_i1 = 0; list_i1 < (int)(y_t.size()) - 1; list_i1++) {
        outfile << y_t.at(list_i1);
        outfile << ", ";
    }
    if ((int)(y_t.size()) > 0) {
        outfile << y_t.at((int)(y_t.size()) - 1);
    }
    outfile << "]";
    outfile << ", " << std::endl;
    outfile << "  dy_t = ";
    outfile << "[";
    for (int list_i1 = 0; list_i1 < (int)(dy_t.size()) - 1; list_i1++) {
        outfile << dy_t.at(list_i1);
        outfile << ", ";
    }
    if ((int)(dy_t.size()) > 0) {
        outfile << dy_t.at((int)(dy_t.size()) - 1);
    }
    outfile << "]";
    outfile << ", " << std::endl;
    outfile << "  t = ";
    outfile << t << std::endl;
    outfile << "  }" << std::endl;
    outfile.close();
    
    dy_t.at(0) = (r_t * K_p - (1 + K_p) * y_t.at(0)) / (2 + K_d);
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'dy_t[0]' assigned ";
    outfile << dy_t[0];
    outfile << " in module ODE" << std::endl;
    outfile.close();
}
