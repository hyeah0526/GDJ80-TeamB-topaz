$(document).ready(function() {
	//ajax 통신 (모든 직원 정보 가져오기)
    $.ajax({
        url: '/topaz/groupware/emp/empAllChart', // 실제 API 엔드포인트로 변경
        method: 'get',
        success: function(response) {
            console.log(response); // 응답 데이터 디버깅

            // 대표자 노드 (admin)
            let adminNode = {
                id: 1,
                name: '이대표',
                department: '인사부',
                grade: '부장',
                img: '/topaz/upload/emp/admin.jpg',
                pid: null
            };

            // 부서를 기준으로 데이터를 그룹화
            let departments = {};
            response.forEach(item => {
                if (item.empName !== '이대표') { // 대표자는 제외
                    if (!departments[item.empDept]) {
                        departments[item.empDept] = [];
                    }
                    departments[item.empDept].push(item);
                }
            });

            // 노드 배열 초기화
            let nodes = [adminNode];
            let currentId = 2;

            // 부서별로 부장, 팀장, 대리, 사원 노드를 추가
            Object.keys(departments).forEach(dept => {
                let deptEmployees = departments[dept];

                // 부장 노드들 추가
                let managers = deptEmployees.filter(emp => emp.empGrade === '부장');
                let managerIds = [];
                managers.forEach(manager => {
                    let managerNode = {
                        id: currentId,
                        name: manager.empName,
                        department: manager.empDept,
                        grade: manager.empGrade,
                        img: manager.file_name ? '/topaz/upload/emp/' + manager.file_name : 'https://cdn.balkan.app/shared/empty-img-none.svg',
                        pid: 1 // 대표자에게 연결
                    };
                    managerIds.push(currentId);
                    nodes.push(managerNode);
                    currentId++;
                });

                // 팀장 노드들 추가
                let teamLeaders = deptEmployees.filter(emp => emp.empGrade === '팀장');
                let teamLeaderIds = [];
                teamLeaders.forEach((teamLeader, index) => {
                    let teamLeaderNode = {
                        id: currentId,
                        name: teamLeader.empName,
                        department: teamLeader.empDept,
                        grade: teamLeader.empGrade,
                        img: teamLeader.file_name ? '/topaz/upload/emp/' + teamLeader.file_name : 'https://cdn.balkan.app/shared/empty-img-none.svg',
                        pid: managerIds[index % managerIds.length] // 부장들에게 순차적으로 연결
                    };
                    teamLeaderIds.push(currentId);
                    nodes.push(teamLeaderNode);
                    currentId++;
                });

                // 대리 노드들 추가
                let assistants = deptEmployees.filter(emp => emp.empGrade === '대리');
                let assistantIds = [];
                assistants.forEach((assistant, index) => {
                    let assistantNode = {
                        id: currentId,
                        name: assistant.empName,
                        department: assistant.empDept,
                        grade: assistant.empGrade,
                        img: assistant.file_name ? '/topaz/upload/emp/' + assistant.file_name : 'https://cdn.balkan.app/shared/empty-img-none.svg',
                        pid: teamLeaderIds[index % teamLeaderIds.length] // 팀장들에게 순차적으로 연결
                    };
                    assistantIds.push(currentId);
                    nodes.push(assistantNode);
                    currentId++;
                });

                // 사원 노드들 추가
                let employees = deptEmployees.filter(emp => emp.empGrade === '사원');
                employees.forEach((employee, index) => {
                    let employeeNode = {
                        id: currentId,
                        name: employee.empName,
                        department: employee.empDept,
                        grade: employee.empGrade,
                        img: employee.file_name ? '/topaz/upload/emp/' + employee.file_name : 'https://cdn.balkan.app/shared/empty-img-none.svg',
                        pid: assistantIds[index % assistantIds.length] // 대리들에게 순차적으로 연결
                    };
                    nodes.push(employeeNode);
                    currentId++;
                });
            });

            // OrgChart 초기화
            let chart = new OrgChart($("#tree")[0], {
                template: "olivia",
                searchDisplayField: 'name',
                toolbar: { // toolbar
                    layout: true,
                    zoom: true,
                    fit: true,
                    expandAll: true
                },
                editForm: { // 모달창 폼
                    buttons: { // 버튼
                        edit: null
                    },
                    generateElementsFromFields: false,
                    elements: [ // 요소
                        { type: 'textbox', label: 'Name', binding: 'name' },
                        { type: 'textbox', label: 'Department', binding: 'department' },
                        { type: 'textbox', label: 'Grade', binding: 'grade' }
                    ]
                },
                nodeBinding: { // 보여지는 정보들
                    field_0: "name",
                    field_1: "department",
                    field_2: "grade",
                    img_0: "img"
                },
                nodes: nodes,
                scaleInitial: OrgChart.match.boundary, // 초기 줌 설정
                nodeSize: [250, 300]
            });
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
});

