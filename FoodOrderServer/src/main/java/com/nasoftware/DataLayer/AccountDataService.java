package com.nasoftware.DataLayer;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.jdom2.*;
import org.jdom2.input.SAXBuilder;

public class AccountDataService {
    static private HashMap<String, String> accountMap;
    static private Lock lock = new ReentrantLock();

    static public void init() {
        File rootFolder = new File("Data");
        if(!rootFolder.exists())
            rootFolder.mkdir();
        File accountFile = new File("Data/accounts.xml");
        if(!accountFile.exists()) {
            try {
                accountFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        lock.lock();
        accountMap = new HashMap<String, String>();
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
                accountMap.put(attribute.getValue(), account.getChild("password").getText());
            }
            lock.unlock();
        }catch(JDOMException e){
            e.printStackTrace();
        }catch(IOException ioe){
            ioe.printStackTrace();
        }
    }

    static public HashMap<String, String> getAccounts(){
        lock.lock();
        final HashMap<String, String> result = accountMap;
        lock.unlock();
        return result;
    }

    static public boolean addAccount(String account, String password) {
        lock.lock();
        if(accountMap.containsKey(account)){
            lock.unlock();
            return false;
        }
        accountMap.put(account, password);
        lock.unlock();
        return true;
    }
}
