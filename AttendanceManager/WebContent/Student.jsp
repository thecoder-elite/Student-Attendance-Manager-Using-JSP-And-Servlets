<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Student</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="Index.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
	String sid = String.valueOf(request.getAttribute("message"));	
	%>
<% 
	String un="user";
	Cookie ck[]=request.getCookies();  
	for(int i=0;i<ck.length;i++){  
		if(ck[i].getName().equals("user"))  
	 		un = ck[i].getValue();//printing name and value of cookie  
	 		System.out.println(ck[i].getName());
	}  
%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand" href="Student.jsp" style="font-size:1.5rem">Hello <%=un %> </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarNav">
	    <ul class="navbar-nav">
	     <li class="nav-item">
	     	<!-- Button trigger modal -->
				<button type="button" class="nav-link logout" data-toggle="modal" data-target="#exampleModalCenter">
				  Raise a Query
				</button>
				
				<!-- Modal -->
				<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLongTitle">Raise a Query</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        	<form action="Query" method="get">
							  <div class="form-group">
							    <label for="tid">Enter Teacher ID</label>
							    <input type="text" class="form-control" id="tid" name="tid" placeholder="Enter Teacher ID">
							  </div>
							  <div class="form-group">
							    <label for="sid">Enter Student ID</label>
							    <input type="text" class="form-control" id="sid" name="sid" placeholder="Enter Student ID">
							  </div>
							  <div class="form-group">
							    <label for="msg">Enter Message</label>
							    <textarea row="5" col="10" class="form-control" id="msg" name="msg">
							  	</textarea>
							  </div>
							  <button type="submit" class="btn btn-primary">Submit</button>
							</form>
				      </div>
				    </div>
				  </div>
				</div>
	     	
	     </li>
	      <li class="nav-item">
	     	 <Form action="LogOut" method="get">
	        	<button class="nav-link logout"  type="submit" name="submit">LogOut</button>
	        </Form>
	      </li>
	    </ul>
	  </div>
	</nav>
	
	<% String msg = String.valueOf(request.getAttribute("message"));%>
	<%
				if(msg.equals("add success")&& !msg.equals("null"))
					out.println("<p style='color:green; text-align:center'>*"+"Query raised Successfully"+"</p>");	
				else if(msg.equals("add unsuccess")&& !msg.equals("null"))
					out.println("<p style='color:red; text-align:center'>*"+"we could not submit your query"+"</p>");	
			%>
	<table class="table table-hover display">
	  <thead class="thead-dark">
	    <tr>
	      <th scope="col">Teacher ID</th>
	      <th scope="col">Subject</th>
	      <th scope="col">Lectures attended</th>
	      <th scope="col">Total Lectures</th>
	    </tr>
	  </thead>
	  <tbody>
	    
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
    System.out.println("running script ");
    try {
    	
    	 	Class.forName(JDBC_DRIVER);
            
            // To set up a connect
            con = DriverManager.getConnection(DB_URL,DUSER,DPASS);
            
            // To execute statement 
            st = con.createStatement();
            // Auto connects to database
            query = String.format("SELECT tid,subject_name,lectures_taken,lectures_attended from student,subject,teacher where sid= '"+sid+"' and student.subjectid = subject.subject_id and subject.subject_id = teacher.subjectid");
            rs = st.executeQuery(query);
            System.out.println("running script 2");
            while(rs.next()){
            	out.println("<tr>");
            	out.println("<td>");
				out.println(rs.getString("tid"));
            		out.println("<td>");
        				out.println(rs.getString("subject_name"));
        				System.out.println("running script "+rs.getString("subject_name"));
            		out.println("<td>");
	            		out.println(rs.getString("lectures_taken"));
	            	out.println("<td>");
	            		out.println(rs.getString("lectures_attended"));
            	out.println("</tr>");
            }
            rs.close();
    
    }
    catch(Exception e){
    	System.out.println(e);
    }
    
	%>
	</tbody>
	</table>
</body>
</html>