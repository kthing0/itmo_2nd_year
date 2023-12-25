package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ResultStorage implements Serializable {
    private List<ResultRow> results = Collections.synchronizedList(new LinkedList<>());
    public void addResult(ResultRow resultRow){
        results.add(resultRow);
    }

    public void clearResults(){
        results.clear();
    }
}
