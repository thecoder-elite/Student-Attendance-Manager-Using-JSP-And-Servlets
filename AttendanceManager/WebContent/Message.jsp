<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View your messages here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link href="Index.css" rel="stylesheet" type="text/css" />
</head>
<body>
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
				<li class="nav-item"><a class="nav-link" href="Message.jsp">Messages</a>
				</li>
				<li class="nav-item">
					<Form action="LogOut" method="get">
						<button class="nav-link logout" type="submit" name="submit">LogOut</button>
					</Form>
				</li>
			</ul>
		</div>
	</nav>

	<table class="table table-hover table-striped display">
		<thead class="thead-dark">
			<tr>
				<th scope="col">Student ID</th>
				<th scope="col">Message</th>
			</tr>
		</thead>
		<tbody>
			<tr>
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
					try {

						Class.forName(JDBC_DRIVER);

						// To set up a connect
						con = DriverManager.getConnection(DB_URL, DUSER, DPASS);

						// To execute statement 
						st = con.createStatement();
						// Auto connects to database
						query = String.format("SELECT `sid`, `feedback` FROM `query` WHERE tid='" + un + "' ");
						rs = st.executeQuery(query);

						while (rs.next()) {
							out.println("<tr>");
							out.println("<td>" + rs.getString("sid") + "</td>");
							out.println("<td>" + rs.getString("feedback") + "</td>");
							out.println("</tr>");
						}
					} catch (Exception e) {
						System.out.println(e);
					}
				%>
			</tr>
		</tbody>
	</table>


</body>
</html>