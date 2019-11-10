<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="./commons/header.jsp" %>

<style>
	#goods_caption {margin: 0 25px;}
</style>

<div class="row">
	<c:forEach items="${list}" var="list">	
	  <div class="col-sm-6 col-md-4">
	    <div class="thumbnail">
		    <div class="imageWrapper">
		      <a href="/shop/view?num=${list.gdsNum}"><img src="${list.gdsThumb}" style="width: 300px; height: 300px;"></a>
		    </div>
	      <div id="goods_caption" class="caption">
	        <a href="/shop/view?num=${list.gdsNum}"><h3>${list.gdsName}</h3></a>
	        <p><fmt:formatNumber value="${list.gdsPrice}" pattern="###,###,###"/>원</p>	        
	      </div>
	    </div>
	  </div>
  </c:forEach>
</div>
<div class="row">
	<div class="col-md-6 col-md-offset-4">
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
	<form id="actionForm" action="/main" method="get">
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

<%@ include file="./commons/footer.jsp" %>