<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../commons/header.jsp" %>
<c:forEach items="${orderList}" var="orderList">
<div class="panel panel-default">
	<div class="panel-heading">
		<h2>상품 주문서</h2>
	</div>
	<div class="panel-body">
		<div class="row">
        	<div class="col-md-12">
           	 	<table class="table table-hover">
                	<tr>
                		<th><label>주문번호</label></th>
                		<td><a href="/shop/myOrderView?num=${orderList.orderId}">${orderList.orderId}</a></td>
                	</tr>
                	<tr>
                		<th><label>수령인</label></th>
                		<td>${orderList.orderRec}</td>
                	</tr>
                	<tr>
                		<th><label>배송 주소</label></th>
                		<td>${orderList.userAddr1} ${orderList.userAddr2} ${orderList.userAddr3}</td>
                	</tr>
                	<tr>
                		<th><label>결제 금액</label></th>
                		<td><fmt:formatNumber value="${orderList.amount}" pattern="###,###,###"/>원</td>
                	</tr>
                	<tr>
                		<th><label>상태</label></th>
                		<td>${orderList.delivery}</td>
                	</tr>
           		</table>
    		</div>	
    	</div>    
	</div>
</div>
</c:forEach>

<%@ include file="../commons/footer.jsp" %>