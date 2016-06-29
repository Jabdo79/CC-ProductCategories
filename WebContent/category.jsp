<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product List</title>
<style>
table {
    width:100%;
}
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
th, td {
    padding: 5px;
    text-align: left;
}
tr:nth-child(even) {
    background-color: #eee;
}
tr:nth-child(odd) {
   background-color:#fff;
}
th {
    background-color: black;
    color: white;
}
</style>


</head>
<body>

<table>
  <tr>
  	<th>ID</th>
    <th>Product Name</th>
    <th>Category</th>
    <th>Price</th>
  </tr>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

String url = "jdbc:mysql://localhost:3306/webproducts?useSSL=true";
//DO NOT include this info in .java files pushed to GitHub in real projects
String user = "java";
String password = "java123";
String userCat = request.getParameter("categories");
String query = "";
if(userCat.equals("all"))
	query = "SELECT ID, name, category, price FROM groceries";
else
	query = "SELECT ID, name, category, price FROM groceries WHERE category ='"+userCat+"'";
try {
	Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, user, password);
    st = con.createStatement();
    rs = st.executeQuery(query);

    while (rs.next()) {
    		int id = rs.getInt(1);
    		String name = rs.getString(2);
    		String category = rs.getString(3);
    		double price = rs.getDouble(4);
    		out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + category + "</td><td>" + price + "</td></tr>");
    }
    
    		
} catch (SQLException e) {
    out.println("DB Exception: " + e);

} finally {
    try {
        if (rs != null) {
            rs.close();
        }
        if (st != null) {
            st.close();
        }
        if (con != null) {
            con.close();
        }

    } catch (SQLException e) {
    		out.println("DB Exception in finally: " + e);
    }
}

%>
</table>
<form name="form" action="category.jsp" method="post">
<select name="categories">
  <option value="all">All Categories</option>
  <option value="Produce">Produce</option>
  <option value="Meat">Meat</option>
  <option value="Cereal">Cereal</option>
  <option value="Dairy">Dairy</option>
</select>
<input type="submit" value="View Category">
</form>
</body>
</html>