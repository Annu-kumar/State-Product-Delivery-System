package demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String email = request.getParameter("email");

		String password = request.getParameter("password");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Annu@845454");

			PreparedStatement ps = con.prepareStatement(

					"SELECT * FROM users WHERE email=?"

			);

			ps.setString(1, email);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				String dbPassword = rs.getString("password");

				if (password.equals(dbPassword)) {

					// Create Session
					HttpSession session = request.getSession();

					session.setAttribute("email", email);

					response.sendRedirect("home.jsp");

				} else {

					response.sendRedirect("login.html?error=Wrong Password");

				}

			}
			else {

				response.sendRedirect("login.html?error=Invalid Email");

			}

			con.close();

		}
		catch (Exception e) {

			e.printStackTrace();

		}

	}
}