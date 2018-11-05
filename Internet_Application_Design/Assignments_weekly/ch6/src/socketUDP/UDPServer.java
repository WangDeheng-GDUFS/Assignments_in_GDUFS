package socketUDP;

import java.io.*;
import java.net.*;
import java.util.Date;

public class UDPServer {
  private int port = 8008;
  private int remotePort;
  private InetAddress  remoteIP;
  private DatagramSocket socket; //UDP套接字 

  public UDPServer() throws IOException {
    socket = new DatagramSocket(9000); 
  }

    //定义一个数据的发送方法。
  public void send(String msg){
    try {
        //先准备一个待发送的数据报
        byte[] outputData=msg.getBytes("GB2312");
        //构建一个数据报文。  
        DatagramPacket outputPacket=new DatagramPacket(outputData,
                                 outputData.length,remoteIP,remotePort);
        //给UDPServer发送数据报
        socket.send(outputPacket);  //给UDPServer发送数据报
    } catch (IOException ex) { }
  }

  //定义一个数据的接收方法。
  public String receive(){//throws IOException{
    String msg;
    //先准备一个空数据报文
    DatagramPacket inputPacket = new DatagramPacket(new byte[512],512);
      try {
          //阻塞语句，有数据就装包，以装完或装满为此.
          socket.receive(inputPacket);
          //从报文中取出字节数据并装饰成字符。
          msg = new String(inputPacket.getData(),
                         0,inputPacket.getLength(),"GB2312");
          this.remoteIP = inputPacket.getAddress();
          this.remotePort = inputPacket.getPort();
      } catch (IOException ex) {
        msg = null;
      }
    return msg;
  }

  public void close(){
    if(socket!=null)  
       socket.close();//释放本地端口.
  }


  public void service() {//单客户版本,即每次只能同时和一个客户建立通信连接。
    System.out.println("UDP service start!");
    while (true) {
      try {
        String msg;
        while ((msg = this.receive())!= null) //阻塞语句，从输入流中读入一行字符串。
        {
            this.send("20161003359王德恒" + new Date().toString() + msg);
        }
      }catch (Exception e) {
         e.printStackTrace();
      }finally {
         try{
           if(socket!=null)
               socket.close();  //断开连接
         }catch (Exception e) {e.printStackTrace();}
      }
    }
  }

  public static void main(String args[])throws IOException {
    new UDPServer().service();
  }
}
