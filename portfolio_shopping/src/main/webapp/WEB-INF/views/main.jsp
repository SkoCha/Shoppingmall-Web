<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="./commons/header.jsp" %>

<style>
	#goods_caption {margin: 0 25px;}
 	.imageWrapper { width: 300px; height: 300px;}
	.thumbnail a img { 
		margin-left: 8%;
		margin-top: 5%; 
		}
</style>

<div class="row">
	<c:forEach items="${list}" var="list">	
	  <div class="col-sm-6 col-md-4">
	    <div class="thumbnail">
		    <div class="imageWrapper">
		      <a href="/shop/view?num=${list.gdsNum}"><img src="${list.gdsThumb}"></a>
		    </div>
	      <div id="goods_caption" class="caption">
	        <a href="/shop/view?num=${list.gdsNum}"><h3>${list.gdsName}</h3></a>
	        <p><fmt:formatNumber value="${list.gdsPrice}" pattern="###,###,###"/>원</p>	        
	      </div>
	    </div>
	  </div>
  </c:forEach>
</div>

<%@ include file="./commons/footer.jsp" %>