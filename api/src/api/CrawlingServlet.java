package api;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;



@WebServlet(value= {"/crawl/cgv","/crawl/daum","/crawl/naver"})
public class CrawlingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		switch(request.getServletPath()) {
		case "/crawl/cgv":
			try {
				Document doc=Jsoup.connect("http://www.cgv.co.kr/movies/").get(); //데이터를 가져오고자 하는 곳으로 접속
				Elements elements=doc.select(".sect-movie-chart");
				JSONArray jArray=new JSONArray();
				for(Element e:elements.select("li")) {
					JSONObject obj=new JSONObject();
					obj.put("rank",e.select(".rank").text());
					obj.put("title", e.select(".title").text());
					jArray.add(obj);
				}
				JSONObject jObject=new JSONObject();
				jObject.put("array",jArray);
				out.println(jObject);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			break;
			
		case "/crawl/daum":
			try {
				Document doc=Jsoup.connect("https://www.daum.net/").get(); //데이터를 가져오고자 하는 곳으로 접속
				Elements elements=doc.select(".list_weather");
				JSONArray jArray=new JSONArray();
				for(Element e:elements.select("li")) {
					JSONObject obj=new JSONObject();
					obj.put("txt_part",e.select(".txt_part").text());
					obj.put("txt_temper",e.select(".txt_temper").text());
					jArray.add(obj);
				}
				JSONObject jObject=new JSONObject();
				jObject.put("array",jArray);
				out.println(jObject);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			break;
			
		case "/crawl/naver":
			try {
				Document doc=Jsoup.connect("https://finance.naver.com/").get(); //데이터를 가져오고자 하는 곳으로 접속
				Elements elements=doc.select(".tbl_home");
				JSONArray UpArray=new JSONArray();
				JSONArray DownArray=new JSONArray();
				
				for(Element e:elements.select(".up")) {
					JSONObject obj=new JSONObject();
					obj.put("th",e.select("th").text());
					obj.put("td",e.select("td").text());
					UpArray.add(obj);
				}
				JSONObject jObject=new JSONObject();
				jObject.put("UpArray",UpArray);
				out.println(jObject);
				
				for(Element e:elements.select(".down")) {
					JSONObject obj=new JSONObject();
					obj.put("th",e.select("th").text());
					obj.put("td",e.select("td").text());
					DownArray.add(obj);
				}
				jObject.put("DownArray",DownArray);
				out.println(jObject);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			break;
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
