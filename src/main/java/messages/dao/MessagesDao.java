package messages.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class MessagesDao {
  
  public static Connection getConnection()
  {
    Connection con=null;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      con=DriverManager.getConnection("jdbc:mysql://localhost:3310/playerinfo","root","mysql");
    }catch(IOException e)
    {
      System.out.println(e);
    }
    return con;
  }
  public static Save()
}
