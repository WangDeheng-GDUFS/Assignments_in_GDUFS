using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ch3
{
    class Dog
    {
        private String sound = "汪！汪！";
        private String name;
        private int MAX_SHOUT_TIMES = 10;
        private static int instance_num = 0;
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


        Dog()
        {
            this.name = "未命名";
            count_instance();
        }

        Dog(String name_of_dog)
        {
            this.name = name_of_dog;
            count_instance();
        }

        Dog(String name_of_dog, String sound_of_dog)
        {
            this.name = name_of_dog;
            this.sound = sound_of_dog;
            count_instance();
        }

        private static void count_instance()
        {
            Dog.instance_num += 1;
        }

        public static int get_instance_num()
        {
            return Dog.instance_num;
        }

        public void shout()
        {
            for (int i = 0; i < MAX_SHOUT_TIMES && i < shout_times; i++)
            {
                Console.WriteLine(string.Format("我的名字叫{0},{1}", this.name, this.sound));
            }
        }

        static void Main(string[] args)
        {
            Dog Test1 = new Dog("狗三");
            Test1.shout_times = 3;
            Test1.shout();

            Console.WriteLine();
            Console.WriteLine();
            Console.WriteLine();

            Dog Test2 = new Dog("狗四");
            Test2.shout_times = 233;
            Test2.shout();
            int num = Dog.get_instance_num();
            Console.WriteLine(string.Format("现在有{0}个Dog对象", num));

            Dog Test3 = new Dog();
            Dog Test4 = new Dog();
            num = Dog.get_instance_num();
            Console.WriteLine(string.Format("现在有{0}个Dog对象", num));

            Console.ReadLine();
        }
    }
}
