#include "Populate.hpp"

#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using std::ofstream;
using std::string;
using std::vector;

Populate::Populate(vector<double> &y_t) : y_t(y_t) {
    ofstream outfile;
    outfile.open("log.txt", std::fstream::app);
    outfile << "function Populate called with inputs: {" << std::endl;
    outfile << "  y_t = ";
    outfile << "[";
    for (int list_i1 = 0; list_i1 < (int)(y_t.size()) - 1; list_i1++) {
        outfile << y_t.at(list_i1);
        outfile << ", ";
    }
    if ((int)(y_t.size()) > 0) {
        outfile << y_t.at((int)(y_t.size()) - 1);
    }
    outfile << "]" << std::endl;
    outfile << "  }" << std::endl;
    outfile.close();
}

void Populate::operator()(vector<double> &y, double t) {
    ofstream outfile;
    outfile.open("log.txt", std::fstream::app);
    outfile << "function operator() called with inputs: {" << std::endl;
    outfile << "  y = ";
    outfile << "[";
    for (int list_i1 = 0; list_i1 < (int)(y.size()) - 1; list_i1++) {
        outfile << y.at(list_i1);
        outfile << ", ";
    }
    if ((int)(y.size()) > 0) {
        outfile << y.at((int)(y.size()) - 1);
    }
    outfile << "]";
    outfile << ", " << std::endl;
    outfile << "  t = ";
    outfile << t << std::endl;
    outfile << "  }" << std::endl;
    outfile.close();
    
    y_t.push_back(y.at(0));
}
