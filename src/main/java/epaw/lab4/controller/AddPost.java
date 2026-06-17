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
import java.sql.Timestamp;

@MultipartConfig
@WebServlet("/AddPost")
public class AddPost extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                try {
                    Post post = new Post();
                    post.setUid(user.getId());
                    post.setUname(user.getUsername());
                    post.setPostDateTime(new Timestamp(System.currentTimeMillis()));

                    String type = request.getParameter("type");
                    post.setType(type != null ? type : "comment");

                    // General post fields
                    post.setContent(request.getParameter("content"));

                    // Image upload (only present on multipart requests, e.g. recipe/review forms)
                    String contentType = request.getContentType();
                    if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
                        try {
                            Part imagePart = request.getPart("image");
                            String imagePath = PostService.instance().savePostImage(imagePart);
                            if (imagePath != null) {
                                post.setImage(imagePath);
                            }
                        } catch (Exception ex) {
                            // No image part present, or read error — just skip it
                            ex.printStackTrace();
                        }
                    }

                    String pidStr = request.getParameter("pid");
                    if (pidStr != null && !pidStr.trim().isEmpty()) {
                        post.setPid(Integer.parseInt(pidStr));
                    }

                    // Recipe fields
                    if ("recipe".equalsIgnoreCase(type)) {
                        post.setTitle(request.getParameter("title"));

                        String servingsStr = request.getParameter("servings");
                        if (servingsStr != null && !servingsStr.trim().isEmpty()) {
                            post.setServings(Integer.parseInt(servingsStr));
                        }

                        String cookingTimeStr = request.getParameter("cookingTime");
                        if (cookingTimeStr != null && !cookingTimeStr.trim().isEmpty()) {
                            post.setCookingTime(Integer.parseInt(cookingTimeStr));
                        }

                        post.setIngredients(request.getParameter("ingredients"));
                        post.setInstructions(request.getParameter("instructions"));
                    }

                    // Review fields
                    else if ("review".equalsIgnoreCase(type)) {
                        post.setReviewTitle(request.getParameter("reviewTitle"));
                        post.setReviewName(request.getParameter("reviewName"));
                        post.setLocation(request.getParameter("location"));

                        String ratingStr = request.getParameter("rating");
                        if (ratingStr != null && !ratingStr.trim().isEmpty()) {
                            post.setRating(Double.parseDouble(ratingStr));
                        }
                    }

                    PostService.instance().add(post, user.getUsername());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}