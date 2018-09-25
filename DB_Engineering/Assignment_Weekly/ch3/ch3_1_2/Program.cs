using System;

namespace ch3_2
{
    public class Animal
    {
        private string name;
        private string sound = "叫声为未定义";
        private readonly int MAX_SHOUT_TIMES = 10;
        private static int instance_num = 0;
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

        public void shout()
        {
            for (int i = 0; i < MAX_SHOUT_TIMES && i < Shout_Times; i++)
            {
                Console.WriteLine(string.Format("我的名字叫{0},{1}", this.name, this.sound));
            }
        }

        static void Main(string[] args)
        {
            Cat cat1 = new Cat("猫一", "喵");
            Dog dog1 = new Dog("狗一", "汪！汪！");
            cat1.shout();
            dog1.shout();
            Console.ReadLine();
        }
    }

    class Cat : Animal
    {
        public Cat(String name_of_animal, String sound_of_animal) : base(name_of_animal, sound_of_animal)
        {

        }
    }

    class Dog : Animal
    {
        public Dog(String name_of_animal, String sound_of_animal) : base(name_of_animal, sound_of_animal)
        {

        }
    }


}