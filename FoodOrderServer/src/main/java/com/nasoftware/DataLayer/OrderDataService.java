package com.nasoftware.DataLayer;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class OrderDataService {
    static private HashMap<String, HashMap<String, String>> orderMap;
    static private Lock lock = new ReentrantLock();

    static public void init() {
        lock.lock();
        OrderDataService.orderMap = new HashMap<>();
        lock.unlock();
    }

    static public HashMap<String, HashMap<String, String>> getOrderMap() {
        lock.lock();
        HashMap<String, HashMap<String, String>> result = new HashMap<>();
        Iterator<Map.Entry<String, HashMap<String, String>>> it = orderMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, HashMap<String, String>> entry = it.next();
            Iterator<Map.Entry<String, String>> itemIt = (entry.getValue()).entrySet().iterator();
            HashMap<String, String> target = new HashMap<>();
            while (itemIt.hasNext()) {
                Map.Entry<String, String> itemEntry = itemIt.next();
                target.put(itemEntry.getKey(), itemEntry.getValue());
            }
            result.put(entry.getKey(), target);
        }
        lock.unlock();
        return result;
    }

    static public void addOrder
}
