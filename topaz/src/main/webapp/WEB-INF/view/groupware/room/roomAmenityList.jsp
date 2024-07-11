<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

    <main id="main" class="main">
        <div class="pagetitle">
          <h1>객실 용품 조회</h1>
          <nav>
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.html">Home</a></li>
              <li class="breadcrumb-item active">room Amenity List</li>
            </ol>
          </nav>
        </div><!-- End Page Title -->
    
        <section class="section">
          <div class="row">
            <div class="col-lg-12">

              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">객실 용품 조회</h5>

                  <!-- General Form Elements -->
                  <form action="/topaz/groupware/room/roomAmenityList" method="post">
                    <c:forEach var="am" items="${amenity}" varStatus="status">
                      <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">${am.amenityName}</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control"  value="${am.amenityStock}" name = "amenityStock">
                          <input type="hidden" class="form-control"  value="${am.amenityNo}" name="amenityNo">
                        </div>
                      </div>
                    </c:forEach>
                      <div class="row mb-3">
                         <label class="col-sm-2 col-form-label">등록자</label>
                         <div class="col-sm-10">
                           <input type="text" class="form-control" value="${amenity[0].regId}" disabled="disabled">
                         </div>
                       </div>
                       <div class="row mb-3">
                         <label class="col-sm-2 col-form-label">수정자</label>
                         <div class="col-sm-10">
                           <input type="text" class="form-control" value="${amenity[0].modId}" disabled="disabled">
                         </div>
                       </div>
                       <div class="text-center">
		                      <button type="submit" class="btn btn-primary">Save Changes</button>
                       </div>
                       
                  </form><!-- End General Form Elements -->
                </div>
              </div>
            </div>
          </div>
        </section>
    </main><!-- End #main -->
    
    <jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>
</html> 
