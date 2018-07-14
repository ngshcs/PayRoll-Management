<%@ page language="java" %>
<%@ page import="java.sql.*,java.util.*,java.io.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>
<html>
<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		out.print("<table>Unauthorised access - Login to access this resource</table>");

	else if("admin".equals(type))
	{

		String id = request.getParameter("id");

		if( id!=null )
		{
			try
			{
				String[] months = { "Jan", "Feb", "Mar", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" };
				Calendar cal = Calendar.getInstance();

				String mon = months[ cal.get(Calendar.MONTH) ];
				String year = "" + cal.get(Calendar.YEAR);
				String rightNow = mon + " " + year;

				Connection con = dbConn.getConnection();
				Statement stmt  = null;
				ResultSet rs = null;
				Statement stmt1  = null;
				ResultSet rs1 = null;
				PreparedStatement ps=null;

				if(id.equals(rightNow))
				{
					stmt = con.createStatement();
					stmt1 = con.createStatement();
					rs = stmt.executeQuery("select name,emp from groups");

					File file = null;
					FileInputStream fis = null;

					try
					{
						while(rs.next())
						{
							//System.out.println( rs.getString(1));
							System.out.println("qwerty");
						//PreparedStatement ps = con.prepareStatement("insert into payslips(id,name,payslip) values(?,?,?)");
							String name = rs.getString(1);
							Blob emp = rs.getBlob(2);

							File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
							file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
							FileOutputStream fos = new FileOutputStream(file);
							fos.write( emp.getBytes(1,(int)emp.length()) );
							fos.close();
							
							String filename = file.getName();
							
							rs1=stmt1.executeQuery("select * from payslips where name='" + name + "' and id='"+rightNow+"'");
		
							fis = new FileInputStream(file);
							if(!rs1.next())
							{
	
							ps = con.prepareStatement("insert into payslips(id,name,payslip) values(?,?,?)");
							ps.setString(1,rightNow);
							ps.setString(2,name);
							ps.setBinaryStream(3, fis, (int)file.length());
							}
							else
							{
								//System.out.println("Hellooo");
						 ps = con.prepareStatement("update payslips set payslip=? where id='"+rightNow+"'and name='"+name+"'");
							ps.setBinaryStream(1, fis, (int)file.length());
							}
							ps.executeUpdate();
							fis.close();
							//file.delete();
							
							session.setAttribute("file",filename);
						}
					}
					catch(Exception e)
					{
						try { fis.close();/*file.delete();*/ } catch(Exception ee) { }
					}
				}
				

				if(stmt==null)
					stmt = con.createStatement();

				rs = stmt.executeQuery("select name from payslips where id=\'" + id + "\'");
				out.println("<h3 style=\"color:navy\"> Payslip of " + id + " </h3>");
				out.println("<table border=\"0\">");

				int sno = 1;
				while(rs.next())
				{
					sno++;
					String str = "viewPayslip.jsp?id=" + id + "&name=" + rs.getString(1);
%>
					<tr> <td> &nbsp;&nbsp; <a class="style1" href="<%= str %>">Click here</a> for  payslip of <%= rs.getString(1) %> </td>  </tr>
<%
				}

				if(sno==1)
					out.println("<tr> <td> No details found </td> </tr>");

				out.println("</table>");
			}
			catch(Exception e)
			{
				out.println("<table>Error: " + e.getMessage() + "</table>");
			}
		}
		else
		{
			out.println("<table>Error: null</table>");
		}
	}
	else
	{
		out.println("<table>Error: Unauthorised - Access Denied</table>");
	}
%>
</html>