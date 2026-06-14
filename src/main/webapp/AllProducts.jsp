<%@ page import="java.sql.*" %>

<%

int cartCount = 0;

try{

	Class.forName("com.mysql.cj.jdbc.Driver");

	Connection con =
	DriverManager.getConnection(
	"jdbc:mysql://localhost:3306/userdb",
	"root",
	"Annu@845454"
	);

	PreparedStatement ps =
	con.prepareStatement(

	"SELECT SUM(quantity) FROM cart WHERE user_id=?"

	);

	ps.setInt(1,1);

	ResultSet rs = ps.executeQuery();

	if(rs.next()){

		cartCount = rs.getInt(1);

	}

	con.close();

}
catch(Exception e){

	e.printStackTrace();

}

%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>All Products</title>

<style>

body{
	margin:0;
	font-family:Arial,sans-serif;
	background:#f4f6fb;
}

/* ================= NAVBAR ================= */

.navbar{

	display:flex;
	justify-content:space-between;
	align-items:center;

	padding:15px 30px;

	background:linear-gradient(
	to right,
	#021b4d,
	#003b9b
	);

	color:white;
}

.logo{

	font-size:25px;
	font-weight:bold;
}

.menu a{

	color:white;
	text-decoration:none;

	margin:0px 18px;

	font-size:17px;
	font-weight:bold;

	transition:.3s;
}

.menu a:hover{

	color:#ffd700;
}

.logout a{

	color:white;

	text-decoration:none;

	border:1px solid white;

	padding:10px 20px;

	border-radius:20px;

	font-weight:bold;
}

.logout a:hover{

	background:white;

	color:#003b9b;
}

/* ================= HEADING ================= */

.heading{

	text-align:center;

	font-size:45px;

	color:#003b9b;

	margin:40px 0;

	font-weight:bold;
}

/* ================= PRODUCTS ================= */

.productContainer{

	width:90%;

	margin:auto;

	display:grid;

	grid-template-columns:
	repeat(auto-fit,minmax(250px,1fr));

	gap:30px;

	padding-bottom:50px;
}

/* Product Card */

.productCard{

	background:white;

	border-radius:15px;

	overflow:hidden;

	box-shadow:
	0 5px 15px rgba(0,0,0,.15);

	transition:.4s;

	text-align:center;
}

.productCard:hover{

	transform:translateY(-10px);

	box-shadow:
	0 10px 25px rgba(0,0,0,.25);
}

.productCard img{

	width:100%;

	height:220px;

	object-fit:cover;
}

.productCard h2{

	color:#003b9b;

	font-size:20px;

	margin:15px 10px;
}

.productCard p{

	color:#666;

	font-size:15px;

	line-height:22px;

	padding:0 15px;

	min-height:80px;
}

.productCard h3{

	color:green;

	font-size:30px;

	margin:15px 0;
}

.productCard button{

	background:#003b9b;

	color:white;

	border:none;

	padding:12px 25px;

	border-radius:8px;

	font-size:16px;

	cursor:pointer;

	margin-bottom:20px;

	transition:.3s;
}

.productCard button:hover{

	background:#021b4d;

	transform:scale(1.05);
}

</style>

</head>

<body>

<!-- Navbar -->

<div class="navbar">

<div class="logo">
 State Product Delivery System
</div>

<div class="menu">

<a href="home.jsp">🏠 Home</a>

<a href="AllProducts.jsp">
🎁 Products
</a>

<a href="MyOrders.jsp">
📋 My Orders
</a>

<a href="CartPage.jsp">
🛒 Cart(<%=cartCount%>)
</a>

</div>

<div class="logout">

<a href="LogoutServlet">
Logout
</a>

</div>

</div>

<!-- Heading -->

<h1 class="heading">
All Products
</h1>

<!-- Product Section -->

<div class="productContainer">

<%

try{

	Class.forName(
	"com.mysql.cj.jdbc.Driver"
	);

	Connection con=
	DriverManager.getConnection(

	"jdbc:mysql://localhost:3306/userdb",
	"root",
	"Annu@845454"

	);

	PreparedStatement ps=
	con.prepareStatement(

	"SELECT * FROM products"

	);

	ResultSet rs=
	ps.executeQuery();

	while(rs.next()){

	String description =
	rs.getString("description");

	if(description == null){

		description =
		"Quality product available for delivery.";

	}

%>

<div class="productCard">

<img src="image/<%=rs.getString("image")%>"
alt="Product Image">

<h2>
<%=rs.getString("product_name")%>
</h2>

<p>
<%=description%>
</p>

<h3>
Rs. <%=rs.getDouble("price")%>
</h3>

<form action="CartServlet"
method="post">

<input type="hidden"
name="productId"
value="<%=rs.getInt("id")%>">

<button type="submit">

Add To Cart

</button>

</form>

</div>

<%

	}

	con.close();

}
catch(Exception e){

	out.println(
	"<h2 style='color:red;text-align:center;'>"
	+ e.getMessage() +
	"</h2>"
	);

}

%>

</div>

</body>
</html>