package org.util;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;

@WebServlet("/AWSService")

public class AWSService extends HttpServlet {
    
	private static final long serialVersionUID = 1L;
	
	private AWSStorageUtil aws = null;

	public AWSService() {
        super();
        aws = AWSStorageUtil.getInstance();
    }
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.getWriter().print("<h2 align=center>Welcome To Amazon S3 Web Service</h2>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if(isMultipart)
		{
			response.setContentType("text/plain");
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items;
            
			try {
				items = upload.parseRequest(request);
				for(FileItem item:items){
					if (!item.isFormField())aws.upload(item);
				}
				response.getWriter().print("File Uploaded");
			} catch (FileUploadException e) {
				e.printStackTrace();
				response.getWriter().print("File Upload Error: " + e.getMessage());
			}
		}
		
		if(getParam(request,"getFile")!=null){
			download(getParam(request,"getFile"), response);
		}
		if(getParam(request,"delFile")!=null){
			aws.delete(getParam(request,"delFile"));
			response.setContentType("text/plain");
			response.getWriter().print("File Deleted");
		}
		if(getParam(request,"listFile")!=null){
			List<String> list = aws.getFileList(getParam(request,"listFile"));
			response.setContentType("text/plain");
			Gson gson = new Gson();
			response.getWriter().print(gson.toJson(list));
		}
		
	}
	
	private String getParam(HttpServletRequest request, String name){
		if(request.getParameter(name)!=null && request.getParameter(name).length()>0)return request.getParameter(name);
		else return null;
	}
	
	private void download(String file, HttpServletResponse response) throws IOException{
		byte[] bytes = aws.getFileFromS3(file);
		response.setContentType("application/force-download");
		response.setContentLength(bytes.length);
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition","attachment; filename=\""+file.substring(file.lastIndexOf("/")+1)+"\"");//fileName);
		ServletOutputStream outs = response.getOutputStream();
		outs.write(bytes);
		outs.flush();
		outs.close();
	}
	
	

}
