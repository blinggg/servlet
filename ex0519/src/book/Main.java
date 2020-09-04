package book;

import java.util.ArrayList;

import bbs.BBSDAO;
import bbs.BBSVO;
import jdk.nashorn.internal.ir.RuntimeNode.Request;
import user.UserDAO;

public class Main {

	public static void main(String[] args) {
		//커넥션 체크하기
		System.out.println(DataBase.CON);
		/*BookDAO dao=new BookDAO();
		ArrayList<BookVO> list=dao.list();
		for(BookVO vo:list){
			System.out.println(vo.toString());
		}*/
		
		/*BBSDAO dao=new BBSDAO();
		ArrayList<BBSVO> list=dao.list();
		for(BBSVO vo:list){
			System.out.println("게시판목록"+ vo.toString());
		}*/
	
		/*UserDAO udao=new UserDAO();
		ArrayList<UserVO> list=udao.list();
		for(UserVO vo:list){
			System.out.println("사용자목록"+ vo.toString());
		}*/
	

	}

}
