package com.parentscommunity.resources.controller;

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
 * Servlet implementation class ResourcesFileDownloadServlet
 */
@WebServlet("/resources/filedownload.do")
public class ResourcesFileDownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResourcesFileDownloadServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 클라이언트가 요청한 파일을 전송하는 로직

        String oriname = request.getParameter("originalFileName"); // 원본 파일명
        String rename = request.getParameter("renamedFileName");   // 저장된 파일명

        // 파일 이름 정리 (특수 문자 제거)
        String sanitizedFileName = oriname.replaceAll("[^a-zA-Z0-9._-]", "_");

        // 파일 경로 지정
        String path = getServletContext().getRealPath("/resources/upload/resources");
        File f = new File(path + "/" + rename);

        // 파일 존재 여부 확인
        if (!f.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
            return;
        }

        // 파일 스트림 생성 및 전송
        try (FileInputStream fis = new FileInputStream(f);
             BufferedInputStream bis = new BufferedInputStream(fis);
             BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream())) {

            // 응답 메시지 작성
            response.setContentType("application/octet-stream");

            // 다운로드 파일 이름 설정
            String responseName = new String(sanitizedFileName.getBytes("UTF-8"), "ISO-8859-1");
            response.setHeader("Content-Disposition", "attachment;filename=" + responseName);

            // 파일 데이터 전송
            int data;
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
        doGet(request, response);
    }
}
