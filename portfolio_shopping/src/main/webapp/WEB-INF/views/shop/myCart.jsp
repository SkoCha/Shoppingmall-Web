<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../commons/header.jsp" %>
<div class="panel panel-default">
	<div class="panel-body">
		<div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                    <tr>                    
                        <th>상품</th>
                        <th class="text-center">선택 수량</th>
                        <th class="text-center">판매가</th>
                        <th class="text-center">Total</th>
                        <th>장바구니 삭제</th>
                    </tr>
                </thead>
                <tbody>
                	<c:set var="sum" value="0"/>
                	<c:forEach items="${cartList}" var="cartList">
                    <tr>
                        <td class="col-md-6">
                        <div class="media">
                            <a class="thumbnail pull-left" href="#"> <img class="media-object" src="${cartList.gdsThumb}" style="width: 72px; height: 72px;"></a>
                            <div class="media-body">
                                <h4 class="media-heading"><a href="#">${cartList.gdsName}</a></h4>
                                <h5 class="media-heading"> 카테고리 <a href="#">테스트</a></h5>
                                <span>배송 상태: </span><span class="text-success"><strong>In Stock</strong></span>
                            </div>
                        </div></td>
                        <td class="col-md-1" style="text-align: center">
                        <span>${cartList.cartStock}</span>개
                        </td>
                        <td class="col-md-1 text-center"><strong><fmt:formatNumber value="${cartList.gdsPrice}" pattern="###,###,###"/>원</strong></td>
                        <td class="col-md-1 text-center"><strong><fmt:formatNumber value="${cartList.gdsPrice * cartList.cartStock}" pattern="###,###,###"/>원</strong></td>
                        <td class="col-md-1">
                        <button type="button" id="cart_delete_btn" class="btn btn-danger" data-cartNum="${cartList.cartNum}">
                            <span class="glyphicon glyphicon-remove"></span> 삭제하기
                        </button></td>
                    </tr>
                    <c:set var="sum" value="${sum + (cartList.gdsPrice * cartList.cartStock)}" />
                    </c:forEach>
                    <c:set var="deliverFee" value="2500" />
                    <script>
                   		$("#cart_delete_btn").on("click", function(){
                   			var conf = confirm("선택한 상품을 삭제하시겠습니까?");
               				if(conf) {
                    			var cartNum = $(this).attr("data-cartNum");
                    			console.log(cartNum);
                    			$.ajax({
                    				url : "/shop/myCart/" + cartNum,
                    				type : "delete",
                    				success : function(result){
                    					if(result) {
                     					location.href = "/shop/myCart";
                    					} else {
                    						alert("장바구니 삭제에 실패하였습니다.");
                    					}
                    				}
                    			});
                   			}	
                    	});
                    	
                    </script>
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td><h5>총 상품 금액</h5></td>
                        <td class="text-right"><h5><strong><fmt:formatNumber value="${sum}" pattern="###,###,###"/>원</strong></h5></td>
                    </tr>
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td><h5>배송료</h5></td>
                        <td class="text-right"><h5><strong><fmt:formatNumber value="${deliverFee}" pattern="###,###,###"/>원</strong></h5></td>
                    </tr>
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td><h3>Total</h3></td>
                        <td class="text-right"><h3><strong><fmt:formatNumber value="${sum + deliverFee}" pattern="###,###,###"/>원</strong></h3></td>
                    </tr>
                    </tbody>
            	</table>
            	<div class="orderInfo">
            	<form class="form-horizontal" method="post" role="form" autocomplete="off">
                    <div class="panel panel-default">
  						<div class="panel-heading"><label>주문 정보 입력하기</label></div>
  						<div class="panel-body order">
    						
    							<input type="hidden" name="amount" value="${sum}"/>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">수령인</label>
    								<div class="col-sm-3">
    									<input type="text" name="orderRec" id="orderRec" required="required" class="form-control" placeholder="수령인의 이름을 입력하세요.">
    								</div>
    							</div>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">수령인 연락처</label>
    								<div class="col-sm-2">
    									<input type="text" name="orderPhone" id="orderPhone" required="required" class="form-control" placeholder="010-XXXX-YYYY">
    								</div>
    							</div>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">우편번호</label>
    								<div class="col-sm-2">
    									<input type="text" name="userAddr1" id="userAddr1" required="required" class="form-control" placeholder="우편번호">
    								</div>
    							</div>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">주소</label>
    								<div class="col-sm-4">
    									<input type="text" name="userAddr2" id="userAddr2" required="required" class="form-control" placeholder="EX) 경기도 성남시 분당구 구미동">
    								</div>
    							</div>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">상세 주소</label>
    								<div class="col-sm-6">
    									<input type="text" name="userAddr3" id="userAddr3" required="required" class="form-control" placeholder="EX) 주공아파트 101동 101호">
    								</div>
    							</div>
  						</div>
					</div>
                        <button type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-shopping-cart"></span> 상품 목록
                        </button>
                        <button type="submit" class="btn btn-success pull-right">
                            상품 주문 <span class="glyphicon glyphicon-play"></span>
                        </button>
                        </form>
        			</div>
        		</div>	
    </div>    
	</div>
</div>
    

<%@ include file="../commons/footer.jsp" %>