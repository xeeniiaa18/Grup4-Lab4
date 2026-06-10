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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    User user = (session != null) ? (User) session.getAttribute("user") : null;

    UserService userService = UserService.getInstance();
    Integer uid = (user != null) ? user.getId() : null;
    List<User> users = userService.getNotFollowedUsers(uid, 0, 8); // fetch more so sorting is meaningful

    // Sort by shared food preferences with current user
    if (user != null && user.getFoodPreferences() != null && users != null) {
        String[] myPrefs = user.getFoodPreferences().toLowerCase().split(",");
        users.sort((a, b) -> {
            int scoreA = countMatches(a.getFoodPreferences(), myPrefs);
            int scoreB = countMatches(b.getFoodPreferences(), myPrefs);
            return scoreB - scoreA; // descending
        });
    }

    request.setAttribute("users", users);
    request.setAttribute("currentUser", user);
    request.getRequestDispatcher("NotFollowed.jsp").forward(request, response);
}

private int countMatches(String prefs, String[] myPrefs) {
    if (prefs == null) return 0;
    String lower = prefs.toLowerCase();
    int count = 0;
    for (String p : myPrefs) {
        if (!p.trim().isEmpty() && lower.contains(p.trim())) count++;
    }
    return count;
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
