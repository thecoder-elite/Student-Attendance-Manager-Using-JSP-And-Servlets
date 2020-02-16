<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Please add the roll no of students</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link href="Index.css" rel="stylesheet" type="text/css" />


<!-- Date picker -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- Time picker -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<!-- function for date and time picker in jquery-->
  <script>
  //datepicker
  $( function() {
    $( "#date" ).datepicker();
  } );
  
  //timepicker
  $( function() {
	  $("#time").timepicker({
		    timeFormat: 'h:mm p',
		    interval: 60,
		    minTime: '7:30am',
		    maxTime: '6:30pm',
		    defaultTime: '8:30am',
		    startTime: '7:30am',
		    dynamic: true,
		    dropdown: true,
		    scrollbar: true
		});
  } );
  </script>

</head>
<body>
<% 
String msg = String.valueOf(request.getAttribute("message"));
	String un="user";
	Cookie ck[]=request.getCookies();  
	for(int i=0;i<ck.length;i++){  
		if(ck[i].getName().equals("user"))  
	 		un = ck[i].getValue();//printing name and value of cookie  
	}  
%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand" href="Teacher.jsp">Hello <%=un %> </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarNav">
	    <ul class="navbar-nav">
	      <li class="nav-item">
	        <a class="nav-link" href="Add.jsp">Add Attendance</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="Message.jsp">Messages</a>
	      </li>
	      <li class="nav-item">
	     	 <Form action="LogOut" method="get">
	        	<button class="nav-link logout"  type="submit" name="submit">LogOut</button>
	        </Form>
	      </li>
	    </ul>
	  </div>
	</nav>
	
	<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
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
    
    
	%>
	
		<form action="Add" method="get" class="loginForm">
		
		  <div class="form-group">
		    <label for="date">Date</label>
		    <input type="text" class="form-control finput" id="date" placeholder="MM/DD/YYY" name="date">
		  </div>
		  
		  <div class="form-group">
		    <label for="time">Time</label>
		    <input type="text" class="form-control finput" id="time" placeholder="Enter Lecture time" name="time">
		  </div>
		  
		   <div class="form-group">
		    <label for="subject">Subject</label>
		    <select class="form-control finput" id="subject" name="subject">
		        <%
		        try {
		        	
		    	 	Class.forName(JDBC_DRIVER);
		            
		            // To set up a connect
		            con = DriverManager.getConnection(DB_URL,DUSER,DPASS);
		            
		            // To execute statement 
		            st = con.createStatement();
		            // Auto connects to database
		            query = String.format("SELECT `subject_id`, `subject_name` FROM `subject`");
		            rs = st.executeQuery(query);
		    			
					while(rs.next()){
		        		out.println("<option>"+rs.getInt("subject_id")+" - "+rs.getString("subject_name")+"</option>");
		        	}
		    }
		    catch(Exception e){
		    	System.out.println(e);
		    }
		        	
		        %>
		      </select>
		  </div>
		  
		   <div class="form-group">
		    <label for="tid">Teacher ID</label>
		    <input type="text" class="form-control finput" id="tid" placeholder="Enter your ID" name="tid">
		  </div>
		  
		 
		  
		  <button type="submit" class="btn btn-success regButton1" name="submit" style="margin-top:1rem;">Submit</button>
		  <%
				if(msg.equals("add success")&& !msg.equals("null"))
					out.println("<p style='color:green'>*"+msg+"</p>");
				else if(!msg.equals("null"))
					out.println("<p style='color:red'>*"+msg+"</p>");	
			%>
		</form>
	
</body>

</html>