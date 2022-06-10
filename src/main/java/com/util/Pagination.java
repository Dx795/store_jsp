package com.util;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public class Pagination {
	public Pagination(){};
	private String strPage = null; // page鍙傛暟鍙橀噺
	private int curPages;// page鍙傛暟鍐呴儴鐨勫��
	private int m_rows; // 璁剧疆姣忛〉鏄剧ず鐨勮褰曟暟
	private int pages;// 鎬婚〉鏁�

	// 鍙栧緱page鍙傛暟鐨勫�艰祴缁欏彉閲弒trPage
	public String strPage(HttpServletRequest request, String page) {
		try {
			strPage = request.getParameter(page);// request瀵硅薄鍙栧緱page鐨勫��
		} catch (Exception e) {
			System.out.println("delcolumn" + e.getMessage());
		}
		return strPage;// 杩斿洖杩欎釜鍊笺��
	} // 椤甸潰鏁�

	public int curPages(String strPage) {
		try {
			if (strPage == null) {// 榛樿娌℃湁灏辫缃槸绗竴椤�
				curPages = 1;
			} else {
				curPages = Integer.parseInt(strPage);// 鍙栧緱strPage鐨勬暣鏁板��
				if (curPages < 1)// 濡傛灉灏忎簬1,鍚屾牱杩斿洖鏄涓�椤�
					curPages = 1;
			}
		} catch (Exception e) {
			System.out.print("curPages");
		}
		return curPages;// 杩斿洖椤甸潰鏁�
	} 
	
	// 璁剧疆姣忛〉瑕佹樉绀虹殑璁板綍鏁�
	public void setRows(int rows) {
		m_rows = rows;
	}

	// 鍙栧緱椤垫暟
	public int getPages(int rowcounts) {
		int test;// 鍙橀噺
		test = rowcounts % m_rows;// 鍙栧緱浣欐暟
		if (test == 0)
			pages = rowcounts / m_rows;// 姣忛〉鏄剧ず鐨勬暣鏁�
		else
			pages = rowcounts / m_rows + 1;// 涓嶆槸鐨勮瘽灏卞姞涓�
		return pages;// 杩斿洖椤垫暟
	}
	public ResultSet getPageSet(ResultSet rs, int curPages) {//瀵圭粨鏋滈泦瀵硅薄杩涜鍒嗛〉澶勭悊
		if (curPages == 1) {
			return rs;// 濡傛灉鏄氨涓�椤电殑璇濓紝灏辫繑鍥炶繖涓猺s
		} else {
			int i = 1;
			try {
				while (rs.next()) {
					i = i + 1;
					if (i > ((curPages - 1) * m_rows))
						break;// 閫�鍑�
				}
				return rs;// 浠庨��鍑哄紑濮嬪皢缁撴灉闆嗚繑鍥�
			} catch (Exception e) {
				System.out.print(e.getMessage());
			}
		}
		return rs;
	}
	// 缁撴灉闆嗙殑杩斿洖
	public ArrayList  getPageSet(List rs, int curPages) {//瀵筶ist瀵硅薄杩涜鍒嗛〉澶勭悊

		ArrayList result=new ArrayList();

			try {
				for(int i=(curPages - 1) * m_rows;i<curPages*m_rows&&i<rs.size();i++){
					//(curPages - 1) * m_rows鏄鍑犻〉鐨勭涓�鏉℃暟鎹鍙�
					//curPages*m_rows鏄鍑犻〉鏈�鍚庝竴鏉＄殑琛屽彿
					//i<rs.size()鏄槻姝㈡暟缁勮秺鐣�
					result.add(rs.get(i));
				}
			} catch (Exception e) {
				System.out.print(e.getMessage());
			}

		return result;
	}
}
