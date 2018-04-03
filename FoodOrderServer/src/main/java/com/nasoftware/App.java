package com.nasoftware;

public class App {

    public static void main(String[] args) {
        System.out.println("Server start!");
        ServerManager serverManager = new ServerManager(8888);
        serverManager.start();
    }
}
