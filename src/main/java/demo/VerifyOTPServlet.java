package demo;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")

public class VerifyOTPServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)

			throws IOException {

		String userOtp = request.getParameter("otp");

		HttpSession session = request.getSession();

		String savedOtp = (String) session.getAttribute("otp");

		if (userOtp.equals(savedOtp)) {

			response.sendRedirect("newpassword.html");

		} else {

			response.getWriter().println("Wrong OTP");

}

	}
}