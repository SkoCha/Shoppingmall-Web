<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../commons/header.jsp" %>
<style>
	.header { display: block; text-align: center;  }
	.header > h1 { float: none; padding: 0 20px 30px 20px; border-bottom: 1px solid #eee; }
</style>
<div class="panel panel-default">
  <div class="panel-body">
  	<div class="row header">
  		<h1>로그인 페이지</h1>
  	</div>
  	<div class="col-md-4">
  	</div>	
  	<div class="col-md-4">
	<form class="form-horizontal" action="/member/login" method="post" autocomplete="off">
		<div class="form-group">
			<label>이메일</label>
			<input class="form-control" type="email" name="userId" placeholder="example@example.com" required="required">
		</div>
		<div class="form-group">
			<label>비밀번호</label>
			<input class="form-control" type="password" name="userPass" placeholder="비밀번호를 입력하세요." required="required">
		</div>
		<div class="form-group">
			<button type="submit" class="btn btn-primary btn-lg btn-block">로그인</button>
		</div>
	</form>
		<c:if test="${result == false}">
			<p style="color:red; text-align:center;">로그인에 실패하였습니다.</p>
		</c:if>	
</div>
<div class="col-md-4">
</div>
  	</div>
  </div>




<%@ include file="../commons/footer.jsp" %>