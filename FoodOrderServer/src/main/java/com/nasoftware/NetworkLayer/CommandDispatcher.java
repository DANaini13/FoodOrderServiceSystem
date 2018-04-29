package com.nasoftware.NetworkLayer;

import com.nasoftware.LogicLayer.AccountService;
import com.nasoftware.LogicLayer.MenuService;
import com.nasoftware.LogicLayer.OrderService;

import java.util.HashMap;

public class CommandDispatcher {
    static public void dispatchComman(HashMap<String, String> args, ComplitionHandler callBack) {
        String command = args.get("command");
        switch (command) {
            case "login": AccountService.login(args.get("account"), args.get("password"), callBack); break;
            case "signUp": AccountService.signUp(args.get("account"), args.get("password"), callBack); break;
            case "getMenu": MenuService.getMenu(args.get("account"), callBack); break;
            case "addMenuItem": MenuService.addMenuItem(args.get("account"), args.get("itemName"), args.get("itemPrice"), callBack); break;
            case "removeMenuItem": MenuService.removeMenuItem(args.get("account"), args.get("itemName"), callBack); break;
            case "orderFood": OrderService.orderFood(args, callBack); break;
            case "checkOrder": OrderService.checkOrder(args.get("account"), callBack); break;
            case "checkOrderStatus": OrderService.checkOrderStatus(args.get("account"), args.get("table"), callBack); break;
            case "finishedFood": OrderService.changeFoodStatus(args.get("account"), args.get("table"), args.get("foodName"), callBack); break;
        }
    }
}
