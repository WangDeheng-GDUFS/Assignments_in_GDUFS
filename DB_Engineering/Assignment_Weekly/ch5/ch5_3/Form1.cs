using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient; //要加上
using System.Data;

namespace ch5_3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connstring = "server=127.0.0.1;database=study;Integrated Security=sspi;";
            // SQL语句，查询Student表中的记录数
            string sqlstring = String.Format("SELECT adminPwd FROM admin WHERE adminUser = '{0}'", textBox1.Text.Trim());
            // 建立连接对象
            SqlConnection conn = new SqlConnection(connstring);

            // 建立数据命令对象
            SqlCommand cmd = new SqlCommand(sqlstring, conn);
            // 打开连接
            conn.Open();

            // 执行命令，返回影响的行数
            SqlDataReader Sdr = cmd.ExecuteReader();
            if (Sdr.Read())
            {
                string password = Sdr[0].ToString();
            }
            if (textBox2.Text.Trim().Equals(password))
            {
                label3.Text = "HINT: WELCOME!";
            }
            else
            {
                label3.Text = "HINT: ERROR!";
            }
            conn.Close();
        }
    }
}
