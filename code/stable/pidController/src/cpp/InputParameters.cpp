#include "InputParameters.hpp"

#include <algorithm>
#include <fstream>
#include <iostream>
#include <limits>
#include <string>

using std::ifstream;
using std::ofstream;
using std::string;

void get_input(string filename, double &r_t, double &K_d, double &K_p, double &t_step, double &t_sim) {
    ofstream outfile;
    outfile.open("log.txt", std::fstream::app);
    outfile << "function get_input called with inputs: {" << std::endl;
    outfile << "  filename = ";
    outfile << filename << std::endl;
    outfile << "  }" << std::endl;
    outfile.close();
    
    ifstream infile;
    infile.open(filename, std::fstream::in);
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    infile >> r_t;
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'r_t' assigned ";
    outfile << r_t;
    outfile << " in module InputParameters" << std::endl;
    outfile.close();
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    infile >> K_d;
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'K_d' assigned ";
    outfile << K_d;
    outfile << " in module InputParameters" << std::endl;
    outfile.close();
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    infile >> K_p;
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'K_p' assigned ";
    outfile << K_p;
    outfile << " in module InputParameters" << std::endl;
    outfile.close();
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    infile >> t_step;
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 't_step' assigned ";
    outfile << t_step;
    outfile << " in module InputParameters" << std::endl;
    outfile.close();
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    infile >> t_sim;
    infile.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 't_sim' assigned ";
    outfile << t_sim;
    outfile << " in module InputParameters" << std::endl;
    outfile.close();
    infile.close();
}

void input_constraints(double r_t, double K_d, double K_p, double t_step, double t_sim) {
    ofstream outfile;
    outfile.open("log.txt", std::fstream::app);
    outfile << "function input_constraints called with inputs: {" << std::endl;
    outfile << "  r_t = ";
    outfile << r_t;
    outfile << ", " << std::endl;
    outfile << "  K_d = ";
    outfile << K_d;
    outfile << ", " << std::endl;
    outfile << "  K_p = ";
    outfile << K_p;
    outfile << ", " << std::endl;
    outfile << "  t_step = ";
    outfile << t_step;
    outfile << ", " << std::endl;
    outfile << "  t_sim = ";
    outfile << t_sim << std::endl;
    outfile << "  }" << std::endl;
    outfile.close();
    
    if (!(r_t > 0)) {
        std::cout << "r_t has value ";
        std::cout << r_t;
        std::cout << ", but is expected to be ";
        std::cout << "above ";
        std::cout << 0;
        std::cout << "." << std::endl;
        throw("InputError");
    }
    if (!(K_d >= 0)) {
        std::cout << "K_d has value ";
        std::cout << K_d;
        std::cout << ", but is expected to be ";
        std::cout << "above ";
        std::cout << 0;
        std::cout << "." << std::endl;
        throw("InputError");
    }
    if (!(K_p > 0)) {
        std::cout << "K_p has value ";
        std::cout << K_p;
        std::cout << ", but is expected to be ";
        std::cout << "above ";
        std::cout << 0;
        std::cout << "." << std::endl;
        throw("InputError");
    }
    if (!(1.0 / 100.0 <= t_step && t_step < t_sim)) {
        std::cout << "t_step has value ";
        std::cout << t_step;
        std::cout << ", but is expected to be ";
        std::cout << "between ";
        std::cout << (1.0 / 100.0);
        std::cout << " ((1)/(100))";
        std::cout << " and ";
        std::cout << t_sim;
        std::cout << " (t_sim)";
        std::cout << "." << std::endl;
        throw("InputError");
    }
    if (!(1 <= t_sim && t_sim <= 60)) {
        std::cout << "t_sim has value ";
        std::cout << t_sim;
        std::cout << ", but is expected to be ";
        std::cout << "between ";
        std::cout << 1;
        std::cout << " and ";
        std::cout << 60;
        std::cout << "." << std::endl;
        throw("InputError");
    }
}
