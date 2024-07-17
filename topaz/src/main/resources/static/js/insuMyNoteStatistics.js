$(document).ready(function() {
    let messageType = 'sent';
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
            url: '/topaz/groupware/myPage/myNoteStaticRest',
            method: 'get',
            success: function(response) {
                
                console.log("response : ", response);

                let labels = ['하루', '일주일', '한달'];
                let data = [];

                if (type === 'noteSendCnt') {
                    response.noteSendCnt.forEach(item => {
                        data.push(item.sentCnt);
                    });
                } else {
                    response.noteRecCnt.forEach(item => {
                        data.push(item.recCnt);
                    });
                }

                const ctx = document.getElementById('barChart').getContext('2d');

                // 기존 차트가 있으면 파괴
                if (myChart) {
                    myChart.destroy();
                }

                myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: type === 'noteSendCnt' ? '보낸 메세지' : '받은 메세지',
                            data: data,
                            backgroundColor: [
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(153, 102, 255, 0.2)'
                            ],
                            borderColor: [
                                'rgba(54, 162, 235, 1)',
                                'rgb(255, 99, 132)',
                                'rgb(153, 102, 255)'
                            ],
                            borderWidth: 2
                        }]
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

    //기본적으로 보낸 메세지의 데이터를 로드
    fetchAndRenderChart(messageType);
});
