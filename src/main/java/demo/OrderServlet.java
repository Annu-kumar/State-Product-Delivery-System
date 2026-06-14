package demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		try {

			double total = Double.parseDouble(request.getParameter("total"));

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Annu@845454");

			// Save Order

			PreparedStatement ps1 = con.prepareStatement(

					"INSERT INTO ordertotal(user_id,total_amount,status) VALUES(?,?,?)",

					Statement.RETURN_GENERATED_KEYS

			);

			ps1.setInt(1, 1);

			ps1.setDouble(2, total);

			ps1.setString(3, "Placed");

			ps1.executeUpdate();

			// Get Order ID

			ResultSet rs = ps1.getGeneratedKeys();

			int orderId = 0;

			if (rs.next()) {

				orderId = rs.getInt(1);

			}

			// Get Cart + Product Details

			PreparedStatement ps2 = con.prepareStatement(

					"SELECT c.product_id," + "c.quantity," + "p.product_name," + "p.price " + "FROM cart c "
							+ "JOIN products p " + "ON c.product_id=p.id " + "WHERE c.user_id=?"

			);

			ps2.setInt(1, 1);

			ResultSet cartRs = ps2.executeQuery();

			// Save Order Items

			while (cartRs.next()) {

				int productId = cartRs.getInt("product_id");

				String productName = cartRs.getString("product_name");

				double price = cartRs.getDouble("price");

				int quantity = cartRs.getInt("quantity");

				double subtotal = price * quantity;

				PreparedStatement ps3 = con.prepareStatement(

						"INSERT INTO order_items(order_id,product_id,product_name,price,quantity,subtotal) VALUES(?,?,?,?,?,?)"

				);

				ps3.setInt(1, orderId);

				ps3.setInt(2, productId);

				ps3.setString(3, productName);

				ps3.setDouble(4, price);

				ps3.setInt(5, quantity);

				ps3.setDouble(6, subtotal);

				ps3.executeUpdate();

			}

			// Clear Cart

			PreparedStatement ps4 = con.prepareStatement(

					"DELETE FROM cart WHERE user_id=?"

			);

			ps4.setInt(1, 1);

			ps4.executeUpdate();

			con.close();

			response.sendRedirect("OrderSuccess.jsp");

		} catch (Exception e) {

			e.printStackTrace();

			response.getWriter().println(e);

		}
	}
}