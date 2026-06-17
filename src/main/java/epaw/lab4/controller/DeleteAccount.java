package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import epaw.lab4.model.User;
import epaw.lab4.repository.UserRepository;

import java.io.IOException;

@WebServlet("/DeleteAccount")
public class DeleteAccount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request, response);
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request, response);
            return;
        }

        // Delete user and all their data from DB
        UserRepository.getInstance().deleteUser(currentUser.getId());

        // Invalidate session
        session.invalidate();

        // Redirect to login with confirmation message
        request.setAttribute("accountDeleted", true);
        request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request, response);
    }
}
