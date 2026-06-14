<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Orders</title>

<style>

body{

margin:0;

font-family:Arial,sans-serif;

background:#f4f4f4;

}

.header{

background:#003b9b;

color:white;

padding:20px;

text-align:center;

font-size:30px;

font-weight:bold;

}

.container{

width:90%;

margin:30px auto;

}

table{

width:100%;

border-collapse:collapse;

background:white;

box-shadow:0 0 10px rgba(0,0,0,.2);

}

th{

background:#003b9b;

color:white;

padding:15px;

}

td{

padding:15px;

text-align:center;

border-bottom:1px solid #ddd;

}

tr:hover{

background:#f5f5f5;

}

.status{

color:green;

font-weight:bold;

}

.backBtn{

display:inline-block;

margin-bottom:20px;

padding:10px 20px;

background:#003b9b;

color:white;

text-decoration:none;

border-radius:5px;

}

.backBtn:hover{

background:#001f66;

}

.noOrder{

background:white;

padding:30px;

text-align:center;

font-size:20px;

box-shadow:0 0 10px rgba(0,0,0,.2);

}

</style>

</head>

<body>

<div class="header">

📋 My Orders

</div>

<div class="container">

<a href="home.jsp" class="backBtn">

← Back to Home

</a>

<table>

<tr>

<th>Order ID</th>

<th>Total Amount</th>

<th>Status</th>

<th>Order Date</th>

</tr>

<%

boolean found=false;

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

"SELECT * FROM ordertotal WHERE user_id=? ORDER BY id DESC"

);

ps.setInt(1,1);

ResultSet rs=
ps.executeQuery();

while(rs.next()){

found=true;

%>

<tr>

<td>

<%=rs.getInt("id")%>

</td>

<td>

₹ <%=rs.getDouble("total_amount")%>

</td>

<td class="status">

<%=rs.getString("status")%>

</td>

<td>

<%=rs.getTimestamp("order_date")%>

</td>

</tr>

<%

}

con.close();

}
catch(Exception e){

out.println(e);

}

%>

</table>

<%

if(!found){

%>

<div class="noOrder">

No Orders Found

</div>

<%

}

%>

</div>

</body>

</html>