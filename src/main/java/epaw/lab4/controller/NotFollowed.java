package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import epaw.lab4.model.User;
import epaw.lab4.service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet("/NotFollowed")
public class NotFollowed extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NotFollowed() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<User> users = null;
		HttpSession session = request.getSession(false);
		
		User user = null;
		if (session != null) {
			user = (User) session.getAttribute("user");
		}

		try {
			UserService userService = UserService.getInstance();
			Integer uid = (user != null) ? user.getId() : null;
			users = userService.getNotFollowedUsers(uid, 0, 4);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("users", users);
		request.setAttribute("currentUser", user); // set current user to check guest state in JSP
		request.getRequestDispatcher("NotFollowed.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
