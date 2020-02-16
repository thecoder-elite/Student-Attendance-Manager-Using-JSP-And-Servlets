
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddAttendance
 */
@WebServlet("/AddAttendance")
public class AddAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddAttendance() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		java.sql.Connection con;
		java.sql.Statement st;
		final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		final String DB_URL = "jdbc:mysql://localhost:3306/attendancemanager";
		final String DUSER = "root";
		final String DPASS = "";
		String query;
		int executeUpdate;
		ResultSet rs;
		int rs1;
		String checkInsert = request.getParameter("addStud");

		if (checkInsert.equals("addStud") && checkInsert != null) {
			try {

				Class.forName(JDBC_DRIVER);

				// To set up a connect
				con = DriverManager.getConnection(DB_URL, DUSER, DPASS);

				// To execute statement
				st = con.createStatement();
				// Auto connects to database
				String sid = request.getParameter("sidInput");
				int attid = Integer.parseInt(request.getParameter("attIDInput"));
				query = String
						.format("INSERT INTO `presentnos`(`attid`, `sid`) VALUES ('" + attid + "','" + sid + "')");
				rs1 = st.executeUpdate(query);
				if (rs1 == 1) {
					System.out.println("Successfully Inserted");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/addStudent.jsp");
					request.setAttribute("submit", attid);
					dispatcher.forward(request, response);
				}
				else {
					response.sendRedirect("addStudent.jsp");
				}

			} catch (Exception e) {
				System.out.println(e);
			}
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
