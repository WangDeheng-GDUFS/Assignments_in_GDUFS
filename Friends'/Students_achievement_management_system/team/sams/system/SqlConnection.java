package team.sams.system;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


//This is the SQL connection class.

public class SqlConnection
{
    private static final String URL="jdbc:mysql://localhost:3306/sams?";    // The URL, use database sams 
    private static final String NAME="root";                                // The user name  
    private static final String PASSWORD="fuyugakuretayokan";               // The password
    public Connection conn = null;                                          // The connection object
    public Statement stmt = null;                                           // The statement object
 
    
    SqlConnection()  
    {  
        // Load the connector 
        try
        {  
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("CONNECTOR LOAD SUCCEED");
        } catch (ClassNotFoundException e) {  
            System.out.println("CONNECTOR LOAD FAIL");  
            e.printStackTrace();  
        }  
        
        conn = null;  
        
        try
        {  
            conn = DriverManager.getConnection(URL, NAME, PASSWORD);

            // Create a Statement object
            stmt = conn.createStatement();
            System.out.println("CONNECT SUCCEED");
            System.out.println("WELCOME!\n");
        } catch (SQLException e) {  
            System.out.println("CONNECT FAILED");
            System.out.println("PLEASE TRY AGAIN.");
            e.printStackTrace();  
        }
    }
    // Close the connection
    public void Close()
    {
        if(conn != null)  
        {
            try
            {  
                conn.close();
                System.out.println("CONNECTION CLOSED");
            } catch (SQLException e) {  
                // TODO Auto-generated catch block
                e.printStackTrace();  
                conn = null;  
            }  
        }
    }
}
