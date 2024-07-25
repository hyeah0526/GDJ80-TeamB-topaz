<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Header -->
  <header id="header" class="header d-flex align-items-center sticky-top">
      <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">
	      <a href="gstMain" class="logo d-flex align-items-center">
	        <!-- 로고 이미지 -->
	        <img src="/topaz/assets/img/TOPAZ_logo.png" alt="">
	        <h1 class="sitename">TOPAZ.</h1>
	      </a>
	
	      <nav id="navmenu" class="navmenu">
		    <ul>
		        <li><a href="gstMain" class="active">Home</a></li>
		        <li><a href="infoPrograms">서비스 및 프로그램</a></li>&nbsp;&nbsp;&nbsp;
		        <li class="dropdown"><span>세대 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i>
		            <ul>
		                <li><a href="infoRegidentDiamond">다이아몬드동</a></li>
		                <li><a href="infoRegidentSilver">실버동</a></li>
		                <li><a href="infoStep">입주 절차</a></li>
		            </ul>
		        </li>&nbsp;&nbsp;
		        <li><a href="volunteerRqAdd">봉사 신청</a></li>
		        <li><a href="newsList">알림마당</a></li>
		        <%
		            // 세션에서 사용자 정보 확인
		            Object guest = session.getAttribute("guest");
		            
		            if (guest != null) {
		                // 로그인 상태
		        %>
		                <li class="dropdown">
		                    <span class="active">내 정보</span>
		                    <i class="bi bi-chevron-down toggle-dropdown"></i>
		                    <ul>
		                        <li><a href="gstMyInfo">마이페이지</a></li>
		                        <li><a href="gstMyVolAppList">내 봉사활동</a></li>
		                    </ul>
		                </li>
		                <li><a href="<%= request.getContextPath() %>/gstLogout">로그아웃</a></li>
		        <%
		            } else {
		                // 비로그인 상태
		        %>
		                <li><a href="gstLogin" id="loginLink" class="active">로그인</a></li>
		                <li><a href="signUp" id="signUpLink" class="active">회원가입</a></li>
		        <%
		            }
		        %>
		    </ul>
		    <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
		</nav>
    </div>
  </header><!-- Header 끝 -->
</body>
</html>