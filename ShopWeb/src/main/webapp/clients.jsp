<%@page import="tn.enis.entity.Client"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>shop</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<h2>Add Client</h2>
		<form action="ClientController" method="post">
			<div class="mb-3">
				<label for="cin" class="form-label">CIN</label> <input type="text"
					class="form-control" name="cin" id="cin" />
			</div>
			<div class="mb-3">
				<label for="nom" class="form-label">Nom</label> <input type="text"
					class="form-control" name="nom" id="nom" />
			</div>
			<div class="mb-3">
				<label for="prenom" class="form-label">Prenom</label> <input
					type="text" class="form-control" name="prenom" id="prenom" />
			</div>
			<button type="submit" class="btn btn-primary" name="action"
				value="Add">Add</button>
		</form>

		<hr />
		<h1>List of Clients</h1>

		<%
		List<Client> clients = (List<Client>) request.getAttribute("clients");
		%>
		<form action="ClientController" method="post">
			<div class="mb-3">
				<label for="search" class="form-label">Search</label> <input
					type="text" class="form-control" name="search" id="search" />
			</div>
			<button type="submit" class="btn btn-primary" name="action"
				value="search">Search</button>
		</form>

		<table class="table table-bordered">
			<thead>
				<tr>
					<th>CIN</th>
					<th>Nom</th>
					<th>Prenom</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (clients != null && !clients.isEmpty()) {
					for (Client client : clients) {
				%>
				<tr id="tr_cin_<%=client.getCin()%>">
					<td><%=client.getCin()%></td>
					<td><%=client.getNom()%></td>
					<td><%=client.getPrenom()%></td>
					<td><a onClick="deleteClient(<%=client.getCin()%>)"
						class="btn btn-danger">Delete</a></td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
		integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
function deleteClient(cin) {
	swal("Etes-vous sûr que vous voulez supprimer ce client ?", {
		  buttons: {
		    non: true,
		    oui: true,
		  },
		})
		.then((value) => {
		  switch (value) {
		    case "oui":
		      $.ajax({
		  		url : "ClientController",
		  		type : "POST",
		  		data : {
		  		action : "Delete",
		  		cin : cin
		  		},
		  		success : function() {
		  		$("#tr_cin_" + cin).remove();
		  		swal.stopLoading();
		  		swal("Le client a été supprimé", {
		  		     icon: "success",
		  		   });
		  		},
		  		error : function() {
		  		swal("Poof! Erreur serveur!", {
		  		     icon: "error",
		  		   });
		  		}
		  		});
		      break;
		    case "non":
		    	swal.close();
		      break;
		  }
		});
}
</script>
</body>
</html>
