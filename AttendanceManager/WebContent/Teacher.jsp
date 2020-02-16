<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to Teacher page</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link href="Index.css" rel="stylesheet" type="text/css" />
</head>
<body>
<% 
	String un="user";
	Cookie ck[]=request.getCookies();  
	for(int i=0;i<ck.length;i++){  
		if(ck[i].getName().equals("user"))  
	 		un = ck[i].getValue();//printing name and value of cookie  
	}  
%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
	<% 
	Connection con;
    Statement st;
    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    final String DB_URL = "jdbc:mysql://localhost:3306/attendancemanager";
    final String DUSER = "root";
    final String DPASS = "";
    String query,query1;
    int executeUpdate;
    ResultSet rs,rs1;
    %>
	<nav class="navbar navbar-expand-lg navbar-darkt bg-dark">
	  <a class="navbar-brand" href="#">Hello <%=un %> </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarNav">
	    <ul class="navbar-nav">
	      <li class="nav-item">
	        <a class="nav-link" href="Add.jsp">Add Attendance</a>
	      </li>
	       <li class="nav-item">
	        <a class="nav-link" href="Message.jsp">Message</a>
	      </li>
	      <li class="nav-item">
	     	 <Form action="LogOut" method="get">
	        	<button class="nav-link logout"  type="submit" name="submit">LogOut</button>
	        </Form>
	      </li>
	    </ul>
	  </div>
	</nav>
	
		<form action="Teacher.jsp" method="get" class="form-inline subjectSelect">
		    <select class="form-control finput" id="subject" name="subject" style="font-size:1.5rem;">
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
					out.println("</select>");
					out.println("<div class='form-group'>");
						out.println("<label style='font-size:1.2rem'>");
							String sub = request.getParameter("subject");
							if(sub==null)
								sub="DBMS";
							sub = sub.substring(4);
							System.out.println("Subject name = "+sub);
							query1 = String.format("SELECT total_lectures,lectures_taken FROM subject,teacher where subject.subject_name='"+sub+"' and subject.subject_id = teacher.subjectid");
				            rs1 = st.executeQuery(query1);
				            rs1.next();
				        		out.println(rs1.getString("lectures_taken")+" out of "+rs1.getString("total_lectures")+" lectures "+" conducted ");
				        	
						out.println("</label>");
					out.println("</div>");
					
		    }
		    catch(Exception e){
		    	System.out.println(e);
		    }
		        	
		        %>
		  </div>
	
	  <button type="submit" class="btn btn-primary mb-2">Refresh</button>
	</form>
	
	<table class="table table-hover table-striped display">
	  <thead class="thead-dark">
	    <tr>
	      <th scope="col">ID</th>
	      <th scope="col">Date</th>
	      <th scope="col">Time</th>
	      <th scope="col">Subject Name</th>
	    </tr>
	  </thead>
	  <tbody>
	 
	  
	<% 
	String sub;
	
	if(request.getParameter("subject")!=null){
		sub = request.getParameter("subject");
	}else{
		sub = "DBMS";
	}
    try {
    	
    	 	Class.forName(JDBC_DRIVER);
            
            // To set up a connect
            con = DriverManager.getConnection(DB_URL,DUSER,DPASS);
            
            // To execute statement 
            st = con.createStatement();
            // Auto connects to database
            query = String.format("SELECT attid,date,time,subject_name from attendance,subject,teacher where attendance.subid='"+sub+"' and attendance.subid = subject.subject_id and attendance.tid = teacher.tid");
            rs = st.executeQuery(query);
            while(rs.next()){
            	out.println("<tr>");
            		out.println("<td>");
            			out.println("<form action='addStudent.jsp' method='get'>");
        					out.println("<button name='submit' id='submit' class='teacherButton' value='"+rs.getString("attid")+"'>"+rs.getString("attid")+"</button>");
        				out.println("</form>");
        			out.println("<td>");
	            		out.println(rs.getString("date"));
	            	out.println("<td>");
	            		out.println(rs.getString("time"));
	            	out.println("<td>");
	            		out.println(rs.getString("subject_name"));
            	out.println("</tr>");
            }
    }
    catch(Exception e){
    	System.out.println(e);
    }
    
	%>
	</tbody>
	</table>
</body>
</html>