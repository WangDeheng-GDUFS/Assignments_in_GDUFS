using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient; //要加上
using System.Data;

namespace ch5_5
{
    class Program
    {
        static void Main(string[] args)
        {
            //使用系统配置文件，则只须打开配置文件进行修改，不需要重新编译程序
            string connstring = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;

            //建立连接对象
            SqlConnection conn = new SqlConnection(connstring);

            //建立数据命令对象
            SqlCommand cmd = new SqlCommand
            {
                Connection = conn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "selectClass"
            }; //创建command对象
            //打开连接
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();  //执行ExecuteReader(),创建DataReader对象
            if (reader.HasRows)  //判读reader里是否还有记录
            {
                int rows = 0;
                Console.WriteLine("*******Records of class******\n");
                while (reader.Read())  //判断是否读完
                {
                    for (int i = 0; i < reader.FieldCount; i++) //FieldCount属性得到字段的个数
                    {
                        //GetName(i)得到第i个字段的名称,GetValue(i)得到第i个字段的值
                        Console.Write("{0}:{1}", reader.GetName(i), reader.GetValue(i));
                    }
                    Console.WriteLine();
                    rows++;
                }
                Console.WriteLine("\n共{0}行记录", rows); //输出共有多少条记录
            }
            reader.Close();  //关闭reader
        }
    }
}
