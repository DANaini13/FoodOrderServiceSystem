package com.nasoftware.LogicLayer;

import com.nasoftware.DataLayer.Order;
import com.nasoftware.DataLayer.OrderDataService;
import com.nasoftware.NetworkLayer.ComplitionHandler;

import java.util.*;

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
        LinkedList<Order> orderList = new LinkedList<>();
        for(int i=0; i<foodList.size(); ++i) {
            Order order = new Order();
            order.foodName = foodList.get(i);
            order.number = Integer.parseInt(String.valueOf(numberList.get(i)));
            Date date = new Date();
            order.orderedTime = date.toString();
            orderList.add(order);
        }
        OrderDataService.addOrder(account, orderList, table);
        HashMap<String, String> result = new HashMap<>();
        result.put("error", "0");
        callback.handler(result);
    }

    static public void checkOrder(String account, ComplitionHandler callback) {
        HashMap result = new HashMap<String, String>();
        result.put("error", "0");
        HashMap map = OrderDataService.getOrderMap(account);
        Iterator it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String table = entry.getKey().toString();
            Iterator listIt = ((LinkedList<Order>)entry.getValue()).iterator();
            while (listIt.hasNext()) {
                Order original = (Order)listIt.next();
                result.put(table + "+" + original.foodName, original.number + "+" + original.orderedTime + "+" + original.finished);
            }
        }
        callback.handler(result);
    }
}
