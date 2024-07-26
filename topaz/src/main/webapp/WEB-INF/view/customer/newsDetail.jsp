<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
  <jsp:include page="inc/header.jsp"></jsp:include>

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
		            <c:if test="${gstId == 'admin'}">
	                  <a href="/topaz/customer/newsModify?newsNo=${newsOne.newsNo }" type="submit" class="btn submitBtn" style="background-color: var(--accent-color); color: white;">알림마당 수정</a>
	                  <a href="/topaz/customer/newsDelete?newsNo=${newsOne.newsNo }&fileName=${newsOne.fileName}" type="submit" class="btn submitBtn" style="background-color: var(--accent-color); color: white;">알림마당 삭제</a>
                	</c:if>
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
		                <textarea class="form-control" rows="7" cols="20" readonly style="text-align: center">${newsOne.content }</textarea>
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