using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ch2
{
    class Cat
    {
        private String sound = "喵";

        public void shout()
        {
            Console.WriteLine(this.sound);
        }
        static void Main(string[] args)
        {
            Cat Test1 = new Cat();
            Test1.shout();
            Console.ReadLine();
        }
    }
}
