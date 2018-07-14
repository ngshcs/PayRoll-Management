package dbbean;
import java.sql.*;

public class DatabaseBean
{
	private Connection connection = null;

	public Connection getConnection( )
	{
		try
		{
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/jntuh";
			String username = "root";
			String password = "jntuh";

			Class.forName(driver);
			connection = DriverManager.getConnection(url,username,password);
		}
		catch(Exception e)
		{
			System.err.println(e.getMessage() + "\n");
			e.printStackTrace();
		}
		finally
		{
			return connection;
		}
	}
}