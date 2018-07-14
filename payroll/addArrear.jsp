<%@ page language="java" %>
<%@ page import="java.sql.*,java.util.*,java.io.*,org.w3c.dom.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>
<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>
<jsp:useBean id="myXml1" class="myxml.MyXML">
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
		String id=request.getParameter("id");
		String name = request.getParameter("name");
		String value1 = request.getParameter("value");
		String Mmonths = request.getParameter("Mmonth");
		String Mmonths1 = request.getParameter("Mmonth1");
		String year= request.getParameter("year");
		String year1= request.getParameter("year1");
		System.out.println("in arrear");
		
		if( name!=null && value1!=null && year!=null  && year1!=null )
		{
			try
			{
				float DA=0.0f;
				float tinc=0.0f;
				int diff=(Integer.parseInt(year1)-Integer.parseInt(year))*12;
				int diff1=(Integer.parseInt(Mmonths1)-Integer.parseInt(Mmonths));
				
				int months=diff+diff1;
				String[] months1 = { "Jan", "Feb", "Mar", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" };
				Calendar cal = Calendar.getInstance();
				String old=null;

				String mon = months1[Integer.parseInt(Mmonths1)];
				//String year2 = "" + cal.get(Calendar.YEAR);
				String rightNow = mon + " " + year1;
				String mon1 = months1[Integer.parseInt(Mmonths)];
				//String year2 = "" + cal.get(Calendar.YEAR);
				String date = (Integer.parseInt(Mmonths1)+1) +"-"+ year;
				// String rightNow1=mon1+""+year;	
				String rightNow2=mon+""+year1;
				//int value=Integer.parseInt(value1);
			   
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();
				String query = "insert into arrear(name,value,dmonth,dyear,pmonth,pyear,months)  values"+
				"('" +name+ "','" +value1+ "','" +Mmonths+ "','" + year + "','" + Mmonths1+ "','" + year1 + "','" + months+ "')";
				stmt.executeUpdate(query);
				
				ResultSet rs = stmt.executeQuery("select * from groups where id=" + id);
				rs.next();

				Blob xml = rs.getBlob(3);
				Blob emp = rs.getBlob(4);

				File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
				File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
				FileOutputStream fos = new FileOutputStream(file);
				fos.write( xml.getBytes(1,(int)xml.length()) );
					fos.close();

					myXml.setDocument(file);
					Element root = myXml.getRoot();

					NodeList allowances = root.getElementsByTagName("allowances");
					Node allowance= allowances.item(0);

					if( allowance.hasChildNodes() )
					{
						NodeList list = allowance.getChildNodes();
						int count = list.getLength();

						for(int i=0 ; i<count; i++)
						{
							Node items = list.item(i);
							
							if( isTextNode(items) )
								continue;
							
							if( items.getNodeName().equals("DA") )
							{
								NodeList item = items.getChildNodes();
							
								Node node = item.item(2);
								 old=node.getFirstChild().getNodeValue();
								node.getFirstChild().setNodeValue(value1);
							}

						}
					}

					myXml.updateXML();

					PreparedStatement ps = con.prepareStatement("update groups set xml=? where id=" +id);
					FileInputStream fis = new FileInputStream(file);
					ps.setBinaryStream(1, fis, (int)file.length());
					ps.executeUpdate();
					fis.close();
					file.delete();

					file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
					fos = new FileOutputStream(file);
					fos.write( emp.getBytes(1,(int)emp.length()) );
					fos.close();
				
					myXml.setDocument(file);
					//	Element root = myXml.getRoot();
				
					NodeList employees =myXml.getRoot().getElementsByTagName("employee");
					int c = employees.getLength();
		
					Element employee = null;
			
					for(int i1=0; i1<c; i1++)
					{
						employee = (Element)employees.item(i1);
						if( isTextNode(employee) )
						continue;

						NodeList allowances1= employee.getElementsByTagName("allowances");
						Node allowance1 = allowances1.item(0);

						if( allowance1.hasChildNodes() )
						{
							NodeList list = allowance1.getChildNodes();
							int count = list.getLength();

							for(int i=0 ; i<count; i++)
							{
								Node items = list.item(i);

								if( isTextNode(items) )
									continue;

								if( items.getNodeName().equals("DA") )
								{
									NodeList item = items.getChildNodes();
									Node node = item.item(2);
									node.getFirstChild().setNodeValue(value1);
								}
							}
						}
					}
	
					myXml.updateXML();

				   ps = con.prepareStatement("update groups set emp=? where id="+id);
					fis = new FileInputStream(file);
					ps.setBinaryStream(1, fis, (int)file.length());
					ps.executeUpdate();
					fis.close();
					file.delete();


				

	out.println("<tr>" +
						"<td align=\"center\"> " + name + " </td>" +
						"<td align=\"center\"> " + value1+ " </td>" +
						"<td align=\"center\" >" + months + "\"> " +
						"<td align=\"center\" >" + date + "\"> " +
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