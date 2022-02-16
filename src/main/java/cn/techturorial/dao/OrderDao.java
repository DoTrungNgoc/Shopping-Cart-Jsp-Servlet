package cn.techturorial.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cn.techturorial.connection.DbCon;
import cn.techturorial.model.Order;
import cn.techturorial.model.Product;

public class OrderDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public OrderDao(Connection con) {
		super();
		this.con = con;
	}
	
	public boolean insertOrder(Order order) {
		boolean result = false;
		try {
			query = "insert into orders (p_id,u_id,o_quantity,o_date) value(?,?,?,?)";
			
			pst = con.prepareStatement(query);
			pst.setInt(1, order.getId());
			pst.setInt(2, order.getuId());
			pst.setInt(3, order.getQuantity());
			pst.setString(4, order.getDate());
			pst.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public List<Order> userOrder(int id){
		List<Order> list =  new ArrayList<Order>();
		try {
			query = "select * from orders where u_id=? order by orders.o_id desc";
			pst = con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			
			while (rs.next()) {
				Order order = new Order();
				ProductDao productDao = new ProductDao(DbCon.getConnection());
				int pId = rs.getInt("p_id");
				
				Product product = productDao.getSingleProduct(pId);
				order.setOrderId(rs.getInt("o_id"));
				order.setId(pId);
				order.setName(product.getName());
				order.setCategoty(product.getCategoty());
				order.setPrice(product.getPrice()*rs.getInt("o_quantity"));
				order.setQuantity(rs.getInt("o_quantity"));
				order.setDate(rs.getString("o_date"));
				list.add(order);
			}
			
			

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public void cancelOrder(int id) {
		try {
			query = "delete from orders where o_id=?";
			pst = con.prepareStatement(query);
			pst.setInt(1, id);
			pst.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
