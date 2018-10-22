package ftpClient;

import java.io.*;
import java.net.*;

public class FileDataServer {
    private final int port = 2020;
    private ServerSocket serverSocket;    // 服务器套接字。
    private Socket acsocket;

    public FileDataServer() throws IOException {
        serverSocket = new ServerSocket(2020);    // 开启2020号监听端口。
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
            try {
                acsocket = serverSocket.accept(); 
                //阻塞语句，监听并等待客户发起连接，有连接请求就生成一个套接字。
                System.out.println("New income: "+ acsocket.getInetAddress());
                
                BufferedReader br =getReader(acsocket);  // 定义字符串输入流。
                PrintWriter pw = putWriter(acsocket);    // 定义字符串输出流。
                
                String msg;
                while ((msg = br.readLine())!= null) //阻塞语句，从输入流中读入一行字符串。
                {
                    downloadFile(msg);
                }
            }catch (IOException e) {
            }finally {
                try{
                    if(acsocket!=null)
                    acsocket.close();  //断开连接
                }catch (IOException e) {e.printStackTrace();}
            }
        }
    }
    
    public void downloadFile(String fileName)
    {
        String dir = "E:\\ftp_server_test\\";
        DataInputStream input = null;//文件输入流
        DataOutputStream output = null;
        DataInputStream getAck = null;//获得服务器的ACK
        int bufferSize = 2048;
        byte[] buf = new byte[bufferSize];//数据存储

        try{
            File file = new File(dir + fileName);
            System.out.println("文件长度:" + (int) file.length());
            input = new DataInputStream(new FileInputStream(dir + fileName));
            output = new DataOutputStream(acsocket.getOutputStream());//将socket设置为数据的传输出口
            getAck = new DataInputStream(acsocket.getInputStream());//设置socket数据的来源
            int readSize;

            readSize = input.read(buf);
            while(readSize != -1)
            {
                output.write(buf, 0, readSize);
//                if(!getAck.readUTF().equals("OK"))
//                {
//                        System.out.println("服务器" + ":" + port + "失去连接！"); 
//                        break;
//                }
                readSize = input.read(buf);
                System.out.println(readSize);
            }
            output.flush();
            // 注意关闭socket链接哦，不然客户端会等待server的数据过来，
            // 直到socket超时，导致数据不完整。
            input.close();
            output.close();
            acsocket.close();
            getAck.close();
            System.out.println("文件传输完成");

        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String args[])throws IOException {
        new FileDataServer().service();
    }
}
