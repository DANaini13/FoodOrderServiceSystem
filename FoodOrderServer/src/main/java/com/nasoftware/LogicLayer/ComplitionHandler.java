package com.nasoftware.LogicLayer;

import java.util.HashMap;

public interface ComplitionHandler {
    void handler(HashMap<String, String> result);   //result = SUCCESS or error message.
}