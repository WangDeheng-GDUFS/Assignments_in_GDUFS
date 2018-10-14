using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;//引入反射
using System.Configuration; //导入配置

namespace ch4_3
{
    //利用反射+配置文件的方法对抽象工厂模式进行改进,使得只有一个工厂类

    public abstract class Pome
    {
        // 梨果类
        public abstract string Name
        { get; }  // 水果名字
    }

    public abstract class Nuclear
    {
        // 核果类
        public abstract string Name
        { get; }  // 水果名字
    }
    
    public class Apple : Pome
    {
        // 梨果类具体水果1
        private string name = "Apple";
        public override string Name
        {
            get { return name; }
        }
    }

    public class Pear : Pome
    {
        // 梨果类具体水果2
        private string name = "Pear";
        public override string Name
        {
            get { return name; }
        }
    }

    public class Cherry : Nuclear
    {
        // 核果类具体水果1
        private string name = "Cherry";
        public override string Name
        {
            get { return name; }
        }
    }

    public class Peach : Nuclear
    {
        // 核果类具体水果2
        private string name = "Peach";
        public override string Name
        {
            get { return name; }
        }
    }

    public class FruitFactory
    {
        // 得到梨果或者核果
        // 读配置文件
        static string pome_name = ConfigurationManager.AppSettings["pome_name"];
        static string nuclear_name = ConfigurationManager.AppSettings["nuclear_name"];

        public static Pome get_pome()
        {
            string className = pome_name;
            // 利用反射技术创建梨果对象
            return (Pome)Assembly.Load("ch4_3").CreateInstance("ch4_3." + className);
        }

        public static Nuclear get_nuclear()
        {
            string className = nuclear_name;
            // 利用反射技术创建核果对象
            return (Nuclear)Assembly.Load("ch4_3").CreateInstance("ch4_3." + className);
        }
    }

    //客户端代码
    class Program
    {
        static void Main(string[] args)
        {
            Pome myPome;
            Nuclear myNuclear;
            myPome = FruitFactory.get_pome();        // 生成梨果
            myNuclear = FruitFactory.get_nuclear();  // 生成核果

            Console.WriteLine("梨果: {0}", myPome.Name);
            Console.WriteLine("核果: {0}", myNuclear.Name);

            Console.ReadLine();
        }
    }
}
