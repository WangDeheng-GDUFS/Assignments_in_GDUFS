package team.sams.system;

public class Score
{
    // This class is to save the score of student
    private String student_id;           // The id of student
    private String student_name;         // The name of student
    private int final_achievement;       // The final achievement of student
    
    Score()
    {
        // Default constructor
        this.student_id = "default";
        this.student_name = "default";
        this.final_achievement = 0;
    }
    
    Score(String s1, String s2, int i3)
    {
        // Constructor
        this.student_id = s1;
        this.student_name = s2;
        this.final_achievement = i3;
    }
    
    public void set(String s1, String s2, int i3)
    {
        // To set the Score
        this.student_id = s1;
        this.student_name = s2;
        this.final_achievement = i3;
    }
    
    public String name()
    {
        // To get the name of the student
        return this.student_name;
    }
    
    public String score()
    {
        // To get the score of the student
        return String.valueOf(this.final_achievement);
    }
    
    
    public void copy(Score s)
    {
        // To copy an object
        this.student_id = s.student_id;
        this.student_name = s.student_name;
        this.final_achievement = s.final_achievement;
    }
    
    public int value()
    {
        // To get the score
        return this.final_achievement;
    }
    
    public String toString()
    {
        // Refactor toString
        return "ID:" + this.student_id + "  Name:" + student_name + "  Score:" + String.valueOf(this.final_achievement);
    }
    
}
