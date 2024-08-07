<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>휴가 신청서</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item">Approval Document</li>
          <li class="breadcrumb-item active">Day Off</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<div class="row justify-content-center"><div class="col-lg-10">
	    	<div class="card"><div class="card-body">
	    		<h6 class="card-title">결재라인</h6>
	    		<!-- 결재선 추가 -->
	    		<div class="row mb-3 align-items-center">
		    		<div class="col-md-2 form-group">
			    		<select class="form-select">
			    			<option>부서</option>
			    		</select>
		    		</div>
		    		
		    		<div class="col-md-2 form-group">
			    		<select class="form-select">
			    			<option>이름</option>
			    		</select>
		    		</div>
		    		
		    		<div class="col-md-2 form-group">
		    			<button class="btn btn-primary">추가</button>
		    		</div>
	    		</div>
	    		
	    		<!-- 선택된 내용 출력 -->
	    		<div><strong>[1]</strong> 부서, 직위, 이름 <a href="#"><span class="text-danger small pt-1 fw-bold">X</span></a></div>
	    	</div></div>
	    </div></div>
    
    
    
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>