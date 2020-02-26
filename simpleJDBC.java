import java.io.File;
import java.io.FileNotFoundException;
import java.sql.* ;
import java.util.Scanner;


class simpleJDBC
{
    public static void main ( String [ ] args ) throws SQLException, FileNotFoundException
    {
        // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        if ( args.length > 0 ){
            tableName += args [ 0 ] ;
        }
        else {
            tableName += "example3.tbl";
        }

        // Register the driver.  You must register the driver before you can use it.
        try {
            DriverManager.registerDriver (new com.ibm.db2.jcc.DB2Driver() ) ;
            //Class.forName("com.ibm.db2.jcc.DB2Driver");
        } catch (Exception cnfe){
            System.out.println("Class not found");
        }

        // This is the url you must use for DB2.
        //Note: This url may not valid now !
        String url = "jdbc:db2://comp421.cs.mcgill.ca:50000/cs421";
        Connection con = DriverManager.getConnection (url,"yxu258","aPW9gu6N") ; //change into group account when executing
        Statement statement = con.createStatement ( ) ;

        // Inserting records into the table donor and individual
        Scanner sc1 = new Scanner(new File("D:/Download/individual.csv")); //update the file address if needed
        sc1.useDelimiter("\r\n");
        sc1.nextLine();
        while(sc1.hasNextLine()){
            String[] temp = sc1.nextLine().split(",");
            String cmd1 = "INSERT INTO donor VALUES (\'"+temp[0]+"\',\'"+temp[1]+"\',\'"+temp[2]+"\',"+temp[3]+")";
            String cmd2 = "INSERT INTO individual VALUES (\'"+temp[1]+"\')";
            statement.executeUpdate(cmd1);
            statement.executeUpdate(cmd2);
        }
        sc1.close();

        // Inserting records into the table donor and organization
        Scanner sc2 = new Scanner(new File("D:/Download/company.csv")); //update the file address if needed
        sc2.useDelimiter("\r\n");
        sc2.nextLine();
        while(sc2.hasNextLine()){
            String[] temp = sc2.nextLine().split(",");
            String cmd1 = "INSERT INTO donor VALUES (\'"+temp[0]+"\',\'"+temp[1]+"\',\'"+temp[2]+"\',"+temp[3]+")";
            String cmd2 = "INSERT INTO organization VALUES (\'"+temp[1]+"\',\'"+temp[4]+"\')";
            statement.executeUpdate(cmd1);
            statement.executeUpdate(cmd2);
        }
        sc2.close();

        statement.close ( ) ;
        con.close ( ) ;
    }
}