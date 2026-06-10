package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/More")
public class More extends HttpServlet {

    public static class MoreItem {
        public String icon, label, description;
        public MoreItem(String icon, String label, String description) {
            this.icon = icon; this.label = label; this.description = description;
        }
        public String getIcon() { return icon; }
        public String getLabel() { return label; }
        public String getDescription() { return description; }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<MoreItem> items = List.of(
            new MoreItem("fa fa-cog",           "Settings",         "Manage your account settings"),
            new MoreItem("fa fa-question-circle","Help & Support",   "Get help with Forkful"),
            new MoreItem("fa fa-shield",         "Privacy & Safety", "Control your privacy settings"),
            new MoreItem("fa fa-info-circle",    "About",            "Learn more about Forkful")
        );
        request.setAttribute("moreItems", items);
        request.getRequestDispatcher("More.jsp").forward(request, response);
    }
}