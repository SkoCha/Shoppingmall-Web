<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../../commons/header.jsp" %>

<style>
	#second_section { margin-left: 15px;}
</style>

<div class="panel panel-default">
  <div class="panel-heading">
    <h1 class="panel-title"><b>상품 조회</b></h1>
  </div>
<div class="panel-body">
	<form role="form" class="form-horizontal" method="post" autocomplete="off">
	<div class="row col-md-6">
	<div class="form-group">	
		<div class="col-md-6">
  			<label>1차 분류</label>
  			<input class="form-control" type="text" name="gdsName" value="${goods.cateCodeRef}" readonly="readonly">
			</div>
			<div class="col-md-6">
  			<label>2차 분류</label>
  			<input class="form-control" type="text" name="gdsName" value="${goods.cateCode}" readonly="readonly">
			</div>
	</div>
	<div class="form-group">
		<div class="col-md-6">
			<label>상품명</label>
			<input class="form-control" type="text" name="gdsName" value="${goods.gdsName}" readonly="readonly">
		</div>
	</div>
	<div class="form-group">
		<div class="col-md-6">
			<label>상품 가격</label>
			<input class="form-control" type="text" name="gdsPrice" value='<fmt:formatNumber value="${goods.gdsPrice}" pattern="###,###,###"/>' readonly="readonly">
		</div>
	</div>
	<div class="form-group">
		<div class="col-md-6">
			<label>상품 수량</label>
			<input class="form-control" type="text" name="gdsStock" value="${goods.gdsStock}" readonly="readonly">
		</div>
	</div>
	<div class="form-group">
		<div class="col-md-6">
			<label>등록 날짜</label>
			<input class="form-control" type="text" name="gdsDate" value='<fmt:formatDate value="${goods.gdsDate}" pattern="yyyy-MM-dd"/>' readonly="readonly">
		</div>
	</div>
	<div class="form-group">
		<div class="col-md-12">
			<label>상품 설명</label>
			<textarea class="form-control" rows="5" cols="10" name="gdsDesc" readonly="readonly">${goods.gdsDesc}</textarea>
		</div>
	</div>
	<div class="form-group">
		<div class="col-md-6">
			<input type="hidden" name="num" value="${goods.gdsNum}">
				<button type="button" class="btn btn-warning" id="modify_btn">상품 수정</button>
				<button type="button" class="btn btn-danger" id="remove_btn">상품 삭제</button>
			</div>
	</div>
	</div>
	<div class="row col-md-6" id="second_section">
		<div class="form-group">
			<div class="col-md-6">
  				<label>상품 이미지</label>
			</div>
		</div>	
		<div class="form-group">
			<div class="col-md-6">
	  			<img src="${goods.gdsThumb}">
	  		</div>
  		</div>	
	
	</div>	
		<!-- 
		<div class="modal fade" id="delete_modal" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
      		<div class="modal-dialog">
   				<div class="modal-content">
          			<div class="modal-header">
       					 <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
        					<h4 class="modal-title custom_align" id="Heading">상품 삭제 확인</h4>
     				 </div>
			         <div class="modal-body">
			       		<div class="alert alert-danger">
			       			<span class="glyphicon glyphicon-warning-sign"></span>정말 이 게시물을 삭제하시겠습니까?</div>
	     			 </div>
				     <div class="modal-footer ">
				        <button type="button" class="btn btn-success" >삭제</button>
				        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				     </div>
       			 </div>
    			/.modal-content 
  			</div>
      		/.modal-dialog 
    	</div>
    	 -->
	</form>
</div>
</div>

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
	
<%@ include file="../../commons/footer.jsp" %>