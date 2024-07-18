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
      <h1>입주자 등록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">HOME</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/resident/residentList">Resident List</a></li>
          <li class="breadcrumb-item active">Resident Add</li>
        </ol>
      </nav>
   </div><!-- Title 종료 -->

   <!-- section 시작 -->
    <section class="section profile">
      <div class="row justify-content-center">
        

        <div class="col-xl-12">
          <div class="card">
            <div class="card-body pt-3">
            	
                <div class="tab-pane show profile-edit pt-3" id="profile-edit">
					<form action="/topaz/groupware/resident/residentAdd" method="post" enctype="multipart/form-data">
                		
						<div class="row">
	                    	<div class="col-lg-6 col-md-6">
	                    	
	                          	<!-- 고객 선택 -->
							    <div class="info-item mb-3">
								    <span class="label">이름</span>
								    <select name="gstSelect" class="form-control" style="width: 200px; display: inline;" onchange="updateGstId()">
								        <c:forEach items="${gstOne}" var="guest">
								            <option value="${guest.gstId}" data-email="${guest.gstEmail}" 
								            		data-phone="${guest.gstPhone}" data-gender="${guest.gstGender }" data-birth="${guest.gstBirth }">${guest.gstName} 
								            </option>
								        </c:forEach>
								    </select>
								</div>

	                    		<div class="info-item mb-3">
								    <span class="label" >사진</span>
								    <span><input class="form-control" type="file" id="formFile" name="uploadFile"></span>
								</div>
								
								<div class="info-item mb-3">
								    <span class="label">아이디</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" id="gstId" name="gstId" type="text"></span>
								</div>
								
								<div class="info-item mb-3">
								    <span class="label">전화번호</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" id="gstPhone" name="gstPhone" type="text" ></span>
								</div>
								
								<div class="info-item mb-3">
								    <span class="label">이메일</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" id="gstEmail" name="gstEmail" type="text" ></span>
								</div>
								
								<div class="info-item mb-3">
								    <span class="label">성별</span>
								    <span><input style="width: 200px; display: inline;" class="form-control" id="gstGender" name="gstGender" type="text" ></span>
								</div>
								
								<div class="info-item mb-3">
								    <span class="label">생년월일</span>
								   	<span><input style="width: 200px; display: inline;" class="form-control" id="gstBirth" name="gstBirth" type="text" ></span>
								</div>
								
								<div class="info-item mb-3">
								    <span class="label">내용</span>
								    <span><textarea style="width: 200px; display: inline;" class="form-control" rows="2" cols="20" name="residentNote"></textarea></span>
								</div>
								
								<div class="info-item mb-3">
								   	<span><input style="width: 200px; display: inline;" class="form-control" name="useYn" type="hidden" value="${resident.useYn}" ></span>
									<span><input style="width: 200px; display: inline;" class="form-control" name="gstType" type="hidden" value="${resident.gstType}"></span>
									<span><input style="width: 200px; display: inline;" class="form-control" name="roomState" id="roomState" type="hidden" ></span>
									<span><input style="width: 200px; display: inline;" class="form-control" name="roomUse" id="roomUse" type="hidden" ></span>
								</div>
							</div>
								<div class="col-lg-6 col-md-6">
								    <div class="info-item mb-3">
								        <span class="label ">계약기간</span>
								        <span><input class="form-control date-input" style="width: 160px; display: inline" name="contractStart" type="datetime" ></span>  ~ 
								        <span><input style="width: 160px; display: inline" class="form-control date-input" name="contractEnd" type="datetime" ></span>
									</div>
									    <!-- 객실 선택 -->
								    <div class="info-item mb-3">
								    	<span class="label">객실</span>
								        <select name="roomNo" class="form-control" style="width: 200px; display: inline;" onchange="updateRoom()">
								            <c:forEach items="${room}" var="c">
								                <option value="${c.roomNo}" data-type="${c.roomType }"
								                		data-dong = "${c.roomDong }" data-ho = "${c.roomHo }"
								                		data-state = "${c.roomState }" data-use = "${c.roomUse }"
								                		>${c.roomType} - ${c.roomDong}동 ${c.roomHo}호
								                </option>
								            </c:forEach>
								        </select>
								    </div>
								    
									<div class="info-item mb-3 align-row">
										<span class="label"></span>
									    <input style="width: 100px; display: inline; text-align: right;" class="form-control date-input" id="roomType" name="roomType" type="text" >
									    <span class="label">타입</span>
									    
									    <input style="width: 100px; display: inline; text-align: right;" class="form-control date-input" id="roomDong" name="roomDong" type="text" >
									    <span class="label">동</span>
									    
									    <input style="width: 100px; display: inline; text-align: right;" class="form-control date-input" id="roomHo" name="roomHo" type="text" >
									    <span class="label">호</span>
									</div>
									
									<div class="info-item mb-3">
									    <span><label class="form-check-label label" for="roomAmenity">어메니티 여부</label></span>
									    <span><input type="hidden" id="hiddenRoomAmenity" name="roomAmenity" value="${resident.roomAmenity == 'Y' ? 'Y' : 'N'}"></span>
									    <span>
									        <input class="form-check-input" type="checkbox" id="roomAmenityCheckbox" ${resident.roomAmenity == 'Y' ? 'checked' : ''} 
									               onchange="document.getElementById('hiddenRoomAmenity').value = this.checked ? 'Y' : 'N';">
									    </span>
									</div>

									<div class="info-item mb-3">
									    <span class="label">보호자 성명</span>
									    <span><input style="width: 200px; display: inline;" class="form-control" name="protectorName" ></span>
									</div>
									
									<div class="info-item mb-3">
									    <span class="label">보호자 연락처</span>
									    <span><input style="width: 200px; display: inline;" class="form-control" name="protectorPhone"></span>
									</div>
									
									<div class="info-item mb-3">
									    <span class="label">입주자와의 관계</span>
									    <span><input style="width: 200px; display: inline;" class="form-control" name="protectorRelation" type="text"></span>
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
    </section>	

   </main><!-- End #main -->
   <!-- =============================== Main 메인 끝 부분 ================================ -->
	<script>
	    // 고객 ID를 업데이트하는 함수
	    function updateGstId() {
	        var selectBox = document.querySelector('select[name="gstSelect"]');
	        var selectedId = selectBox.value; // 셀렉트 박스에서 선택된 값(고객 ID) 가져오기
	        var selectedEmail = selectBox.options[selectBox.selectedIndex].getAttribute('data-email'); // 고객의 이메일 가져오기
	        var selectedPhone = selectBox.options[selectBox.selectedIndex].getAttribute('data-phone'); // 고객의 전화번호 가져오기
	        var selectedGender = selectBox.options[selectBox.selectedIndex].getAttribute('data-gender'); // 고객의 성별 가져오기
	        var selectedBirth = selectBox.options[selectBox.selectedIndex].getAttribute('data-birth'); // 고객의 전화번호 가져오기
	        document.getElementById('gstId').value = selectedId; // 입력 필드에 ID 설정
	        document.getElementById('gstEmail').value = selectedEmail; // 입력 필드에 EMAIL 설정
	        document.getElementById('gstPhone').value = selectedPhone; // 입력 필드에 PHONE 설정
	        document.getElementById('gstGender').value = selectedGender; // 입력 필드에 GENDER 설정
	        document.getElementById('gstBirth').value = selectedBirth; // 입력 필드에 BIRTH 설정
	    }
	    // room을 업데이트 함수
	    function updateRoom(){
	    	var selectRoom = document.querySelector('select[name="roomNo"]');
	    	var selectedRoomType = selectRoom.options[selectRoom.selectedIndex].getAttribute('data-type');
	    	var selectedRoomDong = selectRoom.options[selectRoom.selectedIndex].getAttribute('data-dong');
	    	var selectedRoomHo = selectRoom.options[selectRoom.selectedIndex].getAttribute('data-ho');
	    	var selectedRoomState = selectRoom.options[selectRoom.selectedIndex].getAttribute('data-state');
	    	var selectedUse = selectRoom.options[selectRoom.selectedIndex].getAttribute('data-use');
	    	document.getElementById('roomType').value = selectedRoomType;
	    	document.getElementById('roomDong').value = selectedRoomDong;
	    	document.getElementById('roomHo').value = selectedRoomHo;
	    	document.getElementById('roomState').value = selectedRoomState;
	    	document.getElementById('roomUse').value = selectedUse;
	    }
    </script>
   <!-- ======= footer 부분 ======= -->
   <jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>