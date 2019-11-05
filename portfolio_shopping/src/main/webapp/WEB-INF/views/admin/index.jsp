<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../commons/header.jsp" %>

<div>
	<h1>관리자 메인 페이지</h1>
</div>
<div>
	<p>관리자 메인 페이지 입니다.</p>
</div>
<c:if test="${member != null}">
	<div>
		<p>관리자 ${member.userId}님 환영합니다.</p>
	</div>
	<div>
		<p><a href="/main">일반 화면</a></p>
	</div>
	<a href="/member/logout">로그아웃</a>
</c:if>
<%@ include file="../commons/footer.jsp" %>