<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
	<!-- hyeah CSS / JS -->
	<link rel="stylesheet" href="<c:url value='/css/hyeah.css' />">
	</head>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>외주업체 상세보기</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/bpo/bpoList">Outsourcing List</a></li>
          <li class="breadcrumb-item active">Outsourcing Details</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
		<!-- 외주업체 상세보기 -->
		<c:set var="b" value="${bpoDetail}"></c:set>
		<div class="row bpoLabel">
			<div class="col-xl-4"><div class="card">
				<div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
	              	<img src="/topaz/assets/img/bpo/${b.fileName}" class="rounded-circle bpoPic" width="250px">
	             	<h2>${b.outsourcingName}</h2>
	            </div>
			</div></div>

			<div class="col-xl-8">
				<div class="card"><div class="card-body pt-3">
              	<!-- Tabs 상세보기, 수정, 비밀번호 변경 -->
              	<ul class="nav nav-tabs nav-tabs-bordered">
				  <li class="nav-item">
	                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Details</button>
				  </li>
	
				  <li class="nav-item">
	                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Outsourcing</button>
				  </li>
	
				  <li class="nav-item">
	                 <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
				  </li>
              </ul>
              
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview bpoDetailsAll" id="profile-overview">
                  <h5 class="card-title">About</h5>
                  <p class="small fst-italic">${b.outsourcingAbout}</p>
                  <h5 class="card-title">Outsourcing Details</h5>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">업체명</div>
                    <div class="col-lg-9 col-md-8">${b.outsourcingName}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">아이디</div>
                    <div class="col-lg-9 col-md-8">${b.outsourcingNo}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">업체 담당자</div>
                    <div class="col-lg-9 col-md-8">${b.inchargeName}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">사내 담당자</div>
                    <div class="col-lg-9 col-md-8">${b.empNo}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">계약기간</div>
                    <div class="col-lg-9 col-md-8">${b.contractStart} ~ ${b.contractEnd}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">업체 종류</div>
                    <div class="col-lg-9 col-md-8">${b.outsourcingType}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">연락처</div>
                    <div class="col-lg-9 col-md-8">${b.contactNo}</div>
                  </div>
                  
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">주소</div>
                    <div class="col-lg-9 col-md-8">(${b.postNo})&nbsp;${b.address}</div>
                  </div>

                </div>

                <div class="tab-pane fade profile-edit pt-3 bpoDetails" id="profile-edit">

                  <!-- Edit Outsourcing Form -->
                  <form>
                    <div class="row mb-3">
                      <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">업체 사진</label>
                      <div class="col-md-8 col-lg-9">
                        <input class="form-control" type="file" id="" name="">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="fullName" class="col-md-4 col-lg-3 col-form-label">업체 이름</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="fullName" type="text" class="form-control" id="fullName" value="${b.outsourcingName}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="about" class="col-md-4 col-lg-3 col-form-label">업체 소개</label>
                      <div class="col-md-8 col-lg-9">
                        <textarea name="about" class="form-control" id="about" style="height: 100px">${b.outsourcingAbout}</textarea>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="company" class="col-md-4 col-lg-3 col-form-label">업체 아이디</label>
                      <div class="col-md-8 col-lg-9">
                        <input type="text" id="outsourcingNo" name="outsourcingNo" class="form-control" value="${b.outsourcingNo}" style="background-color: #d9dce1;" readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Job" class="col-md-4 col-lg-3 col-form-label">외주업체 담당자</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="" type="text" class="form-control" value="${b.inchargeName}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Country" class="col-md-4 col-lg-3 col-form-label">사내 담당자</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="" type="text" class="form-control" value="${b.empNo}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Address" class="col-md-4 col-lg-3 col-form-label">계약시작</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="" type="date" class="form-control" id="" value="${b.contractStart}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Phone" class="col-md-4 col-lg-3 col-form-label">계약종료</label>
                      <div class="col-md-8 col-lg-5">
                        <input name="" type="date" class="form-control" id="" value="${b.contractEnd}">
                      </div>
                      <div class="col-md-8 col-lg-4">
                      	<a class="btn btn-primary">비활성화 처리</a>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Email" class="col-md-4 col-lg-3 col-form-label">주소</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="" type="text" class="form-control" id="" value="${b.address}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Twitter" class="col-md-4 col-lg-3 col-form-label">전화번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="" type="text" class="form-control" id="" value="${b.contactNo}">
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label for="Twitter" class="col-md-4 col-lg-3 col-form-label">작성자</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="" type="text" class="form-control" id="" value="${b.regId}" style="background-color: #d9dce1;" readonly>
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label for="Twitter" class="col-md-4 col-lg-3 col-form-label">최종수정자</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="" type="text" class="form-control" id="" value="${b.modId}" style="background-color: #d9dce1;" readonly>
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                  </form><!-- End Profile Edit Form -->

                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
                  <form>
                    <div class="row mb-3">
                      <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="newpassword" type="password" class="form-control" id="newPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Change Password</button>
                    </div>
                  </form><!-- End Change Password Form -->

                </div>
              </div><!-- End Bordered Tabs -->
			</div></div>
		</div></div>
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>