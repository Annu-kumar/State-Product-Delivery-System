package demo;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class SendMail {

	public static void sendOTP(String to, String otp) throws Exception {

		String from = "anu082750@gmail.com";

		String password = "nejj adxw yerr zxzr";

		Properties p = new Properties();

		p.put("mail.smtp.host", "smtp.gmail.com");

		p.put("mail.smtp.port", "587");

		p.put("mail.smtp.auth", "true");

		p.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(p,

				new Authenticator() {

					@Override
					protected PasswordAuthentication getPasswordAuthentication() {

						return new PasswordAuthentication(from, password);

					}

				});

		Message message = new MimeMessage(session);

		message.setFrom(new InternetAddress(from));

		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

		message.setSubject("OTP Verification");

		message.setText("Your OTP is : " + otp);

		Transport.send(message);

}

}