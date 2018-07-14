<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*" %>
<%@ page isThreadSafe="true" %>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");
%>

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

<html>
	<head>
		<link rel="stylesheet" href="./js/jquery-ui.css" type="text/css">
		<style type="text/css">
			body {margin:0;padding:0; font-family: Tahoma, Helvetica, sans-serif, "Times New Roman"; }
			a:link, a:visited { text-decoration:none; color:white; }
			a:hover { text-decoration:underline; }
			em { color: #E33532; }
			.focus { border: 2px solid #AA88FF; background-color: #FFEEAA; }
			h3 { color: blue; }
		</style>

	                  <script type="text/javascript">
	                            if(top.frames.length == 0)
	                                       top.location.href = "./home.jsp?viewEmp.jsp";
	                  </script>

		<script type="text/javascript" src="./js/jquery-1.4.2.min.js"> </script>
		<script type="text/javascript" src="./js/validate.js"> </script>
		<script type="text/javascript" src="./js/jquery-ui.js"> </script>

		<script language="javascript">
			$(document).ready(function()
			{
				$("#tabs").tabs();

				$('input[type="text"]').focus(function() {
					$(this).addClass("focus");
				});

				$('input[type="text"]').blur(function() {
					$(this).removeClass("focus");
				});

				$.validator.addMethod("DateFormat", function(value,element)
				{
					return value.match(/^(0[1-9]|[12][0-9]|3[01])[- //.](0[1-9]|1[012])[- //.]\d\d\d\d$/);
				},"Please enter date in the format dd/mm/yyyy");

				$("#empForm").validate(
				{
					rules:
					{
						title:
						{
							required: true,
						},
						first:
						{
							required: true,
						},
						last:
						{
							required: true,
						},
						dob:
						{
							required: true,
							DateFormat: true,
						},
						gender:
						{
							required: true,
						},
						marital:
						{
							required: true,
						},
						email:
						{
							required: true,
							email: true,
						},
						joining:
						{
							required: true,
							DateFormat: true,
						},
						leaving:
						{
							required: true,
							DateFormat: true,
						},
						basic:
						{
							required: true,
						}
					}
				});
			});
		</script>
	</head>

	<body background="./images/background.png" onunload="">
		<div style="float:left;position:fixed;width:100%;height:30px;top:0px;background:navy;
							z-index:10;color:white;font-size:18px;">
			<div style="float:right;position:relative;top:4px;">
				<a href="homepage.jsp"> Home </a> &nbsp; &nbsp;
				<a href="changePwd.jsp"> Change Password </a> &nbsp; &nbsp;
				<a href="logout.jsp"> Logout </a> &nbsp; &nbsp; &nbsp; &nbsp;
			</div>
			<div style="float:left;position:relative;top:4px;">
				&nbsp; &nbsp; You are logged in as <b style="color:orange;"> admin </b>
			</div>
		</div>

		<div style="width:100%;"> <div style="width:96%;left:2%;float:left;position:absolute;top:30px;padding-top:10px;font-size:16px;">
			<br /> <br /> <form id="empForm" method="post" action="updateEmp.jsp">
<%
		if( "admin".equals(type) )
		{
			int id = Integer.parseInt(request.getParameter("id"));
%>
			<div class="ui-tabs ui-widget ui-widget-content ui-corner-all" id="tabs" style="font-size:13px;">
				<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
					<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
						<a href="#fragment-1">
							<span> Personal Deatils </span>
						</a>
					</li>
					<li class="ui-state-default ui-corner-top">
						<a href="#fragment-2">
							<span> Contact Details </span>
						</a>
					</li>
					<li class="ui-state-default ui-corner-top">
						<a href="#fragment-3">
							<span> Employement-1 </span>
						</a>
					</li>
					<li class="ui-state-default ui-corner-top">
						<a href="#fragment-4">
							<span> Employement-2 </span>
						</a>
					</li>
				</ul>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="fragment-1">
					<table border="0">
<%
			Connection con = dbConn.getConnection();
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from employee where empid=" + id);
			rs.next();
%>
						<tr> <td align="right"> Employee ID : </td>
						<td> <input type="text" name="empid" value="<%= rs.getString(1) %>" readonly /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Salutation<em>*</em> : </td>
						<td> <input type="text" name="title" value="<%= rs.getString(2) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> First Name<em>*</em> : </td>
						<td> <input type="text" name="first" value="<%= rs.getString(3) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Middle Name : </td>
						<td> <input type="text" name="middle" value="<%= rs.getString(4) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Last Name<em>*</em> : </td>
						<td> <input type="text" name="last" value="<%= rs.getString(5) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Date of Birth<em>*</em> : </td>
						<td> <input type="text" name="dob" value="<%= rs.getString(6) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Gender<em>*</em> : </td>
						<td> <input type="text" name="gender" value="<%= rs.getString(7) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Marital Status<em>*</em> : </td>
						<td> <input type="text" name="marital" value="<%= rs.getString(8) %>"  /> </td> </tr>
					</table> <br />
				</div>

<%
		rs = stmt.executeQuery("select * from emp_addr where id=" + id);
		rs.next();
%>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="fragment-2">
					<table border="0">
						<tr> <td align="right"> Address1 : </td>
						<td> <input type="text" name="addr1" value="<%= rs.getString(2) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Address2 : </td>
						<td> <input type="text" name="addr2" value="<%= rs.getString(3) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Street : </td>
						<td> <input type="text" name="street"  value="<%= rs.getString(4) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> City : </td>
						<td> <input type="text" name="city"  value="<%= rs.getString(5) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> State : </td>
						<td> <input type="text" name="state"  value="<%= rs.getString(6) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Country : </td>
						<td> <input type="text" name="country"  value="<%= rs.getString(7) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Zipcode : </td>
						<td> <input type="text" name="zipcode"  value="<%= rs.getString(8) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Homephone : </td>
						<td> <input type="text" name="homephone"  value="<%= rs.getString(9) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Mobile : </td>
						<td> <input type="text" name="mobile"  value="<%= rs.getString(10) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Email<em>*</em> : </td>
						<td> <input type="text" name="email"  value="<%= rs.getString(11) %>"  /> </td> </tr>
					</table>
				</div>

<%
		rs = stmt.executeQuery("select * from emp_job where id=" + id);
		rs.next();
%>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="fragment-3">
					<table border="0">
						<tr> <td align="right"> Date of Joining : </td>
						<td> <input type="text" name="joining" value="<%= rs.getString(2) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>

						<tr> <td align="right"> Date of Leaving : </td>
						<td> <input type="text" name="leaving" value="<%= rs.getString(3) %>"  /> </td> </tr>

						<tr> </tr> <tr> </tr> <tr> </tr>
<%
		Statement stmt1 = con.createStatement();
		ResultSet rs1 = stmt1.executeQuery("select * from department");
		out.println("<tr> <td align=\"right\"> Branch : </td> <td> <select name=\"branch\"> <option> </option>");
		while(rs1.next())
		{
			if( rs1.getString(2).equals(rs.getString(8)) )
				out.println("<option selected=\"selected\"> " + rs1.getString(2) + " </option>");
			else
				out.println("<option> " + rs1.getString(2) + " </option>");
		}
		out.println("</select> </tr>");
		out.println("<tr> </tr> <tr> </tr> <tr> </tr>");

		rs1 = stmt1.executeQuery("select * from designation");
		out.println("<tr> <td align=\"right\"> Designation : </td> <td> <select name=\"job\">");
		while(rs1.next())
		{
			if( rs1.getString(2).equals(rs.getString(4)) )
				out.println("<option selected=\"selected\"> " + rs1.getString(2) + " </option>");
			else
				out.println("<option> " + rs1.getString(2) + " </option>");
		}
		out.println("</select> </tr>");
		out.println("<tr> </tr> <tr> </tr> <tr> </tr>");

		rs1 = stmt1.executeQuery("select * from groups");
		String groupName = null;
		int grpId = rs.getInt(6);
		while(rs1.next())
		{
			if( rs1.getInt(1) == grpId )
			{
				groupName = rs1.getString(2);
				break;
			}
		}
		out.println("<tr> <td align=\"right\"> Group : </td> <td> <input type=\"text\" name=\"group\" value=\"" + groupName + "\" readonly /> </td> </tr>");
		out.println("<tr> </tr> <tr> </tr> <tr> </tr>");
%>
						<tr> <td align="right"> Basic Pay<em>*<em> : </td>
						<td> <input type="text" name="basic" value="<%= rs.getString(7) %>"  /> </td> </tr>
					</table>
				</div>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="fragment-4">
					<table border="0">
<%
		stmt = con.createStatement();
		rs = stmt.executeQuery("select emp from groups where id=" + grpId);
		rs.next();
		Blob xml = rs.getBlob(1);

		File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
		File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
		FileOutputStream fos = new FileOutputStream(file);

		if(xml==null)
			throw new NullPointerException("No allowance, deduction and loan entries in the group");

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
			int empid = Integer.parseInt(employee.getAttribute("empid"));
			if(empid == id)
				break;
		}

		out.println("<tr> <td colspan=\"2\"> <h3> Allowances </h3> </td> </tr>");

		NodeList allowances = employee.getElementsByTagName("allowances");
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

				if( items.hasChildNodes() )
				{
					NodeList item = items.getChildNodes();

					Node node = item.item(0); 
					if( isTextNode(node) )
						continue;
					String name1 = node.getFirstChild().getNodeValue();

					node = item.item(1);
					if( isTextNode(node) )
						continue;
					String type1 = node.getFirstChild().getNodeValue();

					node = item.item(2);
					if( isTextNode(node) )
						continue;
					String value1 = node.getFirstChild().getNodeValue();

					out.println("<tr>");
					out.println("<td align=\"right\"> " + name1  + " : </td>");
					out.println("<td> <input type=\"text\" name=\"" + name1 + "\" value=\"" + value1  + "\"  /> &nbsp; ");

					if(type1.equals("percent"))
					{
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"" + type1 + "\" checked /> % of basic");
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"fixed\" /> Fixed");
					}
					else
					{
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"percent\" /> % of basic");
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"" + type1 + "\" checked /> Fixed");
					}

					out.println("</td> </tr> <tr> </tr> <tr> </tr> <tr> </tr>");
				}
			}
		}


		out.println("<tr> <td colspan=\"2\"> <br /> </td> </tr>");
		out.println("<tr> <td colspan=\"2\"> <h3> Deductions </h3> </td> </tr>");

		NodeList deductions = employee.getElementsByTagName("deductions");
		Node deduction = deductions.item(0);

		if( deduction.hasChildNodes() )
		{
			NodeList list = deduction.getChildNodes();
			int count = list.getLength();

			for(int i=0 ; i<count; i++)
			{
				Node items = list.item(i);

				if( isTextNode(items) )
					continue;

				if( items.hasChildNodes() )
				{
					NodeList item = items.getChildNodes();

					Node node = item.item(0); 
					if( isTextNode(node) )
						continue;
					String name1 = node.getFirstChild().getNodeValue();

					node = item.item(1);
					if( isTextNode(node) )
						continue;
					String type1 = node.getFirstChild().getNodeValue();

					node = item.item(2);
					if( isTextNode(node) )
						continue;
					String value1 = node.getFirstChild().getNodeValue();

					out.println("<tr>");
					out.println("<td align=\"right\"> " + name1  + " : </td>");
					out.println("<td> <input type=\"text\" name=\"" + name1 + "\" value=\"" + value1  + "\"  /> &nbsp; ");

					if(type1.equals("percent"))
					{
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"" + type1 + "\" checked /> % of basic");
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"fixed\" /> Fixed");
					}
					else
					{
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"percent\" /> % of basic");
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"" + type1 + "\" checked /> Fixed");
					}

					out.println("</td> </tr> <tr> </tr> <tr> </tr> <tr> </tr>");
				}
			}
		}


		out.println("<tr> <td colspan=\"2\"> <br /> </td> </tr>");
		out.println("<tr> <td colspan=\"2\"> <h3> Loans </h3> </td> </tr>");

		NodeList loans = employee.getElementsByTagName("loans");
		Node loan = loans.item(0);

		if( loan.hasChildNodes() )
		{
			NodeList list = loan.getChildNodes();
			int count = list.getLength();

			for(int i=0 ; i<count; i++)
			{
				Node items = list.item(i);

				if( isTextNode(items) )
					continue;

				if( items.hasChildNodes() )
				{
					NodeList item = items.getChildNodes();

					Node node = item.item(0); 
					if( isTextNode(node) )
						continue;
					String name1 = node.getFirstChild().getNodeValue();

					node = item.item(1);
					if( isTextNode(node) )
						continue;
					String type1 = node.getFirstChild().getNodeValue();

					node = item.item(2);
					if( isTextNode(node) )
						continue;
					String value1 = node.getFirstChild().getNodeValue();

					node = item.item(3);
					if( isTextNode(node) )
						continue;
					String curr1 = node.getFirstChild().getNodeValue();

					node = item.item(4);
					if( isTextNode(node) )
						continue;
					String tot1 = node.getFirstChild().getNodeValue();

					out.println("<tr>");
					out.println("<td align=\"right\"> " + name1  + " : </td>");
					out.println("<td> <input type=\"text\" name=\"" + name1 + "\" value=\"" + value1  + "\"  /> &nbsp; ");
					out.println("<input type=\"text\" name=\"" + name1 + "curr\" value=\"" + curr1 + "\" size=\"4\"  /> / ");
					out.println("<input type=\"text\" name=\"" + name1 + "tot\" value=\"" + tot1 + "\" size=\"4\"  /> &nbsp; ");

					if(type1.equals("percent"))
					{
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"" + type1 + "\" checked /> % of basic");
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"fixed\" /> Fixed");
					}
					else
					{
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"percent\" /> % of basic");
						out.println("<input type=\"radio\" name=\"" + name1 + "type\" value=\"" + type1 + "\" checked /> Fixed");
					}

					out.println("</td> </tr> <tr> </tr> <tr> </tr> <tr> </tr>");
				}
			}
		}

		file.delete();
%>
					</table>
				</div>

				<table border="0" width="100%">
					<tr> <td align="center">
					<input type="submit" name="submit" value="   Edit   " /> </td> </tr>
				</table>
			</div> </form>
<%
		}
		else
		{
%>
			<script language="javascript">
				var targetURL = "./homepage.jsp";
				alert("Unauthorised - Access Denied... Redirecting to homepage...");
				setTimeout( "window.location.href = targetURL", 1000);
			</script>
<%
		}
%>
		</div> </div>
	</body>
</html>