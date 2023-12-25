package utils;

import dto.Coordinates;

public class CoordinatesValidation {

    public static boolean validateCoordinates(Coordinates coordinates){
        return checkX(coordinates.getX()) && checkY(coordinates.getY()) && checkR(coordinates.getR());
    }

    private static boolean checkX(double x){
        return (x >= -5 && x <= 3);
    }
    private static boolean checkY(double y){
        return (y >= -5 && y <= 3);
    }
    private static boolean checkR(double r){
        return (r >= 1 && r <= 5);
    }
}
