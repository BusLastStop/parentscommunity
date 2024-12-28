package com.parentscommunity.member.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.member.dto.Member;
import com.parentscommunity.member.service.MemberService;

/**
 * Servlet implementation class EnrollPageEndServlet
 */
@WebServlet("/member/enrollend.do")
public class EnrollPageEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollPageEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//요청 데이터 수집
		String userId= request.getParameter("userId");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String userName = request.getParameter("userName"); 
		String gender = request.getParameter("gender"); 
		String email = request.getParameter("email");
		String phone1 = request.getParameter("phone1"); 
		String phone2 = request.getParameter("phone2"); 
		String phone3 = request.getParameter("phone3"); 
		String userPhone = phone1 + phone2 +  phone3; 
		String address = request.getParameter("address");
		String nickname = request.getParameter("nickname"); 
		String memberType = request.getParameter("memberType");
		
		Date userBirthDate = null; 
		
		try {
			//Date.valueOf는 전달된 문자열을 java.sql.Date 객체로 변환
		    userBirthDate = Date.valueOf(request.getParameter("birthDate"));
		} catch (IllegalArgumentException e) {
		    request.setAttribute("msg", "올바른 생년월일을 입력해주세요.");
		    request.setAttribute("loc", "/member/enrollpage.do");
		    return;
		}
		
		// 자녀 정보 수집
	    String[] childGrades = request.getParameterValues("childGrade");
	    String[] schools = request.getParameterValues("school");

	    List<Map<String, Object>> children = new ArrayList<>();
	    if (childGrades != null && schools != null) {
	        for (int i = 0; i < childGrades.length; i++) {
	            Map<String, Object> child = new HashMap<>();
	            child.put("childGrade", childGrades[i]);
	            child.put("school", schools[i]);
	            children.add(child);
	        }
	    }
	    
		 //1.  Member 객체 생성 (데이터를 dto객체로 변환)
        Member m = Member.builder()
                .userId(userId)
                .userPw(password) 
                .userAddress(address)
                .userBirthDate(userBirthDate)
                .userEmail(email)
                .userGender(gender)
                .userPhone(userPhone)
                .userName(userName)
                .userNickname(nickname)
                .userType(memberType)
                .children(children)
                .build();

        // 2. 데이터베이스 저장 및 결과 처리
        String msg, loc;
        try {
            int result = new MemberService().insertMember(m); // MemberService를 통해 데이터 저장
            if (result > 0) {
                msg = "회원가입이 되었습니다.";
                loc = "/";
            } else {
                msg = "회원가입 실패! 다시 시도하세요.";
                loc = "/member/enrollpage.do";
            }
        } catch (RuntimeException e) {
        	e.printStackTrace();
            msg = "회원가입 중 오류가 발생했습니다. 다시 시도해주세요.";
            loc = "/member/enrollpage.do";
        }
        


        // 3. 결과 메시지와 이동 경로 설정
        request.setAttribute("msg", msg);
        request.setAttribute("loc", loc);

        // 4. 결과 페이지로 포워딩 (결과를 jsp로 전달)
        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
