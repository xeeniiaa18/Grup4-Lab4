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

    /** Default page size for paginated feeds. */
    private static final int DEFAULT_SIZE = 20;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = null;
        if (session != null) {
            currentUser = (User) session.getAttribute("user");
        }

        Integer currentUserId = (currentUser != null) ? currentUser.getId() : null;

        String filter  = request.getParameter("filter");
        String uidStr  = request.getParameter("uid");
        String pidStr  = request.getParameter("pid");

        // --- Pagination parameters ---
        int page = parseIntOrDefault(request.getParameter("page"), 0);
        int size = parseIntOrDefault(request.getParameter("size"), DEFAULT_SIZE);
        if (page < 0) page = 0;
        if (size < 1 || size > 100) size = DEFAULT_SIZE;
        int start = page * size;
        int count = size;

        List<Post> posts;
        PostService postService = PostService.instance();

        if ("comments".equalsIgnoreCase(filter) && pidStr != null && !pidStr.trim().isEmpty()) {
            // Comments are not paginated — load all (up to 50)
            Integer pid = parseNullableInt(pidStr);
            if (pid == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post id.");
                return;
            }
            posts = postService.getCommentsByPost(pid, currentUserId, 0, 50);
            request.setAttribute("posts", posts);
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/FeedPosts.jsp").forward(request, response);
            return;
        } else if ("saved".equalsIgnoreCase(filter) && currentUserId != null) {
            posts = postService.getSavedPosts(currentUserId, start, count);
        } else if ("user".equalsIgnoreCase(filter) && uidStr != null && !uidStr.trim().isEmpty()) {
            Integer uid = parseNullableInt(uidStr);
            if (uid == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user id.");
                return;
            }
            posts = postService.getPostsByUser(uid, currentUserId, start, count);
        } else {
            // Default: all public posts (global feed)
            posts = postService.getAllPosts(currentUserId, start, count);
        }

        // Tell the JSP whether there might be more posts to load
        boolean hasMore = (posts != null && posts.size() == size);

        request.setAttribute("posts", posts);
        request.setAttribute("user", currentUser);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", size);
        request.setAttribute("hasMore", hasMore);
        request.getRequestDispatcher("/WEB-INF/FeedPosts.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    // -------------------------------------------------------------------------
    private int parseIntOrDefault(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Integer parseNullableInt(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
