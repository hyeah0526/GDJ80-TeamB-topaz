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
   <jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

   <!-- =============================== Main 메인 시작 부분 ================================ -->
   <main id="main" class="main">
   
   <!-- Title 시작 -->
   <div class="pagetitle">
      <h1>외주업체 전체 목록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item active">Outsourcing List</li>
        </ol>
      </nav>
   </div><!-- Title 종료 -->

   <!-- section 시작 -->
    <section class="section">
        <div class="card"><div class="card-body">
         <h5 class="card-title"></h5>
         
         <!-- 업체 타입/이름 검색기능(공통 코드 W002(1:상시, 2:예약)) -->
         <span class="searchSpan">업체타입</span>
         <select class="form-select" name="searchType" id="searchType" style="width: 10%; display: inline;">
            <option value="" id="typeAll">전체</option>
            <option value="1" id="typeAlways">상시</option>
            <option value="2" id="typeRsvn">예약</option>
         </select>
         &nbsp;&nbsp;&nbsp;
         <span class="searchSpan">업체ID & 업체이름</span>
         <input type="text" name="searchWord" id="searchWord" class="form-control" style="width: 25%; display: inline;">
         <button type="submit" id="searchButton" class="btn btn-primary">검색</button>
         
         <h5 class="card-title"></h5>
         <!-- 외주업체 목록 리스트 -->
         <table class="table table-hover">
                <thead>
                  <tr>
                    <th scope="col">업체 ID</th>
                    <th scope="col">업체 이름</th>
                    <th scope="col">업체 담당자</th>
                    <th scope="col">계약 시작</th>
                    <th scope="col">계약 종료</th>
                    <th scope="col">사내 담당자</th>
                  </tr>
                </thead>
                <tbody id="tableBody">
                   <!-- Ajax 데이터 조회 추가(bpoList()) -->
                </tbody>
         </table>
         
              
            <!-- 페이징 -->
            <nav aria-label="Page navigation example">
              <ul class="pagination" id="paginationUl">
              <li class="page-item">
                    <a class="page-link bpoListPage" href="#" aria-label="Previous">
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                  
                  <li class="page-item bpoListPage">
                     <a class="page-link" href="">1</a>
                  </li>
                      
                  <li class="page-item bpoListPage">
                    <a class="page-link" href="#" aria-label="Next">
                       <span aria-hidden="true">&raquo;</span>
                      </a>
                  </li>
              </ul>
            </nav>

      </div></div>
    
    </section><!-- section 종료 -->

   </main><!-- End #main -->
   <!-- =============================== Main 메인 끝 부분 ================================ -->
   
   <!-- ======= footer 부분 ======= -->
   <jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
   
   <!-- 전체목록 JS -->
   <script>
   /* 전체목록 조회 */
   $(function(){
        bpoList();
    });
   
   /* Ajax 호출 함수 */
   function bpoList(){
      let searchType = $('#searchType').val();
      let searchWord = $('#searchWord').val();
       
      $.ajax({
         url: '/topaz/bpo/bpoList',
         type: 'POST',
         data: {
               "searchWord" : searchWord,
               "searchType" : searchType
         },
         success:function(result){
            console.log("result--> ", result)
            
            // 리스트 불러올 tbody
            let tbody = $('#tableBody');
            
            // tbody 비워주기
            tbody.empty();
            
            // result 데이터만큼 tr생성
            result.forEach(function(item) {
               // tr추가
               //let row = '<tr onclick="">';
               let row = '<tr onclick="window.location.href=\'/topaz/groupware/bpo/bpoDetail?outsourcingNo=' + item.outsourcingNo + '\'">';
                  row += '<td scope="row">' + item.outsourcingNo + '</td>';
                  row += '<td>' + item.outsourcingName + '</td>';
                  row += '<td>' + item.inchargeName + '</td>';
                  row += '<td>' + item.contractStart + '</td>';
                  row += '<td>' + item.contractEnd + '</td>';
                  row += '<td>' + item.empName + '</td>';
                  row += '</tr>';
               
               // tbody에 행 추가
               tbody.append(row); 
               
               
               
            });
         }
      });
      
      
   }    
    
    /* 검색 버튼 누를 시 */
    $('#searchButton').click(function() {
       // 검색 버튼 누를 시 재호출
       bpoList();
    });
   </script>
   
</body>

</html>