package com.nasoftware.LogicLayer;

import com.nasoftware.DataLayer.OrderDataService;
import com.nasoftware.NetworkLayer.ComplitionHandler;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

public class OrderService {
    static public void orderFood(HashMap<String, String> args, ComplitionHandler callback) {
        String account = "";
        String table = "";
        Iterator it = args.entrySet().iterator();
        LinkedList<String> foodList = new LinkedList<>();
        LinkedList<Integer> numberList = new LinkedList<>();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            if(entry.getKey().equals("command"))
                continue;
            if(entry.getKey().equals("account")) {
                account = entry.getValue().toString();
                continue;
            }
            if(entry.getKey().equals("tableNumber")) {
                table = entry.getValue().toString();
                continue;
            }
            foodList.add(entry.getKey().toString());
            numberList.add(Integer.parseInt(entry.getValue().toString()));
        }
        for(int i=0; i<foodList.size(); ++i) {
            OrderDataService.addOrder(account, foodList.get(i), table, numberList.get(i));
        }
    }
}