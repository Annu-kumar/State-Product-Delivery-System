package demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Myservlet")

public class Myservlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String name = request.getParameter("username");

		String email = request.getParameter("email");

		String phone = request.getParameter("phone");

		String password = request.getParameter("password");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Annu@845454");


			// Check duplicate email
			PreparedStatement check = con.prepareStatement("select * from users where email=?");

			check.setString(1, email);

			ResultSet rs = check.executeQuery();

			if (rs.next()) {

				response.sendRedirect("NewFile.html?error=Email already exists");

				return;
			}


			// Generate OTP
			Random random = new Random();

			int otp = 1000 + random.nextInt(9000);

			HttpSession session = request.getSession();

			session.setAttribute("name", name);

			session.setAttribute("email", email);

			session.setAttribute("phone", phone);

			session.setAttribute("password", password);

			session.setAttribute("otp", otp);

			SendMail.sendOTP(email, String.valueOf(otp));

			response.sendRedirect("otp1.html");

			con.close();

		}
		catch (Exception e) {

			e.printStackTrace();

		}
	}
}