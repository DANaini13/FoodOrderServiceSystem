package com.nasoftware.DataLayer;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
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
        HashMap<String, HashMap<String, String>> result = new HashMap<>();
        Iterator<Map.Entry<String, HashMap<String, String>>> it = menuMap.entrySet().iterator();
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

    static public boolean addMenuItem(String account, String menuItem, String price) {
        lock.lock();
        HashMap<String, String> menu = menuMap.get(account);
        if(menu.containsKey(menuItem)) {
            lock.unlock();
            return false;
        }
        menu.put(menuItem, price);
        updateFile();
        lock.unlock();
        return true;
    }

    static public boolean removeMenuItem(String account, String menuItem) {
        lock.lock();
        HashMap<String, String> menu = menuMap.get(account);
        if(!menu.containsKey(menuItem)) {
            lock.unlock();
            return false;
        }
        menu.remove(menuItem);
        updateFile();
        lock.unlock();
        return true;
    }

    static public void updateFile() {
        Iterator<Map.Entry<String, HashMap<String, String>>> it = menuMap.entrySet().iterator();
        Element rootElement = new Element("menus");
        Document document = new Document(rootElement);
        while (it.hasNext()) {
            Map.Entry<String, HashMap<String, String>> entry = it.next();
            Element menuElement = new Element("menu");
            menuElement.setAttribute("accountID", entry.getKey());
            Iterator<Map.Entry<String, String>> itemIt = (entry.getValue()).entrySet().iterator();
            while (itemIt.hasNext()) {
                Map.Entry<String, String> itemEntry = itemIt.next();
                Element foodElement = new Element("food");
                foodElement.setAttribute("foodName", itemEntry.getKey());
                Element priceElement = new Element("price");
                priceElement.setText(itemEntry.getValue());
                foodElement.addContent(priceElement);
                menuElement.addContent(foodElement);
            }
            rootElement.addContent(menuElement);
        }

        XMLOutputter xmlOutput = new XMLOutputter();
        xmlOutput.setFormat(Format.getPrettyFormat());
        try {
            FileOutputStream out;
            File file = new File("Data/menus.xml");
            out = new FileOutputStream(file);
            xmlOutput.output(document, out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
