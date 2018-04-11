package com.nasoftware.DataLayer;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class MenuDataService {
    static private HashMap<String, HashMap<String, String>> menuMap;
    static private Lock lock = new ReentrantLock();

    static public void init() {
        File rootFolder = new File("Data");
        if(!rootFolder.exists())
            rootFolder.mkdir();
        File accountFile = new File("Data/menus.xml");
        if(!accountFile.exists()) {
            try {
                accountFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        lock.lock();
        menuMap = new HashMap<>();
        lock.unlock();
        try {
            lock.lock();
            SAXBuilder saxBuilder = new SAXBuilder();
            Document document = saxBuilder.build(accountFile);
            Element rootElement = document.getRootElement();
            List<Element> accountList = rootElement.getChildren();
            for( int i=0; i<accountList.size(); ++i) {
                Element account = accountList.get(i);
                Attribute attribute = account.getAttribute("accountID");
                String accountName = attribute.getValue();
                List<Element> foodList = account.getChildren();
                HashMap<String, String> temp = new HashMap<>();
                for (int j=0; j<foodList.size(); ++j) {
                    String foodName = foodList.get(j).getAttribute("foodName").getValue();
                    String price = foodList.get(j).getChild("price").getText();
                    temp.put(foodName, price);
                }
                menuMap.put(accountName, temp);
            }
            lock.unlock();
        }catch(JDOMException e){
            e.printStackTrace();
        }catch(IOException ioe){
            ioe.printStackTrace();
        }
    }

    static public HashMap<String, HashMap<String, String>> getMenuMap() {
        lock.lock();
        HashMap<String, HashMap<String, String>> result = menuMap;
        lock.unlock();
        return result;
    }
}
