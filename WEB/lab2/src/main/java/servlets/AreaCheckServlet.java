package servlets;

import dto.Coordinates;
import dto.ResultRow;
import dto.ResultStorage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.CoordinatesValidation;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long startTime = System.nanoTime();
        try{
            Double.parseDouble(req.getParameter("x"));
            Double.parseDouble(req.getParameter("y"));
            Double.parseDouble(req.getParameter("r"));
        } catch (NumberFormatException e) {
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }

        ResultRow resultRow = new ResultRow();
        double x = Double.parseDouble(req.getParameter("x"));
        double y = Double.parseDouble(req.getParameter("y"));
        double r = Double.parseDouble(req.getParameter("r"));
        String hitTimeStr = req.getParameter("hitTime");




        Coordinates coordinates = new Coordinates(x,y,r);
        CoordinatesValidation.validateCoordinates(coordinates);
        boolean hitResult = hitOrMiss(coordinates);

        resultRow.setX(coordinates.getX());
        resultRow.setY(coordinates.getY());
        resultRow.setR(coordinates.getR());
        resultRow.setExecutionTime((double) (System.nanoTime() - startTime) / 1000000);
        resultRow.setResult(hitResult);
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("dd.MM.yyyy, HH:mm:ss");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            Date hitTime = inputFormat.parse(hitTimeStr);

            resultRow.setHitTime(outputFormat.format(hitTime));
        } catch (ParseException ignored) {

        }

        ((ResultStorage) req.getSession().getAttribute("resultStorage")).addResult(resultRow);
        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().println(resultRow.jsonResult());
        req.getRequestDispatcher("/index.jsp").forward(req, resp);


    }

    public boolean hitOrMiss(Coordinates coordinates){
        return rectangleHit(coordinates) || quarterCircleHit(coordinates) || triangleHit(coordinates);
    }

    private boolean rectangleHit(Coordinates coordinates){
        return (coordinates.getX() <= 0 && coordinates.getY() >= 0 && coordinates.getX() <= coordinates.getR() && coordinates.getY() <= coordinates.getR()/2);
    }
    private boolean quarterCircleHit(Coordinates coordinates){
        return (coordinates.getX() * coordinates.getX() + coordinates.getY() * coordinates.getY() <= coordinates.getR() * coordinates.getR() / 4) && (coordinates.getX() <= 0) && (coordinates.getY() <= 0);
    }
    private boolean triangleHit(Coordinates coordinates){
        return (coordinates.getX() >= 0) && (coordinates.getY() <= 0) && (coordinates.getX() * 2 - coordinates.getY() <= coordinates.getR());
    }
}