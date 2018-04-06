package com.nasoftware;

import com.nasoftware.DataLayer.AccountDataService;
import com.nasoftware.NetworkLayer.ServerManager;

/**
 * Protocol Explanation:
 * HTTP GET:
 * Login
 * {
 *     command:login
 *     account:*******
 *     password:*******
 * }
 * Sign Up
 * {
 *     command:signUp
 *     account:********
 *     password:********
 * }
 */


public class App {

    public static void main(String[] args) {
        System.out.println("Server start!");
        AccountDataService.init();
        ServerManager serverManager = new ServerManager(8888);
        serverManager.start();
    }
}
