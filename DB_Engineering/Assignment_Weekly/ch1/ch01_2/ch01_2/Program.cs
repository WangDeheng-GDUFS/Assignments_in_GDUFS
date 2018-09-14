using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ch01_2
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("请输入您的姓名：");
            String user_name = Console.ReadLine();
            Console.WriteLine("欢迎您，" + user_name);
            Console.ReadLine();
        }
    }
}
