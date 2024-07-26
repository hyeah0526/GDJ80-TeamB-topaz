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
      <h1>외주업체 고객 예약 상세 및 수정</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/bpo/bpoMainIn">Reservation</a></li>
          <li class="breadcrumb-item active">Reservation Detail & Edit</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<div class="row justify-content-center"><div class="col-lg-6">
    	 	<div class="card"><div class="card-body">
              <h5 class="card-title">Reservation Detail & Edit</h5>
			  
			  <c:set var="r" value="${bpoRsvnOne}"></c:set>
              <!-- 예약 상세 및 수정폼  -->
              <form id="modRsvnForm" method="post" action="${pageContext.request.contextPath}/bpo/bpoRsvnModify">
                <input type="hidden" name="rsvnNo" value="${r.rsvnNo}">
              
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">시작 날짜</label>
				  <div class="col-sm-10">
				    <input type="datetime-local" class="form-control" id="rsvnStart" name="rsvnStart" value="${r.rsvnStart}">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">종료 날짜</label>
				  <div class="col-sm-10">
				    <input type="datetime-local" class="form-control" id="rsvnEnd" name="rsvnEnd" value="${r.rsvnEnd}">
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
				  		<option value="1" id="rsvnWait">대기</option>
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
				    <input type="text" class="form-control" id="" name="" value="${r.gstName}" readonly style="background-color: #d9dce1;">
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
	              <!-- 전페이지로 이동 버튼 -->
	              <button type="button" onclick="history.back()" class="btn btn-secondary">Close</button>
                </div>
              </form><!-- Vertical Form -->

            </div>
		</div></div></div>
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- JS -->
	<script>
	
	/* 키보드 이벤트 발생 */
	// 원래 들어가 있던 값 넣어주기
	let cnt = $('#rsvnContent').val().length;
	$('#chatHelper').html(cnt);
	
	// 새로운 이벤트 발생시
 	$('#rsvnContent').keyup(function() {
		console.log('키보드 이벤트 확인');
		
		let cnt = $('#rsvnContent').val().length;
		//console.log('키보드 이벤트 확인 cnt-> ', cnt);
		
		// 100글자 이상일경우 문자열 자르기
		if(cnt > 100){
			console.log('100이상 작성으로 substr실행');
			cnt = 100;
			$('#rsvnContent').val($('#rsvnContent').val().substr(0, 100));
		}
		
		// cnt수 사용자에게 보여주기
		$('#chatHelper').html(cnt);
		
	});
	
	
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
 	
 	
 	
 	/* 종료일이 시작일보다 먼저일 수 없게 예외처리 */
    // 시작일 먼저 입력시 유효성검사
    $('#rsvnStart').change(function() {
        validateDateRange();
    });

    // 종료일 먼저 입력시 유효성검사
    $('#rsvnEnd').change(function() {
        validateDateRange();
    });
    
    function validateDateRange() {
        // 시작일, 종료일 값 
        var startDateValue = new Date($('#rsvnStart').val());
        var endDateValue = new Date($('#rsvnEnd').val());

        // 종료일이 시작일보다 이른 경우
        if ($('#rsvnEnd').val() !== '' && endDateValue < startDateValue) {
            // 안내
            alert('종료일은 시작일 이후여야 합니다.');

            // 값 초기화
            $('#rsvnEnd').val('');
        }
    }
 	
 	
 	/* 유효성검사 */
 	$('#bpoRsvnEditBtn').click(function() {
 		// 시작 날짜 유효성 검사
		if($('#rsvnStart').val().length < 1){
			console.log('시작날짜 유효성검사');
			
			alert('시작날짜를 입력해주세요');
			$('#rsvnStart').focus();
			return false; 
		}
		
		// 종료 날짜 유효성 검사
		if($('#rsvnEnd').val().length < 1){
			console.log('종료날짜 유효성검사');
			console.log('종료날짜 유효성검사',$('#addEndDate').val());
			
			alert('종료날짜를 입력해주세요');
			$('#rsvnEnd').focus();
			return false; 
		}
		
		// 예약제목 유효성 검사
		if($('#rsvnTitle').val().length < 1){
			console.log('예약제목 유효성검사');
			
			alert('예약제목을 입력해주세요');
			$('#rsvnTitle').focus();
			return false; 
		}
		
		
		// 내용 유효성 검사
		if($('#rsvnContent').val().length < 1){
			console.log('내용 유효성검사');
			
			alert('예약 내용을 입력해주세요');
			$('#rsvnContent').focus();
			return false; 
		}
		
		// 유효성 검사 완료시 Form 보내기
		modRsvnForm.submit();
 		
 	});
	</script>
</body>

</html>