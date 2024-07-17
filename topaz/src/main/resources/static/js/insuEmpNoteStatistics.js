$(document).ready(function() {
    let messageType = 'noteSendCnt';
    let myChart = null;

    //보낸 메시지 버튼 클릭 시
    $('#sentMessagesBtn').click(function() {
        messageType = 'noteSendCnt';
        fetchAndRenderChart(messageType);
    });

    //받은 메시지 버튼 클릭 시
    $('#receivedMessagesBtn').click(function() {
        messageType = 'noteRecCnt';
        fetchAndRenderChart(messageType);
    });

    function fetchAndRenderChart(type) {
        $.ajax({
            url: '/topaz/groupware/emp/empNoteStaticRest',
            method: 'get',
            success: function(response) {
                console.log("response : ", response);

                let labels = [];
                let dataDay = [];
                let dataWeek = [];
                let dataMonth = [];

                //부서명을 labels 배열에 추가하는 함수
                function addDeptLabels(data) {
                    data.forEach(item => {
                        if (!labels.includes(item.dept)) {
                            labels.push(item.dept);
                        }
                    });
                }

                //기간별 데이터를 배열에 추가하는 함수
                function addPeriodData(data, dayArray, weekArray, monthArray, cntField) {
                    labels.forEach(label => {
                        dayArray.push(data.find(item => item.dept === label && item.period === 'day')?.[cntField] || 0);
                        weekArray.push(data.find(item => item.dept === label && item.period === 'week')?.[cntField] || 0);
                        monthArray.push(data.find(item => item.dept === label && item.period === 'month')?.[cntField] || 0);
                    });
                }

                //메시지 타입에 따른 데이터 처리
                if (type === 'noteSendCnt') {
                    addDeptLabels(response.noteSendCnt);
                    addPeriodData(response.noteSendCnt, dataDay, dataWeek, dataMonth, 'sendCnt');
                } else {
                    addDeptLabels(response.noteRecCnt);
                    addPeriodData(response.noteRecCnt, dataDay, dataWeek, dataMonth, 'receiveCnt');
                }

                const ctx = document.getElementById('barChart').getContext('2d');

                //기존 차트가 있으면 파괴
                if (myChart) {
                    myChart.destroy();
                }

          		//차트 생성
                myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [
                            {
                                label: '하루',
                                data: dataDay,
                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 2
                            },
                            {
                                label: '일주일',
                                data: dataWeek,
                                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                borderColor: 'rgb(255, 99, 132)',
                                borderWidth: 2
                            },
                            {
                                label: '한달',
                                data: dataMonth,
                                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                                borderColor: 'rgb(153, 102, 255)',
                                borderWidth: 2
                            }
                        ]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            },
                            x: {
                                grid: {
                                    display: false
                                },
                                ticks: {
                                    font: {
                                        size: 15
                                    }
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                labels: {
                                    color: "black",
                                    font: {
                                        size: 15
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });
    }

    //페이지 로드 시 기본적으로 보낸 메시지 데이터를 로드
    fetchAndRenderChart(messageType);
});
