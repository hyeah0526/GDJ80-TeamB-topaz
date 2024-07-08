<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
   분류번호: #7 - 입주자 리스트 조회
   시작 날짜: 2024-07-08
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
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>residentList.jsp</h1>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<div class="pagetitle">
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">중제목</a></li>
          <li class="breadcrumb-item active">소제목</li>
        </ol>
      </nav>
	</div><!-- End Page Title -->
	
 	<section class="section">
 	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
		    	<h5 class="card-title">Table with stripped rows</h5>
		    	<div class="container">
    <div class="row mb-3">
        <div class="col-md-1">
            <label for="dong" class="form-label">동</label>
        </div>
        <div class="col-md-2">
            <select id="dong" class="form-select" aria-label="Select dong">
				<option value = "">동을 선택하세요 </option>
            </select>
        </div>
        <div class="col-md-1">
            <label for="type" class="form-label">타입</label>
        </div>
        <div class="col-md-2">
            <select id="type" class="form-select" aria-label="Select ho number">
				<option value ="">타입을 선택하세요</option>
            </select>
        </div>
        <div class="col-md-1">
            <label for="ho" class="form-label">호수</label>
        </div>
        <div class="col-md-2">
            <select id="ho" class="form-select" aria-label="Select second ho number">
                <option value ="">호수를 선택하세요</option>
            </select>
        </div>
    </div>
</div>
		    	
			<div class="search-bar">
				<form class="search-form d-flex align-items-center" method="POST" action="#">
					<input type="text" name="query" placeholder="Search..." title="Enter search keyword">
					<button type="submit" title="Search"><i class="bi bi-search"></i></button>
		    	</form>
		   	</div><!-- End Search Bar -->
		<nav class="header-nav ms-auto">
			<ul class="d-flex align-items-center">
				<li class="nav-item d-block d-lg-none">
					<a class="nav-link nav-icon search-bar-toggle " href="#">
						<i class="bi bi-search"></i>
					</a>
				</li><!-- End Search Icon-->
			</ul>
		</nav>
        <!-- Table with stripped rows -->
        <table class="table table-striped">
          	<thead>
	            <tr>
	              <th scope="col">이름</th>
	              <th scope="col">동</th>
	              <th scope="col">호수</th>
	            </tr>
	       	</thead>
          	<tbody>
				<c:forEach var="r" items="${residentList }">
					<tr>
						<td>${r.gstName}</td>
						<td>${r.roomDong }</td>
						<td>${r.roomHo }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- End Table with stripped rows -->
		<nav aria-label="Page navigation example">
          	<ul class="pagination">
	            <li class="page-item"><a class="page-link" href="/topaz/groupware/resident/residentList?currentPage=1">1</a></li>
	            <li class="page-item"><a class="page-link" href="/topaz/groupware/resident/residentList?currentPage=2">2</a></li>
	            <li class="page-item"><a class="page-link" href="/topaz/groupware/resident/residentList?currentPage=3">3</a></li>
	            <li class="page-item">
	              	<a class="page-link" href="/topaz/groupware/resident/residentList?currentPage=${lastPage }" aria-label="Next">
	                	<span aria-hidden="true">&raquo;</span>
	              	</a>
	            </li>
	        </ul>
        </nav><!-- End Pagination with icons -->
			</div>
		</div>
	</div>
	</section>
    
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<!-- 동, 타입, 호수 분류 -->
	<script type="text/javascript">
		$(document).ready(function() {
            // 동 데이터 요청
           	$.ajax({
           		url:'/topaz/groupware/resident/residentList/dong',
           		method:'POST',
           		success: function(dongData){
           			console.log(dongData);
           			//동을 select에 넣어줌
           			dongData.forEach(function(item){ // dong : String
           				console.log(item);
           				$('#dong').append('<option value ="'+item+'">'+item+'</option>');
           			});
           		}
           	});
           	
           	// 동 선택 시 타입 데이터 요청
           	$('#dong').change(function(){
           		if($('#dong').val() == ''){
           			return;
           		}
           		
           		$('#type').empty();
           		$('#type').append('<option value="">타입을 선택하세요</option>')
           		
           		$.ajax({
           			url: '/topaz/groupware/resident/residentList/type',
           			method: 'POST',
           			data: {'dong' : $('#dong').val()},
           			success:function(typeData){ // type : List
           				console.log(typeData);
           				typeData.forEach(function(item){
           					$('#type').append('<option value="'+item+'">'+item+'</option>');
           				});
           			}
           			
           		});
           	});
           		
       		$('#type').change(function(){
           		if($('#type').val() == ''){
           			return;
           		}
           		
           		$('#ho').empty();
           		$('#ho').append('<option value="">호수를 선택하세요</option>')
           		
           		$.ajax({
           			url: '/topaz/groupware/resident/residentList/ho',
           			method: 'POST',
           			data: {'type' : $('#type').val()},
           			success:function(hoData){ // hoData : List
           				console.log(hoData);
           				hoData.forEach(function(item){
           					console.log(item);
           					$('#ho').append('<option value="'+item+'">'+item+'</option>');
           				});
           			}
           		})
           	});
           	
       	});
		
		// 각 선택 요소에 대해 변경 사항이 생길 때마다 필터링된 목록 요청
	    $('#dong, #type, #ho').change(function(){
	        var dong = $('#dong').val();
	        var type = $('#type').val();
	        var ho = $('#ho').val();
	        $.ajax({
	            url: '/topaz/groupware/resident/residentList/filter',
	            method: 'POST',
	            data: {dong: dong, type: type, ho: ho},
	            success: function(data) {
	                var tbody = $('table.table-striped tbody');
	                tbody.empty();
	                data.forEach(function(item){
	                    var row = '<tr>';
	                    row += '<td>' + item.gstName + '</td>';
	                    row += '<td>' + item.dong + '</td>';
	                    row += '<td>' + item.ho + '</td>';
	                    row += '</tr>';
	                    tbody.append(row);
	                });
	            }
	        });
	    });
	</script>
	
</body>

</html>