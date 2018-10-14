using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace ch4_2
{
    class Calculator
    {
        virtual public double calculate(double num1, double num2)
        {
            return 0;
        }
    }

    class Add : Calculator
    {
        public override double calculate(double num1, double num2)
        {
            return num1 + num2;
        }
    }

    class Sub : Calculator
    {
        public override double calculate(double num1, double num2)
        {
            return num1 - num2;
        }
    }

    class Mul : Calculator
    {
        public override double calculate(double num1, double num2)
        {
            return num1 * num2;
        }
    }

    class Div : Calculator
    {
        public override double calculate(double num1, double num2)
        {
            return num1 / num2;
        }
    }

    abstract class OperatorFactory
    {
        public abstract Calculator get_operation(string operator_of_formula, double num2);
    }

    class AddFac : OperatorFactory
    {
        public override Calculator get_operation(string operator_of_formula, double num2)
        {
            return new Add();
        }
    }

    class SubFac : OperatorFactory
    {
        public override Calculator get_operation(string operator_of_formula, double num2)
        {
            return new Sub();
        }
    }

    class MulFac : OperatorFactory
    {
        public override Calculator get_operation(string operator_of_formula, double num2)
        {
            return new Mul();
        }
    }

    class DivFac : OperatorFactory
    {
        public override Calculator get_operation(string operator_of_formula, double num2)
        {
            return new Div();
        }
    }

    class Program
    {
        private double num1, num2;
        private string operator_of_formula;

        public void get_formula(string input)
        {
            string[] c_array = Regex.Split(input, " ");
            num1 = Convert.ToDouble(c_array[0]);
            num2 = Convert.ToDouble(c_array[2]);
            operator_of_formula = c_array[1];
        }
        static void Main(string[] args)
        {
            string input;
            double result;
            Program program = new Program();
            Calculator operation;
            OperatorFactory Fac;

            input = Console.ReadLine();
            program.get_formula(input);
            switch (program.operator_of_formula)
            {
                case "+":
                    Fac = new AddFac();
                    break;
                case "-":
                    Fac = new AddFac();
                    break;
                case "*":
                    Fac = new AddFac();
                    break;
                case "/":
                    Fac = new AddFac();
                    break;
                default:
                    Fac = null;
                    break;
            }
            operation = Fac.get_operation(program.operator_of_formula, program.num2);
            result = operation.calculate(program.num1, program.num2);
            Console.WriteLine("Result = " + result);
            Console.ReadLine();
        }
    }
}
