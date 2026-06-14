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

@WebServlet("/RemoveCartServlet")

public class RemoveCartServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)

			throws IOException {

		try {

			int productId =

					Integer.parseInt(request.getParameter("productId"));

			int userId = 1;

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con =

					DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Annu@845454");

			PreparedStatement check =

					con.prepareStatement(

							"SELECT quantity " + "FROM cart " + "WHERE user_id=? " + "AND product_id=?"

					);

			check.setInt(1, userId);
			check.setInt(2, productId);

			ResultSet rs = check.executeQuery();

			if (rs.next()) {

				int qty = rs.getInt("quantity");

				if (qty > 1) {

					PreparedStatement update =

							con.prepareStatement(

									"UPDATE cart " + "SET quantity=quantity-1 " + "WHERE user_id=? "
											+ "AND product_id=?"

							);

					update.setInt(1, userId);
					update.setInt(2, productId);

					update.executeUpdate();

				} else {

					PreparedStatement delete =

							con.prepareStatement(

									"DELETE FROM cart " + "WHERE user_id=? " + "AND product_id=?"

							);

					delete.setInt(1, userId);
					delete.setInt(2, productId);

					delete.executeUpdate();

				}

			}

			con.close();

			response.sendRedirect("CartPage.jsp");

		} catch (Exception e) {

			response.getWriter().println(e);

		}

}

}