package team.sams.system;

import java.sql.SQLException;
import java.util.Scanner;

public class Main
{
    // The Main Class
    
    private static void launcher()
    {
        System.out.println("Welcome to use The SAMS\n");                            // Welcome
        Tools tools = new Tools();                                                  // Import the Tools
        String SQL_statement = null;                                                // The SQL statement
        int control = 0;                                                            // The control variable
        int choice = 0;                                                             // To record the choice
        @SuppressWarnings("resource")
        Scanner input = new Scanner(System.in);                                     // The Scanner
        System.out.println("# You can entry a control number to use the system");   // Hint message
        System.out.println("# Entry 1 to insert, 2 to query and 0 to exit\n");
        
        while(true)
        {
            System.out.print("Please entry your choice:");
            control = input.nextInt();                                              // Get the control number
            input.nextLine();                                                       // To the next line
            switch(control)
            {
                case 0:
                    break;
                case 1:
                try
                {
                    tools.insert_record();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                break;
                case 2:
                    SQL_statement = tools.score_query();                             // To query
                    System.out.println("Do you want to analysis the data?(1 for yes, 0 for no)");
                    choice = input.nextInt();                                        // Get the choice
                    input.nextLine();                                                // To the next line
                    if(choice == 1)
                    {
                        tools.score_analysis(SQL_statement);                         // Analysis the data
                    }
                    break;
                default:
                    System.out.println("Please entry 0¡¢1 or 2!");
                    break;
            }
            if(control == 0)
            {
                // Exit
                break;
            }
        }
    }
    
    public static void main(String[] args)
    {
        launcher();                                           // Start!
        System.out.println("Thanks for using");               // Thank you!
    }
}
