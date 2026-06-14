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

@WebServlet("/VerifyOTP")

public class VerifyOTP extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();

		int userOtp = Integer.parseInt(request.getParameter("otp"));

		int storedOtp = (Integer) session.getAttribute("otp");

		if (userOtp == storedOtp) {

			try {

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root",
						"Annu@845454");

				PreparedStatement ps = con
						.prepareStatement("insert into users(name,email,phone,password) values(?,?,?,?)");

				ps.setString(1, (String) session.getAttribute("name"));

				ps.setString(2, (String) session.getAttribute("email"));

				ps.setString(3, (String) session.getAttribute("phone"));

				ps.setString(4, (String) session.getAttribute("password"));

				ps.executeUpdate();

				response.sendRedirect("login.html");

			} catch (Exception e) {

				e.printStackTrace();

			}

		} else {

			response.getWriter().println("Wrong OTP");

		}

}

}