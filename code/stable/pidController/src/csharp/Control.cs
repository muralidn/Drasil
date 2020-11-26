/** \file Control.cs
    \author Naveen Muralidharan
    \brief Controls the flow of the program
*/
using System.Collections.Generic;

public class Control {
    
    /** \brief Controls the flow of the program
        \param args List of command-line arguments
    */
    public static void Main(string[] args) {
        string filename = args[0];
        double r_t;
        double K_d;
        double t_step;
        double t_sim;
        double A_tol;
        double R_tol;
        InputParameters.get_input(filename, out r_t, out K_d, out t_step, out t_sim, out A_tol, out R_tol);
        InputParameters.input_constraints(r_t, K_d, t_step, t_sim);
        List<double> y_t = Calculations.func_y_t(r_t, K_d, t_sim, A_tol, R_tol, t_step);
        OutputFormat.write_output(y_t);
    }
}
