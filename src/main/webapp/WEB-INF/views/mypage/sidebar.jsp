<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<aside class="sidebar">


	<h3>쇼핑정보</h3>
	<ul class="nav nav-pills flex-column">
		<li class="nav-item"><a class="nav-link"
			href="${pageContext.request.contextPath}/mypage/mypageOrderDelivery">주문배송현황</a></li>

	</ul>
	<hr class="hr" />

	<h3>활동정보</h3>
	<ul class="nav nav-pills flex-column">

		<li class="nav-item"><a class="nav-link"
			href="${pageContext.request.contextPath}/order/cart">장바구니</a></li>
		<li class="nav-item"><a class="nav-link"
			href="${pageContext.request.contextPath}/mypage/mypageReview">나의
				상품 후기</a></li>
	</ul>
	<hr class="hr" />
	<h3>개인정보</h3>
	<ul class="nav nav-pills flex-column">
		<li class="nav-item"><a class="nav-link"
			href="${pageContext.request.contextPath}/member/memberEdit">회원정보수정</a></li>
		<li class="nav-item">
		<a class="nav-link" href="#" id="memberDelete" data-toggle="modal" data-target="#memberDeleteModal">회원탈퇴</a>
		</li>
	</ul>
</aside>