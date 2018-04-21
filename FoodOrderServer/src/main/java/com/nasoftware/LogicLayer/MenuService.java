package com.nasoftware.LogicLayer;
import com.nasoftware.DataLayer.MenuDataService;
import com.nasoftware.NetworkLayer.ComplitionHandler;

import java.util.HashMap;

public class MenuService {
    public static void getMenu(String account, ComplitionHandler callback) {
        if(MenuDataService.getMenuMap().containsKey(account)) {
            HashMap<String, String> menu = MenuDataService.getMenuMap().get(account);
            menu.put("error", "0");
            callback.handler(menu);
        } else {
            HashMap<String, String> result = new HashMap<>();
            result.put("error", "还没有创建菜单");
            callback.handler(result);
        }
    }

    public static void addMenuItem(String account, String menuItem, String price, ComplitionHandler callback) {
        HashMap<String, String> result = new HashMap<>();
        if(MenuDataService.addMenuItem(account, menuItem, price))
            result.put("error", "0");
        else
            result.put("error", "要添加的菜单项已经存在啦");
        callback.handler(result);
    }

    public static void removeMenuItem(String account, String menuItem, ComplitionHandler callback) {
        HashMap<String, String> result = new HashMap<>();
        if(MenuDataService.removeMenuItem(account, menuItem))
            result.put("error", "0");
        else
            result.put("error", "找不到您要移除的菜单项");
        callback.handler(result);
    }
}
