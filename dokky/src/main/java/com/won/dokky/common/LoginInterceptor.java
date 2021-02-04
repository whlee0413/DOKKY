package com.won.dokky.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		String path = request.getServletPath();
		String pathCheck = "/boardReplyInsert";
		String query = request.getQueryString();
		
		Object obj = session.getAttribute("login");
		
		if(path.equals(pathCheck)) {
			path = "/boardRead";
		}
		
		if(query !=null) {
			session.setAttribute("prev_url", path+"?"+query);
		}else {
			session.setAttribute("prev_url", path);
		}
			
		
		if(obj != null) {
			return true;
		}
		response.sendRedirect("/loginForm");
		return false;
		
          
        // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서 true로하면 컨트롤러 uri로 가게 됨.
		// return false;  더이상 컨트롤러 요청으로 가지 않도록 false로 반환함
        
    }

	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
			
		
//        	session.setAttribute("login", obj);
//            로그인이 안되어 있으면 로그인 폼으로 다시 돌려보냄(redirect)
//            response.sendRedirect("/loginForm");

        
    }     
	
}
