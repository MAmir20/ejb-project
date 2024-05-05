<%@page import="tn.enis.entity.Compte"%>
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
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
	integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.min.js"
	integrity="sha256-sw0iNNXmOJbQhYFuC9OF2kOlD5KQKe1y5lfBn4C9Sjg="
	crossorigin="anonymous"></script>
<script>  
var clientsDict = [
<%List<Client> clients = (List<Client>) request.getAttribute("clients");
if (clients != null && !clients.isEmpty()) {
	for (int i = 0; i < clients.size(); i++) {
		Client client = clients.get(i);%>
    {
        "label": "<%=client.getPrenom()%> <%=client.getNom()%>",
        "value": "<%=client.getCin()%>",
        "id": <%=client.getCin()%>
    }<%=i < clients.size() - 1 ? "," : ""%>
<%}
}%>
];

$(function() {
    $("#client").autocomplete({
        source: clientsDict,
        minLength: 1,
        select: function(event, ui) {
            // Optional: handle selection event
            console.log(ui.item);
        }
    });
});
</script>


</head>
<body>
	<div class="container">
		<h2>Add Compte</h2>
		<form action="CompteController" method="post">
			<div class="mb-3 ui-widget">
				<label for="client" class="form-label">Client</label> <input
					type="text" class="form-control" name="cin" id="client" />
			</div>
			<div class="mb-3">
				<label for="solde" class="form-label">Solde</label> <input
					type="text" class="form-control" name="solde" id="solde" />
			</div>
			<button type="submit" class="btn btn-primary" name="action"
				value="Add">Add</button>
		</form>

		<hr />
		<h1>
			List of Comptes
			<%=request.getParameter("search") != null ? "of " + request.getParameter("search") : ""%></h1>

		<%
		List<Compte> comptes = (List<Compte>) request.getAttribute("comptes");
		%>
		<form action="CompteController" method="get">
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
					<th>Client</th>
					<th>RIB</th>
					<th>Solde</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (comptes != null && !comptes.isEmpty()) {
					for (Compte compte : comptes) {
				%>
				<tr id="tr_cpt_<%=compte.getRib()%>">
					<td><%=compte.getClient().getCin()%></td>
					<td><%=compte.getClient().getPrenom()%> <%=compte.getClient().getNom()%></td>
					<td><%=compte.getRib()%></td>
					<td><%=compte.getSolde()%></td>
					<td><a
						onClick="editCompte(<%=compte.getRib()%>, <%=compte.getSolde() %>)"
						class="btn btn-warning">Edit</a> <a
						onClick="deleteCompte(<%=compte.getRib()%>)"
						class="btn btn-danger">Delete</a></td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
		<hr />
		<a href="/ShopWeb/ClientController" class="btn btn-secondary">Voir Clients</a>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
function deleteCompte(rib) {
	swal("Etes-vous sûr que vous voulez supprimer ce compte ?", {
		  buttons: {
		    non: true,
		    oui: true,
		  },
		})
		.then((value) => {
		  switch (value) {
		    case "oui":
		      $.ajax({
		  		url : "CompteController",
		  		type : "POST",
		  		data : {
		  		action : "Delete",
		  		rib : rib
		  		},
		  		success : function() {
		  		$("#tr_cpt_" + rib).remove();
		  		swal.stopLoading();
		  		swal("Le compte a été supprimé", {
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


function editCompte(rib, solde) {
    // Assuming you have some form for editing client information
    // You can customize this according to your HTML structure
    const formHtml = `
        <form id="editCompteForm">
            <!-- Add your form fields here for editing client information -->
            <input type="number" id="compteSolde" placeholder="Solde" value="`+solde+`">
        </form>
    `;

    // Show the form in Swal modal
    swal({
        title: "Modifier le compte",
        content: {
            element: "div",
            attributes: {
                innerHTML: formHtml
            }
        },
        buttons: {
            annuler: true,
            enregistrer: {
                text: "Enregistrer",
                value: "enregistrer",
                className: "swal-button--confirm",
            }
        },
    }).then((value) => {
        if (value === "enregistrer") {
            // Perform client update here
            const solde = $("#compteSolde").val();

            $.ajax({
		  		url : "CompteController",
		  		type : "POST",
		  		data : {
		  		action : "Update",
		  		rib:rib,
		  		solde : solde
		  		},
		  		success : function() {
		  		$("#tr_cpt_" + rib).load(location.href + " #tr_cpt_" + rib+">*","" );
		  		swal.stopLoading();
		  		swal("Compte mis à jour avec succès", {
		  		     icon: "success",
		  		   });
		  		},
		  		error : function() {
		  		swal("Poof! Erreur serveur!", {
		  		     icon: "error",
		  		   });
		  		}
		  		});
            console.log("Updated compte solde:", solde);

//             swal("Client mis à jour avec succès", {
//                 icon: "success",
//             });
        }
    });
}


</script>
</body>
</html>
