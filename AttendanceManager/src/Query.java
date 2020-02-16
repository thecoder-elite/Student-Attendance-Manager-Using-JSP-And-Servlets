
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

/**
 * Servlet implementation class Query
 */
@WebServlet("/Query")
public class Query extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Query() {
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
		int rs;

		String sid = request.getParameter("sid");
		String tid = request.getParameter("tid");
		String msg = request.getParameter("msg");
		if (sid.equals("") && tid.equals("") && msg.equals("")) {
			try {

				Class.forName(JDBC_DRIVER);

				// To set up a connect
				con = DriverManager.getConnection(DB_URL, DUSER, DPASS);

				// To execute statement
				st = con.createStatement();
				// Auto connects to database
				query = String.format("INSERT INTO `query`(`tid`, `sid`, `feedback`) VALUES ('" + tid + "','" + sid
						+ "','" + msg + "')");
				rs = st.executeUpdate(query);
				if (rs >= 1) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Student.jsp");
					request.setAttribute("message", "add success");
					dispatcher.forward(request, response);
				} else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Student.jsp");
					request.setAttribute("message", "add unsuccess");
					dispatcher.forward(request, response);
				}

			} catch (Exception e) {
				System.out.println(e);
			}
		}
		else {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Student.jsp");
			request.setAttribute("message", "add unsuccess");
			dispatcher.forward(request, response);
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
