<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dto.ResultRow" %>
<%@ page import="dto.ResultStorage" %>
<%@ page import="utils.TableFormatter" %>
<jsp:useBean id="resultStorage" scope="session" class="dto.ResultStorage" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab 2</title>
    <link rel="icon" type="image/x-icon" href="favicon.ico">

    <style>
        body {
            font-family: sans-serif;
            margin: 0;
        }
        header {
            background-color: #f0f0f0;
            padding: 20px;
            text-align: center;
        }
        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }
        .input-group {
            margin-bottom: 10px;
            margin-right: 232px;
            min-width: 200px;
        }
        label {
            display: inline-block;
            width: 200px;
            text-align: right;
            margin-right: 10px;
        }
        .x-button {
            padding: 10px 20px;
            transition: all 0.2s;
        }
        .x-button.active {
            padding: 14px 24px;
        }
        input[type="text"],
        button[type="submit"] {
            padding: 8px;
        }
        button[type="submit"] {
            margin-left: 245px;
        }
        .error {
            border: 2px solid red;
        }
        .result {
            margin-top: 5px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            max-width: 400px;
            width: 342px;
            max-height: 150px;
            float: right;
            margin-right: 4px;
        }


        .image-container{
            padding-right: 10px;
        }
        .image-container img {
            width: 250px;
            height: auto;
            border: 2px solid black;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f0f0f0;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .dot {
            fill: black;
            stroke: none;
            visibility: hidden;
        }

        .radio-group{
            margin-left: 210px;
            margin-top: -18px;
        }

    </style>

    <script src="./js/hit.js" defer></script>
    <script src="./js/validate.js" defer></script>

</head>
<body>
<header>
    <h1>Лабораторная работа #2</h1>
    <p>ФИО: </p>
    <p>Вариант: </p>
</header>
<main>
    <div class="image-container">
        <svg id="graphic" class="graphic" width="250" xmlns="http://www.w3.org/2000/svg" height="250">
            <-- 125,125 215,125 215,215 125,215 >
            <polygon points="125,125 170,125 125,215"
                     fill="dodgerblue" fill-opacity="1" stroke-width="0"></polygon>

            <path d="M 80 125 A 45 45 90 0 0 125 170 L 125 125 Z"
                  fill="dodgerblue" fill-opacity="1" stroke-width="0"></path>

            <polygon points="35,125 35,80 125,80 125,125 "
                     fill="dodgerblue" fill-opacity="1" stroke-width="0"></polygon>

            <line x1="0" x2="250" y1="125" y2="125" stroke="black"></line>
            <line x1="125" x2="125" y1="0" y2="250" stroke="black"></line>
            <polygon points="125,0 120,10 130,10" stroke="black"></polygon>
            <polygon points="250,125 240,130 240,120" stroke="black"></polygon>

            <line x1="170" x2="170" y1="130" y2="120" stroke="black"></line>
            <line x1="215" x2="215" y1="130" y2="120" stroke="black"></line>

            <line x1="80"  x2="80"  y1="130" y2="120" stroke="black"></line>
            <line x1="35" x2="35" y1="130" y2="120" stroke="black"></line>

            <line x1="130" x2="120" y1="170" y2="170" stroke="black"></line>
            <line x1="130" x2="120" y1="215"  y2="215"  stroke="black"></line>

            <line x1="130" x2="120" y1="80" y2="80" stroke="black"></line>
            <line x1="130" x2="120" y1="35" y2="35" stroke="black"></line>

            <text x="240" y="115">x</text>
            <text x="135" y="10">y</text>

            <text x="160" y="115">R/2</text>
            <text x="210" y="115">R</text>

            <text x="30" y="115" >-R</text>
            <text x="80" y="115">-R/2</text>

            <text x="130" y="80">R/2</text>
            <text x="130" y="40">R</text>

            <text x="130" y="172">-R/2</text>
            <text x="130" y="220">-R</text>
            <circle class="dot" cx="0" cy="0" r="1"></circle>
        </svg>
    </div>
    <form id="coordinateForm" action="${pageContext.request.contextPath}/controller-servlet">
        <div class="input-group">
            <label for="x">Выберите X:</label>
            <select id="selectX">
                <option value=""></option>
                <option value="-5">-5</option>
                <option value="-4">-4</option>
                <option value="-3">-3</option>
                <option value="-2">-2</option>
                <option value="-1">-1</option>
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
            <input type="hidden" id="x" name="x">
            <div id="result-container"></div>
        </div>

        <div class="input-container">
            <div class="input-group">
                <label for="y">Введите Y: </label>
                <input type="text" id="y" name="y" placeholder="(-5..3)" required>
            </div>

            <div class="input-group">
                <label>Выберите R:</label>
                <div class="radio-group">
                    <input type="radio" id="r1" name="r" value="1" required>1
                    <input type="radio" id="r2" name="r" value="2" required>2
                    <input type="radio" id="r3" name="r" value="3" required>3
                    <input type="radio" id="r4" name="r" value="4" required>4
                    <input type="radio" id="r5" name="r" value="5" required>5
                </div>
            </div>
        </div>




        <div class ="input-group">
            <input type="hidden" id="hitTime" name="hitTime">

            <script>
                document.getElementById('hitTime').value = new Date().toLocaleString();
            </script>
        </div>

        <button id="submit" type="submit">Испытать удачу</button>
    </form>

    <table>
        <thead>
        <tr>
            <th>X</th>
            <th>Y</th>
            <th>R</th>
            <th>Результат</th>
            <th>Время выполнения (ms)</th>
            <th>Дата</th>
        </tr>
        </thead>
        <tbody id="results-table"></tbody>
    </table>

</main>






<script>
    let attemptsArray = [];

    function resetDots(newAttemptsArray) {
        if (newAttemptsArray.length !== 0) {
            newAttemptsArray.forEach(dotString => {
                const dot = JSON.parse(dotString);
                attemptsArray.push(dot);
            });
            drawPoints();
            updateTable();
        }
    }

    function updateTable() {
        const tableBody = document.getElementById('results-table');

        attemptsArray.forEach(dot => {
            const newRow = tableBody.insertRow(0);

            const cellX = newRow.insertCell(0);
            const cellY = newRow.insertCell(1);
            const cellR = newRow.insertCell(2);
            const cellResult = newRow.insertCell(3);
            const cellExecutionTime = newRow.insertCell(4);
            const cellDate = newRow.insertCell(5);

            cellX.textContent = dot.x;
            cellY.textContent = dot.y;
            cellR.textContent = dot.r;
            cellResult.textContent = dot.result;
            cellExecutionTime.textContent = dot.executionTime;
            cellDate.textContent = dot.hitTime;

        });
    }


    function drawPoints() {
        const svg = document.getElementById('graphic');

        attemptsArray.forEach(dot => {
            const x = parseFloat(dot.x);
            const y = parseFloat(dot.y);
            const rValue = parseFloat(dot.r);

            const x_coordinate = parseFloat(124 + (90 / rValue) * x);
            const y_coordinate = parseFloat(124 + (90 / rValue) * (-y));

            const dotElement = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            dotElement.setAttribute("cx", x_coordinate);
            dotElement.setAttribute("cy", y_coordinate);
            dotElement.setAttribute("r", "2");
            dotElement.setAttribute("fill", "red");

            svg.appendChild(dotElement);
        });
    }

    resetDots(<%=TableFormatter.getJson(resultStorage)%>);
</script>







</body>
</html>
