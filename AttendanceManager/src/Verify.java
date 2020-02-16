
import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Verify
 */
@WebServlet("/Verify")
public class Verify extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Verify() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// For connection pipeline
		Connection con;
		// For executing queries
		Statement st;
		// Driver required to make SQL Server and application talk.
		final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		// Database URL (That is database location)
		final String DB_URL = "jdbc:mysql://localhost:3306/attendancemanager";
		// Database username and password.
		final String DUSER = "root";
		final String DPASS = ""; // bad practice to store password like this instead store passwords in env
									// variables.
		// Holds the query
		String query, query1;
		try {

			Class.forName(JDBC_DRIVER);

			// To set up a connect
			con = DriverManager.getConnection(DB_URL, DUSER, DPASS);

			// To execute statement
			st = con.createStatement();
			// Auto connects to database

			String un1 = request.getParameter("uname").trim();
			System.out.println("username is " + un1);
			String pw1 = request.getParameter("pwd").trim();
			System.out.println("username is " + pw1);

			System.out.println("Checkbox status is " + request.getParameter("stud"));

			if (request.getParameter("act").equals("Login") && request.getParameter("Radio").equals("Student")) {

				// To store data returned from statement
				ResultSet rs;
				query = String.format("SELECT sid,spass FROM student where sid='" + un1 + "' and spass='" + pw1 + "' ");
				rs = st.executeQuery(query);

				if (rs.next()) {
					System.out.println("login successfull");
					
					Cookie ck = new Cookie("user", un1);// creating cookie object
					response.addCookie(ck);// adding cookie in the response
					
					// response.sendRedirect(request.getContextPath() + "/#");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Student.jsp");
					request.setAttribute("message", un1);
					dispatcher.forward(request, response);
				} else {
					System.out.println("login unsuccessfull");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Index.jsp");
					request.setAttribute("message", "login unsuccess");
					dispatcher.forward(request, response);
				}
			}
			// Teacher login
			else if (request.getParameter("act").equals("Login") && request.getParameter("Radio").equals("Teacher")) {
				// To store data returned from statement
				ResultSet rs1;
				query1 = String.format(
						"SELECT `tid`, `tpass` FROM `teacher` WHERE tid='" + un1 + "' and tpass='" + pw1 + "' ");
				rs1 = st.executeQuery(query1);

				if (rs1.next()) {
					System.out.println("login successfull");
					
					Cookie ck = new Cookie("user", un1);// creating cookie object
					response.addCookie(ck);// adding cookie in the response
					
					// response.sendRedirect(request.getContextPath() + "/#");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Teacher.jsp");
					request.setAttribute("message", un1);
					dispatcher.forward(request, response);
				} else {
					System.out.println("login unsuccessfull");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Index.jsp");
					request.setAttribute("message", "login unsuccess");
					dispatcher.forward(request, response);
				}
			}
		}

		catch (Exception ex) {
			System.out.println("Err in connect: " + ex);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
