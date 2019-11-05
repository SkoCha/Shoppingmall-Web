<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../commons/header.jsp" %>

<div>
	<h1>회원가입 페이지</h1>
</div>
<div>
	<form action="/member/register" method="post">
		<div>
			<label>이메일</label>
			<input type="email" name="userId" placeholder="이메일을 입력하세요." required="required">
		</div>
		<div>
			<label>이름</label>
			<input type="text" name="userName" placeholder="이름을 입력하세요." required="required">
		</div>
		<div>
			<label>휴대폰번호</label>
			<input type="text" name="userPhone" placeholder="휴대폰 번호를 입력하세요." required="required">
		</div>
		<div>
			<label>비밀번호</label>
			<input type="password" name="userPass" placeholder="비밀번호를 입력하세요." required="required">
		</div>
		<div>
			<label>비밀번호 확인</label>
			<input type="password" name="userRePass" placeholder="비밀번호를 다시 입력하세요." required="required">
		</div>
		<div>
			<label>생년 월일</label>
			<input type="text" name="userBirth" placeholder="생년월일을 입력하세요. ex)1990-01-01" required="required">
		</div>
		<div>
			<label>주소</label><input type="text" name="userAddr1" placeholder="주소를 입력하세요">
			<label>주소</label><input type="text" name="userAddr2" placeholder="주소를 입력하세요">
			<label>주소</label><input type="text" name="userAddr3" placeholder="주소를 입력하세요">
		</div>
		<input type="hidden" name="_csrf.parameterName" value="_csrf.token">
		<input type="submit" value="회원 가입">
	</form>
</div>

<%@ include file="../commons/footer.jsp" %>
