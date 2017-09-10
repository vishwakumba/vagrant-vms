import java.util.*;
import java.io.*;
import java.text.*;

public class Hello {
   public static void main(String[] args) throws Exception {
      Date date = new Date();
      System.out.println("Hello, my time now is=" + date);

      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmss");
      String str = sdf.format(date);

      String dirName = "/tmp/good-dir-" + str; 
      File file = new File(dirName);
      file.mkdir();

      String fileName = "/tmp/good-file-" + str; 
      PrintWriter writer = new PrintWriter(fileName);
      String msg = "";
      for (int i = 0; i < 5; i++) {
          date = new Date();
          str = sdf.format(date);
          msg = "Hello, I think the time now is " + date;
          System.out.println(msg);
          writer.println(msg);
          System.out.println("before..");
          //Thread.sleep(1000);
          System.out.println("after..");
      }
      writer.close();
   }
}


