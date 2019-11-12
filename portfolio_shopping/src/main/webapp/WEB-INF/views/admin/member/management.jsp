<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../../commons/header.jsp" %>

<style>
	.pagination { display: block; text-align: center; }
	.pagination > li > a { float: none; }
</style>

<div class="panel panel-default">
  <div class="panel-heading">
    <b><h3 class="panel-title">회원 관리 페이지</h3></b>
  </div>
  <div class="panel-body">
    <div class="row">
        <div class="col-md-12">
        <h4>회원 목록 리스트</h4>
        <div class="table-responsive">                
        	<table id="mytable" class="table table-bordred table-striped">
	            <thead>                   
	                   <th>아이디</th>
	                   <th>이름</th>
	                   <th>전화번호</th>
	                   <th>생년월일</th>
	                   <th>주소</th>
	                   <th>상세 주소</th>
	                   <th>참고 사항</th>
	                   <th>가입 일</th>                       
               	</thead>
    			<tbody>
    				<c:forEach items="${memberList}" var="memberList">    
					    <tr>
						    <td>${memberList.userId}</td>
						    <td>${memberList.userName}</td>
						    <td>${memberList.userPhone}</td>
						    <td>${memberList.userBirth}</td>
						    <td>${memberList.userAddr1}</td>
						    <td>${memberList.userAddr2}</td>
						    <td>${memberList.userAddr3}</td>
						    <td><fmt:formatDate value="${memberList.regDate}" pattern="yyyy/MM/dd" /></td>
						    <%-- <td><p data-placement="top" data-title="Delete"><button class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="${list.gdsNum}" ><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button></p></td> --%>
					    </tr>
				    </c:forEach>
				    	<!-- 
					    <script>
					    	$("button[data-title='Delete']").click(function(){
					    		var target = $(this).attr("data-target");
					    		// console.log(target);
					    		var conf = confirm("상품번호 : " + target + "을 삭제하시겠습니까?");
					    		if(conf) {
					    			$.ajax({
					    				url : "/admin/goods/list/" + target,
					    				type : "delete",
					    				success : function(result){
	                    					if(result) {
	                     					location.href = "/admin/goods/list";
	                    					} else {
	                    						alert("상품 삭제에 실패하였습니다.");
	                    					}
	                    				}
					    			});
					    		}
					    		
					    	});
					    </script>
					     -->
  				</tbody>
			</table>
			</div>
			<div class="row">
	<ul class="pagination">
		
		<c:if test="${pageMaker.prev}">
			<li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">이전</a></li>
		</c:if>
		
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
		</c:forEach>
		
		<c:if test="${pageMaker.next}">
		<li class="paginate_button next"><a href="${pageMaker.endPage + 1}">다음</a></li>
		</c:if>
	
	</ul>
	<form id="actionForm" action="/admin/member/management" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	</form>
	<script>
		$(document).ready(function(){
			var actionForm = $("#actionForm");
			$(".paginate_button a").on("click", function(e) {
				e.preventDefault();
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
		});
	</script>
</div>
</div>
</div>
</div>			
</div>

<%@ include file="../../commons/footer.jsp" %>