package book;

import java.util.ArrayList;

import bbs.BBSDAO;
import bbs.BBSVO;
import jdk.nashorn.internal.ir.RuntimeNode.Request;
import user.UserDAO;

public class Main {

	public static void main(String[] args) {
		//Ŀ�ؼ� üũ�ϱ�
		System.out.println(DataBase.CON);
		/*BookDAO dao=new BookDAO();
		ArrayList<BookVO> list=dao.list();
		for(BookVO vo:list){
			System.out.println(vo.toString());
		}*/
		
		/*BBSDAO dao=new BBSDAO();
		ArrayList<BBSVO> list=dao.list();
		for(BBSVO vo:list){
			System.out.println("�Խ��Ǹ��"+ vo.toString());
		}*/
	
		/*UserDAO udao=new UserDAO();
		ArrayList<UserVO> list=udao.list();
		for(UserVO vo:list){
			System.out.println("����ڸ��"+ vo.toString());
		}*/
	

	}

}
