package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import epaw.lab4.model.User;
import epaw.lab4.service.UserService;
import epaw.lab4.service.PostService;

import java.io.IOException;
import java.util.List;
import epaw.lab4.model.Post;

@WebServlet("/ViewProfile")
public class ViewProfile extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        try {
            int uid = Integer.parseInt(request.getParameter("uid"));

            // Si és el propi perfil, redirigeix a Profile
            if (currentUser != null && currentUser.getId() == uid) {
                response.sendRedirect("Profile");
                return;
            }

            UserService userService = UserService.getInstance();
            User profileUser = userService.getUserById(uid);
            List<Post> posts = PostService.instance().getPostsByUser(
                uid,
                currentUser != null ? currentUser.getId() : null,
                0, 10
            );

            request.setAttribute("profileUser", profileUser);
            request.setAttribute("posts", posts);
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("ViewProfile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Content");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}