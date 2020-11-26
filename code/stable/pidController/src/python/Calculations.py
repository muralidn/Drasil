## \file Calculations.py
# \author Naveen Muralidharan
# \brief Provides functions for calculating the outputs
import scipy.integrate

## \brief Calculates Process Variable: The output value from the power plant
# \param r_t Set-Point: The desired value that the control system must reach. This also knows as reference variable
# \param K_d Proportional Gain: Gain constant of the proportional controller
# \param t_sim Simulation time: Total execution time of the PD simulation (s)
# \param A_tol absolute tolerance
# \param R_tol relative tolerance
# \param t_step Step time: Simulation step time (s)
# \return Process Variable: The output value from the power plant
def func_y_t(r_t, K_d, t_sim, A_tol, R_tol, t_step):
    def f(t, y_t):
        return [(r_t * K_d - (1 + K_d) * y_t[0]) / (2 + K_d)]
    
    r = scipy.integrate.ode(f)
    r.set_integrator("dopri5", atol=A_tol, rtol=R_tol)
    r.set_initial_value(0.0, 0.0)
    y_t = [0.0]
    while r.successful() and r.t < t_sim:
        r.integrate(r.t + t_step)
        y_t.append(r.y[0])
    
    return y_t
