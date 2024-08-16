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


## 4.  WBS / ERD / 테이블 정의서 / 전체 시연 영상 / 배포
- [WBS 링크 이동](https://github.com/hyeah0526/GDJ80-TeamB-topaz/blob/b604b4b91f1e67d116f6fbb620026f718346c888/topaz/src/main/resources/static/document/WBS.png)
- [ERD 다이어그램 링크 이동](https://github.com/hyeah0526/GDJ80-TeamB-topaz/blob/b604b4b91f1e67d116f6fbb620026f718346c888/topaz/src/main/resources/static/document/ERD.png)
- [테이블 정의서](https://docs.google.com/spreadsheets/d/1pRGr-6jWC95Qof-Y3daB35SteG2AeWJwrXgm1-QNgTY/edit?usp=sharing)
- [전체 시연 영상](https://drive.google.com/file/d/1A6D8HMPHWv3ssWJc-uqp4OXnm9PWonpR/view?usp=sharing)
- [배포 링크 이동](http://52.79.81.56/topaz/login)

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

## 7. 후기
#### 박혜아 ([@hyeah0526](https://github.com/hyeah0526)) 
파이널 팀 프로젝트를 통해 스프링의 다양한 기능과 MVC패턴에 익숙해질 수 있었습니다. 
이번 프로젝트에서 여러 API를 적용해보는데 도전했습니다. 처음에는 익숙하지 않아 많은 어려움을 겪었지만, 다양한 방법을 시도하여 문제를 극복하고 구현을 완료하였습니다. 
개개인의 다른 스타일로 의견 충돌이 발생하였지만 소통과 현업 개발자님과의 멘토링을 통하여 현업 스타일의 방식으로 조율하여 진행하였습니다.

#### 김인수 ([@Guinsu](https://github.com/Guinsu))
파이널 프로젝트에서는 여러 가지 기술을 사용하여 다양한 문제를 해결했습니다. 
Interceptor를 통해 페이지 전환 시 로그인 상태가 풀리는 문제를 해결하여, 사용자가 로그인을 유지한 채로 원활하게 페이지를 이동할 수 있도록 했습니다. 
REST API와 Ajax를 활용해 클라이언트와 서버 간의 통신을 원활하게 처리했습니다. 또한, Scheduled 기능을 사용해 월차 지급을 자동화했습니다. 이처럼 다양한 문제를 해결하는 과정에서 혼자서도 성장할 수 있는 개발자의 능력을 키우게 되었습니다.

#### 박수지 ([@SSUJIJI](https://github.com/SSUJIJI))
프로젝트를 통해 REST API와 비동기 데이터 처리 방법에 대해 깊이 이해할 수 있었습니다. 
대분류를 선택하면 중분류를 선택할 수 있는 비동기 드롭다운 기능을 구현하며 비동기 데이터 처리의 중요성과 효과를 깊게 알 수 있었습니다. 
팀원들과의 협업을 통해 프로젝트를 성공적으로 마무리한 경험은 매우 뿌듯했습니다. 이 과정에서 협업 능력을 더욱 강화했습니다.

#### 한은혜 ([@eunhyes](https://github.com/eunhyes))
Spring MVC 구조와 REST API를 처음 배운 후, 이를 익숙하게 사용할 수 있는 기회가 된 프로젝트였습니다.
특히, 로그인과 필터 기능을 처음으로 구현해보면서 세션, 쿠키, 서블릿 등의 개념을 깊이 있게 공부할 수 있었습니다.
다양한 문제를 해결하면서 최신 라이브러리와 프레임워크의 변화에 빠르게 적응하고, 사용하는 능력의 중요성을 깨달았습니다.


