document.addEventListener('DOMContentLoaded', function () {
    let svg = document.getElementById('graphic');
    let dot = document.querySelector('.dot');
    const form = document.getElementById("coordinateForm");



    function handleMouseClick(event) {
        try{
            var rInput = document.querySelector('input[name="r"]:checked').value;
        }catch (TypeError){
                alert('Выберите значение R.');
                return;
        }
        let rValue = parseFloat(rInput);


        let svgRect = svg.getBoundingClientRect();
        let x = event.clientX - svgRect.left;
        let y = event.clientY - svgRect.top;

        dot.setAttribute('cx', x);
        dot.setAttribute('cy', y);


        dot.style.visibility = 'visible';
        let x_coordinate = parseFloat(((x - 124)/(90/rValue)).toFixed(2))
        let y_coordinate = parseFloat(((y - 124)/(-(90/rValue))).toFixed(2))
        console.log('Clicked at:', x, y, '\nCoordinates:', x_coordinate,',', y_coordinate);
    /*    console.log('R:', rValue); */
        document.getElementById('x').value = x_coordinate;
       /* console.log("") */
        document.getElementById('y').value = y_coordinate;
        let url = `${pageContext.request.contextPath}/controller-servlet?x=${x_coordinate}&y=${y_coordinate}&r=${rValue}`;

        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.text();
            })
            .then(data => {
                console.log('Response from server:', data);
                // Handle the response data if needed
                // You can update the table or perform other actions here
            })
            .catch(error => {
                console.error('Fetch error:', error);
            });
    }
    svg.addEventListener('click', handleMouseClick);


    window.handleMouseClick = handleMouseClick;

});