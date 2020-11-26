/** \file InputParameters.cs
    \author Naveen Muralidharan
    \brief Provides the function for reading inputs and the function for checking the physical constraints on the input
*/
using System;
using System.IO;

public class InputParameters {
    
    /** \brief Reads input from a file with the given file name
        \param filename name of the input file
        \param r_t Set-Point: The desired value that the control system must reach. This also knows as reference variable
        \param K_d Proportional Gain: Gain constant of the proportional controller
        \param t_step Step time: Simulation step time (s)
        \param t_sim Simulation time: Total execution time of the PD simulation (s)
        \param A_tol absolute tolerance
        \param R_tol relative tolerance
    */
    public static void get_input(string filename, out double r_t, out double K_d, out double t_step, out double t_sim, out double A_tol, out double R_tol) {
        StreamReader infile;
        infile = new StreamReader(filename);
        infile.ReadLine();
        r_t = Double.Parse(infile.ReadLine());
        infile.ReadLine();
        K_d = Double.Parse(infile.ReadLine());
        infile.ReadLine();
        K_p = Double.Parse(infile.ReadLine());
        infile.ReadLine();
        t_step = Double.Parse(infile.ReadLine());
        infile.ReadLine();
        t_sim = Double.Parse(infile.ReadLine());
        infile.ReadLine();
        A_tol = Double.Parse(infile.ReadLine());
        infile.ReadLine();
        R_tol = Double.Parse(infile.ReadLine());
        infile.Close();
    }
    
    /** \brief Verifies that input values satisfy the physical constraints
        \param r_t Set-Point: The desired value that the control system must reach. This also knows as reference variable
        \param K_d Proportional Gain: Gain constant of the proportional controller
        \param t_step Step time: Simulation step time (s)
        \param t_sim Simulation time: Total execution time of the PD simulation (s)
    */
    public static void input_constraints(double r_t, double K_d, double t_step, double t_sim) {
        if (!(r_t > 0)) {
            Console.Write("Warning: ");
            Console.Write("r_t has value ");
            Console.Write(r_t);
            Console.Write(", but is suggested to be ");
            Console.Write("above ");
            Console.Write(0);
            Console.WriteLine(".");
        }
        if (!(K_d > 0)) {
            Console.Write("Warning: ");
            Console.Write("K_d has value ");
            Console.Write(K_d);
            Console.Write(", but is suggested to be ");
            Console.Write("above ");
            Console.Write(0);
            Console.WriteLine(".");
        }
        if (!(1.0 / 100.0 <= t_step && t_step <= 1)) {
            Console.Write("Warning: ");
            Console.Write("t_step has value ");
            Console.Write(t_step);
            Console.Write(", but is suggested to be ");
            Console.Write("between ");
            Console.Write(1.0 / 100.0);
            Console.Write(" ((1)/(100))");
            Console.Write(" and ");
            Console.Write(1);
            Console.WriteLine(".");
        }
        if (!(1 <= t_sim && t_sim <= 60)) {
            Console.Write("Warning: ");
            Console.Write("t_sim has value ");
            Console.Write(t_sim);
            Console.Write(", but is suggested to be ");
            Console.Write("between ");
            Console.Write(1);
            Console.Write(" and ");
            Console.Write(60);
            Console.WriteLine(".");
        }
    }
}
