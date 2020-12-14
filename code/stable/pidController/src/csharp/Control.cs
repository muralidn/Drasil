/** \file Control.cs
    \author Naveen Ganesh Muralidharan
    \brief Controls the flow of the program
*/
using System;
using System.Collections.Generic;
using System.IO;

public class Control {
    
    /** \brief Controls the flow of the program
        \param args List of command-line arguments
    */
    public static void Main(string[] args) {
        StreamWriter outfile;
        string filename = args[0];
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'filename' assigned ");
        outfile.Write(filename);
        outfile.WriteLine(" in module Control");
        outfile.Close();
        double r_t;
        double K_d;
        double K_p;
        double t_step;
        double t_sim;
        InputParameters.get_input(filename, out r_t, out K_d, out K_p, out t_step, out t_sim);
        InputParameters.input_constraints(r_t, K_d, K_p, t_step, t_sim);
        List<double> y_t = Calculations.func_y_t(r_t, K_p, K_d, t_sim, t_step);
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
        outfile.WriteLine(" in module Control");
        outfile.Close();
        OutputFormat.write_output(y_t);
    }
}
