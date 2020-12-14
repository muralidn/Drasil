/** \file InputParameters.cs
    \author Naveen Ganesh Muralidharan
    \brief Provides the function for reading inputs and the function for checking the physical constraints on the input
*/
using System;
using System.IO;

public class InputParameters {
    
    /** \brief Reads input from a file with the given file name
        \param filename name of the input file
        \param r_t Set-Point: The desired value that the control system must reach. This also knows as the reference variable
        \param K_d Derivative Gain: Gain constant of the derivative controller
        \param K_p Proportional Gain: Gain constant of the proportional controller
        \param t_step Step Time: Simulation step time (s)
        \param t_sim Simulation Time: Total execution time of the PD simulation (s)
    */
    public static void get_input(string filename, out double r_t, out double K_d, out double K_p, out double t_step, out double t_sim) {
        StreamWriter outfile;
        outfile = new StreamWriter("log.txt", true);
        outfile.WriteLine("function get_input called with inputs: {");
        outfile.Write("  filename = ");
        outfile.WriteLine(filename);
        outfile.WriteLine("  }");
        outfile.Close();
        
        StreamReader infile;
        infile = new StreamReader(filename);
        infile.ReadLine();
        r_t = Double.Parse(infile.ReadLine());
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'r_t' assigned ");
        outfile.Write(r_t);
        outfile.WriteLine(" in module InputParameters");
        outfile.Close();
        infile.ReadLine();
        K_d = Double.Parse(infile.ReadLine());
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'K_d' assigned ");
        outfile.Write(K_d);
        outfile.WriteLine(" in module InputParameters");
        outfile.Close();
        infile.ReadLine();
        K_p = Double.Parse(infile.ReadLine());
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 'K_p' assigned ");
        outfile.Write(K_p);
        outfile.WriteLine(" in module InputParameters");
        outfile.Close();
        infile.ReadLine();
        t_step = Double.Parse(infile.ReadLine());
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 't_step' assigned ");
        outfile.Write(t_step);
        outfile.WriteLine(" in module InputParameters");
        outfile.Close();
        infile.ReadLine();
        t_sim = Double.Parse(infile.ReadLine());
        outfile = new StreamWriter("log.txt", true);
        outfile.Write("var 't_sim' assigned ");
        outfile.Write(t_sim);
        outfile.WriteLine(" in module InputParameters");
        outfile.Close();
        infile.Close();
    }
    
    /** \brief Verifies that input values satisfy the physical constraints
        \param r_t Set-Point: The desired value that the control system must reach. This also knows as the reference variable
        \param K_d Derivative Gain: Gain constant of the derivative controller
        \param K_p Proportional Gain: Gain constant of the proportional controller
        \param t_step Step Time: Simulation step time (s)
        \param t_sim Simulation Time: Total execution time of the PD simulation (s)
    */
    public static void input_constraints(double r_t, double K_d, double K_p, double t_step, double t_sim) {
        StreamWriter outfile;
        outfile = new StreamWriter("log.txt", true);
        outfile.WriteLine("function input_constraints called with inputs: {");
        outfile.Write("  r_t = ");
        outfile.Write(r_t);
        outfile.WriteLine(", ");
        outfile.Write("  K_d = ");
        outfile.Write(K_d);
        outfile.WriteLine(", ");
        outfile.Write("  K_p = ");
        outfile.Write(K_p);
        outfile.WriteLine(", ");
        outfile.Write("  t_step = ");
        outfile.Write(t_step);
        outfile.WriteLine(", ");
        outfile.Write("  t_sim = ");
        outfile.WriteLine(t_sim);
        outfile.WriteLine("  }");
        outfile.Close();
        
        if (!(r_t > 0)) {
            Console.Write("r_t has value ");
            Console.Write(r_t);
            Console.Write(", but is expected to be ");
            Console.Write("above ");
            Console.Write(0);
            Console.WriteLine(".");
            throw new Exception("InputError");
        }
        if (!(K_d >= 0)) {
            Console.Write("K_d has value ");
            Console.Write(K_d);
            Console.Write(", but is expected to be ");
            Console.Write("above ");
            Console.Write(0);
            Console.WriteLine(".");
            throw new Exception("InputError");
        }
        if (!(K_p > 0)) {
            Console.Write("K_p has value ");
            Console.Write(K_p);
            Console.Write(", but is expected to be ");
            Console.Write("above ");
            Console.Write(0);
            Console.WriteLine(".");
            throw new Exception("InputError");
        }
        if (!(1.0 / 100.0 <= t_step && t_step < t_sim)) {
            Console.Write("t_step has value ");
            Console.Write(t_step);
            Console.Write(", but is expected to be ");
            Console.Write("between ");
            Console.Write(1.0 / 100.0);
            Console.Write(" ((1)/(100))");
            Console.Write(" and ");
            Console.Write(t_sim);
            Console.Write(" (t_sim)");
            Console.WriteLine(".");
            throw new Exception("InputError");
        }
        if (!(1 <= t_sim && t_sim <= 60)) {
            Console.Write("t_sim has value ");
            Console.Write(t_sim);
            Console.Write(", but is expected to be ");
            Console.Write("between ");
            Console.Write(1);
            Console.Write(" and ");
            Console.Write(60);
            Console.WriteLine(".");
            throw new Exception("InputError");
        }
    }
}
