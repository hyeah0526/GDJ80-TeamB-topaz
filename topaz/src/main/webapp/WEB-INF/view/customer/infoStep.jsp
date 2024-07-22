<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>입주 절차</title>
  <link href="/topaz/assets/img/TOPAZ_logo.png" rel="icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&family=Lato:wght@100;300;400;700;900&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/topaz/assets/vendorGST/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/aos/aos.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/glightbox/css/glightbox.min.css" rel="stylesheet">
  
  <!-- Main CSS File -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">
  
  <style>
    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }

    .content-title {
      margin-bottom: 20px;
      font-style: italic;
      text-align: center;
    }

    @media (max-width: 768px) {
      .col-lg-12 {
        padding: 0 15px;
      }
    }
   
  </style>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
</head>

<body class="portfolio-page">

  <!-- Header -->
  <header id="header" class="header d-flex align-items-center sticky-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">
      <a href="gstMain" class="logo d-flex align-items-center">
        <img src="/topaz/assets/img/TOPAZ_logo.png" alt="TOPAZ Logo">
        <h1 class="sitename">TOPAZ.</h1>
      </a>
      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="gstMain">Home</a></li>
          <li><a href="infoPrograms">서비스 및 프로그램</a></li>
          <li class="dropdown active"><span>세대 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i>
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
  </header>

  <main class="main">
    <section id="about-2" class="about-2 section light-background">
      <div class="container text-center" data-aos="fade-up">
        <div class="content">
          <div class="row justify-content-center content-section" style="margin-top: 50px;">
            <div class="col-12">
              <div class="px-2">
                <h2 class="content-title">TOPAZ 입주 대상</h2>
                <p>
                  &#128312; 편안함과 안전을 중시하는 분들 <br>
                  &#128312; 고유한 삶의 즐거움을 추구하는 분들 <br>
                  &#128312; 자신의 라이프스타일을 자유롭게 즐기고자 하는 분들
                </p>
                <br>
                <br>
                <h2 class="content-title">TOPAZ 입주 절차</h2>
                <br>
                <table>
                  <thead>
                    <tr>
                      <th>단계</th>
                      <th>내용</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1. 상담 예약</td>
                      <td>전화를 통해 전문가와 상담 예약</td>
                    </tr>
                    <tr>
                      <td>2. 방문 및 시설 탐방</td>
                      <td>실버타운을 방문하여 시설 탐방</td>
                    </tr>
                    <tr>
                      <td>3. 신청서 작성</td>
                      <td>입주 신청서 작성 및 개인 정보와 요구사항 기재</td>
                    </tr>
                    <tr>
                      <td>4. 심사 및 승인</td>
                      <td>신청서 심사 및 추가 자료나 인터뷰 진행 후 승인 통지</td>
                    </tr>
                    <tr>
                      <td>5. 계약 체결</td>
                      <td>최종 계약서 확인 및 서명</td>
                    </tr>
                    <tr>
                      <td>6. 입주 준비</td>
                      <td>입주를 위한 이사 서비스 및 초기 정착 안내</td>
                    </tr>
                    <tr>
                      <td>7. 입주 및 생활 시작</td>
                      <td>입주 및 생활 시작</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
		  <br>
	 	  <br>
          <div class="row justify-content-center content-section">
            <div class="col-12" data-aos="fade-up">
              <div class="px-2">
                <h2 class="content-title">TOPAZ 입주 상담시 권고 사항</h2><br>
                <p>
                  입주 상담 시 입소자께서 준비해 주시면 원활한 수속을 도와드리기 위한 안내사항입니다. <br> 
                  입주자의 병력을 정확히 파악하기 위해 최근 의사 소견서와 <br>
                  현재 복용 중인 약물 처방전을 준비해 주시면 정확한 상담이 가능합니다. <br> 환자 본인의 건강보험증 또는 신분증, 진단서,
                  현재 복용 중인 약물 처방전을 지참해주세요.
                </p>
                <br><br>
                <h2 class="content-title">TOPAZ 입주시 필요사항</h2><br>
                <table data-aos="fade-up">
                  <thead>
                    <tr>
                      <th>항목</th>
                      <th>세부사항</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>TOPAZ 입주 준비서류</td>
                      <td>
                        &#128312; 장기요양인정서<br>
                        &#128312; 표준장기요양이용계획서<br>
                        &#128312; 건강진단서(전염성 유무)<br>
                        &#128312; 의사소견서(질병관리) 또는 진단서<br>
                        &#128312; 주민등록 등본(보호자, 입주자 포함)<br>
                        &#128312; 가족관계증명원(보호자, 입주자 포함)<br>
                        &#128312; 신분증 사본(보호자, 입주자)<br>
                      </td>
                    </tr>
                    <tr>
                      <td>TOPAZ 입주 시 준비물품</td>
                      <td>
                        &#128312; 세면도구 치약, 칫솔, 클렌징폼<br>
                        &#128312; 위생용품 개인 물병, 물티슈, 실내화 등<br>
                        &#128312; 의복류 계절에 맞는 상-하의, 양말, 속옷 5개(소모품)<br>
                        &#128312; 복용 약 및 처방전(최소 15일분)<br>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <br><br>
          <h4 class="text-center" style="margin-bottom: 50px; font-style: italic;" data-aos="fade-up">
            전화, 방문을 통해 상담받으실 수 있습니다.<br>
            방문하시어 생활 공간과 분위기를 보시길 권장합니다.<br>
            전화문의 Te1. 02-123-1235
          </h4>
        </div>
      </div>
    </section>
  </main>

  <!-- footer -->
  <jsp:include page="inc/footer.jsp"></jsp:include>

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center">
    <i class="bi bi-arrow-up-short"></i>
  </a>

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
