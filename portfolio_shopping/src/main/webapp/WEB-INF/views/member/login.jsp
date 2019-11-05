<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../commons/header.jsp" %>

<div>
	<h1>로그인 페이지</h1>
</div>
<form action="/member/login" method="post">
<div>
	<label>이메일</label>
	<input type="email" name="userId" required="required" placeholder="example@example.com">
</div>
<div>
	<label>비밀번호</label>
	<input type="password" name="userPass" required="required" placeholder="비밀번호">
</div>
<div>
	<input type="submit" value="로그인">
</div>
<c:if test="${result == false}">
	<p style="color:red;">로그인에 실패하였습니다.</p>
</c:if>
</form>

<%@ include file="../commons/footer.jsp" %>