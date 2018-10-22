package ftpClient;

import java.io.*;
import java.net.*;

public class FileDialogServer {
    private final int port = 2021;
    private ServerSocket serverSocket;    // 服务器套接字。

    public FileDialogServer() throws IOException {
        serverSocket = new ServerSocket(2021);    // 开启2021号监听端口。
        System.out.println("服务器启动");
    }

    private PrintWriter putWriter(Socket socket)throws IOException{
        OutputStream socketOut = socket.getOutputStream();//获得输出流缓冲区的地址。
        return new PrintWriter(new OutputStreamWriter(socketOut,"GB2312"),true);
    }
    private BufferedReader getReader(Socket socket)throws IOException{
        InputStream socketIn = socket.getInputStream();//获得输入流缓冲区的地址
        return new BufferedReader(new InputStreamReader(socketIn,"GB2312"));
    }  

    public void service()
    {
        //单客户版本,即每次只能同时和一个客户建立通信连接。
        while (true)
        {
            Socket socket=null;
            try {
                socket = serverSocket.accept(); 
                //阻塞语句，监听并等待客户发起连接，有连接请求就生成一个套接字。
                System.out.println("New income: "+socket.getInetAddress());
                //本地服务器观测台显示请求的用户信息。
                BufferedReader br =getReader(socket);  // 定义字符串输入流。
                PrintWriter pw = putWriter(socket);    // 定义字符串输出流。
                
                pw.println("可供下载的文件如下：");
                String fName1="E:\\ftp_server_test\\";    // 给出下载目录路经
                File f = new File(fName1);
                String[] s = f.list();    // 获得目录下所有的子目录和文件名.
                int len = s.length;
                int n = 0;
                long filelength = 0;
                File temp;
                while(n < len)
                {
                    temp=new File(f+"\\"+s[n]);
                    if(temp.isFile())
                    {
                        filelength = temp.length() / 1024;    // 字节单位KB
                        pw.println(s[n] + " [" + filelength + "KB]");
                    }
                    else
                        pw.println(s[n] + " [DIR]");
                    n++;
                }
      
                pw.println("************文件下载********************");
                pw.println("输入文件全名，点击下载按钮,退出输入bye");

                String msg;
                while ((msg = br.readLine())!= null) //阻塞语句，从输入流中读入一行字符串。
                {
                    pw.println("来自服务器:" + msg);//向输出流中输出一行字符串。
                    pw.println("来自服务器2:" + msg);
                    pw.println("来自服务器:" + msg);//向输出流中输出一行字符串。
                    pw.println("来自服务器2:" + msg);
                    if (msg.equals("bye")) //如果客户发送的消息为“bye”，就结束通信
                    break;
                }
            }catch (IOException e) {
            }finally {
                try{
                    if(socket!=null)
                    socket.close();  //断开连接
                }catch (IOException e) {e.printStackTrace();}
            }
        }
    }

    public static void main(String args[])throws IOException {
        new FileDialogServer().service();
    }
}
