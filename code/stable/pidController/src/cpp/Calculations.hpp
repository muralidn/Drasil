/** \file Calculations.hpp
    \author Naveen Muralidharan
    \brief Provides functions for calculating the outputs
*/
#ifndef Calculations_h
#define Calculations_h

#include <vector>

#include "ODE.hpp"
#include "Populate.hpp"

using std::vector;

/** \brief Calculates Process Variable: The output value from the power plant
    \param r_t Set-Point: The desired value that the control system must reach. This also knows as reference variable
    \param K_d Proportional Gain: Gain constant of the proportional controller
    \param t_sim Simulation time: Total execution time of the PD simulation (s)
    \param A_tol absolute tolerance
    \param R_tol relative tolerance
    \param t_step Step time: Simulation step time (s)
    \return Process Variable: The output value from the power plant
*/
vector<double> func_y_t(double r_t, double K_d, double t_sim, double A_tol, double R_tol, double t_step);

#endif
