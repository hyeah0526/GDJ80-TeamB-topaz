<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
	<!-- hyeah CSS / JS -->
	<link href="/topaz/css/hyeah.css" rel="stylesheet">
	</head>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBarOut.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>외주업체 고객 예약 상세 및 수정</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item"><a href="/topaz/outsourcing/bpoMainIn">Reservation</a></li>
          <li class="breadcrumb-item active">Reservation Detail & Edit</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<div class="row justify-content-center"><div class="col-lg-6">
    	 	<div class="card"><div class="card-body">
              <h5 class="card-title">Reservation Detail & Edit</h5>
			  
			  <c:set var="r" value="${bpoOutRsvnOne}"></c:set>
              <!-- 예약 상세 및 수정폼  -->
              <form id="modRsvnForm" method="post" action="${pageContext.request.contextPath}/bpo/bpoRsvnModify">
                <input type="hidden" name="rsvnNo" value="${r.rsvnNo}">
              
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">시작 날짜</label>
				  <div class="col-sm-10">
				    <input type="datetime-local" class="form-control" name="rsvnStart" value="${r.rsvnStart}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">종료 날짜</label>
				  <div class="col-sm-10">
				    <input type="datetime-local" class="form-control" name="rsvnEnd" value="${r.rsvnEnd}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 상태</label>
				  <div class="col-sm-3">
				  	<div class="form-control text-center" id="rsvnStateShk">${r.rsvnState}</div>
				  </div>
				  <div class="col-sm-3 col-form-label text-center">상태 변경</div>
				  <div class="col-sm-4">
				  	<select class="form-select" id="rsvnState" name="rsvnState">
				  		<option value="" id="rsvnWait">변경 선택</option>
				  		<option value="2" id="rsvnConfirm">확정</option>
				  		<option value="3" id="rsvnCxl">취소</option>
				  	</select>
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 업체</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" value="${r.outsourcingName}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">고객 이름</label>
				  <div class="col-sm-5">
				    <input type="text" class="form-control" value="${r.gstName}" readonly style="background-color: #d9dce1;">
				  </div>
				  <div class="col-sm-5">
					<input class="form-check-input" type="radio" name="gstGender" id="gstGenderM" onclick="return(false);" readonly> 남자
					&nbsp;&nbsp;&nbsp;
					<input class="form-check-input" type="radio" name="gstGender" id="gstGenderF" onclick="return(false);" readonly> 여자
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 제목</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" id="rsvnTitle" name="rsvnTitle" value="${r.rsvnTitle}">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 내용</label>
				  <div class="col-sm-10">
					<textarea rows="3" maxlength="100" class="col-sm-12 form-control" id="rsvnContent" name="rsvnContent" style="height: 150px">${r.rsvnContent}</textarea>
					(<span id="chatHelper">0</span>/100)
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">작성자</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" id="" name="" value="${r.regName}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">최종 수정자</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" id="" name="" value="${r.modName}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                
                <div class="text-center">
                  <c:if test="${r.rsvnState ne '취소'}">
                  	<button type="submit" id="bpoRsvnEditBtn" class="btn btn-primary">Edit</button>
                  </c:if>
	              <!-- 메인페이지로 이동 버튼 -->
	              <a href="/topaz/outsourcing/bpoMainOut" class="btn btn-secondary">Close</a>
                </div>
              </form><!-- Vertical Form -->

            </div>
		</div></div></div>
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!--  -->
	<script>
	/* type 값에 맞게 checked 추가해주기 */
 	// 성별에 맞게 checked표시해주고 여자는 배경색상을 회색으로 변경
	if(${r.gstGender eq '남자'}){
		console.log('고객 성별: 남자');
		$('#gstGenderM').attr('checked', true);
		$('#gstGenderF').attr('style', 'background-color: #d9dce1');
		
	}else if(${r.gstGender eq '여자'}){
		console.log('고객 성별: 여자');
		$('#gstGenderF').attr('checked', true);
		$('#gstGenderM').attr('style', 'background-color: #d9dce1');
		
	}
 	
	
	/* 예약 상태에 따라 상태 효과 넣어주기 */
 	if(${r.rsvnState eq '대기'}){
 		console.log('예약 상태 : 대기');
 		
 		// 상태변경 - 대기 선택
 		$('#rsvnWait').attr('selected', true);
 		// 예약상태 - 배경색상 변경
 		$('#rsvnStateShk').attr('style', 'background-color: #81bbb2');
 		
 	}else if(${r.rsvnState eq '확정'}){
 		console.log('예약 상태 : 확정');
 		
 		// 상태변경 - 확정 선택
 		$('#rsvnConfirm').attr('selected', true);
 		// 예약상태 - 배경색상 변경
 		$('#rsvnStateShk').attr('style', 'background-color: #f6bf26');
 		
 	}else if(${r.rsvnState eq '취소'}){
 		console.log('예약 상태 : 취소');
 		
 		// 상태변경 - 확정 선택
 		$('#rsvnCxl').attr('selected', true);
 		// 예약상태 - 배경색상 변경
 		$('#rsvnStateShk').attr('style', 'background-color: #d50000');
 		
 		//예약 취소일 경우 모든 내용 수정 불가능하게 변경
 		$('#rsvnState').attr('disabled', true);
 		$('#rsvnState').attr('style', 'background-color: #ffffff');
 		$('#rsvnContent').attr('readonly', true);
 		$('#rsvnTitle').attr('readonly', true);
 		$('#rsvnStart').attr('readonly', true);
 		$('#rsvnEnd').attr('readonly', true);
 	}
	</script>
	
</body>

</html>