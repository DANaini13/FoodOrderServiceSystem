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
}
