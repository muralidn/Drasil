/** \file OutputFormat.cs
    \author Naveen Ganesh Muralidharan
    \brief Provides the function for writing outputs
*/
using System;
using System.Collections.Generic;
using System.IO;

public class OutputFormat {
    
    /** \brief Writes the output values to output.txt
        \param y_t Process Variable: The output value from the power plant
    */
    public static void write_output(List<double> y_t) {
        StreamWriter outfile;
        outfile = new StreamWriter("log.txt", true);
        outfile.WriteLine("function write_output called with inputs: {");
        outfile.Write("  y_t = ");
        outfile.Write("[");
        for (int list_i1 = 0; list_i1 < y_t.Count - 1; list_i1++) {
            outfile.Write(y_t[list_i1]);
            outfile.Write(", ");
        }
        if (y_t.Count > 0) {
            outfile.Write(y_t[y_t.Count - 1]);
        }
        outfile.WriteLine("]");
        outfile.WriteLine("  }");
        outfile.Close();
        
        StreamWriter outputfile;
        outputfile = new StreamWriter("output.txt", false);
        outputfile.Write("y_t = ");
        outputfile.Write("[");
        for (int list_i1 = 0; list_i1 < y_t.Count - 1; list_i1++) {
            outputfile.Write(y_t[list_i1]);
            outputfile.Write(", ");
        }
        if (y_t.Count > 0) {
            outputfile.Write(y_t[y_t.Count - 1]);
        }
        outputfile.WriteLine("]");
        outputfile.Close();
    }
}
