package com;

import java.sql.*;
import java.util.ArrayList;

public class Menu {
    String itemName;
    int itemId;
    String category;
    String type;
    double rate;

    Menu(int itemId)
    {
        this.itemId=itemId;

    }

    void addMenuDetails(String itemName,String category,String type, double rate)
    {
        this.itemName=itemName;
        this.category=category;
        this.type=type;
        this.rate=rate;
    }
}

class Cart extends Menu{
    int quantity;

    Cart(int itemId,int quantity) {
        super(itemId);
        this.quantity=quantity;
    }

    void addMenuDetails()
    {
        try {
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
            Statement stmt = c.createStatement();
            ResultSet r=stmt.executeQuery(String.format("SELECT * from menu where item_id=%d",itemId));
            r.next();
            super.addMenuDetails(r.getString(2),r.getString(3),r.getString(4),r.getDouble(5));
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }
    void makeOrder(int table)
    {
        try {
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
            Statement stmt = c.createStatement();
            stmt.executeUpdate(String.format("INSERT into restaurant.order(item_id,item_name,quantity,rate,table_no) values(%d,'%s',%d,%f,%d)",itemId,itemName,quantity,rate,table));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }
}


class Order{
    String itemName;
    int quantity;
    double rate;
    double amount;

    public Order(String itemName,int quantity,double rate)
    {
        this.quantity=quantity;
        this.itemName=itemName;
        this.rate=rate;
        amount=quantity*rate;
    }
}

class Payment{
    ArrayList<Order> bill=new ArrayList<Order>();
    double total;
    double tax;
    double netAmount;

    void calculateTotal(){
        total=0;
        for(Order i:bill)
        {
            total+=i.amount;
        }
    }

    void calculateTax()
    {
        tax=total*5/100;
    }

    void calculateNetAmount(){
        netAmount=total+tax;
    }
}

class Customer{
    private String name;
    private String phone;
    private String time;

    public Customer(String name,String phone,String time){
        this.phone=phone;
        this.name=name;
        this.time=time;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }
    public String getTime()
    {
        return time;
    }
}