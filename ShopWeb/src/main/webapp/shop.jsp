<!DOCTYPE html>
<%@page import="tn.enis.dto.ProductDto"%>
<%@page import="java.util.List"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="ShopController" method="post">
		<table>
			<tr>
				<td>name</td>
				<td><input type="text" name="name" /></td>
			</tr>
			<tr>
				<td>Quantity</td>
				<td><input type="text" name="quantity" /></td>
			</tr>
			<tr>
				<td>Price</td>
				<td><input type="text" name="price" /></td>
			</tr>
			<tr>
				<td><input type="submit" name="action" value="Add" /></td>
			</tr>
		</table>
	</form>
	<hr />
	<h1>Liste des produits</h1>
	<%
	List<ProductDto> products = (List<ProductDto>) request.getAttribute("products");
	%>
	<table border="1">
		<tr>
			<th>Name</th>
			<th>Quantity</th>
			<th>Price</th>
			<th>Delete</th>
		</tr>
		<%
		if (products != null && !products.isEmpty()) {
			for (ProductDto product : products) {
		%>
		<tr>
			<td><%=product.getName()%></td>
			<td><%=product.getQuantity()%></td>
			<td><%=product.getPrice()%></td>
			<td><a href="ShopController?action=Delete&name=<%=product.getName()%>"><button>Delete</button></a></td>
		</tr>
		<%
		}
		}
		%>
	</table>
</body>
</html>