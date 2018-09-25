using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ch3_5
{
    public interface ICatch_mouse
    {
        void Catch_mouse();
    }
    abstract public class Animal
    {
        public string name;
        public string sound = "叫声为未定义";
        public readonly int MAX_SHOUT_TIMES = 10;
        public static int instance_num = 0;
        public int Shout_Times { get; set; } = 1;


        public Animal()
        {
            this.name = "未命名";
            count_instance();
        }

        public Animal(String name_of_animal)
        {
            this.name = name_of_animal;
            count_instance();
        }

        public Animal(String name_of_animal, String sound_of_animal)
        {
            this.name = name_of_animal;
            this.sound = sound_of_animal;
            count_instance();
        }

        public static void count_instance()
        {
            Animal.instance_num += 1;
        }

        public static int get_instance_num()
        {
            return Animal.instance_num;
        }

        virtual public void shout()
        {
            for (int i = 0; i < MAX_SHOUT_TIMES && i < Shout_Times; i++)
            {
                Console.WriteLine(string.Format("我的名字叫{0},{1}", this.name, this.get_shout()));
            }
        }

        abstract public string get_shout();

        static void Main(string[] args)
        {
            // 实现多态
            Animal cat1 = new Cat("猫一");
            Animal dog1 = new Dog("狗一");
            Animal cattle1 = new Cattle("牛一");
            Animal sheep1 = new Sheep("羊一");
            Cat cat2 = new Cat("猫二");

            cat1.shout();
            dog1.shout();
            cattle1.shout();
            sheep1.shout();
            cat2.Catch_mouse();
            Console.ReadLine();
        }
    }

    class Cat : Animal, ICatch_mouse
    {
        public Cat(String name_of_animal) : base(name_of_animal)
        {

        }

        override public string get_shout()
        {
            return "喵";
        }

        public void Catch_mouse()
        {
            Console.WriteLine("抓到一只老鼠");
        }
    }

    class Dog : Animal, ICatch_mouse
    {
        public Dog(String name_of_animal) : base(name_of_animal)
        {

        }

        override public string get_shout()
        {
            return "汪！汪！";
        }

        public void Catch_mouse()
        {
            Console.WriteLine("抓到一只老鼠");
        }
    }

    class Cattle : Animal
    {
        public Cattle(String name_of_animal) : base(name_of_animal)
        {

        }

        override public string get_shout()
        {
            return "哞~";
        }
    }

    class Sheep : Animal
    {
        public Sheep(String name_of_animal) : base(name_of_animal)
        {

        }

        override public string get_shout()
        {
            return "咩~";
        }
    }
}
