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
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">청소율</h5>
							<span class="col-lg-6">
								<span class="card">
									<span class="card-body">
										<h5 class="card-title">청소율 파이 차트</h5>
										<canvas id="pieChart" style="max-height: 400px;"></canvas>
									</span>
								</span>
							</span>
							<!-- 청소율 게이지 차트 -->
							<span class="col-lg-6">
								<span class="card">
									<span class="card-body">
										<h5 class="card-title">청소율 게이지 차트</h5>
										<canvas id="gaugeChart" style="max-height: 400px;"></canvas>
									</span>
								</span>
							</span>
							<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
							<script src="https://cdn.jsdelivr.net/npm/chartjs-chart-radial-gauge"></script>
							<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
							<script>
								document.addEventListener("DOMContentLoaded", () => {
									let cleanRooms = 0;
									let dirtyRooms = 0;

									$.ajax({
									    url: '/topaz/groupware/room/roomMakeUpChk',
									    method: 'POST',
									    dataType: 'json',
									    success: function(json) {
									        console.log(json);
									        json.forEach(function(item) {
									            cleanRooms += item.cleanRoom;
									            dirtyRooms += item.dirtyRoom;
									        });

									        // 현재 시간 가져오기
									        const now = new Date();
									        const currentTime = now.toLocaleString(); // 로컬 시간 형식으로 변환
									        console.log(now, currentTime);

									        // 데이터가 로드된 후 차트 생성
									        new Chart(document.querySelector('#pieChart'), {
									            type: 'pie',
									            data: {
									                labels: ['Clean', 'Dirty'],
									                datasets: [{
									                    label: 'Room Status',
									                    data: [cleanRooms, dirtyRooms],
									                    backgroundColor: [
									                        'rgba(54, 162, 235, 0.2)', // Blue for Clean
									                        'rgba(255, 99, 132, 0.2)'  // Red for Dirty
									                    ],
									                    borderColor: [
									                        'rgb(54, 162, 235)', // Blue for Clean
									                        'rgb(255, 99, 132)'  // Red for Dirty
									                    ]
									                }]
									            },
									            options: {
									                responsive: true,
									                plugins: {
									                    legend: {
									                        position: 'top',
									                    },
									                    title: {
									                        display: true,
									                        text: currentTime +
									                    	'\n기준 청소 상태', // 차트 제목에 현재 시간 추가
									                        font: {
									                            size: 18
									                        },
									                        padding: {
									                            top: 10,
									                            bottom: 10
									                        }
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
