package courses;

import professors.ProfessorsVO;

public class CoursesVO extends ProfessorsVO{
	private String lcode;
	private String lname;
	private String room;
	private int hours;
	private int capacity;
	private int persons;
	private String instructor;
	
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int hours) {
		this.hours = hours;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public int getPersons() {
		return persons;
	}
	public void setPersons(int persons) {
		this.persons = persons;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	@Override
	public String toString() {
		return "CoursesVO [lcode=" + lcode + ", lname=" + lname + ", room=" + room + ", hours=" + hours + ", capacity="
				+ capacity + ", persons=" + persons + ", instructor=" + instructor + ", getPname()=" + getPname() + "]";
	}
}
