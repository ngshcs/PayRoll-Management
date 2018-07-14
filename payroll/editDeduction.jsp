<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<%!
	public boolean isTextNode(Node node)
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
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String desc = request.getParameter("desc");

		if( id!=null && name!=null && desc!=null )
		{
			try
			{
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();

				String query = "select name from deduction where id=" + id;
				ResultSet rs = stmt.executeQuery(query);
				rs.next();
				String old = rs.getString(1);

				query = "update deduction set name='" + name + "',description='" + desc+ "' where id=" + id;
				stmt.executeUpdate(query);

				query = "select * from groups";
				rs = stmt.executeQuery(query);

				while(rs.next())
				{
					int groupid = Integer.parseInt(rs.getString(1));
					Blob xml = rs.getBlob(3);
					if(xml==null)
						continue;

					File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
					File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
					FileOutputStream fos = new FileOutputStream(file);
					fos.write( xml.getBytes(1,(int)xml.length()) );
					fos.close();

					myXml.setDocument(file);
					Element root = myXml.getRoot();

					NodeList deductions = root.getElementsByTagName("deductions");
					Node deduction= deductions.item(0);

					if( deduction.hasChildNodes() )
					{
						NodeList list = deduction.getChildNodes();
						int count = list.getLength();

						for(int i=0 ; i<count; i++)
						{
							Node items = list.item(i);

							if( isTextNode(items) )
								continue;

							if( items.getNodeName().equals(old) )
							{
								myXml.getDocument().renameNode(items,items.getNamespaceURI(),name);
								NodeList item = items.getChildNodes();
								Node node = item.item(0);
								node.getFirstChild().setNodeValue(name);
							}
						}
					}

					myXml.updateXML();

					PreparedStatement ps = con.prepareStatement("update groups set xml=? where id=" + groupid);
					FileInputStream fis = new FileInputStream(file);
					ps.setBinaryStream(1, fis, (int)file.length());
					ps.executeUpdate();
					fis.close();
					file.delete();



					xml = rs.getBlob(4);
					if(xml==null)
						continue;

					file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
					fos = new FileOutputStream(file);
					fos.write( xml.getBytes(1,(int)xml.length()) );
					fos.close();

					myXml.setDocument(file);
					root = myXml.getRoot();

					NodeList employees = root.getElementsByTagName("employee");
					int c = employees.getLength();
					Element employee = null;

					for(int i=0; i<c; i++)
					{
						employee = (Element)employees.item(i);
						if( isTextNode(employee) )
							continue;

						deductions = employee.getElementsByTagName("deductions");
						deduction= deductions.item(0);

						if( deduction.hasChildNodes() )
						{
							NodeList list = deduction.getChildNodes();
							int count = list.getLength();

							for(int j=0 ; j<count; j++)
							{
								Node items = list.item(j);

								if( isTextNode(items) )
									continue;

								if( items.getNodeName().equals(old) )
								{
									myXml.getDocument().renameNode(items,items.getNamespaceURI(),name);
									NodeList item = items.getChildNodes();
									Node node = item.item(0);
									node.getFirstChild().setNodeValue(name);
								}
							}
						}
					}

					myXml.updateXML();

					ps = con.prepareStatement("update groups set emp=? where id=" + groupid);
					fis = new FileInputStream(file);
					ps.setBinaryStream(1, fis, (int)file.length());
					ps.executeUpdate();
					fis.close();
					file.delete();
				}

				out.println("<tr>" + id + "</tr>");
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