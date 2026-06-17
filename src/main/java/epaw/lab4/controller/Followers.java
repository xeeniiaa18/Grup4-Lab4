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
@WebServlet("/Followers")
public class Followers extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        List<User> followers = null;
        List<User> following = null;

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                try {
                    UserService us = UserService.getInstance();
                    followers = us.getFollowers(user.getId(), 0, 50);
                    following = us.getFollowedUsers(user.getId(), 0, 200);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // Construir un Set d'IDs que ja segueixes
        java.util.Set<Integer> followingIds = new java.util.HashSet<>();
        if (following != null) {
            for (User u : following) {
                followingIds.add(u.getId());
            }
        }

        request.setAttribute("users", followers);
        request.setAttribute("followingIds", followingIds);
        request.getRequestDispatcher("/WEB-INF/Followers.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}