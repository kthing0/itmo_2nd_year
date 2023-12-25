document.addEventListener("DOMContentLoaded", function () {


    const form = document.getElementById("coordinateForm");

    form.addEventListener("submit", function (event) {
        const yInput = document.getElementById("y");
        const selectX = document.getElementById("selectX");
        const rInput = document.querySelector('input[name="r"]:checked');
        let x = document.getElementById("x").value;

        if(selectX.value !== ''){
            x = selectX.value;
        }
        selectX.value = ''

        const y = yInput.value;
        const r = rInput.value;

        console.log(x, selectX)
        const validYValues = [-5,-4,-3,-2,-1,0,1, 2, 3];
        const validRValues = [1, 2, 3, 4, 5];
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

        document.getElementById("x").value = x;


        if (errorMessage) {
            alert(errorMessage);
            event.preventDefault();
        }
    });
});

