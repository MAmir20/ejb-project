<%@page import="tn.enis.entity.Client"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>shop</title>
</head>
<body>
	<form action="ClientController" method="post">
		<table>
			<tr>
				<td>cin</td>
				<td><input type="text" name="cin" /></td>
			</tr>
			<tr>
				<td>nom</td>
				<td><input type="text" name="nom" /></td>
			</tr>
			<tr>
				<td>prenom</td>
				<td><input type="text" name="prenom" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="action" value="Add" /></td>
			</tr>
		</table>
	</form>

	<hr />
	<h1>List of Products</h1>
	<%
	List<Client> clients = (List<Client>) request.getAttribute("clients");
	%>
	<form action="ClientController" method="post">
		<table>
			<tr>
				<td>search</td>
				<td><input type="text" name="search" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="action" value="search" /></td>
			</tr>
		</table>
	</form>
	<table border="1">
		<tr>
			<td>cin</td>
			<td>nom</td>
			<td>prenom</td>
			<td>Delete</td>
		</tr>
		<%
		if (clients != null && !clients.isEmpty()) {
			for (Client client : clients) {
		%>
		<tr>
			<td><%=client.getCin()%></td>
			<td><%=client.getNom()%></td>
			<td><%=client.getPrenom()%></td>
			<td><a
				href="ClientController?action=Delete&cin=<%=client.getCin()%>">delete</a>
		</tr>
		<%
		}
		}
		%>
	</table>
</body>
</html>