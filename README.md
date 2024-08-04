# 토파즈(TOPAZ) :: 실버타운 운영 그룹웨어

## 1. 프로젝트 소개
현대 사회의 고령화로 인해 다양한 형태의 실버타운이 등장함에 따라 실버타운 그룹웨어의 수요가 증가할 것으로 예상하여 업무 효율성 증대를 위한 실버타운 맞춤형 그룹웨어

<img alt="Java" src ="https://img.shields.io/badge/Java-007396.svg?&style=for-the-badge&logo=Java&logoColor=white"/><img src="https://img.shields.io/badge/springboot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white"><img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white"><img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"><img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"><img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"><img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"><img src="https://img.shields.io/badge/Ajax-00758F?style=for-the-badge&logo=ajax&logoColor=white"><img src="https://img.shields.io/badge/mariaDB-003545?style=for-the-badge&logo=mariaDB&logoColor=white"><img src="https://img.shields.io/badge/apache tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"><img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white"><img src="https://img.shields.io/badge/amazonaws-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white"> 


## 2. 기간 및 팀원 구성
- 기간 : 2024.06.24 ~ 2024.07.26
- 참여자 : 박혜아(팀장), 김인수(팀원), 박수지(팀원), 한은혜(팀원)

## 3. 요구사항 명세서
- [요구사항 명세서 링크 이동](https://github.com/hyeah0526/GDJ80-TeamB-topaz/blob/b604b4b91f1e67d116f6fbb620026f718346c888/topaz/src/main/resources/static/document/%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD%EB%AA%85%EC%84%B8%EC%84%9C.png)
<img src="https://github.com/hyeah0526/GDJ80-TeamB-topaz/blob/b604b4b91f1e67d116f6fbb620026f718346c888/topaz/src/main/resources/static/document/%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD%EB%AA%85%EC%84%B8%EC%84%9C.png" width="800"/>


## 4.  WBS / ERD / 테이블 정의서
- [WBS 링크 이동](https://github.com/hyeah0526/GDJ80-TeamB-topaz/blob/b604b4b91f1e67d116f6fbb620026f718346c888/topaz/src/main/resources/static/document/WBS.png)
- [ERD 다이어그램 링크 이동](https://github.com/hyeah0526/GDJ80-TeamB-topaz/blob/b604b4b91f1e67d116f6fbb620026f718346c888/topaz/src/main/resources/static/document/ERD.png)
- [테이블 정의서](https://docs.google.com/spreadsheets/d/1pRGr-6jWC95Qof-Y3daB35SteG2AeWJwrXgm1-QNgTY/edit?usp=sharing)


## 5. 담당 기능
### 1. 사내일정
   - FullCalendar API를 사용하여 캘린더를 통한 사내일정 전체 조회
     - 카테고리 선택으로 종류별 일정 조회 가능
     - 오늘의 일정 조회
   - chart.js를 사용하여 이번달 일정별 통계를 확인 가능
   - 신규 사내일정 추가
     - 일정 추가 버튼 클릭시 모달 팝업이 활성화

### 2. 전자결재
   - 서명 등록 및 수정
     - Signature Pad를 사용하여 작성된 서명 이미지를 서버로 전송 및 저장
   - 결재 등록
     - 휴가 신청서: 연/월/반차 신청이 가능하며, 최종승인시 내 휴가 정보에 등록되도록 구현
     - 기획 제안서: 엑셀, 워드와 같은 첨부파일이 필수로 등록하도록 구현
     - 경비 청구서: 금액 작성 및 영수증 첨부파일이 필수로 등록하도록 구현
   - 결재 상세
     - 각 기안서에 맞는 내용으로 출력되도록 구현
     - 첨부파일은 원본 파일 이름으로 다운로드 가능하도록 설정
   - 결재 승
     - 결재 상세페이지에서 기안자-중간 승인자-최종 승인자의 프로세스로 순차적으로 승인할 수 있도록 구현
     - 승인 상태에 따라 각 프로세스에 맞는 안내문구 출력

### 3. 외주업체 예약 일정
   - FullCalendar API를 사용하여 캘린더를 통한 예약일정 전체 조회
     - 카테고리 선택으로 업체별 예약 일정 조회 가능
     - 오늘의 예약 조회 및 업체별(예약가능업체) 영업 상태 확인
   - 신규 예약일정 추가
     - 신규 예약 생 버튼 클릭시 모달 팝업이 활성화
     - 고객이름 검색을 통해 입주자 선택 가능하도록 구현
    
### 4. 외주업체 목록 및 상세/수정
   - 전체 외주업체 목록을 검색어와 함께 동적으로 구현
   - 상세 페이지에서 탭이동으로 외주업체 정보를 수정 가능

### 5. 외주업체 신규 등록
   - 새로운 업체를 등록 가능하며 상시, 예약 구분에 따라 아이디 앞에 B1(상시) 혹은 B2(예약)을 추가
   - Springboot Validation을 이용한 커맨드객체 유효성 검사 진행


## 6. 미리보기
### 1. 사내일정
<p align="center">
<img src="https://github.com/user-attachments/assets/09ae4fce-0a69-46e2-8f82-fe456f66b497" style="width: 1000px;">
</p><br><br>

### 2. 전자결재 서명 등록 및 수정
<p align="center">
<img src="https://github.com/user-attachments/assets/f597a4e7-3972-4962-8214-730978458ce2" style="width: 1000px;">
</p><br><br>

### 3. 전자결재 등록
<p align="center">
<img src="https://github.com/user-attachments/assets/0d224502-2f1c-4fba-9ed3-aac607afcd10" style="width: 1000px;">
</p><br><br>

### 4. 전자결재 승인
<p align="center">
<img src="https://github.com/user-attachments/assets/dd2a6ae7-b89a-486b-8ede-a5c424f1b121" style="width: 1000px;">
</p><br><br>

### 5. 외주업체 예약일정 / 상세
<p align="center">
<img src="https://github.com/user-attachments/assets/9a1e8335-5844-4da9-89a3-b2c8f7766577" style="width: 1000px;">
</p><br><br>

### 6. 외주업체 업체 신규 등록
<p align="center">
<img src="https://github.com/user-attachments/assets/1c7e11b7-7fdd-48e8-956c-b96e79735b80" style="width: 1000px;">
</p><br><br>




