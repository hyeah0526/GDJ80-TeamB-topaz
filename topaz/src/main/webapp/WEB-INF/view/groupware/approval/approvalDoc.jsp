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
      <h1>기안서 선택</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item active">Approval Document</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section contact">
		<div class="col-lg-12">
			<div class="row justify-content-center">
	            <div class="col-lg-3 text-center">
	              <div class="info-box card">
	                <i class="bi bi-person-arms-up"></i>
	                <h3>휴가 신청서</h3>
	                <p><a class="btn btn-primary" href="/topaz/groupware/approval/approvalDayOff">작성하기 →</a></p>
	              </div>
	            </div>
            
	            <div class="col-lg-3 text-center">
	              <div class="info-box card">
	                <i class="bi bi-file-earmark-richtext"></i>
	                <h3>기획 제안서</h3>
	                <p><a class="btn btn-primary" href="/topaz/groupware/approval/approvalProposal">작성하기 →</a></p>
	              </div>
	            </div>
	            
	            <div class="col-lg-3 text-center">
	              <div class="info-box card">
	                <i class="bi bi-cash"></i>
	                <h3>경비 청구서</h3>
	                <p><a class="btn btn-primary" href="/topaz/groupware/approval/approvalExpense">작성하기 →</a></p>
	              </div>
	            </div>
			</div>
		</div>
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>