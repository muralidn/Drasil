/** \file Calculations.cs
    \author Naveen Muralidharan
    \brief Provides functions for calculating the outputs
*/
using System;
using System.Collections.Generic;
using Microsoft.Research.Oslo;

public class Calculations {
    
    /** \brief Calculates Process Variable: The output value from the power plant
        \param r_t Set-Point: The desired value that the control system must reach. This also knows as reference variable
        \param K_d Proportional Gain: Gain constant of the proportional controller
        \param t_sim Simulation time: Total execution time of the PD simulation (s)
        \param A_tol absolute tolerance
        \param R_tol relative tolerance
        \param t_step Step time: Simulation step time (s)
        \return Process Variable: The output value from the power plant
    */
    public static List<double> func_y_t(double r_t, double K_d, double t_sim, double A_tol, double R_tol, double t_step) {
        List<double> y_t;
        Func<double, Vector, Vector> f = (t, y_t_vec) => {
            return new Vector((r_t * K_d - (1 + K_d) * y_t_vec[0]) / (2 + K_d));
        };
        Options opts = new Options();
        opts.AbsoluteTolerance = A_tol;
        opts.RelativeTolerance = R_tol;
        
        Vector initv = new Vector(0.0);
        IEnumerable<SolPoint> sol = Ode.RK547M(0.0, initv, f, opts);
        IEnumerable<SolPoint> points = sol.SolveFromToStep(0.0, t_sim, t_step);
        y_t = new List<double> {};
        foreach (SolPoint sp in points) {
            y_t.Add(sp.X[0]);
        }
        
        return y_t;
    }
}
