

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Add
 */
@WebServlet("/Add")
public class Add extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Add() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	//  For connection pipeline
	    Connection con;
	    // For executing queries 
	    Statement st;
	    // Driver required to make SQL Server and application talk.
	    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	    // Database URL (That is database location)
	    final String DB_URL = "jdbc:mysql://localhost:3306/attendancemanager";
	    // Database username and password.
	    final String DUSER = "root";
	    final String DPASS = ""; // bad practice to store password like this instead store passwords in env variables.
	    // Holds the query 
	    String query,query1,query2,query3,query4,query5,query6;
	    // Holds user id. (Can be used as session ID)
	    int UID;
	    // Stores update flag. If database updated successfully then its set to true
	    int executeUpdate;
	    try {
	    	
	    	 	Class.forName(JDBC_DRIVER);
	            
	            // To set up a connect
	            con = DriverManager.getConnection(DB_URL,DUSER,DPASS);
	            
	            // To execute statement 
	            st = con.createStatement();
	            // Auto connects to database
	            int rs,rs2,rs4,rs6;
	            ResultSet rs1,rs3,rs5;
	            String tid = request.getParameter("tid");
	           
	            String s =request.getParameter("subject");
	            int subid = Integer.parseInt(s.substring(0,1));
	            System.out.println("Subject id = "+subid);
	            String date =request.getParameter("date");
	            String time =request.getParameter("time");
	            
	            query = String.format("insert into attendance(tid,subid,date,time) values('"+tid+"','"+subid+"','"+date+"','"+time+"')");
	            rs = st.executeUpdate(query);
	            
	           /* query1 = String.format("select lectures_attended from student where subjectid = '"+subid+"' and sid='"+sid+"'");
	            rs1 = st.executeQuery(query1);
	            rs1.next();
	            int num = rs1.getInt("lectures_attended");
	            num++;
	            System.out.println("lectures attended = "+num);
	            query2 = String.format("UPDATE student SET lectures_attended = '"+num+"' WHERE sid='"+sid+"'");
	            rs2 = st.executeUpdate(query2);*/
	          /*  
	            query3 = String.format("SELECT `attid` FROM `attendance` WHERE time='"+time+"' and date='"+date+"'");
	            rs3 = st.executeQuery(query3);
	            rs3.next();
	            int num1 = rs3.getInt("attid");
	            
	            query4 = String.format("INSERT INTO `presentnos`(`attid`, `sid`) VALUES ('"+num1+"','"+sid+"')");
	            rs4 = st.executeUpdate(query4);
	            
	            */
	            query5 = String.format("select 	lectures_taken from teacher where subjectid = '"+subid+"'");
	            rs5 = st.executeQuery(query5);
	            rs5.next();
	            int num3 = rs5.getInt("lectures_taken");
	            num3++;
	            System.out.println("lectures taken = "+num3);
	            query6 = String.format("UPDATE `teacher` SET `lectures_taken`='"+num3+"' WHERE subjectid='"+subid+"'");
	            rs6 = st.executeUpdate(query6);
	            
	            
	            if(rs>=1 && rs6>=1) {
	            	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Add.jsp");
           		 	request.setAttribute("message", "add success");
		 	        dispatcher.forward(request, response);
	            }
	            else {
	            	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Add.jsp");
           		 	request.setAttribute("message", "add unsuccess");
		 	        dispatcher.forward(request, response);
	            }
	         
	      }
	    catch(Exception e) {
	    	System.out.println(e);
	    	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Add.jsp");
   		 	request.setAttribute("message", "we faced a problem");
 	        dispatcher.forward(request, response);
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
