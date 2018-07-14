<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<%!
	public boolean isTextNode(Element node)
	{
		return node.getNodeName().equals("#text");
	}
%>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		out.print("<tr>Unauthorised access - Login to access this resource</tr>");

	else if("admin".equals(type))
	{
		String eid = request.getParameter("id");

		if( eid!=null )
		{
			int id = Integer.parseInt(eid);

			try
			{
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();
				stmt.executeUpdate("delete from employee where empid=" + id);
				stmt.executeUpdate("delete from emp_addr where id=" + id);

				ResultSet rs = stmt.executeQuery("select groupid from emp_job where id=" + id);
				if(rs.next())
				{
					int gid = Integer.parseInt(rs.getString(1));

					rs = stmt.executeQuery("select emp from groups where id=" + gid);
					rs.next();
					Blob xml = rs.getBlob(1);

					if(xml!=null)
					{
						File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
						File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
						FileOutputStream fos = new FileOutputStream(file);
						fos.write( xml.getBytes(1,(int)xml.length()) );
						fos.close();

						myXml.setDocument(file);
						Document document = myXml.getDocument();
						Element root = myXml.getRoot();

						NodeList employees = root.getElementsByTagName("employee");
						int count = employees.getLength();

						for(int i=0; i<count; i++)
						{
							Element employee = (Element)employees.item(i);
							if( isTextNode(employee) )
								continue;
							int empid = Integer.parseInt(employee.getAttribute("empid"));
							if(empid == id)
							{
								root.removeChild(employee);
								myXml.updateXML();

								PreparedStatement ps = con.prepareStatement("update groups set emp=? where id=" + gid);
								FileInputStream fis = new FileInputStream(file);
								ps.setBinaryStream(1, fis, (int)file.length());
								ps.executeUpdate();
								fis.close();
								file.delete();

								break;
							}
						}
					}
				}

				stmt.executeUpdate("delete from emp_job where id=" + id);
%>
				<script language="javascript">
					var targetURL = "./employee.jsp";
					alert("Successfully deleted the employee...");
					setTimeout( "window.location.href = targetURL", 1000);
				</script>
<%
			}
			catch(Exception e)
			{
				out.println("<tr>Error: " + e.getMessage() + "</tr>");
			}
		}
		else
		{
			out.println("<tr>Error: null</tr>");
		}
	}
	else
	{
		out.println("<tr>Error: Unauthorised - Access Denied</tr>");
	}
%>