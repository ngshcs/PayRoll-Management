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
		String lists = request.getParameter("list");

		if( id!=null && name!=null )
		{
			try
			{
				int list1 = Integer.parseInt(lists);
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from groups where id=" + id);
				rs.next();

				Blob xml = rs.getBlob(3);
				Blob emp = rs.getBlob(4);
				File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
				File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
				FileOutputStream fos = new FileOutputStream(file);

				if(xml==null)
				{
					String str = "<salaryhead> <allowances> </allowances> <deductions> </deductions> <loans> </loans> </salaryhead>";
					fos.write(str.getBytes());
				}
				else
					fos.write( xml.getBytes(1,(int)xml.length()) );

				fos.close();


				myXml.setDocument(file);
				Document document = myXml.getDocument();
				Element root = myXml.getRoot();

				NodeList adls;

				if(list1==1)
					adls = root.getElementsByTagName("allowances");
				else if(list1==2)
					adls = root.getElementsByTagName("deductions");
				else
					adls = root.getElementsByTagName("loans");

				Node adl = adls.item(0);

				if( adl.hasChildNodes() )
				{
					NodeList list = adl.getChildNodes();
					int count = list.getLength();

					for(int i=0 ; i<count; i++)
					{
						Node items = list.item(i);
						if(items.getNodeName().equals(name))
						{
							adl.removeChild(items);
							break;
						}
					}
				}

				myXml.updateXML();

				PreparedStatement ps = con.prepareStatement("update groups set xml=? where id=" + rs.getString(1));
				FileInputStream fis = new FileInputStream(file);
				ps.setBinaryStream(1, fis, (int)file.length());
				ps.executeUpdate();
				fis.close();
				file.delete();


				file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
				fos = new FileOutputStream(file);

				if(emp==null)
				{
					String str = "<salaryhead> <allowances> </allowances> <deductions> </deductions> <loans> </loans> </salaryhead>";
					fos.write(str.getBytes());
				}
				else
					fos.write( emp.getBytes(1,(int)emp.length()) );

				fos.close();


				myXml.setDocument(file);
				document = myXml.getDocument();
				root = myXml.getRoot();

				NodeList employees = root.getElementsByTagName("employee");
				int c = employees.getLength();
				Element employee = null;

				for(int i=0; i<c; i++)
				{
					employee = (Element)employees.item(i);
					if( isTextNode(employee) )
						continue;

					if(list1==1)
						adls = employee.getElementsByTagName("allowances");
					else if(list1==2)
						adls = employee.getElementsByTagName("deductions");
					else
						adls = employee.getElementsByTagName("loans");

					if(adls==null)
						continue;

					adl = adls.item(0);

					if( adl.hasChildNodes() )
					{
						NodeList list = adl.getChildNodes();
						int count = list.getLength();

						for(int j=0 ; j<count; j++)
						{
							Node items = list.item(j);
							if(items.getNodeName().equals(name))
							{
								adl.removeChild(items);
								break;
							}
						}
					}
				}

				myXml.updateXML();

				ps = con.prepareStatement("update groups set emp=? where id=" + rs.getString(1));
				fis = new FileInputStream(file);
				ps.setBinaryStream(1, fis, (int)file.length());
				ps.executeUpdate();
				fis.close();
				file.delete();

				out.println("<tr> " + name + " </tr>");
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