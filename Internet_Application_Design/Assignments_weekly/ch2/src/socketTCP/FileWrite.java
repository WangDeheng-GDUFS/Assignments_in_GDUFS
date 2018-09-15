/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package socketTCP;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;

public class FileWrite {
    
    private PrintWriter pw = null;

    public FileWrite(){//定义构造方法
        //使用SAVE AS文件对话框命名文件.
        /*   JFileChooser jfc=new JFileChooser();
        jfc.setCurrentDirectory(new File("E:\\javaApp\\ch01\\"));
        jfc.showSaveDialog(null);
        File fileName=jfc.getSelectedFile();*/ 

        //或直接指定文件名及保存位置.
        File fileName = new File("./talk1.txt");
        try {
            // 新建并打开一个输出文件.   
            FileOutputStream fw = new FileOutputStream(fileName, true);
            pw = new PrintWriter(fw);    // 装饰成字符型输出流.
        } catch (FileNotFoundException ex) {  }
    }

    public void append(String msg){
        //保存给定的字符串.
        pw.append(msg); //输出msg到磁盘文件末尾，并添加行结束符.
        pw.flush();
    }
 
    public void close(){
        pw.close();//关闭该磁盘文件，清空缓冲区
    }
}
