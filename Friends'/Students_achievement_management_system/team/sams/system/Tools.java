package team.sams.system;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Tools
{
    private static SqlConnection conn = new SqlConnection();            // Connect MySQL
    private static Statement stmt = conn.stmt;                          // The Statement object
    
    public static int count_the_columns(String table_name)
    {
        // To count the columns of table
        if(table_name.equals("class"))
            return 3;
        else if(table_name.equals("students"))
            return 2;
        else if(table_name.equals("achievement"))
            return 5;
        else
        {
            // Table name illegal, print the error message
            System.out.println("#-----TABLE NAME ILLEAGE-----#");
            return 0;
        } 
    }
    
    public void insert_record() throws SQLException
    {
        // To insert a record
        @SuppressWarnings("resource")
        Scanner input = new Scanner(System.in);     // The Scanner
        String table_name = null;                   // The name of the table
        int column_num = 0;                         // The number of column of the table
        String [] values = new String[5];           // The values to insert
        String SQL_statement = null;                // The SQL statement
        int i;                                      // Loop variable
        
        System.out.print("Please entry the name of the table:");
        table_name = input.next();                  // Input the table name
        column_num = count_the_columns(table_name); // Count the columns
        if(column_num == 0)
        {
            // Table name illegal, exit the function
            return;
        }
        
        // Splicing SQL statement 
        SQL_statement = String.format("INSERT INTO %s VALUES(", table_name);
        for(i = 0; i < column_num; i ++)
        {
            // Get the values
            System.out.printf("Please entry value%d:", i + 1);
            values[i] = input.next();
        }
        for(i = 0; i < column_num - 1; i ++)
        {
            if(i == 3)
            {
                // The table 'achieve' has two integer type field, do another process
                SQL_statement = SQL_statement + String.valueOf(values[i]) + ", " + String.valueOf(values[i + 1]) + ")";
                stmt.executeUpdate(SQL_statement);
                System.out.println("\n#-----INSERT SUCCEED-----#\n");
                return;
            }
            SQL_statement = SQL_statement + "'" + values[i] + "', ";
        }
        SQL_statement = SQL_statement + "'" + values[i] + "');";
        
        stmt.executeUpdate(SQL_statement);
        System.out.println("\n#-----INSERT SUCCEED-----#\n");
    }

    
    public String score_query()
    {
        // To query the score by class
        @SuppressWarnings("resource")
        Scanner input = new Scanner(System.in);     // The Scanner
        String class_name = null;                   // The name of the class
        String SQL_statement = null;                // The SQL statement
        ResultSet result = null;                    // The result of query
        
        System.out.print("Please entry the name of the class:");
        class_name = input.next();                  // Input the class name
        SQL_statement = String.format("SELECT student_id, student_name, final_achievement FROM achievement WHERE class_name='%s'", class_name);
        try
        {
            result = stmt.executeQuery(SQL_statement);
            // To print the result of query
            System.out.println("\nstudent_id | student_name | final_achievement");
            while (result.next())
            {
                System.out.print("   " + result.getString(1) + "          ");
                System.out.print(result.getString(2) + "             ");
                System.out.print(result.getInt(3) + "\t");
                System.out.println();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("\n#-----QUERY SUCCEED-----#\n");
        
        return SQL_statement;
    }
    
    public void score_analysis(String SQL_statement)
    {
        // To analysis the score
        System.out.println("START ANALYSE");           // Start

        @SuppressWarnings("resource")
        Scanner input = new Scanner(System.in);        // The Scanner
        ResultSet result = null;
        try
        {
            result = stmt.executeQuery(SQL_statement);
        } catch (SQLException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        
        int student_num = 0;                           // To count the number of students 
        double average_score = 0;                      // To calculate the average score
        int A = 0, B = 0, C = 0, D = 0, E = 0;         // Statistics of the number of students in each fraction(A for 90+,B for 80~90,
                                                       // C for 70~80,D for 60~70,E for 60-
        Score top = new Score();                       // The top student
        Score worst = new Score();                     // The worst student
        Score temp = new Score();                      // A Temporary
        int control = 0;                               // The control variable
        
        worst.set("default", "default", 101);          // Set the worst score
        
        try
        {
            while (result.next())
            {
                student_num ++;
                temp.set(result.getString(1), result.getString(2), result.getInt(3));
                average_score += temp.value();
                int t = temp.value() / 10;
                switch(t)
                {
                    // Statistics of the number of students in each fraction
                    case 10:
                        A ++;
                        break;
                    case 9:
                        A ++;
                        break;
                    case 8:
                        B ++;
                        break;
                    case 7:
                        C ++;
                        break;
                    case 6:
                        D ++;
                        break;
                    default:
                        E ++;
                }
                if(temp.value() > top.value())
                {
                    top.copy(temp);
                }
                if(temp.value() < worst.value())
                {
                    worst.copy(temp);
                }
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        average_score = average_score / student_num;        // The average score
        System.out.println("#-----ANALYSE COMPLETED-----#\n");
        
        // Hint text
        System.out.println("# You can see the result by a control number");
        System.out.println("# Entry 1 for the top student, 2 for the worst student");
        System.out.println("# 3 for average score, 4 for the number of students in each fraction");
        System.out.println("# 0 to exit\n");
        
        while(true)
        {
            // Print the result
            System.out.print("Please entry your choice:");
            
            control = input.nextInt();           // Get control number
            input.nextLine();                    // To the next line
            
            switch(control)
            {
                case 0:
                    break;
                case 1:
                    System.out.println(String.format("\nThe top student in the classin the class was %s, who has %s pionts.\n", top.name(), top.score()));
                    break;
                case 2:
                    System.out.println(String.format("\nThe worst student in the class was %s, who has %s pionts.\n", worst.name(), worst.score()));
                    break;
                case 3:
                    System.out.println("\nThe average score of this class is " + String.valueOf(average_score) + "\n");
                    break;
                case 4:
                    System.out.println("\nThe number of students in each fraction:");
                    System.out.println(" 90+  80~90 70~80 60~70 60-");
                    System.out.println(String.format("  %d     %d     %d     %d     %d   \n", A, B, C, D, E));
                    break;
                default:
                    System.out.println("Please entry 0~4:");
                    break;
            }
            if(control == 0)
            {
                // Exit the loop
                break;
            }
            System.out.println("#------------------------------#\n");
        }
        
        System.out.println("ANALYSE EXIT");
    }
    
    protected void finalize()
    {
        // Finalization code here
        // Close the connection   
        conn.Close();
    }
}
