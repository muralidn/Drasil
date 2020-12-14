#include "Calculations.hpp"

#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "Constants.hpp"
#include "ODE.hpp"
#include "Populate.hpp"
#include "boost/numeric/odeint/integrate/integrate_const.hpp"
#include "boost/numeric/odeint/stepper/generation.hpp"
#include "boost/numeric/odeint/stepper/runge_kutta_dopri5.hpp"

using std::ofstream;
using std::string;
using std::vector;

vector<double> func_y_t(double r_t, double K_p, double K_d, double t_sim, double t_step) {
    ofstream outfile;
    outfile.open("log.txt", std::fstream::app);
    outfile << "function func_y_t called with inputs: {" << std::endl;
    outfile << "  r_t = ";
    outfile << r_t;
    outfile << ", " << std::endl;
    outfile << "  K_p = ";
    outfile << K_p;
    outfile << ", " << std::endl;
    outfile << "  K_d = ";
    outfile << K_d;
    outfile << ", " << std::endl;
    outfile << "  t_sim = ";
    outfile << t_sim;
    outfile << ", " << std::endl;
    outfile << "  t_step = ";
    outfile << t_step << std::endl;
    outfile << "  }" << std::endl;
    outfile.close();
    
    vector<double> y_t;
    ODE ode = ODE(K_p, K_d, r_t);
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'ode' assigned ";
    outfile << "Instance of ODE object";
    outfile << " in module Calculations" << std::endl;
    outfile.close();
    vector<double> currVals{0.0};
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'currVals' assigned ";
    outfile << "[";
    for (int list_i1 = 0; list_i1 < (int)(currVals.size()) - 1; list_i1++) {
        outfile << currVals.at(list_i1);
        outfile << ", ";
    }
    if ((int)(currVals.size()) > 0) {
        outfile << currVals.at((int)(currVals.size()) - 1);
    }
    outfile << "]";
    outfile << " in module Calculations" << std::endl;
    outfile.close();
    Populate pop = Populate(y_t);
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'pop' assigned ";
    outfile << "Instance of Populate object";
    outfile << " in module Calculations" << std::endl;
    outfile.close();
    
    boost::numeric::odeint::runge_kutta_dopri5<vector<double>> rk = boost::numeric::odeint::runge_kutta_dopri5<vector<double>>();
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'rk' assigned ";
    outfile << "Instance of boost::numeric::odeint::runge_kutta_dopri5<vector<double>> object";
    outfile << " in module Calculations" << std::endl;
    outfile.close();
    auto stepper = boost::numeric::odeint::make_controlled(Constants::AbsTol, Constants::RelTol, rk);
    outfile.open("log.txt", std::fstream::app);
    outfile << "var 'stepper' assigned ";
    outfile << "Instance of auto object";
    outfile << " in module Calculations" << std::endl;
    outfile.close();
    boost::numeric::odeint::integrate_const(stepper, ode, currVals, 0.0, t_sim, t_step, pop);
    
    return y_t;
}
