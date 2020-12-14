/** \file Calculations.cs
    \author Naveen Ganesh Muralidharan
    \brief Provides functions for calculating the outputs
*/
using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.Research.Oslo;

public class Calculations {
    
    /** \brief Calculates Process Variable: The output value from the power plant
        \param r_t Set-Point: The desired value that the control system must reach. This also knows as the reference variable
        \param K_p Proportional Gain: Gain constant of the proportional controller
        \param K_d Derivative Gain: Gain constant of the derivative controller
        \param t_sim Simulation Time: Total execution time of the PD simulation (s)
        \param t_step Step Time: Simulation step time (s)
        \return Process Variable: The output value from the power plant
    */
    public static List<double> func_y_t(double r_t, double K_p, double K_d, double t_sim, double t_step) {
        StreamWriter outfile;
        outfile = new StreamWriter("log.txt", true);
        outfile.WriteLine("function func_y_t called with inputs: {");
        outfile.Write("  r_t = ");
        outfile.Write(r_t);
        outfile.WriteLine(", ");
        outfile.Write("  K_p = ");
        outfile.Write(K_p);
        outfile.WriteLine(", ");
        outfile.Write("  K_d = ");
        outfile.Write(K_d);
        outfile.WriteLine(", ");
        outfile.Write("  t_sim = ");
        outfile.Write(t_sim);
        outfile.WriteLine(", ");
        outfile.Write("  t_step = ");
        outfile.WriteLine(t_step);
        outfile.WriteLine("  }");
        outfile.Close();
        
        List<double> y_t;
        Func<double, Vector, Vector> f = (t, y_t_vec) => {
            return new Vector((r_t * K_p - (1 + K_p) * y_t_vec[0]) / (2 + K_d));
        };
        Options opts = new Options();
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'opts' assigned ");
        outfile.Write("Instance of Options object");
        outfile.WriteLine(" in module Calculations");
        outfile.Close();
        opts.AbsoluteTolerance = Constants.AbsTol;
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'opts.AbsoluteTolerance' assigned ");
        outfile.Write(opts.AbsoluteTolerance);
        outfile.WriteLine(" in module Calculations");
        outfile.Close();
        opts.RelativeTolerance = Constants.RelTol;
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'opts.RelativeTolerance' assigned ");
        outfile.Write(opts.RelativeTolerance);
        outfile.WriteLine(" in module Calculations");
        outfile.Close();
        
        Vector initv = new Vector(0.0);
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'initv' assigned ");
        outfile.Write("Instance of Vector object");
        outfile.WriteLine(" in module Calculations");
        outfile.Close();
        IEnumerable<SolPoint> sol = Ode.RK547M(0.0, initv, f, opts);
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'sol' assigned ");
        outfile.Write("Instance of IEnumerable<SolPoint> object");
        outfile.WriteLine(" in module Calculations");
        outfile.Close();
        IEnumerable<SolPoint> points = sol.SolveFromToStep(0.0, t_sim, t_step);
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'points' assigned ");
        outfile.Write("Instance of IEnumerable<SolPoint> object");
        outfile.WriteLine(" in module Calculations");
        outfile.Close();
        y_t = new List<double> {};
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'y_t' assigned ");
        outfile.Write("[");
        for (int list_i1 = 0; list_i1 < y_t.Count - 1; list_i1++) {
            outfile.Write(y_t[list_i1]);
            outfile.Write(", ");
        }
        if (y_t.Count > 0) {
            outfile.Write(y_t[y_t.Count - 1]);
        }
        outfile.Write("]");
        outfile.WriteLine(" in module Calculations");
        outfile.Close();
        foreach (SolPoint sp in points) {
            y_t.Add(sp.X[0]);
        }
        
        return y_t;
    }
}
