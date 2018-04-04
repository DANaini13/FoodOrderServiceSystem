package com.nasoftware.LogicLayer;

import java.util.HashMap;

public class AccountService {
    static void login(String account, String password, ComplitionHandler callback) {
        HashMap<String, String> args = new HashMap<String, String>();
        args.put("result", "success");
        callback.handler(args);
    }

    static void signUp(String account, String password, ComplitionHandler callback) {
        HashMap<String, String> args = new HashMap<String, String>();
        args.put("result", "success");
        callback.handler(args);
    }
}
