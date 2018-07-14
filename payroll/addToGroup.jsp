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
		String type1 = request.getParameter("type");
		String value = request.getParameter("value");
		String lists = request.getParameter("list");

		if( id!=null && name!=null && type!=null && value!=null && lists!=null)
		{
			try
			{
				int list = Integer.parseInt(lists);
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

				if(list==1)
					adls = root.getElementsByTagName("allowances");
				else if(list==2)
					adls = root.getElementsByTagName("deductions");
				else
					adls = root.getElementsByTagName("loans");

				Node adl = adls.item(0);

				Element eleA = document.createElement(name);
					Element eleName = document.createElement("name");
					eleName.setTextContent(name);

					Element eleType = document.createElement("type");
					eleType.setTextContent(type1);

					Element eleValue = document.createElement("value");
					eleValue.setTextContent(value);

				eleA.appendChild(eleName);
				eleA.appendChild(eleType);
				eleA.appendChild(eleValue);


				adl.appendChild(eleA);
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

					if(list==1)
						adls = employee.getElementsByTagName("allowances");
					else if(list==2)
						adls = employee.getElementsByTagName("deductions");
					else
						adls = employee.getElementsByTagName("loans");

					if(adls==null)
						continue;

					adl = adls.item(0);

					eleA = document.createElement(name);
						eleName = document.createElement("name");
						eleName.setTextContent(name);

						eleType = document.createElement("type");
						eleType.setTextContent(type1);

						eleValue = document.createElement("value");
						eleValue.setTextContent(value);
					eleA.appendChild(eleName);
					eleA.appendChild(eleType);
					eleA.appendChild(eleValue);

					if(list==3)
					{
						Element eleCurr = document.createElement("current");
						eleCurr.setTextContent("0");

						Element eleTot = document.createElement("total");
						eleTot.setTextContent("0");

						eleA.appendChild(eleCurr);
						eleA.appendChild(eleTot);
					}

					adl.appendChild(eleA);
				}

				myXml.updateXML();

				ps = con.prepareStatement("update groups set emp=? where id=" + rs.getString(1));
				fis = new FileInputStream(file);
				ps.setBinaryStream(1, fis, (int)file.length());
				ps.executeUpdate();
				fis.close();
				file.delete();


				out.println("<tr>" +
						"<td align=\"center\"> " + name + " </td>" +
						"<td align=\"center\"> " + type1 + " </td>" +
						"<td align=\"center\"> " + value + " </td>" +
						"<td align=\"center\"> " +
						"        <img class=\"delete\" src=\"./images/delete.png\" title=\"Delete\" width=\"16px\" height=\"16px\" />" +
						"</td>" +
					"</tr>");
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