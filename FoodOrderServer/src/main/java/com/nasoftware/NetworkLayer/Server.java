package com.nasoftware.NetworkLayer;
import com.nasoftware.LogicLayer.CommandDispatcher;
import com.nasoftware.LogicLayer.JsonParser;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;

interface EndingCallBack{
    public void handler();
}

public class Server extends Thread {
    private Socket socket;
    private EndingCallBack callBack;


    Server(Socket socket, EndingCallBack callBack) {
        this.socket = socket;
        this.callBack = callBack;
    }

    @Override
    protected void finalize() throws Throwable {
        super.finalize();
        this.callBack.handler();
    }

    @Override
    public void run() {
        try {
            BufferedReader bd = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String requestHeader;
                int contentLength = 0;
                while ((requestHeader = bd.readLine()) != null && !requestHeader.isEmpty()) {
                    System.out.println(requestHeader);
                    if (requestHeader.startsWith("GET")) {
                        int begin = requestHeader.indexOf("/?") + 2;
                        int end = requestHeader.indexOf("HTTP/");
                        String condition = requestHeader.substring(begin, end);
                        HashMap args = JsonParser.parseJSON(condition);
                        CommandDispatcher.dispatchComman(args, (HashMap<String, String> resultObj) -> {
                            response(resultObj);
                        });
                    }
                    /**
                     * 获得POST参数
                     * 1.获取请求内容长度
                     */
                    if(requestHeader.startsWith("Content-Length")){
                        int begin=requestHeader.indexOf("Content-Lengh:")+"Content-Length:".length();
                        String postParamterLength=requestHeader.substring(begin).trim();
                        contentLength=Integer.parseInt(postParamterLength);
                        System.out.println("POST参数长度是："+Integer.parseInt(postParamterLength));
                    }
                }
                StringBuffer sb = new StringBuffer();
                if (contentLength > 0) {
                    for (int i = 0; i < contentLength; i++) {
                        sb.append((char) bd.read());
                    }
                    System.out.println("POST参数是：" + sb.toString());
                }
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }

    private void response(HashMap<String, String> args) {
        PrintWriter pw = null;
        try {
            pw = new PrintWriter(socket.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        pw.println("HTTP/1.1 200 OK");
        pw.println("Content-type:application/json");
        pw.println();
        JSONObject json = new JSONObject();
        try {
            for(Map.Entry<String, String> entry:args.entrySet()) {
                json.put(entry.getKey(), entry.getValue());
            }
            pw.println(json.toString());
            pw.flush();
            socket.close();
        } catch (JSONException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
