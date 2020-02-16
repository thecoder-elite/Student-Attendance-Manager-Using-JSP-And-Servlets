<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List of present Roll nos</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link href="Index.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%
		Connection con;
		Statement st;
		final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		final String DB_URL = "jdbc:mysql://localhost:3306/attendancemanager";
		final String DUSER = "root";
		final String DPASS = "";
		String query;
		int executeUpdate;
		ResultSet rs;
		int rs1;
	%>
	<%
		String un = "user";
		Cookie ck[] = request.getCookies();
		for (int i = 0; i < ck.length; i++) {
			if (ck[i].getName().equals("user"))
				un = ck[i].getValue();//printing name and value of cookie  
		}
	%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="Teacher.jsp">Hello <%=un%>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="Add.jsp">Add
						Attendance</a></li>
				<li class="nav-item"><a class="nav-link" href="Message.jsp">Message</a>
				</li>
				<li class="nav-item">
					<Form action="LogOut" method="get">
						<button class="nav-link logout" type="submit" name="submit">LogOut</button>
					</Form>
				</li>
			</ul>
		</div>
	</nav>

	<!-- Adding a new Student -->
	<form class="form-inline"
		style="margin-left: 25%; margin-top: 2rem; margin-bottom: 2rem;" action="AddAttendance" method="get">
		<div class="form-group mx-sm-3 mb-2">
			<label for="attIDInput" class="sr-only">Attendance ID</label> <input
				type="text" class="form-control finput" id="attIDInput" name="attIDInput"
				placeholder="Enter Attendance ID">
		</div>
		<div class="form-group mx-sm-3 mb-2">
			<label for="sidInput" class="sr-only">Student ID</label> <input
				type="text" class="form-control finput" id="sidInput" name="sidInput"
				placeholder="Enter Student ID">
		</div>
		<button type="submit" name="addStud" id="addStud" class="btn btn-primary mb-2" value="addStud">Add
			Student</button>
	</form>
	<!-- --------------------------------------- -->

	<table class="table table-striped table-hover display"
		style="margin-top: 1rem;">
		<thead class="thead-dark">
			<tr>
				<th scope="col">Attendance ID</th>
				<th scope="col">Student ID</th>
				<th scope="col">Status</th>
				<th scope="col">Delete</th>
			</tr>
		</thead>
		<tbody>
			<%
				try {

					Class.forName(JDBC_DRIVER);

					// To set up a connect
					con = DriverManager.getConnection(DB_URL, DUSER, DPASS);

					// To execute statement 
					st = con.createStatement();
					// Auto connects to database
					int attid = Integer.parseInt(request.getParameter("submit"));
					System.out.println(attid);
					query = String.format("SELECT attid,`sid` FROM `presentnos` WHERE attid='" + attid + "'");
					rs = st.executeQuery(query);
					while (rs.next()) {
						out.println("<tr>");
							out.println("<form action='DeleteAttedance' method='get'>");
								out.println("<td>");
									out.println("<input type='text' readonly class='form-control-plaintext' id='attid' name='attid' value='"+rs.getString("attid")+"' />");
								out.println("<td>");
									out.println("<input type='text' readonly class='form-control-plaintext' id='sid' name='sid' value='"+rs.getString("sid")+"' />");
								out.println("<td>");
									out.println("<p style='color:green'>" + "Present" + "</p>");
								out.println("<td>");
									out.println(
											"<button name='delete' id='delete' class='btn btn-outline-danger' value='Mark as Absent'>"
													+ "Mark as Absent" + "</button>");
							out.println("</form>");
						out.println("</tr>");

					}

				} catch (Exception e) {
					System.out.println(e);
				}
			%>
		</tbody>
	</table>

</body>
</html>