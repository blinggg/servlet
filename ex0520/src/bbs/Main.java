package bbs;

import book.BookDAO;
import user.UserDAO;

public class Main {

	public static void main(String[] args) {
		
		BBSDAO dao=new BBSDAO();
		System.out.println(dao.list("seqno", "", "seqno", "desc", 1, 5));
		
		//BookDAO dao=new BookDAO();
		//System.out.println(dao.list("title","�ڹ�",1,3));
		
		//UserDAO dao=new UserDAO();
		//System.out.println(dao.list("name", "������", 1, 3));

	}

}
