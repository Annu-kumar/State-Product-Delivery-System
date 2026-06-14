<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>

<head>

<title>Products</title>

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

button:hover{
background:#021f5e;
}

</style>

</head>

<body>

<h1>Products</h1>

<%

try{

String sid=
(String)request.getAttribute(
"stateId"
);

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
"SELECT * FROM products WHERE state_id=?"
);

ps.setInt(
1,
Integer.parseInt(sid)
);

ResultSet rs=
ps.executeQuery();

boolean found=false;

while(rs.next()){

found=true;

%>

<div class="card">

<img src="image/<%=rs.getString("image")%>">

<h3>
<%=rs.getString("product_name")%>
</h3>

<h2>
Rs.<%=rs.getDouble("price")%>
</h2>

<p style="
color:gray;
font-size:14px;
padding:10px;
line-height:20px;">

<%=rs.getString("description")==null
?"No description available"
:rs.getString("description")%>

</p>

<form
action="CartServlet"
method="post">

<input
type="hidden"
name="productId"
value="<%=rs.getInt("id")%>">

<button>
Add To Cart
</button>

</form>

</div>

<%

}

if(!found){

out.println(
"<h2>No Products Found</h2>"
);

}

con.close();

}

catch(Exception e){

out.println(e);

}

%>

</body>

</html>