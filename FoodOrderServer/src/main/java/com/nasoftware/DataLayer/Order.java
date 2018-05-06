package com.nasoftware.DataLayer;

public class Order {
    public String orderedTime;
    public String foodName;
    public int number;
    public Boolean finished;

    public Order() {
        this.finished = false;
    }

    public boolean equals(Object o) {
        if(o instanceof Object) {
            return ((Order) o).foodName == this.foodName;
        }
        return false;
    }
}
