package com.nasoftware;

import java.sql.*;

public class App {

    public static void main(String[] args) throws SQLException {
        System.out.println("Server start!");
        ServerManager serverManager = new ServerManager(8888);
        serverManager.start();
    }
}
