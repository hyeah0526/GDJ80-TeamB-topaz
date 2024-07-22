<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>알림마당 상세</title>

  <!-- Favicons -->
  <link href="/topaz/assets/img/TOPAZ_logo.png" rel="icon">

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

  <!-- Main CSS File -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">
</head>

<body class="blog-details-page">
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
          <li><a href="gstMain" >Home</a></li>
          <li><a href="infoPrograms">서비스 및 프로그램</a></li>&nbsp;&nbsp;&nbsp;
          <li class="dropdown"><span>세대 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i>
            <ul>
              <li><a href="infoRegidentDiamond">다이아몬드동</a></li>
              <li><a href="infoRegidentSilver">실버동</a></li>
              <li><a href="infoStep">입주 절차</a></li>
            </ul>
          </li>&nbsp;&nbsp;
          <li><a href="volunteerRqAdd">봉사 신청</a></li>
          <li><a href="newsList" class="active">알림마당</a></li>
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
               <h1>알림마당 상세</h1>
               <nav class="breadcrumbs">
                   <ol>
                       <li><a href="gstMain">Home</a></li>
                       <li><a href="newsList">알림마당</a></li>
                       <li class="current">상세보기</li>
                   </ol>
               </nav>
           </div>
       </div>
  		<!-- Page Title 끝 -->
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <!-- Blog Details Section -->
          <section id="blog-details" class="blog-details section">
            <div class="container">
            	<div>
                  <a href="/topaz/customer/newsModify?newsNo=${newsOne.newsNo }" type="submit" class="btn submitBtn" style="background-color: var(--accent-color); color: white;">알림마당 수정</a>
                  <a href="/topaz/customer/newsDelete?newsNo=${newsOne.newsNo }&fileName=${newsOne.fileName}" type="submit" class="btn submitBtn" style="background-color: var(--accent-color); color: white;">알림마당 삭제</a>
                </div>
                <br>
				<article class="article" style="text-align: center; margin-auto" >
	                <div class="content">
		                <h2 class="title">${newsOne.title }</h2>
		                <div class="post-img">
		                <br>
		                  <img src="/topaz/assets/img/guest/${newsOne.fileName }" alt="" class="img-fluid" width="600px">
		                </div>
		                <p>
		                <textarea class="form-control" rows="7" cols="20" readonly >${newsOne.content }</textarea>
		                </p>
		                <p>
		                 등록자/등록시간 <br>
						 ${newsOne.regId }/${newsOne.regTime }
		                </p>
		                <p>
		                 수정자/수정시간 <br>
		                  ${newsOne.modId }/${newsOne.modTime }
		                </p>
	                </div><!-- End post content -->
              	</article>
            </div>
          </section><!-- /Blog Details Section -->
        </div>
      </div>
    </div>
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

  <!-- Main JS File -->
  <script src="/topaz/assets/js/mainGST.js"></script>

</body>

</html>