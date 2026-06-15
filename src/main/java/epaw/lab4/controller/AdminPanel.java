package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import epaw.lab4.model.User;
import epaw.lab4.repository.PostRepository;
import epaw.lab4.repository.UserRepository;
import epaw.lab4.repository.VerificationRequestRepository;
import epaw.lab4.service.UserService;
import epaw.lab4.service.PostService;

import java.io.IOException;

@MultipartConfig
@WebServlet("/AdminPanel")
public class AdminPanel extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private User getAdminOrNull(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admins only.");
            return null;
        }
        return user;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User admin = getAdminOrNull(request, response);
        if (admin == null) return;

        request.setAttribute("users", UserService.getInstance().getAllUsers());
        request.setAttribute("posts", PostService.instance().getAllPosts(admin.getId(), 0, 50));
        request.setAttribute("verificationRequests", VerificationRequestRepository.getInstance().findAllPending());
        request.getRequestDispatcher("AdminPanel.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    User admin = getAdminOrNull(request, response);
    if (admin == null) return;

    String action = request.getParameter("action");
    String idStr  = request.getParameter("id");

    if (action != null && idStr != null) {
        int id = Integer.parseInt(idStr);
        switch (action) {
            case "ban":        UserRepository.getInstance().banUser(id);     break;
            case "unban":      UserRepository.getInstance().unbanUser(id);   break;
            case "deleteUser": UserRepository.getInstance().deleteUser(id);  break;
            case "deletePost": PostRepository.getInstance().adminDelete(id); break;
            case "acceptVerification": VerificationRequestRepository.getInstance().accept(id); break;
            case "rejectVerification": VerificationRequestRepository.getInstance().reject(id); break;
        }
    }

    // Reload the panel data and forward back (don't redirect — AJAX swallows it)
    request.setAttribute("users", UserService.getInstance().getAllUsers());
    request.setAttribute("posts", PostService.instance().getAllPosts(admin.getId(), 0, 50));
    request.setAttribute("verificationRequests", VerificationRequestRepository.getInstance().findAllPending());
    request.getRequestDispatcher("AdminPanel.jsp").forward(request, response);
}
}