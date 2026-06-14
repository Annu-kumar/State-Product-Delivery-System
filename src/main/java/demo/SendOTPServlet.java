package demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SendOTPServlet")

public class SendOTPServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)

			throws IOException {

		String email = request.getParameter("email");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Annu@845454");

			PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE email=?");

			check.setString(1, email);

			ResultSet rs = check.executeQuery();

			if (rs.next()) {

				Random random = new Random();

				int otp = 100000 + random.nextInt(900000);

				HttpSession session = request.getSession();

				session.setAttribute("otp", String.valueOf(otp));

				session.setAttribute("email", email);

				String sender = "anu082750@gmail.com";

				String password = "nejj adxw yerr zxzr";

				Properties p = new Properties();

				p.put("mail.smtp.auth", "true");
				p.put("mail.smtp.starttls.enable", "true");
				p.put("mail.smtp.host", "smtp.gmail.com");
				p.put("mail.smtp.port", "587");

				Session s = Session.getInstance(p, new Authenticator() {

@Override
					protected PasswordAuthentication getPasswordAuthentication() {

						return new PasswordAuthentication(sender, password);

					}
				});

				Message message = new MimeMessage(s);

				message.setFrom(new InternetAddress(sender));

				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

				message.setSubject("Password Reset OTP");

				message.setText("Your OTP is : " + otp);

				Transport.send(message);

				response.sendRedirect("otp.html");

			} else {

				response.getWriter().println("Email not registered");

			}

			con.close();

		} catch (Exception e) {

			response.getWriter().println(e.getMessage());

			e.printStackTrace();

		}

}
}