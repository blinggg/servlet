package book;

public class CartVO extends BookVO{
	private int number;

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	@Override
	public String toString() {
		return "CartVO [number=" + number + ", getNumber()=" + getNumber() + ", getCode()=" + getCode()
				+ ", getTitle()=" + getTitle() + ", getWriter()=" + getWriter() + ", getPrice()=" + getPrice()
				+ ", toString()=" + super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ "]";
	}


	
	
}
