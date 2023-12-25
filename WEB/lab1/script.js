document.addEventListener("DOMContentLoaded", function () {
        function loadInitialData() {
        fetch("hits.json")
            .then((response) => response.json())
            .then((data) => {
                const resultsTable = document.getElementById("results-table");

                data.forEach((item) => {
                    const newRow = document.createElement("tr");
                    newRow.innerHTML = `
                      <td>${item.x}</td>
                      <td>${item.y}</td>
                      <td>${item.r}</td>
                      <td>${item.result}</td>
                      <td>${item.exec_time}</td>
                      <td>${item.formattedDate}</td>
                    `;
                    resultsTable.insertBefore(newRow, resultsTable.firstChild);
                });
            })
            .catch((error) => {
                console.error("Не удалось загрузить данные:", error);
            });
    }
    loadInitialData();


    const xButtons = document.querySelectorAll(".x-button");
    const xInput = document.getElementById("x");

    xButtons.forEach((button) => {
        button.addEventListener("click", function () {
            xButtons.forEach((btn) => btn.classList.remove("active"));
            this.classList.add("active");
            xInput.value = this.value;
        });
    });

    const form = document.getElementById("coordinateForm");

    form.addEventListener("submit", function (event) {
        const yInput = document.getElementById("y");
        const rInput = document.getElementById("r");

        const x = xInput.value;
        const y = yInput.value;
        const r = rInput.value;

        const validYValues = [-5,-4,-3,-2,-1,0,1, 2, 3];
        const validRValues = [1, 2, 3, 4];
        let errorMessage = "";

        if(!x) errorMessage += "Значение X не выбрано.\n";

        if (!validYValues.includes(parseInt(y))) {
            errorMessage += "Некорректное значение Y.\n";
            rInput.classList.add("error");
        } else {
            rInput.classList.remove("error");
        }

        if (!validRValues.includes(parseInt(r))) {
            errorMessage += "Некорректное значение R.\n";
            rInput.classList.add("error");
        } else {
            rInput.classList.remove("error");
        }

        if (errorMessage) {
            alert(errorMessage);
            event.preventDefault();
            form.reset();
        }
    });
});

