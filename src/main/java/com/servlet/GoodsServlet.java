package com.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import com.bean.Category;
import com.bean.Goods;
import com.daofactory.DaoFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/GoodsServlet")
public class GoodsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//�ϴ���������
		// �ϴ��ļ��洢Ŀ¼
	    private static final String UPLOAD_DIRECTORY = "upload";
	    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 10;  // 3MB
	    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 100; // 40MB
	    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 120; // 50MB	
	
    public GoodsServlet() {
        // TODO Auto-generated constructor stub
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Goods good=new Goods();
		String msg="";
		boolean result=false;
		int gid=0;
		int cid=1;
		String path="error.jsp";
		ArrayList<Goods> tuijianGoods=new ArrayList<Goods>();
		ArrayList<Goods> cainixihGoods=new ArrayList<Goods>();
		ArrayList<Category> categories=new ArrayList<Category>();
		String type=request.getParameter("type");
		 String gname="";
			double price=0.0;
			double inPrice=0.0;
			String introduction="";
			int stock=0;

			String fileName="";
			String picture="";
			 double highPraise=0.0;
			 int sales=0;
		
			
		
		if(request.getParameter("gid")!=null)
			gid=Integer.parseInt((String)request.getParameter("gid"));
		if(request.getParameter("cid")!=null)
			cid=Integer.parseInt(request.getParameter("cid"));
//		System.out.println(cid+"GoodsServlet 45");
		//����gid��ʾ����
		if(type.equals("viewbygid")){
			//�û��Ĳ鿴
//				System.out.println("�û�y");
				try {
					good=DaoFactory.getGoodsDaoInstance().getById(gid);
					tuijianGoods=DaoFactory.getGoodsDaoInstance().pxgetbyCidQsan(cid);
					cainixihGoods=DaoFactory.getGoodsDaoInstance().pxgetbyCidSalesidianwu(cid);
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				//��ֵ����ͼƬ ȫ�ֵ���
				if(good.getXqPicture()==null)
				{
					good.setXqPicture("");
				}
				else {
					String img=good.getXqPicture();
					String pic[]=img.split(";");
					request.setAttribute("img", pic);
//					for (int i = 0; i < pic.length; i++) {
//						System.out.println("GoodsServlet.java 58��"+pic[i]);
//					}
				}
				//��ֵչʾͼƬ
				if(good.getZsPicture()==null)
				{
					good.setZsPicture("");
				}
				else {
					String img=good.getZsPicture();
					String pic[]=img.split(";");
					request.setAttribute("zsimg", pic);
				}
				
				
				//�����úõ�good���Ƽ���tuijianGoods��������Ĳ���ϲ����ֵ��ȫ�� ��proDetailֱ�ӵ���
				request.setAttribute("good", good);
				request.setAttribute("tuijianGoods", tuijianGoods);
				request.setAttribute("cainixihGoods", cainixihGoods);
				path="proDetail.jsp";	
		}
		else if (type.equals("viewbygidadmin")) {
			//����Ա�Ĳ鿴���� 
			String quanxian = request.getParameter("quanxian");
			if(quanxian.equals("admin"))
			{
				System.out.println("����y");
				try {
					good=DaoFactory.getGoodsDaoInstance().getById(gid);
					categories=DaoFactory.getCategoryDaoInstance().getAll();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				for (int i = 0; i < categories.size(); i++) {
					if(good.getCid()==categories.get(i).getCid())
					{
						good.setCidname(categories.get(i).getCname());
						categories.remove(i);
					}	
				}
				
				
				//��ֵ����ͼƬ ȫ�ֵ���
				if(good.getXqPicture()==null)
				{
					good.setXqPicture("");
				}
				else {
					String img=good.getXqPicture();
					String pic[]=img.split(";");
					request.setAttribute("img", pic);
					for (int i = 0; i < pic.length; i++) {
//						System.out.println("GoodsServlet.java 58��"+pic[i]);
					}
				}
				//��ֵչʾͼƬ
				if(good.getZsPicture()==null)
				{
					good.setZsPicture("");
				}
				else {
					String img=good.getZsPicture();
					String pic[]=img.split(";");
					request.setAttribute("zsimg", pic);
				}
				request.setAttribute("good", good);
				request.setAttribute("categories", categories);

				path="goodupdate.jsp";
			}
		}
		//����˿ڵ��������Ʒ��ť ������ֵ����������
		else  if(type.equals("insertGood")){
			categories=new ArrayList<Category>();
			try {
				categories=DaoFactory.getCategoryDaoInstance().getAll();
			} catch (Exception e) {
				// TODO: handle exception
			}
			request.setAttribute("categories", categories);
			path="goodInsert.jsp";
			
		}
		//����Ա������Ʒȷ��
		else  if(type.equals("insertSJGood")){
			//�ϴ����뿪ʼ
			// ����Ƿ�Ϊ��ý���ϴ�ServletFileUpload
	        if (!ServletFileUpload.isMultipartContent(request)) {
	            // ���������ֹͣ
	            PrintWriter writer = response.getWriter();
	            writer.println("Error: ��������� enctype=multipart/form-data");
	            writer.flush();
	            return;
	        }
	 
	        // �����ϴ�����
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // �����ڴ��ٽ�ֵ - �����󽫲�����ʱ�ļ����洢����ʱĿ¼��
	        factory.setSizeThreshold(MEMORY_THRESHOLD);
	        // ������ʱ�洢Ŀ¼
	        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
	 
	        ServletFileUpload upload = new ServletFileUpload(factory);
	         
	        // ��������ļ��ϴ�ֵ
	        upload.setFileSizeMax(MAX_FILE_SIZE);
	         
	        // �����������ֵ (�����ļ��ͱ�����)
	        upload.setSizeMax(MAX_REQUEST_SIZE);
	        
	        // ���Ĵ���
	        upload.setHeaderEncoding("UTF-8"); 

	        // ���·����Ե�ǰӦ�õ�Ŀ¼
	        String uploadPath = request.getSession().getServletContext().getRealPath("\\upload");
	        // ���Ŀ¼�������򴴽�
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir();
	        }
	 
	        try {
	            // ���������������ȡ�ļ�����
	            @SuppressWarnings("unchecked")
	            ServletRequestContext src = new ServletRequestContext(request);
	            List<FileItem> formItems = upload.parseRequest(src);

	           
	            
	            if (formItems != null && formItems.size() > 0) {
	                // ����������
	                for (FileItem item : formItems) {
	                    // �����ڱ��е��ֶ�
	                    if (item.isFormField()) {//�ж�item�Ƿ��Ǽ򵥵ı��ֶ�
	                    	 if(item.getFieldName().equals("gname")){
	                             gname=item.getString("utf-8");
	                         }else if(item.getFieldName().equals("price")){
	                             price=Double.parseDouble(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("inPrice")){
	                        	 inPrice=Double.parseDouble(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("stock")){
	                        	 stock=Integer.parseInt(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("cid")){
	                        	 cid=Integer.parseInt(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("introduction")){
	                        	 introduction=item.getString("utf-8");
	                         }
	                    	 
	                    }else {
	                    	 fileName = new File(item.getName()).getName();
	                        String filePath = uploadPath + File.separator + fileName;
	                        File storeFile = new File(filePath);
	                        // �ڿ���̨����ļ����ϴ�·��
//	                        System.out.println(filePath);
	                        // �����ļ���Ӳ��
	                        item.write(storeFile);
	                         picture="upload/"+fileName;
	                         //��ͼ����ʾ
	                        request.setAttribute("picture",picture);
	                        

	                        
	                    }
	                }
	            }
	        } catch (Exception ex) {
	            request.setAttribute("message",
	                    "������Ϣ: " + ex.getMessage());
	        }
	        // ��ת�� message.jsp
	      // getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
	      //�ϴ��������
			/*
			String bookname=request.getParameter("bookname");
			String author=request.getParameter("author");
			String press=request.getParameter("press");
			String pubdate=request.getParameter("pubdate");
			String isbn=request.getParameter("isbn");
			float price=Float.parseFloat(request.getParameter("price"));
			*/
			good.setGname(gname);
			good.setInPrice(inPrice);
			good.setPrice(price);
			good.setIntroduction(introduction);
			good.setCid(cid);
			good.setStock(stock);
			good.setPicture(picture);
			//
			
			try {
				result = DaoFactory.getGoodsDaoInstance().add(good);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (result == true)
				path="goodsManagement.jsp";	
		}
		//��ɾ��
		else  if(type.equals("delete")){
			try {
				result=DaoFactory.getGoodsDaoInstance().delete(gid);
				// TODO: handle exception
			}catch (Exception e) {
				// TODO: handle exception
			}
			if (result == true)
				path="goodsManagement.jsp";		
		}
		//����ɾ��
		else if(type.equals("deleteAll")){
			String ids[]=request.getParameterValues("all");
			 int i=0;
			 String condition="";
			 for(i=0;i<ids.length;i++){
				 condition+=ids[i];
			 if(i!=ids.length-1) condition+=",";
			 }
			try {
				result=DaoFactory.getGoodsDaoInstance().deleteAll(condition);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(result==true)
				path="goodsManagement.jsp";
		}
		//�����������
		else if(type.equals("uptade")){
			//�ϴ����뿪ʼ
			// ����Ƿ�Ϊ��ý���ϴ�ServletFileUpload
	        if (!ServletFileUpload.isMultipartContent(request)) {
	            // ���������ֹͣ
	            PrintWriter writer = response.getWriter();
	            writer.println("Error: ��������� enctype=multipart/form-data");
	            writer.flush();
	            return;
	        }
	 
	        // �����ϴ�����
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // �����ڴ��ٽ�ֵ - �����󽫲�����ʱ�ļ����洢����ʱĿ¼��
	        factory.setSizeThreshold(MEMORY_THRESHOLD);
	        // ������ʱ�洢Ŀ¼
	        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
	 
	        ServletFileUpload upload = new ServletFileUpload(factory);
	         
	        // ��������ļ��ϴ�ֵ
	        upload.setFileSizeMax(MAX_FILE_SIZE);
	         
	        // �����������ֵ (�����ļ��ͱ�����)
	        upload.setSizeMax(MAX_REQUEST_SIZE);
	        
	        // ���Ĵ���
	        upload.setHeaderEncoding("UTF-8"); 

	        // ���·����Ե�ǰӦ�õ�Ŀ¼
	        String uploadPath = request.getSession().getServletContext().getRealPath("\\upload");
	        // ���Ŀ¼�������򴴽�
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir();
	        }
	 
	        try {
	            // ���������������ȡ�ļ�����
	            @SuppressWarnings("unchecked")
	            ServletRequestContext src = new ServletRequestContext(request);
	            List<FileItem> formItems = upload.parseRequest(src);

	           
	            
	            if (formItems != null && formItems.size() > 0) {
	                // ����������
	                for (FileItem item : formItems) {
	                    // �����ڱ��е��ֶ�
	                    if (item.isFormField()) {//�ж�item�Ƿ��Ǽ򵥵ı��ֶ�
	                    	if(item.getFieldName().equals("gid")){
	                    		gid=Integer.parseInt(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("gname")){
	                             gname=item.getString("utf-8");
	                         }else if(item.getFieldName().equals("price")){
	                             price=Double.parseDouble(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("inPrice")){
	                        	 inPrice=Double.parseDouble(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("stock")){
	                        	 stock=Integer.parseInt(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("cid")){
	                        	 cid=Integer.parseInt(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("introduction")){
	                        	 introduction=item.getString("utf-8");
	                         }else if(item.getFieldName().equals("highPraise")){
	                        	 highPraise=Double.parseDouble(item.getString("utf-8"));
	                         }else if(item.getFieldName().equals("sales")){
	                        	 sales=Integer.parseInt(item.getString("utf-8"));
	                         } 
	                    }else {
	                    	 fileName = new File(item.getName()).getName();
	                        String filePath = uploadPath + File.separator + fileName;
	                        File storeFile = new File(filePath);
	                        // �ڿ���̨����ļ����ϴ�·��
	                        System.out.println(filePath);
	                        // �����ļ���Ӳ��
	                        item.write(storeFile);
	                         picture="upload/"+fileName;
	                         //��ͼ����ʾ
	                        request.setAttribute("picture",picture);
	                        

	                        
	                    }
	                }
	            }
	        } catch (Exception ex) {
	            request.setAttribute("message",
	                    "������Ϣ: " + ex.getMessage());
	        }
	        // ��ת�� message.jsp
	      // getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
	      //�ϴ��������
			 		 
			 
			good.setGid(gid);
			good.setGname(gname);
			good.setPrice(price);
			good.setInPrice(inPrice);
			good.setIntroduction(introduction);
			good.setStock(stock);
			good.setCid(cid);
			good.setPicture(picture);
			good.setHighPraise(highPraise);
			good.setSales(sales);
			good.setHighPraise(highPraise);
			good.setSales(sales);
			
			try {
				result = DaoFactory.getGoodsDaoInstance().update(good);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(result==true)
				path="goodsManagement.jsp";
		}
		request.setAttribute("msg", msg);
		request.getRequestDispatcher(path).forward(request, response);
	}

}
