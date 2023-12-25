package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.kopitubruk.util.json.JSONUtil;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ResultRow implements Serializable {
    private double x;
    private double y;
    private double r;
    private String hitTime;
    private double executionTime;
    private boolean result;

    private Map<String, String> getResultMap(){
        Map<String, String> columns = new HashMap<>();
        columns.put("x", String.valueOf(x));
        columns.put("y", String.valueOf(y));
        columns.put("r", String.valueOf(r));
        columns.put("hitTime", hitTime);
        columns.put("executionTime", String.valueOf(executionTime));
        columns.put("result", String.valueOf(result));

        return columns;
    }

    public String jsonResult(){
        return JSONUtil.toJSON(this.getResultMap());
    }

}
