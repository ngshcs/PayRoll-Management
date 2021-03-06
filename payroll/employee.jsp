<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*,java.util.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");
%>

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
			a.style3:link, a.style3:visited { text-decoration:none; color:blue; }
			a.style3:hover { text-decoration:underline; }
			a.style4:link, a.style4:visited { text-decoration:none; color:blue; }
			a.style4:hover { text-decoration:underline; }
			tr td img { cursor: pointer; }
			select { border: 1px groove #5f5f5f; width:160px; }
			.focus { border: 2px solid #AA88FF; background-color: #FFEEAA; }

			table.mytable 
			{
				font-family:arial;
				background-color: #CDCDCD;
				margin:10px 0pt 15px;
				font-size: 9pt;
				text-align: left;
				width:98%;
			}

			table.mytable tr th
			{
				background-color: #e6EEEE;
				border: 1px solid #FFF;
				font-size: 10pt;
				padding: 4px;
			}

			table.mytable tr td
			{
				color: #3D3D3D;
				padding: 4px;
				background-color: #FFF;
				vertical-align: top;
			}
		</style>

		<script type="text/javascript" src="./js/jquery-1.4.2.min.js"> </script>
		<script type="text/javascript" src="./js/jquery-ui.js"> </script>

		<script language="javascript">
			$(document).ready(function()
			{
				$("#tabs").tabs();

				$("#mygroup").change(function()
				{
					var Id = $("#mygroup option:selected").attr("id");
					$("#main").html('<br /> &nbsp;&nbsp;<b> Loading. . .</b>');
					window.location.href = 'employee.jsp?id=' + Id;
				});
				
				$("#mydept").change(function()
				{
					var Id = $("#mygroup option:selected").attr("id");
					var Id2= $("#mydept option:selected").attr("id");
					$("#main").html('<br /> &nbsp;&nbsp;<b> Loading. . .</b>');
					window.location.href = 'employee.jsp?id=' + Id+'&id2='+Id2;
				//	window.location.href +=Id2;
				});
				$("#mydesg").change(function()
				{
					var Id = $("#mygroup option:selected").attr("id");
					var Id2= $("#mydept option:selected").attr("id");
					var Id3=$("#mydesg option:selected").attr("id");
					$("#main").html('<br /> &nbsp;&nbsp;<b> Loading. . .</b>');
					window.location.href = 'employee.jsp?id=' + Id+'&id2='+Id2+'&id3='+Id3;
				//	window.location.href +=Id2;
				});
			
				 $("#hide").click(function(){
							 $("#addLtoG").hide( "drop", 
							  {direction: "up"}, 1000 );
				  });
				$("#dialog").dialog({autoOpen: false},{title: 'Add New Group'},{hide: 'slide'  },{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'} );

				$("#dialog1").dialog({autoOpen: false},{title: 'Edit Group'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$("#addAtoG").dialog({autoOpen: false},{title: 'Add Allowance to Group'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$("#addDtoG").dialog({autoOpen: false},{title: 'Add Deduction to Group'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$("#addLtoG").dialog({autoOpen: false},{title: 'Add Loan to Group'},{hide: { effect: 'drop', direction: "down" }},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: { effect: 'drop', direction: "up" }});

				$("#editA").dialog({autoOpen: false},{title: 'Edit Allowance to Group'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});
				
					$("#addArr").dialog({autoOpen: false},{title: 'Add Arrear'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$("#editArr").dialog({autoOpen: false},{title: 'Edit Arrear'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});

				$('input[type="text"]').focus(function() {
					$(this).addClass("focus");
				});

				$('input[type="text"]').blur(function() {
					$(this).removeClass("focus");
				});
				
			

				$("#addA").click(function()
				{
					$("#addAtoG").dialog("open");
					$("#addAtoG #val").attr("value","");

					var trs = $("#fragment-1 table.mytable").find('tr');
					for(var i=1; i<trs.length; i++)
					{
						var tds = trs[i].innerHTML;
						var data = tds.substring(20,tds.indexOf("</td>"));
						data = jQuery.trim(data);

						$("#atog").val(data);
						$("#atog option:selected").remove();
					}

					document.getElementById("butA").disabled = false;
				});
				
				$("#addAr").click(function()
				{
					$("#addArr").dialog("open");
					$("#addArr #eid1").attr("value","");
					$("#addArr #ename1").attr("value","");
				//	$("#addArr #emonth1").attr("value","0");
					//$("#mymonth").attr("id");
					$("#addArr #year").attr("value","");
					$("#addArr #year1").attr("value","");

					document.getElementById("butArr").disabled = false;
				});
				
				

				$("#addD").click(function()
				{
					$("#addDtoG").dialog("open");
					$("#addDtoG #val").attr("value","");

					var trs = $("#fragment-2 table.mytable").find('tr');
					for(var i=1; i<trs.length; i++)
					{
						var tds = trs[i].innerHTML;
						var data = tds.substring(20,tds.indexOf("</td>"));
						data = jQuery.trim(data);

						$("#dtog").val(data);
						$("#dtog option:selected").remove();
					}

					document.getElementById("butD").disabled = false;
				});

				$("#addL").click(function()
				{
					$("#addLtoG").dialog("open");
					$("#addLtoG #val").attr("value","");

					var trs = $("#fragment-3 table.mytable").find('tr');
					for(var i=1; i<trs.length; i++)
					{
						var tds = trs[i].innerHTML;
						var data = tds.substring(20,tds.indexOf("</td>"));
						data = jQuery.trim(data);

						$("#ltog").val(data);
						$("#ltog option:selected").remove();
					}

					document.getElementById("butL").disabled = false;
				});

				$("#addE").click(function()
				{
					var Id = $("#mygroup option:selected").attr("id");
					window.location.href = 'addEmployee.jsp?id=' + Id;
				});

				$("#fragment-4 table.mytable tr td a.style4").click(function()
				{
					var c = confirm("Are you sure you want to continue?");
					return c;
				});

					$("#fragment-5 table.mytable tr td img.edit").click(function()
				{
					var tds = $(this).parent().parent().find('td');
					
					
					 var val = jQuery.trim(tds[0].innerHTML);
					 $("#editArr #eid2").attr("value",val); 

					val = jQuery.trim(tds[1].innerHTML);
					$("#editArr #ename2").attr("value",val);

					val = jQuery.trim(tds[2].innerHTML);
					$("#editArr #emonth2 ").attr("value",val);

					val = jQuery.trim(tds[3].innerHTML);
					var val1=val.substring((val.length)-4,val.length);
					$("#editArr #year2").attr("value",val1);
					
					val1=val.substring(0,1);
					$(" #mymonth2 option:selected").attr("value",val1);

					$("#editArr").dialog("open");
					document.getElementById("editArrear").disabled = false;
				});

				$("#fragment-1 table.mytable tr td img.edit").click(function()
				{
					var tds = $(this).parent().parent().find('td');
					
					
					 var val = jQuery.trim(tds[0].innerHTML);
					 $("#editA #eid").attr("value",val); 

					val = jQuery.trim(tds[2].innerHTML);
					$("#editA #ename").attr("value",val);

					
					$("#editA #edesc").attr("value","");

					$("#editA").dialog("open");
					document.getElementById("editAllowance").disabled = false;
				});

				$("#editAllowance").click(function()
				{
					var Id =$("#mygroup option:selected ").attr("id");
					var name = $("#editA #eid").val();
					var value = $("#editA #edesc").val();
					var type = $("#editA input:checked").val();
					
					if( value.length==0 )
					{
						
						return false;
					}

					document.getElementById("editAllowance").disabled = true;
					document.getElementById("editAllowance").value = "  Wait...  ";
					         
					this.timer = setTimeout(function()
					{
						//alert(Id+name+value+type);
							  $.ajax({ 
					      url: 'editAllowancetoGroup.jsp',
						data: 'id=' + Id + '&name=' + name + '&type=' + type + '&value=' + value ,
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
								$("#fragment-1 table.mytable").append(msg);
								alert("Successfully Updated . . . . .");
								window.location.reload();
							}
							else
								alert(msg);

							$("#editA").dialog("close");
							document.getElementById("editAllowance").disabled = false;
								document.getElementById("editAllowance").value = "   Update   ";
						}
					        });
					}, 200);
				
				
				return false;
			
			});
				

				$("#fragment-1 table.mytable tr td img.delete").click(function()
				{
					var c = confirm("Are you sure you want to continue?");
					if(c==false)
						return false;

					var tds = $(this).parent().parent().find('td');
					var trs = $(this).parent().parent();
					var Id = $("#mygroup option:selected").attr("id");
					var name = jQuery.trim(tds[0].innerHTML);
					var list = 1;

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'delFromGroup.jsp',
						data: 'id=' + Id + '&name=' + name + '&list=' + list,
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
								trs.remove();
								alert("Successfully Deleted . . . . .");
								window.location.reload();
							}
							else
								alert(msg);
						}
					        });
					}, 200);

					return false;
				});


				$("#fragment-2 table.mytable tr td img.delete").click(function()
				{
					var c = confirm("Are you sure you want to continue?");
					if(c==false)
						return false;

					var tds = $(this).parent().parent().find('td');
					var trs = $(this).parent().parent();
					var Id = $("#mygroup option:selected").attr("id");
					var name = jQuery.trim(tds[0].innerHTML);
					var list = 2;

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'delFromGroup.jsp',
						data: 'id=' + Id + '&name=' + name + '&list=' + list,
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
								trs.remove();
								alert("Successfully Deleted . . . . .");
								window.location.reload();
							}
							else
								alert(msg);
						}
					        });
					}, 200);

					return false;
				});

				$("#fragment-3 table.mytable tr td img.delete").click(function()
				{
					var c = confirm("Are you sure you want to continue?");
					if(c==false)
						return false;

					var tds = $(this).parent().parent().find('td');
					var trs = $(this).parent().parent();
					var Id = $("#mygroup option:selected").attr("id");
					var name = jQuery.trim(tds[0].innerHTML);
					var list = 3;

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'delFromGroup.jsp',
						data: 'id=' + Id + '&name=' + name + '&list=' + list,
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
								trs.remove();
								alert("Successfully Deleted . . . . .");
								window.location.reload();
							}
							else
								alert(msg);
						}
					        });
					}, 200);

					return false;
				});


				$("#butA").click(function()
				{
					var Id = $("#mygroup option:selected").attr("id");
					var name = $("#addAtoG select").val();
					var type = $("#addAtoG input:checked").val();
					var value = $("#addAtoG #val").val();
					var list =1;

					if(name==null)
					{
						alert("Select a valid name");
						return false;
					}

					if( value.length==0 )
					{
						alert("Enter a value");
						return false;
					}

					document.getElementById("butA").disabled = true;
					document.getElementById("butA").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'addToGroup.jsp',
						data: 'id=' + Id + '&name=' + name + '&type=' + type + '&value=' + value + '&list=' + list,
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
								$("#fragment-1 table.mytable").append(msg);
								alert("Successfully Updated . . . . .");
								window.location.reload();
							}
							else
								alert(msg);

							$("#addAtoG").dialog("close");
							document.getElementById("butA").disabled = false;
							document.getElementById("butA").value = "   Add   ";
						}
					        });
					}, 200);

					return false;
				});

				$("#butArr").click(function()
				{
					//alert("Hi");
					var id=$("#mygroup option:selected").attr("id");
					var name=$("#addArr #eid1").val();
					var value=$("#addArr #ename1").val();
					//var months=$("#addArr #emonth1").val();
					var Mmonth=$(" #mymonth option:selected").attr("id");
					var Mmonth1=$(" #mymonth1 option:selected").attr("id");
					var year=$("#addArr #year").val();
					   var year1=$("#addArr #year1").val();
					//var list =1;

					if(name.length==0)
					{
						alert("Select a valid name");
						return false;
					}

					if( value.length==0 )
					{
						alert("Enter a value");
						return false;
					}
					if(year.length==0 )
					{
						alert("Enter a year");
						return false;
					}
					
					if(Mmonth==-1 )
					{
						alert("select a month");
						return false;
					}
					document.getElementById("butArr").disabled = true;
					document.getElementById("butArr").value = "  Wait...  ";
					
					this.timer = setTimeout(function()
					{

						alert(id+""+name+" "+ value+" "+Mmonth1+" "+Mmonth+" "+year);
						    $.ajax({
						url: 'addArrear.jsp',
					data: 'id=' + id + '&name=' +name + '&value=' + value  + '&Mmonth=' + Mmonth + '&Mmonth1=' + Mmonth1  + '&year=' + year+ '&year1=' + year1,
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
								$("#fragment-5 table.mytable").append(msg);
								alert("Successfully Updated . . . . .");
								window.location.reload();
							}
							else
								alert(msg);

							$("#addArr").dialog("close");
							document.getElementById("butArr").disabled = false;
							document.getElementById("butArr").value = "   Add   ";
						}
					        });
					}, 200);

					return false;
				});
					  

					

				$("#butD").click(function()
				{
					var Id = $("#mygroup option:selected").attr("id");
					var name = $("#addDtoG select").val();
					var type = $("#addDtoG input:checked").val();
					var value = $("#addDtoG #val").val();
					var list = 2;

					if(name==null)
					{
						alert("Select a valid name");
						return false;
					}

					if( value.length==0 )
					{
						alert("Enter a valid name" + "\nNumbers (0-9) are allowed");
						return false;
					}

					document.getElementById("butD").disabled = true;
					document.getElementById("butD").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'addToGroup.jsp',
						data: 'id=' + Id + '&name=' + name + '&type=' + type + '&value=' + value + '&list=' + list,
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
								$("#fragment-2 table.mytable").append(msg);
								alert("Successfully Updated . . . . .");
								window.location.reload();
							}
							else
								alert(msg);

							$("#addDtoG").dialog("close");
							document.getElementById("butD").disabled = false;
							document.getElementById("butD").value = "   Add   ";
						}
					        });
					}, 200);

					return false;
				});

				$("#butL").click(function()
				{
					var Id = $("#mygroup option:selected").attr("id");
					var name = $("#addLtoG select").val();
					var type = $("#addLtoG input:checked").val();
					var value = $("#addLtoG #val").val();
					var list = 3;

					if(name==null)
					{
						alert("Select a valid name");
						return false;
					}

					if( value.length==0 )
					{
						alert("Enter a valid name" + "\nNumbers (0-9) are allowed");
						return false;
					}

					document.getElementById("butL").disabled = true;
					document.getElementById("butL").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'addToGroup.jsp',
						data: 'id=' + Id + '&name=' + name + '&type=' + type + '&value=' + value + '&list=' + list,
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
								$("#fragment-3 table.mytable").append(msg);
								alert("Successfully Updated . . . . .");
							}
							else
								alert(msg);

							$("#addLtoG").dialog("close");
							document.getElementById("butL").disabled = false;
							document.getElementById("butL").value = "   Add   ";
						}
					        });
					}, 200);

					return false;
				});

				$("#edit").click(function()
				{
					var val = $("select").val();
					$("#dialog1 #name1").attr("value",val);

					val = $("option:selected").attr("id");
					$("#dialog1 #id1").attr("value",val);

					$("#dialog1").dialog("open");
					document.getElementById("editGroup").disabled = false;
				});

				$("#editGroup").click(function()
				{
					var Id = $("#dialog1 #id1").val();
					var Name = $("#dialog1 #name1").val();

					if( Name.length==0 )
					{
						alert("Enter a valid name");
						return false;
					}

					document.getElementById("editGroup").disabled = true;
					document.getElementById("editGroup").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'editGroup.jsp',
						data: 'id=' + Id + '&name=' + Name,
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
								$("option:selected").html(Name);
								alert("Successfully Updated . . . . .");
							}
							else
								alert(msg);

							$("#dialog1").dialog("close");
							$("#groupname").html(Name);
							document.getElementById("editGroup").disabled = false;
							document.getElementById("editGroup").value = "   Edit   ";
						}
					        });
					}, 200);

					return false;
				});

			
				$("#add").click(function()
				{
					$("#dialog").dialog("open");
					$("#dialog #name").attr("value","");

					document.getElementById("addGroup").disabled = false;
				});

				$("#addGroup").click(function()
				{
					var Name = $("#dialog #name").val();

					if( Name.length==0 )
					{
						alert("Enter a valid name");
						return false;
					}

					document.getElementById("addGroup").disabled = true;
					document.getElementById("addGroup").value = "  Wait...  ";

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'addGroup.jsp',
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
								msg = msg.substring(msg.indexOf('<tr>')+4,msg.indexOf('</tr>'));
								$("select").append(msg);
								alert("Successfully Added . . . . .");
							}
							else
								alert(msg);

							$("#dialog").dialog("close");
							document.getElementById("addGroup").disabled = false;
							document.getElementById("addGroup").value = "   Add   ";
						}
					        });
					}, 200);

					return false;
				});


				$("#remove").click(function()
				{
					var c = confirm("Are you sure you want to continue?");
					if(c==false)
						return false;

					var Name = $("option:selected").attr("id");

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'delGroup.jsp',
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
								$("option:selected").remove();
								$("#main").html('<br /> &nbsp;&nbsp;<b> Loading. . .</b>');
								alert("Successfully Deleted . . . . .");
								window.location.reload();
							}
							else
								alert(msg);
						}
					        });
					}, 200);

					return false;
				});

				$("#delemp").click(function()
				{
					var c = confirm("Are you sure you want to continue?");
					return c;
				});
			});
		</script>

	                   <script type="text/javascript">
	                            if(top.frames.length == 0)
	                                       top.location.href = "./home.jsp?employee.jsp";
	                   </script>
	</head>

	<body background="./images/background.png" onUnload="">
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
			<br /> <br /> <table border="0"> <tr>
				<td align="right"> <strong style="color:navy;"> Select Group : </strong> </td>
				<td> <select type="groups" id="mygroup">
<%
		if( "admin".equals(type) )
		{
			
		        try
		       {
			String Id = request.getParameter("id");
			String Id2=request.getParameter("id2");
			String Id3=request.getParameter("id3");
			
			Connection con = dbConn.getConnection();
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			Statement stm=con.createStatement();
			Statement stmt1=con.createStatement();
			Statement stmt2=con.createStatement();
			ResultSet rs3=null;
			Statement stmt3=con.createStatement();
			ResultSet rs4=null;
			Statement stmt5=con.createStatement();
			ResultSet rs5=null;
			ResultSet rs = stmt.executeQuery("select * from groups order by id");
			int sno = 0;

			while(rs.next())
			{
				if( !rs.getString(1).equals(Id) )
					out.println("<option id=\"" + rs.getString(1) + "\"> " +  rs.getString(2) + " </option>");
				else
					out.println("<option id=\"" + rs.getString(1) + "\" selected=\"selected\"> " +  rs.getString(2) + " </option>");
			}
				
			if( Id==null )
				rs.beforeFirst();
			else
				rs = stmt.executeQuery("select * from groups where id=" + Id);
		
			rs.next();
			
			Blob xml = rs.getBlob(3);
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
			Element root = myXml.getRoot();
%>
				</select></td>
				<%
		
							if(Id2==null||Integer.parseInt(Id2)==0)
							{
									Id2="x";
									
							}
							else	
							{
								rs3=stmt2.executeQuery("select code from department where id="+Id2);
								rs3.next();
								}
								if(Id3==null||Integer.parseInt(Id3)==0)
							{
									Id3="x";
									
							}
							else	
							{
								rs4=stmt3.executeQuery("select name from desg where id="+Id3);
								rs4.next();
								}
						if(rs.getString(2).equals("Teaching Staff"))
				   {
						ResultSet rs1 = stm.executeQuery("select * from department order by id");
						
				%>
				<td align="right"> <strong style="color:navy;"> Select Branch : </strong> </td>
			<td>	<select type="depatrment" id="mydept"> 
			<%
					if(Id2.equals("x"))
					%>
						<option id=0>All</option selected>
				<%	while(rs1.next())
			{
				if( !rs1.getString(1).equals(Id2) )
					out.println("<option id=\"" + rs1.getString(1) + "\"> " +  rs1.getString(2) + " </option>");
				else
				{
					//System.out.println(Id2);
					out.println("<option id=\"" + rs1.getString(1) + "\" selected=\"selected\"> " +  rs1.getString(2) + " </option>");
				}
			}
					%>
				</select></td>
				<td align="right"> <strong style="color:navy;"> Select Desg : </strong> </td><td><select type="desg" id="mydesg">
					<% rs1 = stm.executeQuery("select * from desg order by id");
					if(Id3.equals("x"))
					%>
						<option id=0>All</option selected>
						<%
					while(rs1.next())
						{
						
						if( !rs1.getString(1).equals(Id3) )
							{
						
							out.println("<option id=\"" + rs1.getString(1) + "\"> " +  rs1.getString(2) + " </option>");}
						else
						{
					//System.out.println(Id2);
						out.println("<option id=\"" + rs1.getString(1) + "\" selected=\"selected\"> " +  rs1.getString(2) + " </option>");
							}
						}
				   }
				%>
					</select></td> <td> &nbsp; &nbsp; </td>
				<td> <img id="add" src="./images/add.png" width="24px;" height="24px" title="Add Group" /> </td>
				<td>&nbsp;  </td>
				<td> <img id="edit" src="./images/edit.png" width="24px;" height="24px" title="Edit Group" /> </td>
				<td>&nbsp;  </td>
				<td> <img id="remove" src="./images/delete.png" width="24px;" height="24px" title="Delete Group" /> </td>
				<td>&nbsp;  </td>
			</tr> <tr> <td colspan="9"> <hr /> </tr>
			</table> <br />

			<div id="main"> <strong style="color:navy;"> Group Name : </strong>
			<span id="groupname" > <%= rs.getString(2) %> </span>
			<br /> <br />

			<div class="ui-tabs ui-widget ui-widget-content ui-corner-all" id="tabs" style="font-size:12px;">
				<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
					<li class="ui-state-default ui-corner-top">
						<a href="#fragment-1">
							<span> Allowances </span>
						</a>
					</li>
					<li class="ui-state-default ui-corner-top">
						<a href="#fragment-2">
							<span> Deductions </span>
						</a>
					</li>
					<li class="ui-state-default ui-corner-top">
						<a href="#fragment-3">
							<span> Loans </span>
						</a>
					</li>
					<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
						<a href="#fragment-4">
							<span> Employees </span>
						</a>
					</li>
					<%if(rs.getString(2).equals("Teaching Staff"))
				   {
				%>
						<li class="ui-state-default ui-corner-top">
						<a href="#fragment-5">
							<span>Arrear </span>
						</a>
					</li>
					<%}%>
					<!--<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
						<a href="#fragment-6">
							<span> Employees Details </span>
						</a>
					</li>-->
				</ul>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="fragment-1">
					<table class="mytable">
						<tr>
							<th align="center"> Allowance </th>
							<th align="center"> Type </th>
							<th align="center"> Value </th>
							<th align="center"> </th>
							<th align="center"> </th>
						</tr>
<%
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

				out.println("<tr>");

				if( items.hasChildNodes() )
				{
					NodeList item = items.getChildNodes();
					sno = 0;

					for(int j=0; j<item.getLength(); j++)
					{
						sno++;
						Node node = item.item(j); 

						if( isTextNode(node) )
							continue;

						String value = node.getFirstChild().getNodeValue();
						out.println("<td align=\"center\"> " + value + " </td>");
					}
				}

				if( sno != 0 )
				{
%>
							<td align="center">
							        <img class="edit" src="./images/edit.png" title="Edit" width="16px" height="16px" />
							</td>
							<td align="center">
							        <img class="delete" src="./images/delete.png" title="Delete" width="16px" height="16px" />
							</td>
<%
				}
%>
						</tr>
<%
			}
		}
%>
					</table>
					<table align="right">
						<tr>
							<td>
								<font id="addA" style="color:#DA4A38;cursor:pointer;">
									<strong> Add Allowance </strong>
								</font>&nbsp;
							</td>
						</tr>
					</table> <br /> <br />
				</div>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="fragment-2">
					<table class="mytable">
						<tr>
							<th align="center"> Deduction </th>
							<th align="center"> Type </th>
							<th align="center"> Value </th>
							<th align="center"> </th>
							
						</tr>
<%
		NodeList deductions = root.getElementsByTagName("deductions");
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

				out.println("<tr>");

				if( items.hasChildNodes() )
				{
					NodeList item = items.getChildNodes();
					sno = 0;

					for(int j=0; j<item.getLength(); j++)
					{
						sno++;
						Node node = item.item(j); 

						if( isTextNode(node) )
							continue;

						String value = node.getFirstChild().getNodeValue();
						out.println("<td align=\"center\"> " + value + " </td>");
					}
				}

				if( sno != 0 )
				{
%>
							
							<td align="center">
							        <img class="delete" src="./images/delete.png" title="Delete" width="16px" height="16px" />
							</td>
<%
				}
%>
						</tr>
<%
			}
		}
%>
					</table>
					<table align="right">
						<tr>
							<td>
								<font id="addD" style="color:#DA4A38;cursor:pointer;">
									<strong> Add Deduction </strong>
								</font>&nbsp;
							</td>
						</tr>
					</table> <br /> <br />
				</div>
					<div class="ui-tabs-panel ui-widget-content ui-corner-bottom" id="fragment-3">
					<table class="mytable">
						<tr>
							<th align="center"> Loan </th>
							<th align="center"> Type </th>
							<th align="center"> Value </th>
							<th align="center"> </th>
						</tr>
				
<%
		NodeList loans = root.getElementsByTagName("loans");
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

				out.println("<tr>");

				if( items.hasChildNodes() )
				{
					NodeList item = items.getChildNodes();
					sno = 0;

					for(int j=0; j<item.getLength(); j++)
					{
						sno++;
						Node node = item.item(j); 

						if( isTextNode(node) )
							continue;

						String value = node.getFirstChild().getNodeValue();
						out.println("<td align=\"center\"> " + value + " </td>");
					}
				}

				if( sno != 0 )
				{
%>
							<td align="center">
							        <img class="delete" src="./images/edit.png" title="Delete" width="16px" height="16px" />
							</td>
<%
				}
%>
						</tr>
<%
			}
		}

		file.delete();
%>
					</table>
					<table align="right">
						<tr>
							<td>
								<font id="addL" style="color:#DA4A38;cursor:pointer;">
									<strong> Add Loan </strong>
								</font>&nbsp;
							</td>
						</tr>
					</table> <br /> <br />
				</div>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom" id="fragment-4">
					<table class="mytable">
						<tr>
							<th> Employee ID </th>
							<th> Employee Name </th>
							<th>  </th>
							<th>  </th>
						</tr>
						  
<%
					String query=null;
				//List<Integer> ints = new ArrayList<Integer>();
				String ints="1";
		if(Id2.equals("x")&& Id3.equals("x"))
				   {
			 query = "select id from emp_job where groupid=" + Integer.parseInt(rs.getString(1));
				   }
		else if(Id3.equals("x"))
				 {
			
			query="select id from emp_job where  branch='" + rs3.getString(1) + "'";

				   }
		else if(Id2.equals("x"))
				   {
				query="select id from emp_job where designation='" + rs4.getString(1) + "'";
				   }
		else
				query="select id from emp_job where designation='" + rs4.getString(1) + "' and branch='"+ rs3.getString(1)+"'";
		Statement st = con.createStatement();
		ResultSet res = st.executeQuery(query);

		while(res.next())
		{
			int empid = Integer.parseInt(res.getString(1));
			ints+=" "+empid;
			rs5 = stmt5.executeQuery("select salutation,firstname,middlename,lastname from employee where empid=" + empid);

			if(rs5.next())
			{
				out.println("<tr>" +
					"	<td> " + empid + " </td>" + 
					"	<td> <a title=\"View Profile\" class=\"style3\" href=\"viewEmp.jsp?id=" + empid + "\"> " + rs5.getString(1) + " " + rs5.getString(2) + " " + rs5.getString(4) + " <a/> </td>" +
					"	<td> <a title=\"View Payslip\" class=\"style3\" href=\"empPayslip1.jsp?id=" + empid + "\"> Payslip </a> </td>"+
					"	<td> <a title=\"Delete Employee\" class=\"style4\" href=\"delEmp.jsp?id=" + empid + "\"> Delete </a> </td>" +
					"</tr>");
			}
	
		}
		   
		/*Iterator it = ints.iterator();
while (it.hasNext()) {
System.out.println(it.next())
};*/
%>

					</table>
					<table align="right">
						<tr>
							<td>
								  <%					
								if(ints.length()>1)
							  {
							  out.println(	"<a  title=\"View Payslip of all employees\" class=\"style3\"" + "href=\"empPayslips.jsp?id="+ints+"&id1="+rs.getString(2)+"&id2="+Id2+"&id3="+Id3+"\">Payslip of all "+ "employees  </a>");
							ints=null;
							   }
								%>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<font id="addE" style="color:#DA4A38;cursor:pointer;">
									<strong> Add Employee </strong>
								</font>&nbsp;
							</td>
						</tr>
					</table> <br /> <br />
				</div>
				<%if(rs.getString(2).equals("Teaching Staff"))
				   {
							%>
				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom" id="fragment-5">
					<table class="mytable">
						<tr>
							<th align="center"> Arrear </th>
							<th align="center"> value </th>
							<th align="center"> months </th>
							<th align="center"> date</th>
							<th align="center"> </th>
						</tr>
						<%
								String query1="select * from arrear ";
								rs5 = stmt5.executeQuery(query1);
								if(rs5.next())
								{
									
										rs5 = stmt5.executeQuery(query1);
										while(rs5.next())
									{
											out.print("<tr>");
										out.print("<td align=\"center\"> " + rs5.getString(1) + " </td>"+
											"<td align=\"center\"> " + rs5.getString(2) + " </td>"+
												"<td align=\"center\"> " + rs5.getString(7) + " </td>"+
												"<td align=\"center\"> " +  (Integer.parseInt(rs5.getString(5))+1)+"-"+rs5.getString(6) + " </td>");
											%>
											<td align="center">
											<img class="edit" src="./images/edit.png" title="Edit" width="16px" height="16px" />
							            </td>
											<%
								out.print("</tr>");
									}
								}
							%>

				</table>
					<table align="right">
						<tr>
							<td>
								<font id="addAr" style="color:#DA4A38;cursor:pointer;">
									<strong> Add Arrear </strong>
								</font>&nbsp;
							</td>
						</tr>
					</table> <br /> <br />
				</div>
			<%}%>
			</div> 
			 <div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="fragment-6">
				<% rs5=stmt.executeQuery("select * from arrear");

					%>
			 </div>
		</div>

			<div id="dialog">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Group Name : </td>
						<td> <input type="text" name="name" id="name"> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="addGroup" value="   Add   " disabled />
						</td>
					</tr>
				</table>
			</div>

			<div id="dialog1">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> ID : </td>
						<td> <input type="text" name="id1" id="id1" disabled /> </td>
					</tr>
					<tr>
						<td align="right"> Group Name : </td>
						<td> <input type="text" name="name1" id="name1"> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="editGroup" value="   Edit   " disabled />
						</td>
					</tr>
				</table>
			</div>

			<div id="addAtoG">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Select: </td>
						<td> <select id="atog">
<%
		rs = st.executeQuery("select * from allowance");
		while(rs.next())
			out.println("<option id=\"a" + rs.getString(1) + "\"> " + rs.getString(2) + " </option>");
%>
						</select> </td>
					</tr>
					<tr>
						<td align="right"> Type : </td>
						<td> <input type="radio" name="type" value="fixed" checked /> Fixed &nbsp;
						<input type="radio" name="type" value="percent" /> Percent(% of basic) </td>
					</tr>
					<tr>
						<td align="right"> Value : </td>
						<td> <input type="text" id="val" /> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="butA" value="   Add   " disabled />
						</td>
					</tr>
				</table>
			</div>

			

			<div id="addDtoG">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Select: </td>
						<td> <select id="dtog">
<%
		st = con.createStatement();
		rs = st.executeQuery("select * from deduction");
		while(rs.next())
			out.println("<option id=\"a" + rs.getString(1) + "\"> " + rs.getString(2) + " </option>");
%>
						</select> </td>
					</tr>
					<tr>
						<td align="right"> Type : </td>
						<td> <input type="radio" name="type1" value="fixed" checked /> Fixed &nbsp;
						<input type="radio" name="type1" value="percent" /> Percent(% of basic) </td>
					</tr>
					<tr>
						<td align="right"> Value : </td>
						<td> <input type="text" id="val" /> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="butD" value="   Add   " disabled />
						</td>
					</tr>
				</table>
			</div>

			<div id="addLtoG">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Select: </td>
						<td> <select id="ltog">
<%
		st = con.createStatement();
		rs = st.executeQuery("select * from loan");
		while(rs.next())
			out.println("<option id=\"a" + rs.getString(1) + "\"> " + rs.getString(2) + " </option>");
%>
						</select> </td>
					</tr>
					<tr>
						<td align="right"> Type : </td>
						<td> <input type="radio" name="type2" value="fixed" checked /> Fixed &nbsp;
						<input type="radio" name="type2" value="percent" /> Percent(% of basic) </td>
					</tr>
					<tr>
						<td align="right"> Value : </td>
						<td> <input type="text" id="val" /> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="butL" value="   Add   " disabled />
						</td>
					</tr>
				</table>
			</div>

				<div id="editA">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Allowance : </td>
						<td> <input type="text" value="" id="eid" name="eid" disabled> </td>
					</tr>
					<tr>
						<td align="right"> old Value : </td>
						<td> <input type="text" value="" id="ename" name="ename" disabled> </td>
					</tr>
					<tr>
						<td align="right"> Type : </td>
						<td> <input type="radio" name="type2" value="fixed" checked /> Fixed &nbsp;
						<input type="radio" name="type2" value="percent" /> Percent(% of basic) </td>
					</tr>
					<tr>
						<td align="right"> new Value : </td>
						<td> <input type="text" value="" id="edesc" name="edesc"> </td>
					</tr>
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="editAllowance" value="Update"  disabled />
						</td>
					</tr>
				</table>
			</div>
			
				<div id="addArr">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Arrear : </td>
						<td> <input type="text" value="" id="eid1" name="eid" > </td>
					</tr>
					<tr>
						<td align="right"> Value: </td>
						<td> <input type="text" value="" id="ename1" name="evalue" > </td>
					</tr>
					
					<tr>
						<td align="right"> Month of modification : </td>
						 <b style="color:navy;"> Select : </b> 
				<td> <select name="month" id="mymonth">
					<option id="-1"> --select-- </option>
					<option id="0"> Jan </option>
					<option id="1"> Feb </option>
					<option id="2"> Mar </option>
					<option id="3"> April </option>
					<option id="4"> May </option>
					<option id="5"> June </option>
					<option id="6"> July </option>
					<option id="7"> Aug </option>
					<option id="8"> Sept </option>
					<option id="9"> Oct </option>
					<option id="10"> Nov </option>
					<option id="11"> Dec</option>
				</select> 
				 &nbsp; <input type="text" id="year" name="year" size="6" />
				<span style="color:#888;font-size:14px;"> <i> Eg: 2012 </i> </span> </td>
					</tr>
					<tr>
						<td align="right"> Month of Implementation : </td>
						
				<td> <select name="month" id="mymonth1">
					<option id="-1"> --select-- </option>
					<option id="0"> Jan </option>
					<option id="1"> Feb </option>
					<option id="2"> Mar </option>
					<option id="3"> April </option>
					<option id="4"> May </option>
					<option id="5"> June </option>
					<option id="6"> July </option>
					<option id="7"> Aug </option>
					<option id="8"> Sept </option>
					<option id="9"> Oct </option>
					<option id="10"> Nov </option>
					<option id="11"> Dec</option>
				</select> 
				 &nbsp; <input type="text" id="year1" name="year" size="6" />
				<span style="color:#888;font-size:14px;"> <i> Eg: 2012 </i> </span> </td>
					</tr>
					
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="butArr" value="   Add   " disabled />
						</td>
					</tr>
				</table>
			</div>

			<div id="editArr">
				<table align="center" style="font-size:17px;">
					<tr>
						<td align="right"> Arrear : </td>
						<td> <input type="text" value="" id="eid2" name="eid" disabled> </td>
					</tr>
					<tr>
						<td align="right"> Value: </td>
						<td> <input type="text" value="" id="ename2" name="evalue" > </td>
					</tr>
					<tr>
						<td align="right"> Month: </td>
						<td> <input type="text" value="" id="emonth2" name="emonth" > </td>
					</tr>
					<tr>
						<td align="right"> Month of modification : </td>
						 <b style="color:navy;"> Select : </b> 
				<td> <select name="month" id="mymonth2">
					<option id="-1"> --select-- </option>
					<option id="0"> Jan </option>
					<option id="1"> Feb </option>
					<option id="2"> Mar </option>
					<option id="3"> April </option>
					<option id="4"> May </option>
					<option id="5"> June </option>
					<option id="6"> July </option>
					<option id="7"> Aug </option>
					<option id="8"> Sept </option>
					<option id="9"> Oct </option>
					<option id="10"> Nov </option>
					<option id="11"> Dec</option>
				</select> 
				 &nbsp; <input type="text" id="year2" name="year" size="6" />
				<span style="color:#888;font-size:14px;"> <i> Eg: 2012 </i> </span> </td>
					</tr>
					
					<tr> </tr>  <tr> </tr>  <tr> </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="button" id="editArrear" value="   Update   " disabled />
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
				alert("Error: <%= e %>... Redirecting to homepage...");
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