package com.nasoftware;

import com.nasoftware.NetworkLayer.ServerManager;
import java.sql.*;

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

    public static void main(String[] args) throws SQLException {
        System.out.println("Server start!");
        ServerManager serverManager = new ServerManager(8888);
        serverManager.start();
    }
}
