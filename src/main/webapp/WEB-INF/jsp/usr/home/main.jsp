<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<%@ include file="../common/head.jspf"%>

<form onsubmit="event.preventDefault(); submitQuestion();">
    <textarea id="questionContent" placeholder="Ask a question"></textarea>
    <button type="submit">Submit</button>
</form>
<h2>Questions and Answers</h2>
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

	<div>FAQ</div>


	<div>제주도 관광 정보</div>
	<button>관광지</button>
	<button>날씨</button>


	<%@ include file="../common/foot.jspf"%>