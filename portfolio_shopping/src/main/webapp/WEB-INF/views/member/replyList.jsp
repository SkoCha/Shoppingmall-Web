<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../commons/header.jsp" %>
<style>
	.pagination { display: block; text-align: center; }
	.pagination > li > a { float: none; }
</style>

<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">내가 작성한 모든 상품평</h3>
  </div>
  <div class="panel-body">
    <div class="row">
        <div class="col-md-12">
        <h4>리스트</h4>
        <div class="table-responsive">                
              <table id="mytable" class="table table-bordred table-striped">
                   <thead>
	               		<th>댓글 번호</th>
	                   	<th>작성자</th>
	                   	<th>댓글 작성 상품</th>
	                   	<th>작성 내용</th>
	                   	<th>작성 날짜</th>
	                   	<th>삭제</th>
                	</thead>
    				<tbody>
    					<c:forEach items="${replyList}" var="replyList">
					    <tr>
						    <td>${replyList.repNum}</td>
						    <td>${replyList.userId}</td>
						    <td><a href="/shop/view?num=${replyList.gdsNum}">바로가기</a></td>
						    <td>${replyList.repCon}</td>
						    <td><fmt:formatDate value="${replyList.repDate}" pattern="yyyy/MM/dd"/></td>
						    <td><button class="btn btn-danger btn-xs" data-title="Delete" data-target="${replyList.repNum}" ><span class="glyphicon glyphicon-trash"></span></button></td>
					    </tr>
					    </c:forEach>
					    <script>
					    	$("button[data-title='Delete']").click(function(){
					    		var target = $(this).attr("data-target");
					    		// console.log(target);
					    		var conf = confirm("댓글번호 : " + target + "을 삭제하시겠습니까?");
					    		if(conf) {
					    			$.ajax({
					    				url : "/member/replyList/" + target,
					    				type : "delete",
					    				success : function(result){
	                    					if(result) {
	                     					location.href = "/member/replyList";
	                    					} else {
	                    						alert("상품평 삭제에 실패하였습니다.");
	                    					}
	                    				}
					    			});
					    		}
					    		
					    	});
					    </script>
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
				<form id="actionForm" action="/member/replyList" method="get">
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

<%@ include file="../commons/footer.jsp" %>