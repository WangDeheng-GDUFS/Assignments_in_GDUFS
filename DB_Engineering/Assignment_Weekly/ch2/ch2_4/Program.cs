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
        private int MAX_SHOUT_TIMES = 10;
        private int shout_times = 1;
        public int Shout_Times
        {
            get
            {
                return shout_times;
            }
            set
            {
                shout_times = value;
            }
        }


        Cat()
        {
            this.name = "未命名";
        }

        Cat(String name_of_cat)
        {
            this.name = name_of_cat;
        }

        Cat(String name_of_cat, String sound_of_cat)
        {
            this.name = name_of_cat;
            this.sound = sound_of_cat;
        }

        public void shout()
        {
            for(int i = 0; i < MAX_SHOUT_TIMES && i < shout_times; i ++)
            {
                Console.WriteLine(string.Format("我的名字叫{0},{1}", this.name, this.sound));
            }
        }

        static void Main(string[] args)
        {
            Cat Test1 = new Cat("猫三");
            Test1.shout_times = 3;
            Test1.shout();

            Console.WriteLine();
            Console.WriteLine();
            Console.WriteLine();

            Cat Test2 = new Cat("猫四");
            Test2.shout_times = 233;
            Test2.shout();
            Console.ReadLine();
        }
    }
}
