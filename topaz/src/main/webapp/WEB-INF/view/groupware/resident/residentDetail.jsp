<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
   분류번호: #7 - 입주자 관리 페이지 : 입주자 상세보기/입주자 수정
   시작 날짜: 2024-07-09
   담당자: 박수지
-->

<!DOCTYPE html>
<html lang="en">
   <!-- ======= header <Head> 부분 ======= -->
   <jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
   
   	<!-- ======= css ======= -->
	<link rel="stylesheet" href="/topaz/css/suji.css"> 
   
<body>
   <!-- ======= header <Body> 부분 ======= -->
   <jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
   
   <!-- ======= sideBar 부분 ======= -->
   <jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

   <!-- =============================== Main 메인 시작 부분 ================================ -->
   <main id="main" class="main">
   
   <!-- Title 시작 -->
   <div class="pagetitle">
      <h1>입주자 상세조회</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">HOME</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/resident/residentList">Resident List</a></li>
          <li class="breadcrumb-item active">Resident Detail</li>
        </ol>
      </nav>
   </div><!-- Title 종료 -->

   <!-- section 시작 -->
    <section class="section profile">
      <div class="row justify-content-center">
        

        <div class="col-xl-10">
        
          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">상세보기</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">수정하기</button>
                </li>

              </ul>
              
              <!-- 상세보기 -->
	          <div class="tab-content pt-2">
	              <div class="tab-pane fade show active profile-overview" id="profile-overview">
	                  <div class="col-xl-4">
			          <div>
			            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
			              <img src="/topaz/assets/img/guest/${resident.fileName}" alt="Profile" class="rounded-circle">
			              <h2>${resident.gstName }</h2>
			            </div>
			          </div>
			        </div>
	                  <div class="row">
	                      <div class="col-lg-6 col-md-6">
	                          <div class="info-item">
	                              <span class="label">이름</span>
	                              <span class="value">${resident.gstName}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">아이디</span>
	                              <span class="value">${resident.gstId}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">전화번호</span>
	                              <span class="value">${resident.gstPhone}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">이메일</span>
	                              <span class="value">${resident.gstEmail}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">성별</span>
	                              <span class="value">${resident.gstGender}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">생년월일</span>
	                              <span class="value">${resident.gstBirth}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">내용</span>
	                              <span class="value">${resident.residentNote}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">수정 직원</span>
	                              <span class="value">${resident.modId}</span>
	                          </div>
	                      </div>
	                      <div class="col-lg-6 col-md-6">
	                          <div class="info-item">
	                              <span class="label">계약기간</span>
	                              <span class="value">${resident.contractStart} ~ ${resident.contractEnd}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">객실, 타입</span>
	                              <span class="value">${resident.roomNo}, ${resident.roomType}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">동, 호수</span>
	                              <span class="value">${resident.roomDong}, ${resident.roomHo}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">어메니티 여부</span>
	                              <span class="value">${resident.roomAmenity}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">보호자 성명</span>
	                              <span class="value">${resident.protectorName}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">보호자 연락처</span>
	                              <span class="value">${resident.protectorPhone}</span>
	                          </div>
	                          <div class="info-item">
	                              <span class="label">입주자와의 관계</span>
	                              <span class="value">${resident.protectorRelation}</span>
	                          </div>
	                      
	                      </div>
	                  </div>
	              </div>
	              
	              
            	<!-- 수정 -->  
                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
					<form action="/topaz/groupware/resident/residentDetail?gstId=${resident.gstId }" method="post" enctype="multipart/form-data" >
                		<div class="row mb-3">
	                      <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">입주자 사진</label>
	                      <div class="col-md-8 col-lg-9">
	                        <img id="preview" class="preview">
	                        <input class="form-control" type="file" name="uploadFile" id="uploadFile">
	                        <input class="form-control" type="hidden" name="oldFileName" value="${resident.fileName}">
                      	  </div>
	                    </div>
						<div class="row">
	                    	<div class="col-lg-6 col-md-6">
	                          	<div class="info-item mb-3">
									<span class="label">이름</span>
		                            <span><input style="width: 200px; display: inline;" class="form-control" name="resiName" type="text" value="${resident.gstName}" disabled="disabled"></span>
	                          	</div>
								<div class="info-item mb-3">
								    <span class="label">아이디</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" name="resiId" type="text" value="${resident.gstId}" disabled="disabled"></span>
								</div>
								<div class="info-item mb-3">
								    <span class="label">전화번호</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" name="gstPhone" type="text" value="${resident.gstPhone}"></span>
								</div>
								<div class="info-item mb-3">
								    <span class="label">이메일</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" name="gstEmail" type="text" value="${resident.gstEmail}"></span>
								</div>
								<div class="info-item mb-3">
								    <span class="label">성별</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" name="resiGender" type="text" value="${resident.gstGender}" disabled="disabled"></span>
								</div>
								<div class="info-item mb-3">
								    <span class="label">생년월일</span>
								   	<span><input style="width: 200px; display: inline;" class="form-control" name="resiBirth" type="text" value="${resident.gstBirth}" disabled="disabled"></span>
								</div>
								<div class="info-item mb-3">
								    <span class="label">내용</span>
								    <span><textarea style="width: 200px; display: inline;" class="form-control" rows="2" cols="20" name="residentNote">${resident.residentNote}</textarea></span>
								</div>
								<div class="info-item mb-3">
								    <span class="label">수정 직원</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" name="modId" type="text" value="${resident.modId}" disabled="disabled"></span>
								   	<span><input style="width: 200px; display: inline;" class="form-control" name="useYn" type="hidden" value="${resident.useYn}" ></span>
									<span><input style="width: 200px; display: inline;" class="form-control" name="gstType" type="hidden" value="${resident.gstType}"></span>
								    
								    </div>
								</div>
								<div class="col-lg-6 col-md-6">
								    <div class="info-item mb-3">
								        <span class="label ">계약기간</span>
								        <span><input class="form-control date-input" style="width: 160px; display: inline" name="contractStart" type="datetime" value = "${resident.contractStart }" disabled="disabled"></span>  ~ 
								        <span><input style="width: 160px; display: inline" class="form-control date-input" name="contractEnd" type="datetime" value = "${resident.contractEnd }"></span>
									</div>
									<div class="info-item mb-3">
									    <span class="label">객실, 타입</span>
									    <span><input style="width: 160px; display: inline" class="form-control date-input" name="roomNo" type="text" value = "${resident.roomNo }" disabled="disabled"></span> &
									    <span><input style="width: 160px; display: inline" class="form-control date-input" name="roomType" type="text" value = "${resident.roomType }" disabled="disabled"></span>
									</div>
									<div class="info-item mb-3">
									    <span class="label">동, 호수</span>
									    <span><input style="width: 150px; display: inline" class="form-control date-input" name="roomDong" type="text" value = "${resident.roomDong }" disabled="disabled"></span> 동 
									    <span><input style="width: 150px; display: inline" class="form-control date-input" name="roomHo" type="text" value = "${resident.roomHo }" disabled="disabled"></span> 호
									</div>
									<div class="info-item mb-3">
									    <span><label class="form-check-label label" for="roomAmenity">어메니티 여부</label></span>
    									<span><input type="hidden" name="roomAmenity" value="N"></span>
										<span><input class="form-check-input" type="checkbox" id="roomAmenity" name="roomAmenity" ${resident.roomAmenity == 'Y' ? 'checked' : ''} value="Y" onchange="this.form.roomAmenity.value = this.checked ? 'Y' : 'N';"></span>

									</div>
									<div class="info-item mb-3">
									    <span class="label">보호자 성명</span>
									    <span><input style="width: 200px; display: inline;" class="form-control" name="protectorName" value = "${resident.protectorName }"type="text"></span>
									</div>
									<div class="info-item mb-3">
									    <span class="label">보호자 연락처</span>
									    <span><input style="width: 200px; display: inline;" class="form-control" name="protectorPhone" value = "${resident.protectorPhone }"type="text"></span>
									</div>
									<div class="info-item mb-3">
									    <span class="label">입주자와의 관계</span>
									    <span><input style="width: 200px; display: inline;" class="form-control" name="protectorRelation" value = "${resident.protectorRelation }"type="text"></span>
									</div>

				    			</div>
				    			
				    		<div class="text-center">
		                      <button type="submit" class="btn btn-primary">Save Changes</button>
		                    </div>
				    	</div>
					</form><!-- End Profile Edit Form -->      
	            </div>
              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>	

   </main><!-- End #main -->
   <!-- =============================== Main 메인 끝 부분 ================================ -->
   
   <!-- ======= footer 부분 ======= -->
   <jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>