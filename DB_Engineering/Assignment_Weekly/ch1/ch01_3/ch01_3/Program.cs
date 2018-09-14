using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ch01_3
{
    class Program
    {
        static void Main(string[] args)
        {
            int i;
            int number = 0;
            int fir, sec, thi, fort;
            for (i = 4; i < 10; i++)
            {
                number = i * i;
                thi = number / 10;
                fort = number % 10;
                if (thi == fort)
                {
                    Console.WriteLine("The plate number of the cat is 00" + number);
                }
            }

            for (i = 32; i < 100; i++)
            {
                number = i * i;
                fir = number / 1000;
                sec = number % 1000 / 100;
                thi = number % 100 / 10;
                fort = number % 10;
                if (fir == sec && thi == fort)
                {
                    Console.WriteLine("The plate number of the cat is " + number);
                    break;
                }
            }
            Console.ReadLine();
        }
    }
}
