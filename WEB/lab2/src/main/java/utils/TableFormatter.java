package utils;

import dto.ResultStorage;
import org.kopitubruk.util.json.JSONUtil;

import java.util.HashSet;
import java.util.Set;

public class TableFormatter {

    public static String getJson(ResultStorage hitStorage) {
        Set<String> jsonHitList = new HashSet<>();
        hitStorage.getResults().forEach(hit -> {
            String jsonHit = hit.jsonResult();
            jsonHitList.add(jsonHit);
        });
        return JSONUtil.toJSON(jsonHitList);
    }
}