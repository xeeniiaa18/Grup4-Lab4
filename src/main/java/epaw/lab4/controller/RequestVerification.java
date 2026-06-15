package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import epaw.lab4.model.User;
import epaw.lab4.repository.VerificationRequestRepository;

import java.io.IOException;

@MultipartConfig
@WebServlet("/RequestVerification")
public class RequestVerification extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You must be logged in.");
            return;
        }

        String message = request.getParameter("message");
        if (message == null) message = "";

        VerificationRequestRepository.getInstance().submit(user.getId(), message);

        // Fetch the updated request state to display
        // Forward to Profile controller to render the page
        request.getRequestDispatcher("Profile").forward(request, response);
    }
}
