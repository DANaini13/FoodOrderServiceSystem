package com.nasoftware.LogicLayer;

import java.util.HashMap;

public class CommandDispatcher {
    static public void dispatchComman(HashMap<String, String> args, ComplitionHandler callBack) {
        String command = args.get("command");
        switch (command) {
            case "login": AccountService.login(args.get("account"), args.get("password"), callBack); break;
            case "signUp": AccountService.signUp(args.get("account"), args.get("password"), callBack); break;
            case "getMenu": MenuService.getMenu(args.get("account"), callBack); break;
        }
    }
}
