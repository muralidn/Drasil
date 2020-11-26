#include "Calculations.hpp"

#include <vector>

#include "ODE.hpp"
#include "Populate.hpp"
#include "boost/numeric/odeint/integrate/integrate_const.hpp"
#include "boost/numeric/odeint/stepper/generation.hpp"
#include "boost/numeric/odeint/stepper/runge_kutta_dopri5.hpp"

using std::vector;

vector<double> func_y_t(double r_t, double K_d, double t_sim, double A_tol, double R_tol, double t_step) {
    vector<double> y_t;
    ODE ode = ODE(K_d, K_d, r_t);
    vector<double> currVals{0.0};
    Populate pop = Populate(y_t);
    
    boost::numeric::odeint::runge_kutta_dopri5<vector<double>> rk = boost::numeric::odeint::runge_kutta_dopri5<vector<double>>();
    auto stepper = boost::numeric::odeint::make_controlled(A_tol, R_tol, rk);
    boost::numeric::odeint::integrate_const(stepper, ode, currVals, 0.0, t_sim, t_step, pop);
    
    return y_t;
}
