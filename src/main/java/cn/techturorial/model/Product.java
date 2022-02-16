package cn.techturorial.model;

public class Product {
	private int id;
	private String name;
	private String categoty;
	private double price;
	private String image;
	
	public Product() {
		super();
	}

	public Product(int id, String name, String categoty, double price, String image) {
		super();
		this.id = id;
		this.name = name;
		this.categoty = categoty;
		this.price = price;
		this.image = image;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCategoty() {
		return categoty;
	}

	public void setCategoty(String categoty) {
		this.categoty = categoty;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", categoty=" + categoty + ", price=" + price + ", image="
				+ image + "]";
	}
	
	

	
	
	
}
