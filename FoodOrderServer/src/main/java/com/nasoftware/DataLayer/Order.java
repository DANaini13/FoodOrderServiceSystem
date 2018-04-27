package com.nasoftware.DataLayer;

public class Order {
    public String orderedTime;
    public String foodName;
    public int number;
    public String table;

    public boolean equals(Object o) {
        if(o instanceof Object) {
            return ((Order) o).foodName == this.foodName && ((Order) o).table == this.table;
        }
        return false;
    }
}
