using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace ch4
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

    class OperatorFactory
    {
        public static Calculator select_operation(string operator_of_formula, double num2)
        {
            Calculator operation = null;
            switch (operator_of_formula)
            {
                case "+":
                    operation = new Add();
                    break;
                case "-":
                    operation = new Sub();
                    break;
                case "*":
                    operation = new Mul();
                    break;
                case "/":
                    if (num2 == 0)
                    {
                        Console.WriteLine("divide zero error");
                        return null;
                    }
                    operation = new Div();
                    break;
                default:
                    Console.WriteLine("Operator error");
                    return null;
            }
            return operation;
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

            input = Console.ReadLine();
            program.get_formula(input);
            operation = OperatorFactory.select_operation(program.operator_of_formula, program.num2);
            result = operation.calculate(program.num1, program.num2);
            Console.WriteLine("Result = " + result);
            Console.ReadLine();
        }
    }
}
