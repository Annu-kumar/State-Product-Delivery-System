<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
response.setHeader(
"Cache-Control",
"no-cache, no-store, must-revalidate");

response.setHeader(
"Pragma",
"no-cache");

response.setDateHeader(
"Expires",
0);

HttpSession userSession =
request.getSession(false);

if(userSession == null ||
userSession.getAttribute("email") == null){

	response.sendRedirect(
	"login.html");

	return;
}

int cartCount = 0;

try{

	Class.forName(
	"com.mysql.cj.jdbc.Driver"
	);

	Connection con =
	DriverManager.getConnection(
	"jdbc:mysql://localhost:3306/userdb",
	"root",
	"Annu@845454"
	);

	PreparedStatement ps =
	con.prepareStatement(

	"SELECT SUM(quantity) "+
	"FROM cart "+
	"WHERE user_id=?"

	);

	ps.setInt(1,1);

	ResultSet rs =
	ps.executeQuery();

	if(rs.next()){

		cartCount =
		rs.getInt(1);

	}

	rs.close();
	ps.close();
	con.close();

}
catch(Exception e){

	e.printStackTrace();

	out.println(e);

}
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<meta http-equiv="Cache-Control"
content="no-cache, no-store, must-revalidate">

<meta http-equiv="Pragma"
content="no-cache">

<meta http-equiv="Expires"
content="0">

<title>Home</title>

<link rel="stylesheet"
href="home.css">

</head>

<body>


<div class="navbar">

<div class="logo">
<span>🚚 State Product <br> Delivery System</span>
</div>

<div class="menu">

<a href="#">🏠 Home</a>

<a href="AllProducts.jsp">🎁 Products</a>

<a href="MyOrders.jsp">📋 My Orders</a>

<a href="CartPage.jsp">

🛒 Cart(<%=cartCount%>)

</a>

<a href="#">👤 Profile</a>

</div>

<div class="logout">
<a href="LogoutServlet">Logout</a>
</div>

</div>


<!-- Banner -->

<div class="banner">
<img src="image/banana.png" alt="State Product Banner">
</div>


<!-- State Section -->

<div class="states">

<h2 class="title">Select Your State</h2>

<div class="state-container">

<div class="card">
<a href="ProductServlet?stateId=1">
<img src="image/Bihar.png">
<h3>Bihar</h3>
</a>
</div>

<div class="card">
<a href="ProductServlet?stateId=2">
<img src="image/Punjab.png">
<h3>Punjab</h3>
</a>
</div>

<div class="card">
<a href="ProductServlet?stateId=3">
<img src="image/Rajsathan.png">
<h3>Rajasthan</h3>
</a>
</div>

<div class="card">
<a href="ProductServlet?stateId=4">
<img src="image/Utterpradesh.png" alt="Utter Pradesh">
<h3>Uttar Pradesh</h3>
</a>
</div>

<div class="card">
<a href="ProductServlet?stateId=5">
<img src="image/Odisha.png">
<h3>Odisha</h3>
</a>
</div>

</div>

</div>

<!-- About Project -->

<div class="about">

<h2>About State Product Delivery System</h2>

<p>

State Product Delivery System is an online platform developed to
connect users with famous products from different states of India.
The system helps customers explore traditional items, handicrafts,
food products, clothes, and unique state specialties from one place.

Users can select a state, view products, add items to cart,
place orders, and track their purchases easily.

Our objective is to support local businesses and promote
state culture through digital technology.

</p>

</div>



<!-- Terms and Conditions -->

<div class="terms">

<h2>Terms & Conditions</h2>

<ul>

<li>
Users should provide correct information during registration.
</li>

<li>
Products shown on the website are subject to availability.
</li>

<li>
Prices may change without prior notice.
</li>

<li>
Orders once confirmed cannot be modified after shipment.
</li>

<li>
Users should not misuse or copy website content.
</li>

<li>
Payment information should be entered carefully.
</li>

<li>
Delivery times may vary according to location.
</li>

<li>
The system reserves the right to cancel invalid orders.
</li>

</ul>

</div>

<footer class="footer">

<div class="footerTop">

<a href="home.jsp">🏠 Home</a>

<a href="#">📦 Products</a>

<a href="home.jsp#about">ℹ️ About</a>

<a href="home.jsp#contact">📞 Contact</a>

</div>


<div class="footerMiddle">

<div>
📍 Gurgaon, India
</div>

<div>
📞 +91 6206625438
</div>

<div>
📧 support@stateproducts.com
</div>

</div>


<div class="socialIcons">

<a href="#">📘</a>
<a href="#">📷</a>
<a href="#">✖</a>
<a href="#">💼</a>

</div>


<div class="footerBottom">

<span>
© 2026 All Rights Reserved
</span>

<span>
Privacy Policy
</span>

<span>
Terms & Conditions
</span>

</div>

</footer>

</body>
</html>