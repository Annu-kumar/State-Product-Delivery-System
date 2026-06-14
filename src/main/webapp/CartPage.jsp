<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>

<head>

<title>My Cart</title>

<style>

body{
font-family:Arial;
text-align:center;
background:#f5f5f5;
}

.card{
width:250px;
display:inline-block;
margin:20px;
padding:15px;
background:white;
border-radius:10px;
box-shadow:0px 0px 10px gray;
}

.card img{
width:100%;
height:180px;
object-fit:cover;
border-radius:10px;
}

button{
padding:10px;
background:#003b9b;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
}

h2{
color:green;
}

</style>

</head>

<body>

<h1>My Cart</h1>

<%

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

"SELECT products.id,"+
"products.product_name,"+
"products.price,"+
"products.image,"+
"cart.quantity "+
"FROM cart "+
"JOIN products "+
"ON cart.product_id=products.id "+
"WHERE cart.user_id=?"

);

ps.setInt(1,1);

ResultSet rs=
ps.executeQuery();

double total=0;

boolean found=false;

while(rs.next()){

found=true;

double price=
rs.getDouble("price");

int qty=
rs.getInt("quantity");

double subtotal=
price*qty;

total+=subtotal;

%>

<div class="card">

<img src="image/<%=rs.getString("image")%>">

<h3>
<%=rs.getString("product_name")%>
</h3>

<p>

<form
action="UpdateQuantityServlet"
method="post">

<input
type="hidden"
name="productId"
value="<%=rs.getInt("id")%>">

<button
name="action"
value="minus">

-

</button>

<%=qty%>

<button
name="action"
value="plus">

+

</button>

</form>

</p>

<p>
Price:
Rs.<%=price%>
</p>

<p>
Subtotal:
Rs.<%=subtotal%>
</p>

<form
action="RemoveCartServlet"
method="post">

<input
type="hidden"
name="productId"
value="<%=rs.getInt("id")%>">

<button type="submit">
Remove
</button>

</form>

</div>

<%
}

if(!found){
%>

<h2>Your Cart is Empty</h2>

<%
}
%>

<h2>

Total :
Rs.<%=total%>

</h2>

<form
action="OrderServlet"
method="post">

<input
type="hidden"
name="total"
value="<%=total%>">

<button type="submit">

Place Order

</button>

</form>

<%

rs.close();
ps.close();
con.close();

%>

</body>
</html>