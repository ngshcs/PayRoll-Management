<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");
%>

<html>
	<head>
		<link rel="stylesheet" href="./tablesorter/table.css" type="text/css">
		<link rel="stylesheet" href="./js/jquery-ui.css" type="text/css">
		<style type="text/css">
			body {margin:0;padding:0; font-family: Tahoma, Helvetica, sans-serif, "Times New Roman"; }
			a:link, a:visited { text-decoration:none; color:white; }
			a:hover { text-decoration:underline; }
			tr td img { cursor: pointer; }
			.focus { border: 2px solid #AA88FF; background-color: #FFEEAA; }
		</style>

		<script type="text/javascript" src="./js/jquery-1.4.2.min.js"> </script>
		<script type="text/javascript" src="./js/jquery-ui.js"> </script>
		<script type="text/javascript" src="./tablesorter/tablesorter.js"> </script>
		<script type="text/javascript">
			$(document).ready(function()
			{
				$("table.tablesorter").tablesorter({
					sortList: [[0,0]],
					headers:
					{ 
						2: { sorter: false },
						3: { sorter: false }
					}
				});

				$("#dialog").dialog({autoOpen: false},{title: 'Add New Designation'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$("#dialog1").dialog({autoOpen: false},{title: 'Edit Designation'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$('input[type="text"]').focus(function() {
					$(this).addClass("focus");
				});

				$('input[type="text"]').blur(function() {
					$(this).removeClass("focus");
				});


				$("table.tablesorter td img.delete").click(function()
				{
					var tds = $(this).parent().parent().find('td');
					var trs = $(this).parent().parent();
					var Id = jQuery.trim(tds[0].innerHTML);

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'delJob.jsp',
						data: 'id=' + Id,
						type: 'post',
						success: function(msg)
						{
							msg = msg.substring(msg.indexOf('<tr>')+4,msg.indexOf('</tr>'));
							if( msg.indexOf('Unauthorised access') != -1 )
							{
								top.location.href = "index.jsp";
							}
							else if( msg.indexOf('Error') == -1 )
							{
								trs.remove();
								$("table.tablesorter").trigger("update");
								alert("Successfully Deleted . . . . .");
							}
							else
								alert(msg);
						}
					        });
					}, 200);
				});

				$("table.tablesorter td img.edit").click(function()
				{
					var tds = $(this).parent().parent().find('td');

					var val = jQuery.trim(tds[0].innerHTML);
					$("#dialog1 #eid").attr("value",val);

					val = jQuery.trim(tds[1].innerHTML);
					$("#dialog1 #ename").attr("value",val);

					$("#dialog1").dialog("open");
					document.getElementById("editJob").disabled = false;
				});

				$("#editJob").click(function()
				{
					var Id = $("#dialog1 #eid").val();
					var Name = $("#dialog1 #ename").val();

					if( Name.length==0 )
					{
						alert("Enter a name");
						return false;
					}

					document.getElementById("editJob").disabled = true;
					document.getElementById("editJob").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'editJob.jsp',
						data: 'id=' + Id + '&name=' + Name,
						type: 'post',
						success: function(msg)
						{
							msg = msg.substring(msg.indexOf('<tr>')+4,msg.indexOf('</tr>'));
							if( msg.indexOf('Unauthorised access') != -1 )
							{
								top.location.href = "index.jsp";
							}
							else if( msg.indexOf('Error') == -1 )
							{
								var tds = $('#'+Id).parent().find('td');

								tds[0].innerHTML = $("#dialog1 #eid").val();
								tds[1].innerHTML = $("#dialog1 #ename").val();

								alert("Successfully Updated . . . . .");
								$("table.tablesorter").trigger("update");
							}
							else
								alert(msg);

							$("#dialog1").dialog("close");
							document.getElementById("editJob").disabled = false;
							document.getElementById("editJob").value = "   Update   ";
						}
					        });
					}, 200);

					return false;
				});

				$("#add").click(function()
				{
					$("#dialog").dialog("open");
					$("#dialog #name").attr("value","");

					document.getElementById("addJob").disabled = false;
				});

				$("#addJob").click(function()
				{
					var Name = $("#dialog #name").val();

					if( Name.length==0 )
					{
						alert("Enter a name");
						return false;
					}

					document.getElementById("addJob").disabled = true;
					document.getElementById("addJob").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'addJob.jsp',
						data: 'name=' + Name,
						type: 'post',
						success: function(msg)
						{
							msg = msg.substring(msg.indexOf('<tr>'),msg.indexOf('</tr>')+5);
							if( msg.indexOf('Unauthorised access') != -1 )
							{
								top.location.href = "index.jsp";
							}
							else if( msg.indexOf('Error') == -1 )
							{
								$("table.tablesorter > tbody").append(msg);
								alert("Successfully Added . . . . .");
								$("table.tablesorter").trigger("update");
							}
							else
								alert(msg);

							$("#dialog").dialog("close");
							document.getElementById("addJob").disabled = false;
							document.getElementById("addJob").value = "   Add   ";
						}
					        });
					}, 200);

					return false;
				});
			}); 
		</script>
	                   <script type="text/javascript">
	                            if(top.frames.length == 0)
	                                       top.location.href = "./home.jsp?designation.jsp";
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
<%
		if( "admin".equals(type) )
		{
		          try
		         {
			Connection con = dbConn.getConnection();
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from designation order by id");
			int sno = 0;
%>
			<br /> <br />
			<table cellspacing="1" class="tablesorter">
				<thead> <tr>
					<th align="center" class="header headerSortDown"> ID </th>
					<th align="center" class="header"> Designation </th>
					<th align="center"> &nbsp; </th>
				</tr> </thead> <tbody>
<%
				while( rs.next() )
				{
					sno++;
%>
					<tr>
						<td align="center"> <%= rs.getString(1) %> </td>
						<td align="center"> <%= rs.getString(2) %> </td>
						<td align="center" id="<%= rs.getString(1) %>">
						        <img class="edit" src="./images/edit.png" title="Edit" width="16px" height="16px" />
						</td>
					</tr>
<%
				}

				if(sno==0)
				{
%>
					<tr>
						<td colspan="4" align="center"> No details found </td>
					</tr>
<%
				}
%>
				</tbody>
			</table> <br />

			<table align="right" border="0">
				<tr>
				        <td> <input type="image" src="./images/add.png" width="24px" height="24px" /> </td>
				        <td id="add"> <font style="color:#DA4A38;cursor:pointer;"> <strong> Add New Designation </strong> </font> </td>
				        <td> &nbsp; &nbsp; &nbsp; </td>
				</tr>
			</table>

			<div id="dialog">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Designation Name : </td>
						<td> <input type="text" name="name" id="name"> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="addJob" value="   Add   " disabled />
						</td>
					</tr>
				</table>
			</div>

			<div id="dialog1">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> ID : </td>
						<td> <input type="text" value="" id="eid" name="eid" disabled> </td>
					</tr>
					<tr>
						<td align="right"> Designation Name : </td>
						<td> <input type="text" value="" id="ename" name="ename"> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="editJob" value="   Update   " disabled />
						</td>
					</tr>
				</table>
			</div>
<%
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