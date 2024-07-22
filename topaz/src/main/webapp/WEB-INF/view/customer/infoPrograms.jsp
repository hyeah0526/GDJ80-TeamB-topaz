<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>프로그램</title>
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

<body class="services-page">
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
          <li><a href="infoPrograms" class="active">서비스 및 프로그램</a></li>
          <li class="dropdown"><span>세대 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i>
            <ul>
              <li><a href="infoRegidentDiamond">다이아몬드동</a></li>
              <li><a href="infoRegidentSilver">실버동</a></li>
              <li><a href="infoStep">입주 절차</a></li>
            </ul>
          </li>
          <li><a href="volunteerRqAdd">봉사 신청</a></li>
          <li><a href="newsList">알림마당</a></li>
          <li><a href="gstLogin">로그인</a></li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>
    </div>
  </header><!-- Header 끝 -->
  
  <main class="main">
    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container">
        <h1>서비스 및 프로그램</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="gstMain.html">Home</a></li>
            <li class="current">서비스 및 프로그램</li>
          </ol>
        </nav>
      </div>
    </div><!-- Page Title 끝 -->

    <!-- Section 1 -->
    <section id="about" class="about section">

      <div class="container">
        <div class="row align-items-center justify-content-between">
          <div class="col-lg-7 mb-5 mb-lg-0 order-lg-2" data-aos="fade-up" data-aos-delay="400">
            <div class="swiper init-swiper">
              <script type="application/json" class="swiper-config">
                {
                  "loop": true,
                  "speed": 600,
                  "autoplay": {
                    "delay": 5000
                  },
                  "slidesPerView": "auto",
                  "pagination": {
                    "el": ".swiper-pagination",
                    "type": "bullets",
                    "clickable": true
                  },
                  "breakpoints": {
                    "320": {
                      "slidesPerView": 1,
                      "spaceBetween": 40
                    },
                    "1200": {
                      "slidesPerView": 1,
                      "spaceBetween": 1
                    }
                  }
                }
              </script>
              <div class="swiper-wrapper">
                <div class="swiper-slide">
                  <img src="/topaz/assets/img/program6.png" alt="Image" class="img-fluid">
                </div>
                <div class="swiper-slide">
                  <img src="/topaz/assets/img/program7.png" alt="Image" class="img-fluid">
                </div>
                <div class="swiper-slide">
                  <img src="/topaz/assets/img/program8.png" alt="Image" class="img-fluid">
                </div>
              </div>
              <div class="swiper-pagination"></div>
            </div>
          </div>
          <div class="col-lg-4 order-lg-1" >
            <h1 class="mb-4" data-aos="fade-up" style="font-style: italic;">
              TOPAZ 서비스 및 프로그램
            </h1>
            <p data-aos="fade-up" style="font-style: italic; font-size: 20px;">
              다양한 서비스 및 프로그램을 통해 <br>
              여러분의 생활의 질을 향상시키고 <br>
              건강을 증진시킬 수 있습니다.
            </p>
            
          </div>
        </div>
      </div>
    </section><!-- Section 1 끝 -->

    <!-- Section 2 -->
    <section id="about-2" class="about-2 section">

      <div class="container">
        <div class="content">
          <div class="row justify-content-center">
            <div class="col-sm-12 col-md-5 col-lg-4 col-xl-4 order-lg-2 offset-xl-1 mb-4">
              <div class="img-wrap text-center text-md-left" data-aos="fade-up" data-aos-delay="100">
                <div class="img">
                  <img src="/topaz/assets/img/program1.png" alt="circle image" class="img-fluid">
                </div>
              </div>
            </div>

            <div class="offset-md-0 offset-lg-1 col-sm-12 col-md-5 col-lg-5 col-xl-4" data-aos="fade-up">
              <div class="px-3">
                <h2 class="content-title text-start" style="font-style: italic; font-size: 20px; " >
                  의료 서비스
                </h2><br>
                <p class="lead" style="font-style: italic; font-size: 20px;">
                  여러분의 건강 관리를 위한<br>
                  의료 서비스를 제공합니다.
                </p>
                <p class="mb-5" style="font-style: italic; font-size: 20px;">
                  정기적인 건강 검진과 맞춤형 <br>
                  치료 프로그램을 통해 최상의 <br>
                  건강 상태를 유지할 수 있도록 돕습니다.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- Section 2 끝 -->
    
    <section id="about-2" class="about-2 section">

      <div class="container">
        <div class="content">
          <div class="row justify-content-center">
            <div class="coffset-md-0 offset-lg-1 col-sm-12 col-md-5 col-lg-5 col-xl-4">
              <div class="img-wrap text-center text-md-left" data-aos="fade-up" data-aos-delay="100">
                <div class="img">
                  <img src="/topaz/assets/img/program2.png" alt="circle image" class="img-fluid">
                </div>
              </div>
            </div>

            <div class="col-sm-12 col-md-5 col-lg-4 col-xl-4 order-lg-2 offset-xl-1 mb-4" data-aos="fade-up">
              <div class="px-3">
                <h2 class="content-title text-start" style="font-style: italic; font-size: 20px;">
                  차량 지원 서비스
                </h2><br>
                <p class="lead" style="font-style: italic; font-size: 20px;">
                  여러분의 이동을 돕는 <br>
                  차량 지원 서비스를 제공합니다.
                </p>
                <p class="mb-5" style="font-style: italic; font-size: 20px;">
                  병원 방문, 쇼핑, 외출 등 필요한<br>
                  모든 상황에서 안전하고 편리한 <br>
                  차량 지원을 받으실 수 있습니다.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- Section 2 끝 -->
    
    <section id="about-2" class="about-2 section">

      <div class="container">
        <div class="content">
          <div class="row justify-content-center">
            <div class="col-sm-12 col-md-5 col-lg-4 col-xl-4 order-lg-2 offset-xl-1 mb-4">
              <div class="img-wrap text-center text-md-left" data-aos="fade-up" data-aos-delay="100">
                <div class="img">
                  <img src="/topaz/assets/img/program3.png" alt="circle image" class="img-fluid">
                </div>
              </div>
            </div>

            <div class="offset-md-0 offset-lg-1 col-sm-12 col-md-5 col-lg-5 col-xl-4" data-aos="fade-up">
              <div class="px-3">
                <h2 class="content-title text-start" style="font-style: italic; font-size: 20px;">
                  미용 서비스
                </h2><br>
                <p class="lead" style="font-style: italic; font-size: 20px;">
                  여러분의 아름다움을 위한 <br>
                  미용 서비스를 제공합니다.
                </p>
                <p class="mb-5" style="font-style: italic; font-size: 20px;">
                  편안한 환경에서 미용 관리를 <br>
                  받을 수 있도록, 전문 스탭이 안전하고<br>
                  깨끗하게 서비스를 제공합니다.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- Section 2 끝 -->
    <section id="about-2" class="about-2 section">

      <div class="container">
        <div class="content">
          <div class="row justify-content-center">
            <div class="offset-md-0 offset-lg-1 col-sm-12 col-md-5 col-lg-5 col-xl-4">
              <div class="img-wrap text-center text-md-left" data-aos="fade-up" data-aos-delay="100">
                <div class="img">
                  <img src="/topaz/assets/img/program4.png" alt="circle image" class="img-fluid">
                </div>
              </div>
            </div>

            <div class="col-sm-12 col-md-5 col-lg-4 col-xl-4 order-lg-2 offset-xl-1 mb-4" data-aos="fade-up">
              <div class="px-3">
                <h2 class="content-title text-start" style="font-style: italic; font-size: 20px;">
                  심리 상담
                </h2><br>
                <p class="lead" style="font-style: italic; font-size: 20px;">
                  마음의 평화를 위한 <br>
                  심리 상담 서비스를 제공합니다.
                </p>
                <p class="mb-5" style="font-style: italic; font-size: 20px;">
                  전문 상담사와의 1:1 상담을 통해 <br>
                  여러분의 정신 건강을 돌보고 <br>
                  스트레스를 해소할 수 있도록<br>
                  도와드립니다.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- Section 2 끝 -->
    
    <section id="about-2" class="about-2 section">

      <div class="container">
        <div class="content">
          <div class="row justify-content-center">
            <div class="col-sm-12 col-md-5 col-lg-4 col-xl-4 order-lg-2 offset-xl-1 mb-4">
              <div class="img-wrap text-center text-md-left" data-aos="fade-up" data-aos-delay="100">
                <div class="img">
                  <img src="/topaz/assets/img/program5.png" alt="circle image" class="img-fluid">
                </div>
              </div>
            </div>

            <div class="offset-md-0 offset-lg-1 col-sm-12 col-md-5 col-lg-5 col-xl-4" data-aos="fade-up">
              <div class="px-3">
                <h2 class="content-title text-start" style="font-style: italic; font-size: 20px;">
                  야외 활동
                </h2><br>
                <p class="lead" style="font-style: italic; font-size: 20px;">
                  봉사 활동과 연계된 <br>
                  다양한 야외 활동 프로그램을 제공합니다.
                </p>
                <p class="mb-5" style="font-style: italic; font-size: 20px;">
                  자연에서의 산책, 봉사 활동 참여 등 <br>
                  다양한 야외 활동을 통해 건강한 생활을 <br>
                  즐기실 수 있습니다.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- Section 2 끝 -->
    
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