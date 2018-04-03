package com.nasoftware;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ServerManager extends Thread{
    private int serverCount;
    private Lock countLock;
    public final int port;

    public ServerManager(int port) {
        this.serverCount = 0;
        this.countLock = new ReentrantLock();
        this.port = port;
    }

    public void run() {
        try {
            ServerSocket serverSocket = new ServerSocket(this.port);
            while (true) {
                Socket socket = serverSocket.accept();
                countLock.lock();
                ++serverCount;
                countLock.unlock();
                Server server = new Server(socket, () -> {
                   if(serverCount <= 0) {
                       return;
                   }
                   countLock.lock();
                   --serverCount;
                   countLock.unlock();
                });
                server.start();
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
            System.exit(-1);
        }

    }
}
