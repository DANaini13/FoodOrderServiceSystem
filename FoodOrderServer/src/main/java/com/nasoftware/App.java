package com.nasoftware;

import com.nasoftware.DataLayer.AccountDataService;
import com.nasoftware.DataLayer.MenuDataService;
import com.nasoftware.DataLayer.OrderDataService;
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
 *
 * {
 *     result:success | fail reason
 * }
 *
 * Sign Up
 * {
 *     command:signUp
 *     account:********
 *     password:********
 * }
 *
 * {
 *     result:success | fail reason
 * }
 *
 * Get Menu
 * {
 *     command:getMenu
 *     account:********
 * }
 *
 * {
 *     error: 0 | fail reason
 *     foodName1: price
 *     foodName2: price
 *     ....
 * }
 *
 * Add Menu Item
 * {
 *     command:addMenuItem
 *     account:********
 *     itemName: name
 *     itemPrice: price
 * }
 *
 * Remove Menu Item
 * {
 *     command:removeMenuItem
 *     account:*******
 *     itemName: name
 * }
 *
 * Order Food
 * {
 *     command:orderFood
 *     account:********
 *     tableNumber: table number
 *     foodName1:number
 *     foodName2:number
 *     ....
 * }
 *
 * Check Ordered Food
 * {
 *     command:checkOrder
 *     account:********
 * }
 *
 * {
 *     error: 0 | fail reason
 *     table+foodName1: number+time+finished
 *     table+foodName2: number+time+finished
 *     ....
 * }
 *
 * Check Order Status
 * {
 *     command:checkOrderStatus
 *     account:********
 *     table:table number
 * }
 *
 * {
 *     foodName: 1|0+number
 *     foodName1: 1|0+number
 * }
 *
 * Finished Food
 * {
 *     command:finishedFood
 *     account:********
 *     table: table number
 *     foodName: food name
 * }
 *
 * {
 *     result:success | failed
 * }
 */


public class App {

    public static void main(String[] args) {
        System.out.println("Server start!");
        AccountDataService.init();
        MenuDataService.init();
        OrderDataService.init();
        ServerManager serverManager = new ServerManager(8888);
        serverManager.start();
    }
}
