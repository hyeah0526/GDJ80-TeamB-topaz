$(document).ready(function() {

	let senderId = $('#senderId').val();
	
	
    //부서 목록 토글
    function toggleDept(deptId) {
        const deptElement = document.getElementById(deptId);
        deptElement.style.display = deptElement.style.display === 'none' ? 'block' : 'none';
    }

    //체크박스 클릭 시 받는 사람 필드 업데이트
    $(document).on('change', '.deptCheckbox', function() {
        updateRecipientsField();
    });

    //직원 목록을 초기 로드
    function loadAllEmployees() {
        $.get('/topaz/groupware/emp/selectEmpName', { empName: '' }, function(response) {
            displayEmployeeList(response);
            checkSelectedRecipients();
        });
    }

    //직원 목록을 표시하는 함수
    function displayEmployeeList(empList) {
        const deptListContainer = $('#deptList');
        deptListContainer.empty();

        const deptMap = {};
        empList.forEach(emp => {
            if (!deptMap[emp.empDept]) {
                deptMap[emp.empDept] = [];
            }
            deptMap[emp.empDept].push(emp);
        });

        for (const deptName in deptMap) {
            const employees = deptMap[deptName];
            let deptHtml = `
                <div class="dept-item">
                    <div class="dept-name" onclick="toggleDept('${deptName}')">
                        <span>+</span> ${deptName}
                    </div>
                    <div class="emp-list" id="${deptName}" style="display: none;">`;

            employees.forEach(emp => {
                deptHtml += `
                    <div>
                        <input type="checkbox" class="deptCheckbox" value="${emp.empName}" data-empno="${emp.empNo}" data-dept="${deptName}" data-name="${emp.empName}"> ${emp.empName}
                    </div>`;
            });

            deptHtml += '</div></div>';
            deptListContainer.append(deptHtml);
        }
    }

    //검색 버튼 클릭 시 이름 검색
    $('#searchButton').click(function() {
        const searchKeyword = $('#searchDept').val();
        $.get('/topaz/groupware/emp/selectEmpName', { empName: searchKeyword }, function(response) {
            displayEmployeeList(response);
            checkSelectedRecipients();
            $('#searchDept').val(''); //검색 입력 필드 초기화
        });
    });

    //리셋 버튼 클릭 시 전체 목록 표시
    $('#resetButton').click(function() {
        loadAllEmployees();
        $('#searchDept').val(''); //검색 입력 필드 초기화
    });

    //전송 버튼 클릭 시 쪽지 전송
    $('#sendButton').click(function() {
        const noteContent = $('#noteContent').val();
        const recipients = [];
        const recipientNos = [];
        
        $('.deptCheckbox:checked').each(function() {
            recipients.push($(this).val());
            recipientNos.push($(this).data('empno'));
        });

        if (recipients.length > 0 && noteContent) {
          	
            $.ajax({
                url: '/topaz/groupware/myPage/insertNote',
                method: 'post',
                contentType: 'application/json',
                data: JSON.stringify({
                    noteContent: noteContent,
                    recipients: recipients
                }),
                success: function() {
                    alert('쪽지가 전송되었습니다.');
                    
                    console.debug("MyNoteAdd :: socket >> ",webSocket)
                    
                    if(webSocket){
						
						const msg = senderId + "," + recipientNos.join(',') + "," + noteContent;
						console.log("msg : " + msg);
						
						 webSocket.send(msg);
					}
                    //window.location.href = '/topaz/groupware/myPage/myNoteList';
                }
            });
        } else {
            alert('모든 필드를 입력해주세요.');
        }
    });
    
 

    //초기 로드 시 모든 직원 목록 표시
    loadAllEmployees();
    

    //받는 사람 필드 업데이트 함수
    function updateRecipientsField() {
        const recipientsField = $('#recipients');
        const checkedBoxes = $('.deptCheckbox:checked');
        let recipients = [];

        checkedBoxes.each(function() {
            const empName = $(this).data('name');
            const deptName = $(this).data('dept');
            recipients.push(`[${deptName} - ${empName}]`);
        });

        recipientsField.val(recipients.join(', '));
    }

    //체크된 값 유지 함수
    function checkSelectedRecipients() {
        const recipientsField = $('#recipients').val();
        if (!recipientsField) return;

        const recipients = recipientsField.split(', ').map(r => {
            const match = r.match(/\[(.*?) - (.*?)\]/);
            return match ? match.slice(1, 3) : [];
        });
        recipients.forEach(([deptName, empName]) => {
            $(`.deptCheckbox[data-name="${empName}"][data-dept="${deptName}"]`).prop('checked', true);
        });
    }
    
    
});

//부서 목록 토클 함수
function toggleDept(deptId) {
    const deptElement = document.getElementById(deptId);
    deptElement.style.display = deptElement.style.display === 'none' ? 'block' : 'none';
}
