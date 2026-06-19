package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import epaw.lab4.model.Post;
import epaw.lab4.model.User;
import epaw.lab4.service.PostService;

import java.io.IOException;

@MultipartConfig
@WebServlet("/EditPost")
public class EditPost extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) return;
        User user = (User) session.getAttribute("user");
        if (user == null) return;

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) return;

        int postId;
        try { postId = Integer.parseInt(idStr.trim()); } catch (NumberFormatException e) { return; }

        PostService ps = PostService.instance();
        Post post = ps.getPostById(postId, user.getId());
        if (post == null) return;

        // Ownership check (admins may also edit)
        if (post.getUid() != user.getId() && !"admin".equals(user.getRole())) return;

        // Update common text body
        post.setContent(request.getParameter("content"));

        if ("recipe".equalsIgnoreCase(post.getType())) {
            post.setTitle(request.getParameter("title"));
            String servStr = request.getParameter("servings");
            post.setServings(servStr != null && !servStr.trim().isEmpty() ? Integer.parseInt(servStr) : null);
            String ctStr = request.getParameter("cookingTime");
            post.setCookingTime(ctStr != null && !ctStr.trim().isEmpty() ? Integer.parseInt(ctStr) : null);
            post.setIngredients(request.getParameter("ingredients"));
            post.setInstructions(request.getParameter("instructions"));
        } else if ("review".equalsIgnoreCase(post.getType())) {
            post.setReviewTitle(request.getParameter("reviewTitle"));
            post.setReviewName(request.getParameter("reviewName"));
            post.setLocation(request.getParameter("location"));
            String ratingStr = request.getParameter("rating");
            post.setRating(ratingStr != null && !ratingStr.trim().isEmpty() ? Double.parseDouble(ratingStr) : null);
        }

        // Optional new image
        try {
            Part imagePart = request.getPart("image");
            String imagePath = PostService.instance().savePostImage(imagePart);
            if (imagePath != null) post.setImage(imagePath);
        } catch (Exception ignored) {}

        ps.update(post);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}