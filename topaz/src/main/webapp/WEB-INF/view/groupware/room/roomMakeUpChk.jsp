<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
   분류번호: #8 - 객실 관리 페이지 : 객실 청소율 조회
   시작 날짜: 2024-07-13
   담당자: 박수지
-->
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

    <div class="pagetitle">
      <h1>청소통계</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/room/roomList">room List</a></li>
          <li class="breadcrumb-item active">Statistics</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->


    <section class="section">
      <div class="row">
       
        <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">청소율</h5>

              <canvas id="barChart" style="max-height: 400px;"></canvas>
				<script>
				  document.addEventListener("DOMContentLoaded", () => {
				    const xValues = [];
				    const yValues = [];
				
				    $.ajax({
				      url: '/topaz/groupware/room/roomMakeUpChk',
				      method: 'POST',
				      dataType: 'json',
				      success: function(json) {
				        console.log(json);
				        json.forEach(function(item) {
				          xValues.push(item.cleanRoom);
				          yValues.push(item.cleanRate);
				        });
				
				        // 데이터가 로드된 후 차트 생성
				        new Chart(document.querySelector('#barChart'), {
				          type: 'bar',
				          data: {
				            labels: xValues,
				            datasets: [{
				              label: 'Bar Chart',
				              data: yValues,
				              backgroundColor: [
				                'rgba(255, 99, 132, 0.2)',
				                'rgba(255, 159, 64, 0.2)',
				              ],
				              borderColor: [
				                'rgb(255, 99, 132)',
				                'rgb(255, 159, 64)',
				              ],
				              borderWidth: 1
				            }]
				          },
				          options: {
				            scales: {
				              y: {
				                beginAtZero: true
				              }
				            }
				          }
				        });
				      },
				      error: function(xhr, status, error) {
				        console.error('AJAX 오류:', status, error);
				      }
				    });
				  });
				</script>


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