<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to attendance manager</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link href="Index.css" rel="stylesheet" type="text/css" />

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Sriracha&display=swap"
	rel="stylesheet">
</head>
<body class="indexBody">
	<h1 class="indexHeader">Welcome to Attendance Manager</h1>

	<%
		String msg = String.valueOf(request.getAttribute("message"));
	%>
	<div class="mainBody">
		<form action="Verify" class="loginForm" method="get">
			<div class="form-group">
				<label for="username">User ID:</label> <input type="text"
					class="form-control finput" placeholder="Enter User ID" id="uname"
					name="uname">
			</div>
			<div class="form-group">
				<label for="pwd">Password:</label> <input type="password"
					class="form-control finput" placeholder="Enter password" id="pwd"
					name="pwd">
			</div>


			<div class="form-check" style="margin-top:0.5rem; margin-bottom:0.5rem;">
				<input class="form-check-input fcheck" type="radio" name="Radio"
					id="Student" value="Student" checked> <label
					class="form-check-label" for="Student">Student</label>
			</div>
			<div class="form-check" style="margin-top:0.5rem; margin-bottom:0.5rem;">
				<input class="form-check-input fcheck" type="radio" name="Radio"
					id="Teacher" value="Teacher"> <label
					class="form-check-label" for="Teacher">Teacher</label>
			</div>


			<button type="submit" class="btn btn-primary loginButton" name="act"
				value="Login">Login</button>
			
			<div style="margin-top: 1rem; font-size: 1.2rem;">
				<%
					if (msg.equals("reg success") && !msg.equals("null"))
						out.println("<p style='color:green'>*" + msg + "</p>");
					else if (!msg.equals("null"))
						out.println("<p style='color:red'>*" + msg + "</p>");
				%>
			</div>
		</form>
	</div>
</body>
</html>