<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../commons/header.jsp" %>

<style>
#non_image_section { 
		margin-left: 30px;
		}
		
	#name_section { 
		border-bottom: 1px solid #e8e8e8;
		padding-bottom: 15px;
		}
		
	.column_section {
		padding-top: 20px;
		border-bottom: 1px solid #e8e8e8;
		padding-bottom: 15px;
	}
	
	.last_section {
		padding-top: 20px;
		padding-bottom: 15px;
	}
	
	.last_section input {
		width: 50px;
	}
	
	#table_section td {
		padding-left: 50px;
	}
	
	h1 small {
		margin-left: 20px;
		font-size: 75%;
	}
	
	#please_login {
		text-align: center;
	}
	
	#reply_content td{
		padding-left: 100px;
	}
	
	ul.chat {
		padding-left: 0px;
	}
	
	ul.chat li {
		list-style: none;
		border-bottom: 1px solid #e8e8e8;
		padding-top: 20px;
		margin-left: 0px;
	}
</style>

<script>
function replyList() {
 	var gdsNum = ${view.gdsNum};
 	$.getJSON("/shop/view/replyList" + "?num=" + gdsNum, function(data) {
 		var str = "";
 		$(data).each(function(){
 			var repDate = new Date(this.repDate);
 			repDate = repDate.toLocaleDateString("ko-US");
 			
 			str += "<li class='left clearfix' data-gdsNum='"+ this.gdsNum +"'>"
 				+ "<div class='header'>"
 				+ "<strong class='primary-font'>" + this.userName + "</strong> 님"
 				+ "<small class='pull-right text-muted'>" + repDate + "</small>"
 				+ "</div>"
 				+ "<p>" + this.repCon + "</p>"
 				+ "</li>"
 		});
 		$("ul.chat").html(str);
 	});
 	
}
</script>

<!-- 
<script type="text/javascript">

var formObj = $("form[role='form']");

$("#modify_btn").click(function(){
	formObj.attr("action", "/admin/goods/modify");
	formObj.attr("method", "get");
	formObj.submit();
});

$("#remove_btn").click(function(){
	var ask = confirm("정말로 삭제하시겠습니까?");
	
	if(ask) {
		formObj.attr("action", "/admin/goods/remove");
		formObj.submit();			
	}
});
</script>

 -->
<div class="panel panel-default">
  <div class="panel-heading">
    <h1 class="panel-title"><b>상품 상세 페이지</b></h1>
  </div>
<div class="panel-body">
	<div class="row col-md-6">
		<div>
  			<label>상품 이미지</label>
		</div>	
		<div>
	  		<img class="img-responsive" src="${view.gdsImg}">
  		</div>	
	</div>
	<div class="row col-md-6" id="non_image_section">
		<div id="name_section">
			<h3><label>${view.gdsName}</label></h3>
		</div>
		<div class="column_section">
			<table id="table_section">
				<tr>
					<th>등록 날짜</th>
					<td><fmt:formatDate value="${view.gdsDate}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>${view.cateName}</td>
				</tr>
				<tr>
					<th>판매가</th>
					<td><fmt:formatNumber value="${view.gdsPrice}" pattern="###,###,###"/>원</td>
				</tr>
				<tr>
					<th>잔여 수량</th>
					<td>${view.gdsStock}개</td>
				</tr>
			</table>
		</div>
		<div class="column_section">
			<div>
				<label><b>상품 설명</b></label>
			</div>			
			<div>
				${view.gdsDesc}
			</div>			
		</div>
		<form role="form" method="post">
			<input type="hidden" name="gdsNum" value="${view.gdsNum}">
		</form>
		<div class="last_section">
			<div class="form-inline">
				<div class="form-group">
					<label><b>구매 수량</b></label>
					<input class="form-control" min="1" max="${view.gdsStock}" type="number" value="1">
				</div>
				<div class="form-group">
					<button type="button" class="btn btn-primary">장바구니 추가</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<div class="panel panel-default">
	<div class="panel-heading">
		<h1 class="panel-title"><b>REVIEW</b><small>상품 한줄평을 남겨주세요.^^ 상대방을 비방하는 댓글은 무통보 삭제될 수도 있습니다.</small></h1>
	</div>
	<div class="panel-body">
		<c:if test="${member == null}">
		<h3 id="please_login">로그인 후 상품평을 남기실 수 있습니다.</h3><hr>
		</c:if>
		<c:if test="${member != null}">
    	<div class="row form-group">
    		<form role="form" method="post" autocomplete="off">
    			<input type="hidden" name="gdsNum" value="${view.gdsNum}">
	    		<div class="col-md-11">
	    			<input type="text" class="form-control" name="repCon" id="repCon" placeholder="한줄평 작성">
	    		</div>
	    		<div class="col-md-1">
	    			<button type="submit" id="reply_btn" class="btn btn-default pull-right">등록</button>
	    		</div>
    		</form>    		
   		</div>
		</c:if>
		<ul class="chat">
			<%-- 
			<c:forEach items="${reply}" var="reply">
				<li class="left clearfix" data-repNum="${reply.repNum}">
					<div class="header">
						<strong class="primary-font">${reply.userName}</strong> 님
						<small class="pull-right text-muted"><fmt:formatDate value="${reply.repDate}" pattern="yyyy/MM/dd"/></small>
					</div>
					<p>${reply.repCon}</p>
				</li>
			</c:forEach>
			 --%>
			 <script>
			 	replyList();
			 </script>
		</ul>
		 	
	</div>
</div>

 
<%@ include file="../commons/footer.jsp" %>