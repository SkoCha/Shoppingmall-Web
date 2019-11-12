<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../commons/header.jsp" %>
<style>
	#post_btn { margin-left: 30px; }
	.empty_cart { text-align: center; }
</style>
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
                    	<c:set var="deliverFee" value="0"/>
                    	<c:if test="${cartList != null}">
                    		 <c:set var="deliverFee" value="${deliverFee + 2500}"/>
                    	</c:if>
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
            	<form action="/shop/myCart" class="form-horizontal" method="post" role="form" autocomplete="off">
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
    							<div class="form-group form-inline">
    								<label class="col-sm-2 control-label">우편번호</label>
    								<div class="col-sm-2">
    									<input type="text" id="sample2_postcode" required="required" class="form-control" placeholder="우편번호">
   									</div>
   									<div class="col-sm-2">
    									<input type="button" id="post_btn" class="form-control" onclick="sample2_execDaumPostcode()" value="주소 찾기">
    								</div>
    							</div>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">주소</label>
    								<div class="col-sm-4">
    									<input type="text" name="userAddr1" id="sample2_address" required="required" class="form-control" placeholder="주소">
    								</div>
    							</div>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">상세 주소</label>
    								<div class="col-sm-4">
    									<input type="text" name="userAddr2" id="sample2_detailAddress" required="required" class="form-control" placeholder="상세 주소">
    								</div>
    							</div>
    							<div class="form-group">
    								<label class="col-sm-2 control-label">참고 항목</label>
    								<div class="col-sm-4">
    									<input type="text" name="userAddr3" id="sample2_extraAddress" required="required" class="form-control" placeholder="참고 항목">
    								</div>
    							</div>
    							<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
									<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
									</div>
									
									<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
									<script>
									    var element_layer = document.getElementById('layer');
									
									    function closeDaumPostcode() {
									        element_layer.style.display = 'none';
									    }
									
									    function sample2_execDaumPostcode() {
									        new daum.Postcode({
									            oncomplete: function(data) {
									                var addr = ''; // 주소 변수
									                var extraAddr = ''; // 참고항목 변수
									
									                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
									                    addr = data.roadAddress;
									                } else { // 사용자가 지번 주소를 선택했을 경우(J)
									                    addr = data.jibunAddress;
									                }
									
									                if(data.userSelectedType === 'R'){
									                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
									                        extraAddr += data.bname;
									                    }
									                    if(data.buildingName !== '' && data.apartment === 'Y'){
									                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
									                    }
									                    if(extraAddr !== ''){
									                        extraAddr = ' (' + extraAddr + ')';
									                    }
									                    document.getElementById("sample2_extraAddress").value = extraAddr;
									                
									                } else {
									                    document.getElementById("sample2_extraAddress").value = '';
									                }
									
									                document.getElementById('sample2_postcode').value = data.zonecode;
									                document.getElementById("sample2_address").value = addr;
									                document.getElementById("sample2_detailAddress").focus();
									
									                element_layer.style.display = 'none';
									            },
									            width : '100%',
									            height : '100%',
									            maxSuggestItems : 5
									        }).embed(element_layer);
									
									        element_layer.style.display = 'block';
									
									        initLayerPosition();
									    }
									
									    function initLayerPosition(){
									        var width = 300; //우편번호서비스가 들어갈 element의 width
									        var height = 400; //우편번호서비스가 들어갈 element의 height
									        var borderWidth = 5; //샘플에서 사용하는 border의 두께
									
									        element_layer.style.width = width + 'px';
									        element_layer.style.height = height + 'px';
									        element_layer.style.border = borderWidth + 'px solid';
									        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
									        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
									    }
									</script>
  						</div>
					</div>
                        <button type="button" class="btn btn-default" id="toList">
                            <span class="glyphicon glyphicon-shopping-cart"></span> 상품 목록
                        </button>
                        <script>
                        	$("#toList").click(function(){
                        		location.href = "/main";
                        	});
                        </script>
                        <button type="submit" class="btn btn-success pull-right" id="order_btn">
                            상품 주문 <span class="glyphicon glyphicon-play"></span>
                        </button>
                        <script>
                        	$("#order_btn").click(function(e){
                        		e.preventDefault();
                        	});
                        </script>
                        </form>
        			</div>
        		</div>	
    </div>    
	</div>
</div>
    

<%@ include file="../commons/footer.jsp" %>