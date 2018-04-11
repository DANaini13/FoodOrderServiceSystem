package com.nasoftware.LogicLayer;
import com.nasoftware.DataLayer.MenuDataService;
import java.util.HashMap;

public class MenuService {
    static void getMenu(String account, ComplitionHandler callback) {
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
}
