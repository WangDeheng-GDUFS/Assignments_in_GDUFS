using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.Reflection; // 引入反射
using System.Configuration; // 导入配置

namespace ch4_2_2
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
            string ope_fac_name;


            input = Console.ReadLine();
            program.get_formula(input);
            ope_fac_name = ConfigurationManager.AppSettings[program.operator_of_formula];
            Fac = (OperatorFactory)Assembly.Load("ch4_2_2").CreateInstance("ch4_2_2." + ope_fac_name);
            operation = Fac.get_operation(program.operator_of_formula, program.num2);
            result = operation.calculate(program.num1, program.num2);
            Console.WriteLine("Result = " + result);
            Console.ReadLine();
        }
    }
}
