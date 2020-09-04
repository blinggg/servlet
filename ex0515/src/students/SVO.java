package students;

public class SVO {
	private String scode;
	private String sname;
	private String dept;
	private int year;
	private String birthday;
	private String advisor;
	private String pname;
	
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getAdvisor() {
		return advisor;
	}
	public void setAdvisor(String advisor) {
		this.advisor = advisor;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	@Override
	public String toString() {
		return "SVO [scode=" + scode + ", sname=" + sname + ", dept=" + dept + ", year=" + year + ", birthday="
				+ birthday + ", advisor=" + advisor + ", pname=" + pname + "]";
	}
	

	
	
	
}
