package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import epaw.lab4.model.User;

import java.io.IOException;

@WebServlet("/Profile")
public class Profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String mode = request.getParameter("mode");

        if ("edit".equals(mode)) {
            // Mostra el formulari d'edició
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
        } else {
            // Fetch verification request
            if (user != null) {
                request.setAttribute("verificationRequest", epaw.lab4.repository.VerificationRequestRepository.getInstance().findByUid(user.getId()).orElse(null));
            }
            // Mostra la vista de lectura (per defecte)
            request.setAttribute("profileUser", user);
            request.setAttribute("isSelf", true);
            request.getRequestDispatcher("ViewProfile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}