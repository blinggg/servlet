package bbs;

public class BBSVO {
	private int seqno;
	private String title;
	private String content;
	private String writer;
	private String wdate;
	
	public int getSeqno() {
		return seqno;
	}
	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	
	@Override
	public String toString() {
		return "bbsVO [seqno=" + seqno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", wdate="
				+ wdate + "]";
	}
	
	
	
	
}
