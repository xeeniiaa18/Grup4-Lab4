package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import epaw.lab4.model.Post;
import epaw.lab4.model.User;
import epaw.lab4.service.PostService;

import java.io.IOException;
import java.util.List;

@WebServlet("/Posts")
public class Posts extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = null;
        if (session != null) {
            currentUser = (User) session.getAttribute("user");
        }

        Integer currentUserId = (currentUser != null) ? currentUser.getId() : null;

        String filter = request.getParameter("filter");
        String uidStr = request.getParameter("uid");

        List<Post> posts;
        PostService postService = PostService.instance();

        if ("saved".equalsIgnoreCase(filter) && currentUserId != null) {
            posts = postService.getSavedPosts(currentUserId, 0, 20);
        } else if ("user".equalsIgnoreCase(filter) && uidStr != null && !uidStr.trim().isEmpty()) {
            int uid = Integer.parseInt(uidStr);
            posts = postService.getPostsByUser(uid, currentUserId, 0, 20);
        } else {
            // Default: All public posts (for guests and global feed)
            posts = postService.getAllPosts(currentUserId, 0, 20);
        }

        request.setAttribute("posts", posts);
        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("FeedPosts.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
