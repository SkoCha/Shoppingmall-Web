<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../commons/header.jsp" %>
<div class="panel panel-default">
	<div class="panel-heading">
		<h2>상세 주문 내역</h2>
	</div>
	<div class="panel-body">
		<div class="row">
        	<div class="col-md-12">
           	 	<table class="table table-hover">
           	 		<c:forEach items="${orderView}" var="orderView" varStatus="status">
           	 		<c:if test="${status.first}">
                	<tr>
                		<th><label>수령인</label></th>
                		<td>${orderView.orderRec}</td>
                	</tr>
                	<tr>
                		<th><label>배송 주소</label></th>
                		<td>(${orderView.userAddr1}) ${orderView.userAddr2} ${orderView.userAddr3}</td>
                	</tr>
                	<tr>
                		<th><label>결제 금액</label></th>
                		<td><fmt:formatNumber value="${orderView.amount}" pattern="###,###,###"/>원</td>
                	</tr>
                	<tr>
                		<th><label>상태</label></th>
                		<td>${orderView.delivery}</td>
                	</tr>
                	</c:if>
                	</c:forEach>
           		</table>
    		</div>	
    	</div>
    	<div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                    <tr>                    
                        <th>상품</th>
                        <th>  </th>
                        <th class="text-center">선택 수량</th>
                        <th class="text-center">판매가</th>
                        <th class="text-center">Total</th>
                    </tr>
                </thead>
                <tbody>
                	<c:set var="sum" value="0"/>
                	<c:forEach items="${orderView}" var="orderView">
                    <tr>
                        <td class="col-md-6">
                        <div class="media">
                            <a class="thumbnail pull-left" href="#"> <img class="media-object" src="${orderView.gdsThumb}" style="width: 72px; height: 72px;"></a>
                            <div class="media-body">
                                <h4 class="media-heading"><a href="#">${orderView.gdsName}</a></h4>
                                <h5 class="media-heading"> 카테고리 <a href="#">테스트</a></h5>
                                <span>배송 상태: </span><span class="text-success"><strong>In Stock</strong></span>
                            </div>
                        </div></td>
                        <td>  </td>
                        <td class="col-md-1" style="text-align: center">
                        <span>${orderView.cartStock}</span>개
                        </td>
                        <td class="col-md-1 text-center"><strong><fmt:formatNumber value="${orderView.gdsPrice}" pattern="###,###,###"/>원</strong></td>
                        <td class="col-md-1 text-center"><strong><fmt:formatNumber value="${orderView.gdsPrice * orderView.cartStock}" pattern="###,###,###"/>원</strong></td>
                    </tr>
                    <c:set var="sum" value="${sum + (orderView.gdsPrice * orderView.cartStock)}" />
                    </c:forEach>
                    <c:set var="deliverFee" value="2500" />
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td><h5>상품 금액</h5></td>
                        <td>   </td>
                        <td class="text-right"><h5><strong><fmt:formatNumber value="${sum}" pattern="###,###,###"/>원</strong></h5></td>
                    </tr>
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td><h5>배송료</h5></td>
                        <td>   </td>
                        <td class="text-right"><h5><strong><fmt:formatNumber value="${deliverFee}" pattern="###,###,###"/>원</strong></h5></td>
                    </tr>
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td><h5>Total</h5></td>
                        <td>   </td>
                        <td class="text-right"><h5><strong><fmt:formatNumber value="${sum + deliverFee}" pattern="###,###,###"/>원</strong></h5></td>
                    </tr>
                    </tbody>
            	</table>
        		</div>	
    </div>
	</div>
</div>

<%@ include file="../commons/footer.jsp" %>