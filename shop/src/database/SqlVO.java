package database;

public class SqlVO {
	private String key;
	private String word;
	private String order;
	private String desc;
	private int page;
	private int perPage;
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	@Override
	public String toString() {
		return "SqlVO [key=" + key + ", word=" + word + ", order=" + order + ", desc=" + desc + ", page=" + page
				+ ", perPage=" + perPage + "]";
	}

}
