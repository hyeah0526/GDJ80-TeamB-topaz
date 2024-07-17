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
		<div class="row ">
	        <div class="col-lg-12">
	          <div class="card"><div class="card-body ">
	              <h5 class="card-title">청소/미청소 방 개수</h5>
	                     <canvas id="pieChart" class="chartCanvas" style="margin: auto"></canvas>
	          </div></div>
	        </div>
	
			<div class="col-lg-6">
	          <div class="card"><div class="card-body">
	              <h5 class="card-title">청소율 차트</h5>
	                 	<canvas id="barChart" class="chartCanvas"></canvas>
	          </div></div>
	        </div>
			
			<div class="col-lg-6">
	          <div class="card"><div class="card-body">
	              <h5 class="card-title">객실 점유율 차트</h5>
	                  	<canvas id="occupancyChart" class="chartCanvas"></canvas>
	          </div></div>
	        </div>
			
			
		</div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<script>
			document.addEventListener("DOMContentLoaded", () => {
				let cleanRooms = 0;
				let dirtyRooms = 0;
				let cleanRate = 0;
				let totalRoom = 0;
				let onRoom = 0;
				let offRoom = 0;
				
				$.ajax({
				    url: '/topaz/groupware/room/roomMakeUpChk',
				    method: 'POST',
				    dataType: 'json',
				    success: function(json) {
				        console.log(json);
				        if (json.length > 0) {
                                           let data = json[0];
                                           cleanRooms = data.cleanRoom;
                                           dirtyRooms = data.dirtyRoom;
                                           cleanRate = data.cleanRate;
                                           totalRoom = data.totalRoom;
                                           onRoom = data.onRoom;
                                           offRoom = data.offRoom;
                                       }

				        // 현재 시간 가져오기
				        const now = new Date();
				        const currentTime = now.toLocaleString(); // 로컬 시간 형식으로 변환
				        console.log(now, currentTime);

				        // 전체 방의 백분율 구하기
				        const totalRoomPercentage = (totalRoom/totalRoom) * 100;
				        console.log(totalRoomPercentage);
				        
				        // 데이터가 로드된 후 차트 생성
				        var pieChartCanvas = document.querySelector('#pieChart');
				        var pieChartContext = pieChartCanvas.getContext('2d');

				        new Chart(pieChartContext, {
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
				                        text: currentTime + '\n 기준 청소 상태',
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

				        var barChartCanvas = document.querySelector('#barChart');
				        var barChartContext = barChartCanvas.getContext('2d');

				        new Chart(barChartContext, {
				            type: 'bar',
				            data: {
				                labels: ['Clean Rate'],
				                datasets: [{
				                    label: 'Rate (%)',
				                    data: [cleanRate,totalRoomPercentage],
				                    backgroundColor: [
				                        'rgba(54, 162, 235, 0.2)', // Blue for Clean
				                    ],
				                    borderColor: [
				                        'rgb(54, 162, 235)', // Blue for Clean
				                    ]
				                }]
				            },
				            options: {
				                responsive: true,
				                scales: {
				                	y: {
				                		beginAtZero: true,
				                		max:100,
				                		ticks: {
				                		    stepSize: 15 
				                		}
				                	}
				                },
				                plugins: {
				                    legend: {
				                        display: false
				                    },
				                    title: {
				                        display: true,
				                        text: currentTime +
				                    	' 기준 청소율', // 차트 제목에 현재 시간 추가
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
				        var occupancyChartCanvas = document.querySelector('#occupancyChart');
				        var occupancyChartContext = occupancyChartCanvas.getContext('2d');

				        new Chart(occupancyChartContext, {
				            type: 'bar',
				            data: {
				                labels: ['입실', '공실'],
				                datasets: [{
				                    label: 'Rooms',
				                    data: [onRoom, offRoom],
				                    backgroundColor: [
				                        'rgba(75, 192, 192, 0.2)', // Teal for Occupied
				                        'rgba(255, 205, 86, 0.2)'  // Yellow for Unoccupied
				                    ],
				                    borderColor: [
				                        'rgb(75, 192, 192)', // Teal for Occupied
				                        'rgb(255, 205, 86)'  // Yellow for Unoccupied
				                    ]
				                }]
				            },
				            options: {
				                responsive: true,
				                scales: {
				                    y: {
				                        beginAtZero: true,
				                        max: totalRoom
				                    }
				                },
				                plugins: {
				                    legend: {
				                        display: false
				                    },
				                    title: {
				                        display: true,
				                        text: ' 객실 점유율', 
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
		</section>
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->

	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<style>
	    .chartCanvas {
	        max-height: 400px;
	        max-width: 400px;
	        width: 100%;
	        height: 100%;
	    }
	</style>
</body>
</html>
