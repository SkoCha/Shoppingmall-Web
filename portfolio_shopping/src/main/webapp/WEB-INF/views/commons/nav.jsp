<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-inverse">
	<div class="navbar-header">
		<button class="navbar-toggle" type="button" data-toggle="collapse"
			data-target=".js-navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="/main">Sko's Shopping</a>
	</div>

	<div class="collapse navbar-collapse js-navbar-collapse">
		<ul class="nav navbar-nav">
			<li class="dropdown mega-dropdown"><a href="#"
				class="dropdown-toggle" data-toggle="dropdown">상품 목록 <span
					class="caret"></span></a>
				<ul class="dropdown-menu mega-dropdown-menu">
					<!--
					<li class="col-sm-3">
						 <ul>
							<li class="dropdown-header">Men Collection</li>
							<div id="menCollection" class="carousel slide"
								data-ride="carousel">
								<div class="carousel-inner">
									<div class="item active">
										<a href="#"><img
											src="http://placehold.it/254x150/ff3546/f5f5f5/&text=New+Collection"
											class="img-responsive" alt="product 1"></a>
										<h4>
											<small>Summer dress floral prints</small>
										</h4>
										<button class="btn btn-primary" type="button">49,99 €</button>
										<button href="#" class="btn btn-default" type="button">
											<span class="glyphicon glyphicon-heart"></span> Add to
											Wishlist
										</button>
									</div>
									End Item
									<div class="item">
										<a href="#"><img
											src="http://placehold.it/254x150/3498db/f5f5f5/&text=New+Collection"
											class="img-responsive" alt="product 2"></a>
										<h4>
											<small>Gold sandals with shiny touch</small>
										</h4>
										<button class="btn btn-primary" type="button">9,99 €</button>
										<button href="#" class="btn btn-default" type="button">
											<span class="glyphicon glyphicon-heart"></span> Add to
											Wishlist
										</button>
									</div>
									End Item
									<div class="item">
										<a href="#"><img
											src="http://placehold.it/254x150/2ecc71/f5f5f5/&text=New+Collection"
											class="img-responsive" alt="product 3"></a>
										<h4>
											<small>Denin jacket stamped</small>
										</h4>
										<button class="btn btn-primary" type="button">49,99 €</button>
										<button href="#" class="btn btn-default" type="button">
											<span class="glyphicon glyphicon-heart"></span> Add to
											Wishlist
										</button>
									</div>
									End Item
								</div>
								End Carousel Inner
								Controls
								<a class="left carousel-control" href="#menCollection"
									role="button" data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
									<span class="sr-only">Previous</span>
								</a> <a class="right carousel-control" href="#menCollection"
									role="button" data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
									<span class="sr-only">Next</span>
								</a>
							</div>
							/.carousel
							<li class="divider"></li>
							<li><a href="#">View all Collection <span
									class="glyphicon glyphicon-chevron-right pull-right"></span></a></li>
						</ul>
					</li>
					-->
					<li class="col-sm-3">
						<ul>
							<li class="dropdown-header"><a href="/shop/list?category=100&lev=1">Men's Item</a></li>
							<li><a href="/shop/list?category=101&lev=2">니트</a></li>
							<li><a href="/shop/list?category=102&lev=2">아우터</a></li>
							<li><a href="/shop/list?category=103&lev=2">셔츠</a></li>
							<li><a href="/shop/list?category=104&lev=2">팬츠</a></li>
							<li><a href="/shop/list?category=105&lev=2">악세서리</a></li>
							<!-- <li class="divider"></li>
							<li class="dropdown-header">Fonts</li>
							<li><a href="#">Glyphicon</a></li>
							<li><a href="#">Google Fonts</a></li> -->
						</ul>
					</li>
					<li class="col-sm-3">
						<ul>
							<li class="dropdown-header"><a href="/shop/list?category=200&lev=1">Women's Item</a></li>
							<li><a href="/shop/list?category=201&lev=2">니트</a></li>
							<li><a href="/shop/list?category=202&lev=2">아우터</a></li>
							<li><a href="/shop/list?category=203&lev=2">블라우스</a></li>
							<li><a href="/shop/list?category=204&lev=2">스커트</a></li>
							<li><a href="/shop/list?category=205&lev=2">원피스</a></li>
							<li><a href="/shop/list?category=206&lev=2">악세서리</a></li>
						</ul>
					</li>
					<li class="col-sm-3">
						<ul>
							<li class="dropdown-header"><a href="/shop/list?category=300&lev=1">ETC</a></li>
							<li><a href="/shop/list?category=301&lev=2">향수</a></li>
							<li><a href="/shop/list?category=302&lev=2">공용 화장품</a></li>
							<li><a href="/shop/list?category=303&lev=2">가방&신발</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li><a href="#">상품평</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<c:if test="${member != null}">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"> <c:out
							value="${member.userId}" /><span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/shop/myCart">장바구니</a></li>
						<li><a href="/shop/myOrder">내 주문 목록</a></li>
						<li><a href="#">작성한 상품평</a></li>
						<li class="divider"></li>
						<li><a href="#">회원 정보 수정</a></li>
					</ul></li>
				<c:if test="${member.enabled == 1}">
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" role="button" href="/admin/index"
						aria-expanded="false"> 관리자 메뉴<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="/admin/goods/register">상품 등록</a></li>
							<li><a href="/admin/goods/list">상품 목록 관리</a></li>
							<li><a href="/admin/depart">상품평 관리</a></li>
							<li class="divider"></li>
							<li><a href="/admin/depart">회원 관리</a></li>
						</ul></li>
				</c:if>
				<li><a href="/member/logout">로그아웃</a></li>
			</c:if>
			<c:if test="${member == null}">
				<li><a href="/member/register">회원 가입</a></li>
				<li><a href="/member/login">로그인</a></li>
			</c:if>
		</ul>
	</div>
	<!-- /.nav-collapse -->
</nav>
