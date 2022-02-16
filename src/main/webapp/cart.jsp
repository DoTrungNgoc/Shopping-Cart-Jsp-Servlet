<%@page import="java.text.DecimalFormat"%>
<%@page import="cn.techturorial.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="cn.techturorial.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.techturorial.model.User"%>
<%@page import="cn.techturorial.connection.DbCon"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");  
List<Cart> cartProduct = null; 
if (cart_list!=null){
	ProductDao pDao = new ProductDao(DbCon.getConnection());
	cartProduct = pDao.getCartProduct(cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
	.table tbody td {
		vartical-align: midle;
	}
	.btn-incre, .btn-decre {
		box-showdow: none;
		font-size: 25px;
	}
</style>
</head>          
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="d-flex py-3">
			<h3>Total Price: $ ${ (total>0)?dcf.format(total):0 }</h3>
			<a class="mx-3 btn btn-primary" href="cart-check-out"> Check Out</a>
		</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Buy now</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
				<% 
					if (cart_list != null){
						for(Cart c:cartProduct){%>
							<tr>
								<td class="align-middle"><%= c.getName() %></td>
								<td class="align-middle"><%= c.getCategoty() %></td>
								<td class="align-middle"><%= dcf.format(c.getPrice()) %>$</td>
								<td>
									<form method="post" class="form-inline" action="order-now">
										<input type="hidden" name="id" value="<%= c.getId() %>" class="form-input">
										<div class="form-group d-flex justify-content-between">
											<a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a> 
											<input type="text" name="quantity" class="form-control w-50"  value="<%= c.getQuantity() %>" > 
											<a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a>
										</div>
										<button type="submit" class="btn btn-primary btn-sm">Buy</button>
									</form>
								</td>
								<td class="align-middle"><a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%= c.getId() %>">Remove</a> </td>
							</tr>
					<%}
					}%>
			</tbody>
		</table>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>