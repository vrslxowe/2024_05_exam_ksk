<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<%@ include file="../common/head.jspf"%>

<form onsubmit="event.preventDefault(); submitQuestion();">
    <textarea id="questionContent" placeholder="문의사항을 입력하세요"></textarea>
    <button type="submit">검색</button>
</form>
<h2>답변</h2>
<ul id="questionsList"></ul>

<script>
async function submitQuestion() {
    const content = document.getElementById("questionContent").value;
    const response = await fetch('/api/questions', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ content: content })
    });
    const data = await response.json();
    displayAnswer(content, data);
}

    function displayAnswer(question, answer) {
        const questionsList = document.getElementById("questionsList");
        const li = document.createElement("li");
        li.innerHTML = `<strong>${question}</strong>: ${answer}`;
        questionsList.appendChild(li);
    }
</script>

<button class="tourist"></button>
<button class="weather"></button>
<div>제주도 관광 정보</div>
<div id="touristInfo"></div>

<button id="fetchWeatherButton">제주도 오늘 날씨</button>
<div id="weatherInfo"></div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const fetchWeatherButton = document.getElementById('fetchWeatherButton');
    const weatherInfoDiv = document.getElementById('weatherInfo');

    fetchWeatherButton.addEventListener('click', async () => {
        try {
            const response = await fetch('/api/weather');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();

            const temperatureData = data.response.body.items.item.filter(entry => entry.category === 'TMP');

            const hourlyTemperatures = temperatureData.map(entry => {
                // fcstTime에서 앞의 두 자리만 추출하여 시간 정보만 사용
                const fcstTime = entry.fcstTime;
                const hour = fcstTime.slice(0, 2); // 앞의 두 자리만 추출

                // 온도 데이터가 문자열로 오는 경우가 있으므로, 숫자로 변환
                // 숫자 변환에 실패하는 경우를 대비하여 예외 처리
                let temperature;
                try {
                    temperature = parseFloat(entry.fcstValue);
                } catch {
                    temperature = 'N/A'; // 변환에 실패하면 'N/A'로 설정
                }
                
                return {
                    time: hour + "시", // 시간만 표시 (분은 무시)
                    temperature: temperature + "도" // 온도
                };
            });

            // JSON 형식으로 결과를 화면에 표시
            weatherInfoDiv.innerHTML = JSON.stringify(hourlyTemperatures, null, 2);
        } catch (error) {
            weatherInfoDiv.innerText = 'Failed to fetch weather data: ' + error.message;
        }
    });
});
</script>

 <h1>제주도 관광지</h1>
    
    <div th:if="${response}">
        <pre th:text="${response}"></pre>
    </div>

<%@ include file="../common/foot.jspf"%>
