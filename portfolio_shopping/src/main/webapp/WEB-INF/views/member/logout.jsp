<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../commons/header.jsp" %>

<div>
	<h1>로그아웃 페이지</h1>
</div>
<form action="/member/logout" method="post">
<div>
	<input type="hidden" name="_csrf.parameterName" value="_csrf.token">
	<input type="submit" value="로그아웃">
</div>
</form>

<%@ include file="../commons/footer.jsp" %>