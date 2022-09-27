<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/css/common/searchBox.css">
<link rel="stylesheet"  href="/css/common/header.css">
<meta name="description" content="Phozogy Template">
<meta name="keywords" content="Phozogy, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="770076919086-eq6fgbjuq59078luff512ol07ifc52h8.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css?family=Quantico:400,700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">

<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="/css/bootstraps/css/bootstrap.min.css"
   type="text/css">
<link rel="stylesheet"
   href="/css/bootstraps/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/css/bootstraps/css/elegant-icons.css"
   type="text/css">
<link rel="stylesheet"
   href="/css/bootstraps/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet"
   href="/css/bootstraps/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/css/bootstraps/css/slicknav.min.css"
   type="text/css">
<link rel="stylesheet" href="/css/bootstraps/css/style.css"
   type="text/css">



<!-- Header Section Begin -->
<header class="header-section">
   <div class="container-fluid">
      <div class="row">
         <div class="col-lg-12">
				<!-- 로그인 회원가입 마이페이지 -->
				<div id="top_mini_1" style="margin-right: 30px">
				<!-- 마스터에 들어 있던 것  -->
					<ul class="clearfix">
						<sec:authorize access="isAnonymous()">
							<li><a href="/account/sign-in">로그인</a></li>
							<li><a href="/account/sign-up">회원가입</a></li>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal" var="member"/>
							<li><p>${member.memberDto.memberName}</p> <li><p style="font-size: 14px; margin-left: -11px;">님</p></li>
							<li><p>관리자</p></li>
							<c:set var="String" value="${login.user_id }"/>
							<li><a href="/account/logout">로그아웃</a></li>
							<c:if test="${member.memberDto.memberRole == 'ROLE_ADMIN'}">
								<li><a href="/admin/enrollBook">관리자 페이지</a></li>
							</c:if>
						</sec:authorize>
					</ul>
					<!-- 로그인 회원가입 마이페이지 -->
					<div id="mobile-menu-wrap"></div>
				</div>
			</div>
		</div>
	</div>
</header>

<!-- Header End -->