package com.parentscommunity.post.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PostFileDownloadServlet
 */
@WebServlet("/post/filedownload.do")
public class PostFileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostFileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 클라이언트가 요청한 파일을 보내주는 기능

        String oriname = request.getParameter("originalFileName");
        String rename = request.getParameter("renamedFileName");

        // 파일 이름 정리 (특수 문자 제거)
        String sanitizedFileName = oriname.replaceAll("[^a-zA-Z0-9._-]", "_");

        // 파일 다운로드
        // 1. 요청한 파일을 가져옴 -> java.io.FileInputStream을 이용해서 가져옴
        String path = getServletContext().getRealPath("/resources/upload/board");
        File f = new File(path + "/" + rename);

        // 2. inputstream, outputstream 클래스 생성하기
        try (FileInputStream fis = new FileInputStream(f);
             BufferedInputStream bis = new BufferedInputStream(fis);
             BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream())) {

            // 3. 응답 메세지 작성
            // contentType 작성 -> application /octet-stream
            response.setContentType("application/octet-stream");

            // 파일 이름 처리
            String responseName = new String(sanitizedFileName.getBytes("UTF-8"), "ISO-8859-1");
            response.setHeader("Content-Disposition", "attachment;filename=" + responseName);

            // 4. 파일 보내기
            int data = -1;
            while ((data = bis.read()) != -1) {
                bos.write(data);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
