package com.nasoftware.DataLayer;

import java.util.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class OrderDataService {
    static private HashMap<String, LinkedList<Order>> orderMap;
    static private Lock lock = new ReentrantLock();
    static public void init() {
        lock.lock();
        orderMap = new HashMap<>();
        lock.unlock();
    }

    static public void addOrder(String account, String food, String table, int number) {
        Order order = new Order();
        order.foodName = food;
        order.table = table;
        order.number = number;
        Date date = new Date();
        order.orderedTime = date.toString();
        lock.lock();
        LinkedList<Order> orders = orderMap.get(account);
        if(orders == null) {
            orders = new LinkedList();
        }
        Iterator it = orders.iterator();
        while (it.hasNext()) {
            Order currentOrder = (Order) it.next();
            if(currentOrder.equals(order)) {
                currentOrder.number += order.number;
                lock.unlock();
                return;
            }
        }
        orders.add(order);
        orderMap.put(account, orders);
        lock.unlock();
    }
}
