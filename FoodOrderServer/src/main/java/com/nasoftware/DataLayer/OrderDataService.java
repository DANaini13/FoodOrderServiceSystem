package com.nasoftware.DataLayer;

import java.util.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class OrderDataService {
    static private HashMap<String, HashMap<String, LinkedList<Order>>> orderMap;
    static private Lock lock = new ReentrantLock();
    static public void init() {
        lock.lock();
        orderMap = new HashMap<>();
        lock.unlock();
    }

    static public void addOrder(String account, LinkedList<Order> orderList, String table) {

        lock.lock();
        HashMap<String, LinkedList<Order>> orders = orderMap.get(account);
        if(orders == null) {
            orders = new HashMap<>();
        }
        orders.put(table, orderList);
        orderMap.put(account, orders);
        lock.unlock();
    }

    static public HashMap<String, LinkedList<Order>> getOrderMap(String account) {
        HashMap<String, LinkedList<Order>> result = new HashMap<>();
        lock.lock();
        if(orderMap.get(account) == null) {
            lock.unlock();
            return result;
        }
        Iterator it = orderMap.get(account).entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry)it.next();
            Iterator listIt = ((LinkedList<Order>)entry.getValue()).iterator();
            String table = entry.getKey().toString();
            LinkedList<Order> list = new LinkedList<>();
            while (listIt.hasNext()) {
                Order original = (Order)listIt.next();
                Order order = new Order();
                order.number = original.number;
                order.orderedTime = original.orderedTime;
                order.foodName = original.foodName;
                order.finished = original.finished;
                list.add(order);
            }
            result.put(table, list);
        }
        lock.unlock();
        return result;
    }

    static public boolean changeFoodStatus(String account, String table, String foodName) {
        lock.lock();
        HashMap<String, LinkedList<Order>> orders = orderMap.get(account);
        if(orders == null) {
            lock.unlock();
            return false;
        }
        LinkedList<Order> foods = orders.get(table);
        Iterator it = foods.iterator();
        while (it.hasNext()) {
            Order order = (Order) it.next();
            if(foodName.equals(order.foodName)) {
                order.finished = true;
                lock.unlock();
                return true;
            }
        }
        lock.unlock();
        return false;
    }
}
