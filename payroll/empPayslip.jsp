<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*,java.util.*" %>
<%@ page isThreadSafe="true" %>

<%!
	public boolean isTextNode(Node node)
	{
		return node.getNodeName().equals("#text");
	}
%>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<%
	String result = null;

	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");

	try
	{
		Connection con = dbConn.getConnection();
		Statement stmt = con.createStatement();

		String eid = request.getParameter("id");
		int empid;


		if("admin".equals(type))
		{
			empid  = Integer.parseInt(eid);

			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition","attachment;filename=" + eid + ".xls");
		}
		else
		{
			ResultSet rs = stmt.executeQuery("select empid from employee where login='" + username + "' and admin='" + type + "'");
			rs.next();

			eid = rs.getString(1);
			empid = Integer.parseInt(eid);
		}

			String query = "select salutation, firstname, middlename, lastname from employee where empid=" + empid;
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			String name = rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4);

			query = "select designation, branch, basic, groupid from emp_job where id=" + empid;
			rs = stmt.executeQuery(query);
			rs.next();
			String job = rs.getString(1);
			String branch = rs.getString(2);
			int basic = Integer.parseInt(rs.getString(3));
			int gid = Integer.parseInt(rs.getString(4));

			query = "select name, emp from groups where id=" + gid;
			rs = stmt.executeQuery(query);
			rs.next();
			String grpname = rs.getString(1);
			Blob xml = rs.getBlob(2);

			File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
			File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
			FileOutputStream fos = new FileOutputStream(file);
			fos.write( xml.getBytes(1,(int)xml.length()) );
			fos.close();

			myXml.setDocument(file);
			Element root = myXml.getRoot();

			NodeList employees = root.getElementsByTagName("employee");
			int c = employees.getLength();
			Element employee = null;

			for(int i=0; i<c; i++)
			{
				employee = (Element)employees.item(i);
				if( isTextNode(employee) )
					continue;
				int id = Integer.parseInt(employee.getAttribute("empid"));
				if(empid == id)
					break;
			}


			NodeList allowances = employee.getElementsByTagName("allowances");
			Node allowance= allowances.item(0);

			String[][] empA = null;
			float gross = basic;

			if( allowance.hasChildNodes() )
			{
				NodeList list = allowance.getChildNodes();
				int count = list.getLength();
				empA = new String[count][2];

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);
					if( isTextNode(items) )
						continue;

					NodeList nodes = items.getChildNodes();
					empA[i][0] = nodes.item(0).getFirstChild().getNodeValue();
					String type1 = nodes.item(1).getFirstChild().getNodeValue();
					if(type1.indexOf("fixed")!=-1)
					{
						empA[i][1] = nodes.item(2).getFirstChild().getNodeValue();
						float f = Float.parseFloat(empA[i][1]);
						gross += f;
					}
					else
					{
						float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
						empA[i][1] = "" + f;
						gross += f;
					}
				}
			}


			NodeList deductions = employee.getElementsByTagName("deductions");
			Node deduction= deductions.item(0);

			String[][] empD = null;
			float ded = 0.0f;

			if( deduction.hasChildNodes() )
			{
				NodeList list = deduction.getChildNodes();
				int count = list.getLength();
				empD = new String[count][2];

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);
					if( isTextNode(items) )
						continue;

					NodeList nodes = items.getChildNodes();
					empD[i][0] = nodes.item(0).getFirstChild().getNodeValue();
					String type1 = nodes.item(1).getFirstChild().getNodeValue();
					if(type1.indexOf("fixed")!=-1)
					{
						empD[i][1] = nodes.item(2).getFirstChild().getNodeValue();
						float f = Float.parseFloat(empD[i][1]);
						ded += f;
					}
					else
					{
						float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
						empD[i][1] = "" + f;
						ded += f;
					}
				}
			}

			NodeList loans = employee.getElementsByTagName("loans");
			Node loan= loans.item(0);

			String[][] empL = null;

			if( loan.hasChildNodes() )
			{
				NodeList list = loan.getChildNodes();
				int count = list.getLength();
				empL = new String[count][4];

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);
					if( isTextNode(items) )
						continue;

					NodeList nodes = items.getChildNodes();
					empL[i][0] = nodes.item(0).getFirstChild().getNodeValue();
					String type1 = nodes.item(1).getFirstChild().getNodeValue();
					if(type1.indexOf("fixed")!=-1)
					{
						empL[i][1] = nodes.item(2).getFirstChild().getNodeValue();
						float f = Float.parseFloat(empL[i][1]);
						ded += f;
					}
					else
					{
						float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
						empL[i][1] = "" + f;
						ded += f;
					}

					empL[i][2] = nodes.item(3).getFirstChild().getNodeValue();
					empL[i][3] = nodes.item(4).getFirstChild().getNodeValue();
				}
			}

			file.delete();

			String[] months = { "Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" };
			Calendar cal = new GregorianCalendar();

			String mon = months[ cal.get(Calendar.MONTH) ];
			String year = "" + cal.get(Calendar.YEAR);
			String rightNow = mon + " " + year;


			result = "<table border=\"1\">" +
				"<tr> <td colspan=\"9\" align=\"center\"> <h3> JNTUH College of Engineering, Nachupally </h3> </td> </tr>" +
				"<tr> <td colspan=\"3\"> <b> Name </b> : " + name + "</td>" +
				"<td colspan=\"2\" align=\"center\"> <b> Designation </b> : " + job + " " + branch + "</td>" +
				"<td colspan=\"3\" align=\"center\"> <b> Group </b> : " + grpname + "</td>" +
				"<td colspan=\"1\" align=\"right\"> " + rightNow + "</td> </tr>" +
				"<tr> <td colspan=\"9\"> </td> </tr>" +
				"<tr> <td colspan=\"3\"> <b> Allowances </b> </td> <td colspan=\"3\"> <b> Deductions </b> </td> <td colspan=\"3\"> <b> Loans </b> </td>  </tr>" +

				"<tr>" +
					"<td colspan=\"3\"> <table border=\"1\">";

				for(int i=0; i<empA.length;i++)
				{
					result += "<tr>";
					result += "<td align=\"right\" colspan=\"2\"> <b>" + empA[i][0] + "</b>  </td>";
					result += "<td> " + empA[i][1] + " </td>";
				}

					result += "</table> </td>" +

					"<td colspan=\"3\"> <table border=\"1\">";

				for(int i=0; i<empD.length;i++)
				{
					result += "<tr>";
					result += "<td align=\"right\" colspan=\"2\"> <b>" + empD[i][0] + "</b>  </td>";
					result += "<td> " + empD[i][1] + " </td>";
				}

					result += "</table> </td>" +

					"<td colspan=\"3\"> <table border=\"1\">";

				for(int i=0; i<empL.length;i++)
				{
					result += "<tr>";
					result += "<td align=\"right\" colspan=\"2\"> <b>" + empL[i][0] + "</b>  </td>";
					result += "<td> " + empL[i][1] + " (" + empL[i][2] + "/" + empL[i][3] + ") </td>";
				}

					result += "</table> </td>" +
				"</tr>" +
				"<tr> <td colspan=\"3\" align=\"right\"> <b> Gross Pay </b> : " + gross + "</td>" +
				"<td colspan=\"6\" align=\"right\"> <b> Total Deduction </b> : " + ded + "</td>  </tr>" +
				"<tr> <td colspan=\"9\" align=\"right\"> <b> Net Pay </b> : " + (gross- ded) + "</td> </tr>" +
			"</table>";

		if("admin".equals(type))
			out.println(result);
		else
			session.setAttribute("result",result);

	}
	catch(Exception e)
	{
%>
		<script language="javascript">
			var targetURL = "./homepage.jsp";
			alert("Error: <%= e.getMessage() %>... Redirecting to homepage...");
			setTimeout( "window.location.href = targetURL", 1000);
		</script>
<%
	}
%>