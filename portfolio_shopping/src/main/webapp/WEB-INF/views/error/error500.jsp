<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../commons/header.jsp" %>

<style>
	.error_section { text-align: center; margin-top: 100px; }
	.error_section p { text-align: center; margin-top: 100px; margin-bottom: 100px; }
</style>

<div class="panel panel-danger">
  <div class="panel-heading">
    <h1 class="panel-title">ERROR</h1>
  </div>
  <div class="panel-body">
  	<div class="error_section">
    	<h2>잘못된 요청으로 인한 오류가 발생하였습니다.</h2> 
    	<p>관리자에게 문의하여 주시길 바랍니다.</p>
  	</div>
  </div>
</div>

<%@ include file="../commons/footer.jsp" %>