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
        private String name;

        Cat()
        {
            this.name = "未命名";
        }

        Cat(String name_of_cat)
        {
            this.name = name_of_cat;
        }

        public void shout()
        {
            Console.WriteLine(string.Format("我的名字叫{0},{1}", this.name, this.sound));
        }
        static void Main(string[] args)
        {
            Cat Test1 = new Cat("猫一");
            Test1.shout();
            Console.ReadLine();
        }
    }
}
