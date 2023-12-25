<?php
header("Content-Type: application/json");

const X_MIN = -2, X_MAX = 2;
const Y_MIN = -5, Y_MAX = 3;
const R_MIN = 1, R_MAX = 4;
const pattern = '/^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}\s\|\s([01][0-9]|2[0-3]):[0-5][0-9]$/';

if (isset($_POST['x']) && isset($_POST['y']) && isset($_POST['r'])) {
    $x = $_POST['x'];
    $y = $_POST['y'];
    $r = $_POST['r'];
    $formattedDate = $_POST['formattedDate'];
    $start = microtime(true);


    function isValid($x, $y, $r, $formattedDate): bool
    {
        if (!is_numeric($x) || !is_numeric($y) || !is_numeric($r)) {
            return false;
        }
        if ($r < R_MIN || $r > R_MAX) {
            return false;
        }

        if ($x < X_MIN || $x > X_MAX) {
            return false;
        }

        if ($y < Y_MIN || $y > Y_MAX) {
            return false;
        }
        if(!preg_match(pattern, $formattedDate)){
            return false;
        }

        return true;
    }

    if(isValid($x, $y, $r, $formattedDate)) {
        $y = round($y, 2);
        $r = round($r, 2);

        function hitOrMiss($x, $y, $r): bool
        {
            return triangleHit($x, $y, $r) || quarterCircleHit($x, $y, $r) || rectangleHit($x, $y, $r);
        }

        function triangleHit($x, $y, $r): bool
        {
            return ($x >= 0) && ($y <= 0) && ($x - $y <= $r);
        }

        function quarterCircleHit($x, $y, $r): bool
        {
            return ($x * $x + $y * $y <= $r * $r / 4) && ($x <= 0) && ($y <= 0);
        }

        function rectangleHit($x, $y, $r): bool
        {
            return ($x >= 0) && ($y >= 0) && ($x <= $r / 2) && ($y <= $r / 2);
        }

        $hitOrMiss = hitOrMiss($x, $y, $r);
        $exec_time = (microtime(true) - $start) * 1000;
        $result = array(
            'x' => $x,
            'y' => $y,
            'r' => $r,
            'result' => $hitOrMiss ? 'Точка внутри области' : 'Точка вне области',
            'exec_time' => round($exec_time, 3),
            'formattedDate' => $formattedDate,
        );

        $hitData = file_exists('hits.json') ? json_decode(file_get_contents('hits.json'), true) : array();
        $hitData[] = $result;
        file_put_contents('hits.json', json_encode($hitData));

        echo json_encode($result);
    }
} else {
    echo json_encode(array('error' => 'Недостаточно данных для вычисления.'));
}



