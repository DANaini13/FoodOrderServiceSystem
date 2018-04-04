package com.nasoftware.LogicLayer;

import java.util.HashMap;

public class JsonParser {
    static public HashMap<String, String> parseJSON(String content) {
        HashMap result = new HashMap<String, String>();
        String args[] = content.split("&");
        for (String x:args) {
            String parts[] = x.split("=");
            result.put(parts[0], parts[1]);
        }
        return result;
    }
}
