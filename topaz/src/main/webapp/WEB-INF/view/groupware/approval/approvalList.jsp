<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
<!--	<script src="/topaz/javascriptSignature/js/signature_pad.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="/topaz/javascriptSignature/css/css.css">
     <script>
        let canvas = $("#signature-pad canvas")[0];
        let sign = new SignaturePad(canvas, {
            minWidth: 1, // 초기값 5
            maxWidth: 3, // 초기값 10
            penColor: "rgb(0, 0, 0)" // 서명 색상
        });
        
        $("[data-action]").on("click", function(){
            if ( $(this).data("action")=="clear" ){
                sign.clear();
            }
            else if ( $(this).data("action")=="save" ){
                if (sign.isEmpty()) {
                    alert("서명을 작성해 주세요.");
                } else {
                    $.ajax({
                        url : "signSave.jsp",
                        method : "post",
                        dataType : "json",
                        data : {
                            sign : sign.toDataURL()
                        },
                        success : function(r){
                            alert("저장 완료 : " + r.filename);
                            sign.clear();
                        },
                        error : function(res){
                            console.log(res);
                        }
                    });
                }
            }
        });
        
        
        function resizeCanvas(){
            let canvas = $("#signature-pad canvas")[0];
    
            let ratio =  Math.max(window.devicePixelRatio || 1, 1);
            canvas.width = canvas.offsetWidth * ratio;
            canvas.height = canvas.offsetHeight * ratio;
            canvas.getContext("2d").scale(ratio, ratio);
        }
        
        $(window).on("resize", function(){
            resizeCanvas();
        });

        resizeCanvas();
    </script> -->
     <style>
        .hiddenBtn {
            display: none;
        }
    </style>
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>approvalList.jsp</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">중제목</a></li>
          <li class="breadcrumb-item active">소제목</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->
	
	<a href ="/topaz/groupware/approval/approvalSign">서명 등록</a>
	<!-- section 시작 -->
    <section class="section">
    <div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						
						<!-- Table with stripped rows -->
						<div id="searchFormContainer" style="margin-top: 20px;">
							<form action="/topaz/groupware/approval/approvalList" id="searchForm" method="get">
								<div id="approvalStateContainer" style="margin-bottom: 30px;">
									<button type="button" class="btn btn-primary" value="">전체</button>
									<button type="button" class="btn btn-primary" value="4">승인</button>
									<button type="button" class="btn btn-primary" value="3">진행</button>
									<button type="button" class="btn btn-primary" value="2">대기</button>
									<button type="button" class="btn btn-primary" value="1">취소 / 반려</button>
								</div>
								<div id="approvalSearchContainer">
									<button type="button" class="resetBtn hiddenBtn">초기화</button>
									<input type="text" placeholder="제목 또는 내용을 검색해 주세요" name="searchWord">
									<button type="submit" class="btn btn-primary">검색</button>
								</div>
							</form>
						</div>
						<br>
						<form action="" method="get">
							<button type="submit" class="btn btn-primary">작성</button>
						</form>
						<table class="table">
							<thead>
								<tr>
									<th>문서 번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>상태</th>
									<th>결재 시작</th>
									<th>결재 종료</th>
								</tr>	
							<!-- 상단 노출 공지사항 -->
							<tbody id="approvalListContainer">
							</tbody>
						</table>
						
					<nav aria-label="Page navigation example">
						<ul class="pagination" id="paginationUl">
			           </ul>
					</nav>				
						<!-- End Table with stripped rows -->
					</div>
				</div>
			</div>
		</div>
    
    
    
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/jihoonApprovalListSelect.js"></script>
</body>

</html>