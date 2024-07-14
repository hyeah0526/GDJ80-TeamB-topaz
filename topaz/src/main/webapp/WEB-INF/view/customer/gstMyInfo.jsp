<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>회원가입</title>
  <!-- Favicons -->
  <link href="/topaz//topaz/assets/img/TOPAZ_logo.png" rel="icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/topaz/assets/vendorGST/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/aos/aos.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/glightbox/css/glightbox.min.css" rel="stylesheet">
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음 주소 API -->

  <!-- Main CSS File -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">
</head>

<body class="team-page">
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
          <li><a href="gstMain">Home</a></li>
          <li><a href="infoCompany">회사소개</a></li>
          <li><a href="infoPrograms">프로그램</a></li>
          <li class="dropdown"><a href="infoRegident"><span>세대 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
            <ul>
              <li><a href="infoRegidentA">A동</a></li>
              <li><a href="#">B동</a></li>
              <li><a href="#">C동</a></li>
              <li><a href="#">Dropdown 4</a></li>
            </ul>
          </li>
          <li><a href="volunteerRqAdd">봉사 신청</a></li>
          <li><a href="newsList">알림마당</a></li>
          <!-- JavaScript로 동적으로 변경될 부분 -->
          <li><a href="gstMyInfo" id="myInfoLink" class="active">내 정보</a></li>
          <li><a href="gstLogin" id="loginLink" class="active">로그인</a></li>
          <li><a href="signUp" id="signUpLink" class="active">회원가입</a></li>
          <li><a href="${pageContext.request.contextPath}/gstLogout">로그아웃</a></li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>
    </div>
  </header><!-- Header 끝 -->

  <main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container">
        <h1>내 정보</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="gstMain.html">Home</a></li>
            <li class="current">내 정보</li>
          </ol>
        </nav>
      </div>
    </div><!-- Page Title 끝 -->

    <!-- 입력 폼 -->
    <section id="contact" class="contact section">

      <div class="container" data-aos="fade">

        <div class="row justify-content-center gy-5 gx-lg-5">
          <div class="col-lg-6">
            <form action="signUpPost" method="post" role="form" class="php-email-form">
              <div class="row">
                <div class="form-group mt-3">
                  <input type="text" name="gstId" value="${gstDetail.gstId}" readonly style="background-color: #F6F6F6;" class="form-control">
                </div>
              </div>
              <div class="form-group mt-3">
                <input type="password" value="${gstDetail.gstPw}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstPw">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.gstName}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstName">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.gstEmail}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstEmail">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.gstGender}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstGender">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.gstBirth}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstBirth">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.gstPhone}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstPhone">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.gstType}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstType">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.postNo}" readonly style="background-color: #F6F6F6;" class="form-control" name="postNo">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.address}" readonly style="background-color: #F6F6F6;" class="form-control" name="address">
              </div>
              
              
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.roomNo}" readonly style="background-color: #F6F6F6;" class="form-control" name="roomNo">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.roomType}" readonly style="background-color: #F6F6F6;" class="form-control" name="roomType">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.roomDong}" readonly style="background-color: #F6F6F6;" class="form-control" name="roomDong">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.roomAmenity}" readonly style="background-color: #F6F6F6;" class="form-control" name="roomAmenity">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.residentNote}" readonly style="background-color: #F6F6F6;" class="form-control" name="residentNote">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.protectorName}" readonly style="background-color: #F6F6F6;" class="form-control" name="protectorName">
              </div>
              <div class="form-group mt-3">
                <input type="text" value="${gstDetail.protectorPhone}" readonly style="background-color: #F6F6F6;" class="form-control" name="protectorPhone">
              </div>
       		   <div class="form-group mt-3">
                <input type="text" value="${gstDetail.protectorRelation}" readonly style="background-color: #F6F6F6;" class="form-control" name="protectorRelation">
              </div>
              
       		
       
              <div class="row justify-content-center">
              	<div class="col-md-6 mt-3 text-center"><button type="submit">탈퇴하기</button></div>
              	<div class="col-md-6 mt-3 text-center"><button type="submit">수정하기</button></div>
              </div>
            </form>
            
          </div><!-- End Contact Form -->

        </div>

      </div>

    </section><!-- 입력 폼 끝 -->   
  </main>

  <!-- footer -->
  <jsp:include page="inc/footer.jsp"></jsp:include>

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="/topaz/assets/vendorGST/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/aos/aos.js"></script>
  <script src="/topaz/assets/vendorGST/swiper/swiper-bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/purecounter/purecounter_vanilla.js"></script>
  <script src="/topaz/assets/vendorGST/glightbox/js/glightbox.min.js"></script>
  <script src="/topaz/assets/vendorGST/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="/topaz/assets/vendorGST/isotope-layout/isotope.pkgd.min.js"></script>

  <script src="<c:url value='/js/post.js'/>"></script>

  <!-- Main JS File -->
  <script src="/topaz/assets/js/mainGST.js"></script>

</body>

</html>