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
						3: { sorter: false }
					}
				});

				$("#dialog").dialog({autoOpen: false},{title: 'Add New Allowance'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$("#dialog1").dialog({autoOpen: false},{title: 'Edit Allowance'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});


				$('input[type="text"]').focus(function() {
					$(this).addClass("focus");
				});

				$('input[type="text"]').blur(function() {
					$(this).removeClass("focus");
				});


				$("table.tablesorter td img.edit").click(function()
				{
					var tds = $(this).parent().parent().find('td');

					var val = jQuery.trim(tds[0].innerHTML);
					$("#dialog1 #eid").attr("value",val);

					val = jQuery.trim(tds[1].innerHTML);
					$("#dialog1 #ename").attr("value",val);

					val = jQuery.trim(tds[2].innerHTML);
					$("#dialog1 #edesc").attr("value",val);

					$("#dialog1").dialog("open");
					document.getElementById("editAllowance").disabled = false;
				});

				$("#editAllowance").click(function()
				{
					var Id = $("#dialog1 #eid").val();
					var Name = $("#dialog1 #ename").val();
					var Desc = $("#dialog1 #edesc").val();
					var ck_name = /^[A-Za-z][-A-Za-z0-9]{1,20}$/;

					if( !ck_name.test(Name) )
					{
						alert("Enter a valid name" + "\n Alphabets(A-Z,a-z), Numbers(0-9) and - are allowed");
						return false;
					}

					if( Desc.length==0 )
					{
						alert("Enter description");
						return false;
					}

					document.getElementById("editAllowance").disabled = true;
					document.getElementById("editAllowance").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'editAllowance.jsp',
						data: 'id=' + Id + '&name=' + Name + '&desc=' + Desc,
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
								tds[2].innerHTML = $("#dialog1 #edesc").val();

								alert("Successfully Updated . . . . .");
								$("table.tablesorter").trigger("update");
							}
							else
								alert(msg);

							$("#dialog1").dialog("close");
							document.getElementById("editAllowance").disabled = false;
							document.getElementById("editAllowance").value = "   Update   ";
						}
					        });
					}, 200);

					return false;
				});

				$("#add").click(function()
				{
					$("#dialog").dialog("open");
					$("#dialog #name").attr("value","");
					$("#dialog #desc").attr("value","");

					document.getElementById("addAllowance").disabled = false;
				});

				$("#addAllowance").click(function()
				{
					var Name = $("#dialog #name").val();
					var Desc = $("#dialog #desc").val();
					var ck_name = /^[A-Za-z][-A-Za-z0-9]{1,20}$/;

					if( !ck_name.test(Name) )
					{
						alert("Enter a valid name" + "\n Alphabets(A-Z,a-z), Numbers(0-9) and - are allowed");
						return false;
					}

					if( Name.length==0 )
					{
						alert("Enter name");
						return false;
					}

					if( Desc.length==0 )
					{
						alert("Enter description");
						return false;
					}

					document.getElementById("addAllowance").disabled = true;
					document.getElementById("addAllowance").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'addAllowance.jsp',
						data: 'name=' + Name + '&desc=' + Desc,
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
							document.getElementById("addAllowance").disabled = false;
							document.getElementById("addAllowance").value = "   Add   ";
						}
					        });
					}, 200);

					return false;
				});
			}); 
		</script>
	                   <script type="text/javascript">
	                            if(top.frames.length == 0)
	                                       top.location.href = "./home.jsp?allowances.jsp";
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
			ResultSet rs = stmt.executeQuery("select * from allowance order by id");
			int sno = 0;
%>
			<br /> <br />
			<table cellspacing="1" class="tablesorter">
				<thead> <tr>
					<th align="center" class="header headerSortDown"> ID </th>
					<th align="center" class="header"> Allowance </th>
					<th align="center" class="header"> Description </th>
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
						<td align="center"> <%= rs.getString(3) %> </td>
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
				        <td id="add"> <font style="color:#DA4A38;cursor:pointer;"> <strong> Add New Allowance </strong> </font> </td>
				        <td> &nbsp; &nbsp; &nbsp; </td>
				</tr>
			</table>

			<div id="dialog">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Allowance : </td>
						<td> <input type="text" name="name" id="name"> </td>
					</tr>
					<tr>
						<td align="right"> Description : </td>
						<td> <input type="text" name="desc" id="desc"> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="addAllowance" value="   Add   " disabled />
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
						<td align="right"> Allowance : </td>
						<td> <input type="text" value="" id="ename" name="ename"> </td>
					</tr>
					<tr>
						<td align="right"> Description : </td>
						<td> <input type="text" value="" id="edesc" name="edesc"> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="editAllowance" value="   Update   " disabled />
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