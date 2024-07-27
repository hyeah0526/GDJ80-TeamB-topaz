<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
   분류번호: #1,12 - 로그인
   시작 날짜: 2024-07-05
   담당자: 한은혜
-->
<!DOCTYPE html>
<html>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
<body>
	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main>
	    <div class="container">
	      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
	        <div class="container">
	          <div class="row justify-content-center">
	          	<!-- 직원 로그인 폼 -->
	            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
	              <div class="d-flex justify-content-center py-4">
	                <a class="logo d-flex align-items-center w-auto">
	                  <img src="/topaz/assets/img/logo.png" alt="">
	                  <span class="d-none d-lg-block">직원으로 로그인</span>
	                </a>
	              </div><!-- End Logo -->
	              <div class="card mb-3">
	                <div class="card-body">
		                <div class="mb-3 pt-4 pb-2">
		                  <h5 class="card-title text-center pb-0 fs-4">Login</h5>
		                </div>
		            <form method="post" class="row g-3 needs-validation" action="${pageContext.request.contextPath}/loginPost">
		                <div class="mb-4 d-flex justify-content-center">
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="userType" value="employee" id="userType1" checked>
							  <label class="form-check-label" for="userType1">
							    직원 로그인
							  </label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="userType" value="outsourcing" id="userType2" >
							  <label class="form-check-label" for="userType2">
							    업체 로그인
							  </label>
							</div>
						</div>
						<div class="text-center justify-content-center" style="color: red;">
							<span>${errMsg }</span>
						</div>
	                    <div class="col-12 mt-3 mb-2">
	                      <label for="id" class="form-label">ID</label>
	                      <input type="text" name="id" class="form-control" id="id" value="admin">
	                    </div>
	                    <div class="col-12 mb-3">
	                      <label for="pw" class="form-label">PW</label>
	                      <input type="password" name="pw" class="form-control" id="pw" value="1234">
	                    </div>
	                    <div class="col-12 mb-4">
	                      <button class="btn btn-primary w-100" type="submit">Login</button>
	                    </div>
	                  </form>
	                </div>
	              </div>
	            </div>
	            
	            <!-- 외주업체 로그인 폼 -->
	            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
	              <div class="d-flex justify-content-center py-4">
	                <a class="logo d-flex align-items-center w-auto">
	                  <img src="/topaz/assets/img/logo.png" alt="">
	                  <span class="d-none d-lg-block">외주업체로 로그인</span>
	                </a>
	              </div><!-- End Logo -->
	              <div class="card mb-3">
	                <div class="card-body">
		                <div class="mb-3 pt-4 pb-2">
		                  <h5 class="card-title text-center pb-0 fs-4">Login</h5>
		                </div>
		            <form method="post" class="row g-3 needs-validation" action="${pageContext.request.contextPath}/loginPost">
		                <div class="mb-4 d-flex justify-content-center">
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="userType" value="employee" id="userType1">
							  <label class="form-check-label" for="userType1">
							    직원 로그인
							  </label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="userType" value="outsourcing" id="userType2" checked>
							  <label class="form-check-label" for="userType2">
							    업체 로그인
							  </label>
							</div>
						</div>
						<div class="text-center justify-content-center" style="color: red;">
							<span>${errMsg }</span>
						</div>
	                    <div class="col-12 mt-3 mb-2">
	                      <label for="id" class="form-label">ID</label>
	                      <input type="text" name="id" class="form-control" id="id" value="B2NAMOO">
	                    </div>
	                    <div class="col-12 mb-3">
	                      <label for="pw" class="form-label">PW</label>
	                      <input type="password" name="pw" class="form-control" id="pw" value="1234">
	                    </div>
	                    <div class="col-12 mb-4">
	                      <button class="btn btn-primary w-100" type="submit">Login</button>
	                    </div>
	                  </form>
	                </div>
	              </div>
	            </div>
	            <!-- 고객 회원가입 및 로그인 버튼 -->
	            <div class="col-lg-4 col-md-6 align-items-center justify-content-center">
	              <div class="d-flex justify-content-center py-4">
	                <a class="logo d-flex align-items-center w-auto">
	                  <img src="/topaz/assets/img/logo.png" alt="">
	                  <span class="d-none d-lg-block">고객으로 회원가입 및 로그인</span>
	                </a>
	              </div><!-- End Logo -->
	              <div class="card mb-3">
	                <div class="card-body d-flex flex-column align-items-center justify-content-center" style="height: 463.56px;">
	                    <div class="col-10 mb-4">
			              	<a href="/topaz/customer/signUp" style="color: white; "><button class="btn btn-primary w-100" type="button" style="height: 50px;">고객 회원가입</button></a>
			            </div>
			            
			            <div class="col-10 mb-4">
			              	<a href="/topaz/customer/gstLogin" style="color: white; "><button class="btn btn-primary w-100" type="button" style="height: 50px;">고객 로그인</button></a>
			            </div>
	                </div>
	              </div>
	            </div>
	            
	            
	            
	          </div>
	        </div>
	
	      </section>
	
	    </div>
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
</body>

</html>