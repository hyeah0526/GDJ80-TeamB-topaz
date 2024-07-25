<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<!-- 다음 주소 API -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
					<c:if test="${b.fileName eq null}">
						<img src="/topaz/assets/img/bpo/bpoPaging.png" class="rounded-circle bpoPic" width="250px">
					</c:if>
					<c:if test="${b.fileName ne null}">
	              		<img src="/topaz/assets/img/bpo/${b.fileName}" class="rounded-circle bpoPic" width="250px">
	              	</c:if>
	             	<h2>${b.outsourcingName}</h2>
	             	<input type="hidden" value="${b.useYn}" name="useYn" id="useYn">
	             	<c:if test="${b.useYn eq 'Y'}">
		             	<button id="activeChange" type="button" class="btn btn btn-primary">활성화 상태</button>
	             	</c:if>
	             	<c:if test="${b.useYn eq 'N'}">
		             	<button id="activeChange" type="button" class="btn btn btn-secondary">비활성화 상태</button>
	             	</c:if>
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
                    <div class="col-lg-9 col-md-8">${b.empName}</div>
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
				
                  <!-- 외주업체 수정 폼 -->
                  <form method="post" action="${pageContext.request.contextPath}/groupware/bpo/bpoModify" enctype="multipart/form-data">
                    <div class="row mb-3">
                      <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">업체 사진</label>
                      <div class="col-md-8 col-lg-9">
                        <img id="preview" class="preview">
                        <input class="form-control" type="file" name="uploadFile" id="uploadFile">
                        <input class="form-control" type="hidden" name="oldFileName" value="${b.fileName}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="fullName" class="col-md-4 col-lg-3 col-form-label">업체 이름</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="outsourcingName" type="text" class="form-control" id="outsourcingName" value="${b.outsourcingName}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="about" class="col-md-4 col-lg-3 col-form-label">업체 소개</label>
                      <div class="col-md-8 col-lg-9">
                        <textarea name="outsourcingAbout" class="form-control" id="outsourcingAbout" style="height: 100px">${b.outsourcingAbout}</textarea>
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
                        <input name="inchargeName" id="inchargeName" type="text" class="form-control" value="${b.inchargeName}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Country" class="col-md-4 col-lg-3 col-form-label">사내 담당자</label>
                      <div class="col-md-8 col-lg-5">
                        <input type="text" id="empNameInput" name="empNameInput" class="form-control" value="${b.empName}">
                        <input type="hidden" id="empNoInput" name="empNo" class="form-control" value="${b.empNo}" readonly>
                      </div>
                      <div class="col-md-8 col-lg-4">
                      	<button type="button" id="chkEmp" class="btn btn-primary">직원검색</button>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Address" class="col-md-4 col-lg-3 col-form-label">계약시작</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="contractStart" id="contractStart" type="date" class="form-control" value="${b.contractStart}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Phone" class="col-md-4 col-lg-3 col-form-label">계약종료</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="contractEnd" id="contractEnd" type="date" class="form-control" value="${b.contractEnd}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Email" class="col-md-4 col-lg-3 col-form-label">주소</label>
                      <div class="col-md-8 col-lg-5">
	                      <input name="postNo" class="form-control" data-step="11" placeholder="우편번호" maxlength="5" value="${b.postNo}" readonly>
						  <input name="firstAddress" id="firstAddress" class="step form-control" data-step="12" placeholder="주소" value="${b.address}">
                      </div>
                      <div class="col-md-8 col-lg-4">
                        <button class="step btn btn-primary" type="button" data-step="10" onclick="openPostcode('postNo','firstAddress')">우편번호찾기</button><br>
                        <input name="address" id="address" type="hidden" class="form-control" value="${b.address}">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Twitter" class="col-md-4 col-lg-3 col-form-label">전화번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="contactNo" id="contactNo" type="number" class="form-control" value="${b.contactNo}">
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label for="Twitter" class="col-md-4 col-lg-3 col-form-label">작성자</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="regId" type="text" class="form-control" value="${b.regId}" style="background-color: #d9dce1;" readonly>
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label for="Twitter" class="col-md-4 col-lg-3 col-form-label">최종수정자</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="modId" type="text" class="form-control" value="${b.modId}" style="background-color: #d9dce1;" readonly>
                      </div>
                    </div>

                    <div class="text-center">
                      <c:if test="${b.useYn eq 'Y'}">
	                      <button type="submit" id="modBpoBtn" class="btn btn-primary">Save Changes</button>
                      </c:if>
                      <c:if test="${b.useYn eq 'N'}">
	                      해당 업체는 비활성화 상태로 수정이 불가능합니다.<br>
	                      <button type="button" class="btn btn-secondary">Save Changes</button>
                      </c:if>
                      <button type="button" class="btn btn-primary" onclick="window.location.href='/topaz/groupware/bpo/bpoDetail?outsourcingNo=${b.outsourcingNo}'">Cancel</button>
                    </div>
                  </form><!-- End Profile Edit Form -->

                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
                  <form method="post" action="${pageContext.request.contextPath}/groupware/bpo/bpoResetPw">
                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">비밀번호 초기화</label>
                      
                      <div class="col-md-8 col-lg-9">
                      	<input type="password" class="form-control" name="outsourcingPw">
                      	<input type="hidden" name="outsourcingNo" value="${b.outsourcingNo}">
                      </div>
                    </div>
                    <div class="text-center">
	                    <c:if test="${b.useYn eq 'Y'}">
	                      	<button id="bpoResetPwBtn" type="submit" class="btn btn-primary">Reset Password</button>
	                    </c:if>
	                    <c:if test="${b.useYn eq 'N'}">
	                      	<button type="button" class="btn btn-secondary">Reset Password</button>
	                      	<br>해당 업체는 비활성화 상태로 수정이 불가능합니다.
	                    </c:if>
                    </div>
                  </form><!-- End Change Password Form -->

                </div>
              </div><!-- End Bordered Tabs -->
			</div></div>
		</div></div>
    </section><!-- section 종료 -->
    
    
    <!-- 직원검색 모달 -->
	<div class="modal fade" id="empModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
			<!-- 모달 제목 -->
			<div class="modal-header">
				<h5 class="modal-title">담당 직원 선택</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			
				<div class="modal-body">
					<div class="row mb-5">
						<label for="inputEmail" class="col-sm-4 col-form-label"></label>
						<div class="col-sm-8 scheduleModalDiv" id="empNameSelectDiv">
							<!-- 직원 출력되는 곳 -->
						</div>
					</div>
				</div>
				
				<!-- 모달 일정 취소/등록버튼 -->
				<div class="modal-footer">
					<button type="button" id="empChkCxlBtn" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					<button id="empChkSaveBtn" type="submit" class="btn btn-primary">Save</button>
				</div>
		</div></div>
	</div><!-- End 직원검색 Modal-->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 카카오 우편번호API -->
	<script src="<c:url value='/js/post.js'/>"></script>
	
	<!-- 외주업체등록/상세 JS -->
	<script src="<c:url value='/js/hyeahBpoAdd.js'/>"></script>
</body>

</html>