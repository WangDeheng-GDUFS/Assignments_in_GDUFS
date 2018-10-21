using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient; //要加上
using System.Data;

namespace ch5
{
    class Program
    {
        //本程序采用有连接方式完成对数据库的更新，注意操作的步骤

        static void Main(string[] args)
        {
            //(1)连接数据库
            SqlConnection conn = new SqlConnection
            {
                ConnectionString = "server=127.0.0.1;database=study;Integrated Security=sspi;"
            };

            //(2)创建SqlCommand对象
            SqlCommand selectCMD = new SqlCommand
            {
                Connection = conn,
                CommandType = CommandType.Text,//该命令也可以不写，因为是默认值

                //(3)设置执行的SQL命令
                CommandText = "insert into student(s_id,s_name) values('s00034','陈名');" +
                              "UPDATE student SET s_name='陈名(R)' WHERE s_id='s00034';" +
                              "DELETE FROM student WHERE s_id='s00034';"
            };
            //(4)打开连接
            conn.Open();
            //(5)执行ExecuteNonQuery（）
            int rows = selectCMD.ExecuteNonQuery();

            Console.WriteLine("{0}行被修改。", rows);
            Console.ReadLine();

            //(6)断开连接
            conn.Close();
        }
    }
}
