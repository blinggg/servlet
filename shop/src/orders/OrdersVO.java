package orders;

import product.ProductVO;

public class OrdersVO extends ProductVO{
	private String order_id;
	 private String prod_id;
	 private int price;
	 private int quantity;
	 private int sum;
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	@Override
	public String toString() {
		return "OrdersVO [order_id=" + order_id + ", prod_id=" + prod_id + ", price=" + price + ", quantity=" + quantity
				+ ", sum=" + sum + ", getProd_name()=" + getProd_name() + ", getCompany()=" + getCompany() + "]";
	}
	 

}
