package demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)

			throws ServletException, IOException {

		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		String email = request.getParameter("email");

		String newPassword = request.getParameter("newpassword");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Annu@845454");

			PreparedStatement ps = con.prepareStatement(

					"UPDATE users SET password=? WHERE email=?"

			);

			ps.setString(1, newPassword);
			ps.setString(2, email);

			int result = ps.executeUpdate();

			if (result > 0) {

				out.println("<script>" +

						"alert('Password Updated Successfully');" +

						"window.location='login.html';" +

						"</script>");

			} else {

				out.println("<script>" +

						"alert('Email not found');" +

						"window.history.back();" +

						"</script>");

			}

			con.close();

		} catch (Exception e) {

			out.println(e);

}

	}
}