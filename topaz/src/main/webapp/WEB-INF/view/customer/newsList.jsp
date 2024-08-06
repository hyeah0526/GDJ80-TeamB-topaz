<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>알림마당</title>
    <!-- Favicons -->
    <link href="/topaz/assets/img/TOPAZ_logo.png" rel="icon">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet">
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
<body class="about-page">
  <!-- Header -->
  <jsp:include page="inc/header.jsp"></jsp:include>
  
    <main class="main">
        <!-- Page Title -->
        <div class="page-title light-background">
            <div class="container">
                <h1>알림마당</h1>
                <nav class="breadcrumbs">
                    <ol>
                        <li><a href="gstMain">Home</a></li>
                        <li class="current">알림마당</li>
                    </ol>
                </nav>
            </div>
        </div>
        <!-- Page Title 끝 -->
        <!-- 직원 소개 Section -->
        <section id="team" class="team section">
            <div class="site-section slider-team-wrap">
                <div class="container">
	                <div>
	                	<div>
		                	<c:if test="${gstId == 'admin' }">
		                      	<a href="/topaz/customer/newsAdd" type="submit" class="btn submitBtn" style="background-color: var(--accent-color); color: white;">알림마당 등록</a>
		                    </c:if>
		               	</div>
	                </div>
	                <hr>
                    <div class="slider-nav d-flex justify-content-end mb-3">
                        <a href="#" class="js-prev js-custom-prev"><i class="bi bi-arrow-left-short"></i></a>
                        <a href="#" class="js-next js-custom-next"><i class="bi bi-arrow-right-short"></i></a>
                    </div>
                    <div class="swiper init-swiper" data-aos="fade-up" data-aos-delay="100">
                        <script type="application/json" class="swiper-config">
                            {
                                "loop": true,
                                "speed": 600,
                                "autoplay": {
                                    "delay": 5000
                                },
                                "slidesPerView": "1",
                                "pagination": {
                                    "el": ".swiper-pagination",
                                    "type": "bullets",
                                    "clickable": true
                                },
                                "navigation": {
                                    "nextEl": ".js-custom-next",
                                    "prevEl": ".js-custom-prev"
                                },
                                "breakpoints": {
                                    "640": {
                                        "slidesPerView": 2,
                                        "spaceBetween": 30
                                    },
                                    "768": {
                                        "slidesPerView": 3,
                                        "spaceBetween": 30
                                    },
                                    "1200": {
                                        "slidesPerView": 3,
                                        "spaceBetween": 30
                                    }
                                }
                            }
                        </script>
                        <div class="swiper-wrapper">
                            <c:forEach var="newsItem" items="${newsList}">
                                <div class="swiper-slide">
                                    <div class="team">
                                        <div class="pic">
                                            <a href="/topaz/customer/newsDetail?newsNo=${newsItem.newsNo }"><img src="/topaz/upload/guest/${newsItem.fileName}" alt="Image" class="img-fluid" style="width: 400px; height: 300px"></a>
                                        </div>
                                        <h3 class="">
                                            <a href="/topaz/customer/newsDetail?newsNo=${newsItem.newsNo }"><span class="">${newsItem.title}</span></a>
                                        </h3>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <!-- /.container -->
            </div>
        </section>
        <!-- 직원 소개 Section 끝 -->
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
