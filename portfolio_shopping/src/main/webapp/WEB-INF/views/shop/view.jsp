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
 			
 			str += "<li class='left clearfix' data-repNum='"+ this.repNum +"'>"
 				+ "<div class='header'>"
 				+ "<strong class='primary-font'>" + this.userName + "</strong> 님"
 				+ "<small class='pull-right text-muted'>" + repDate + "</small>"
 				+ "</div>"
 				+ "<p><span>" + this.repCon + "</span>"
 				+ "<c:if test='${member != null}'>"
 				+ "<button id='replyDelete_btn' data-repNum='" + this.repNum + "' class='btn btn-danger btn-xs pull-right' style='margin-left:5px;'>삭제</button>"
 				+ "<button id='replyModify_btn' data-repNum='" + this.repNum + "' class='btn btn-warning btn-xs pull-right'>수정</button>"
 				+ "</c:if>"
 				+ "</p>"
 				+ "</li>"
 		});
 		$("ul.chat").html(str);
 	});
}

function replyRegist() {
	$("#reply_btn").on("click", function(){
		
		var formObj = $("form[role='replyForm']");
		var gdsNum = $("#gdsNum").val();
		var repCon = $("#repCon").val();
		
		var data = {
				gdsNum : gdsNum,
				repCon : repCon
		};
		
		$.ajax({
			url : "/shop/view/replyRegist",
			type : "post",
			data : data,
			success : function(){
				replyList();
				$("#repCon").val("");
			}
		});
		
	});	
}


$(document).on("click", "#replyDelete_btn", function(){
	
	var deleteConfirm = confirm("댓글을 삭제하시겠습니까?");
	if(deleteConfirm) {
		var data = { repNum : $(this).attr("data-repNum") };
		
		$.ajax({
			url : "/shop/view/replyDelete",
			type : "post",
			data : data,
			success : function(result){
				if(result == 1) {
					replyList();
				} else {
					alert("본인이 작성한 댓글만 삭제 가능합니다.");
				}
			},
			error : function() {
				alert("로그인 후에 삭제할 수 있습니다.");
			}
		});
	}
});
	
$(document).on("click", "#replyModify_btn", function(){
	$("#modifyModal").modal();
	var repNum = $(this).attr("data-repNum");
	var repCon = $(this).parent().children("span").text();
	
	$(".modalInput > input").val(repCon);
	$(".modal_modify_btn").attr("data-repNum", repNum);
});

$(document).on("click", ".modal_modify_btn", function(){
	
	var modifyConfirm = confirm("댓글을 수정하시겠습니까?");
	if(modifyConfirm) {
		var data = { 
				repNum : $(this).attr("data-repNum"),
				repCon : $(".modalInput > input").val()
				};
		
		$.ajax({
			url : "/shop/view/replyModify",
			type : "post",
			data : data,
			success : function(result){
				if(result == 1) {
					replyList();
					$("#modifyModal").modal("hide");
				} else {
					alert("본인이 작성한 댓글만 수정 가능합니다.");
				}
			},
			error : function() {
				alert("로그인 후에 수정할 수 있습니다.");
			}
		});
	}
});

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
				<c:if test="${view.gdsStock > 0}">
				<div class="form-group">
					<label><b>구매 수량</b></label>
					<input class="form-control numBox" min="1" max="${view.gdsStock}" type="number" value="1">
				</div>
				<div class="form-group">
					<button type="button" class="btn btn-primary addCart_btn">장바구니 추가</button>
					<script>
					$(".addCart_btn").click(function(){
						
						var gdsNum = $("#gdsNum").val();
						var cartStock = $(".numBox").val();
						
						var data = {
								gdsNum : gdsNum,
								cartStock : cartStock
						};
						
						$.ajax({
							url : "/shop/view/addCart",
							type : "post",
							data : data,
							success : function(result){
								if(result == 1) {
									alert("장바구니에 추가 하였습니다.");
								} else {
									alert("로그인 후 이용할 수 있습니다.");
								}
								$(".numBox").val("1");
							},
							error : function(){
								alert("장바구니 추가에 실패하였습니다.");
							}
						});
						
					});
					</script>
				</div>
				</c:if>
				<c:if test="${view.gdsStock == 0}">
					<label><b>현재 재고가 없습니다.</b></label>
				</c:if>
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
    		<form role="replyForm" method="post" autocomplete="off">
    			<input type="hidden" id="gdsNum" name="gdsNum" value="${view.gdsNum}">
	    		<div class="col-md-11">
	    			<input type="text" class="form-control" name="repCon" id="repCon" placeholder="한줄평 작성">
	    		</div>
	    		<div class="col-md-1">
	    			<button type="button" id="reply_btn" class="btn btn-default pull-right">등록</button>
	    		</div>
	    		<script>
	    			replyRegist();
	    		</script>
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
  <div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title">한줄 상품평 수정</h4>
        </div>
        <div class="modal-body">
          <p>아래의 내용을 수정합니다.</p>
          <div class="modalInput">
          	<input type="text" class="form-control" name="repCon">
          </div>
        </div>
          <div class="modal-footer">	
          	<button type="button" class="btn btn-primary modal_modify_btn" data-dismiss="modal">수정하기</button>
          </div>
      </div>
      
    </div>
  </div>

	</div>
</div>

 
<%@ include file="../commons/footer.jsp" %>