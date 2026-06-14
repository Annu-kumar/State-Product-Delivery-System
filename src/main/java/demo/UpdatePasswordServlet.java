package demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdatePasswordServlet")

public class UpdatePasswordServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)

			throws IOException {

		String password = request.getParameter("password");

		HttpSession session = request.getSession();

		String email = (String) session.getAttribute("email");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Annu@845454");

			PreparedStatement ps = con.prepareStatement("UPDATE users SET password=? WHERE email=?");

			ps.setString(1, password);

			ps.setString(2, email);

			ps.executeUpdate();

			response.sendRedirect("login.html");

		} catch (Exception e) {

			e.printStackTrace();
}

	}
}