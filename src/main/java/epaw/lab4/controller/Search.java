package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import epaw.lab4.model.User;
import epaw.lab4.repository.UserRepository;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/Search")
public class Search extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String q = request.getParameter("q");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (q == null || q.trim().length() < 2) {
            out.write("<p style='padding:10px;color:#CE9C6A;font-size:13px;'>Type at least 2 characters.</p>");
            return;
        }

        List<User> results = UserRepository.getInstance().searchByUsername(q.trim());

        if (results.isEmpty()) {
            out.write("<p style='padding:10px 14px;color:#CE9C6A;font-size:13px;'>No users found.</p>");
            return;
        }

        for (User u : results) {
            out.write(
                "<div style='display:flex;align-items:center;gap:10px;padding:10px 14px;cursor:pointer;transition:background 0.15s;' " +
                "onmouseover=\"this.style.background='#FFF6ED'\" onmouseout=\"this.style.background='white'\" " +
                "onclick=\"$('#content').load('Posts?filter=user&uid=" + u.getId() + "');$('#searchResults').hide();$('#searchInput').val('');\">" +
                "<div style='width:32px;height:32px;border-radius:50%;background:#FFF6ED;border:1.5px solid #CE9C6A;display:flex;align-items:center;justify-content:center;flex-shrink:0;'>" +
                "<i class=\"fa fa-user\" style=\"color:#CE9C6A;font-size:13px;\"></i></div>" +
                "<div><div style='font-weight:700;font-size:13px;color:#46331F;'>" + escapeHtml(u.getFirstName()) + " " + escapeHtml(u.getLastName()) + "</div>" +
                "<div style='font-size:11px;color:#CE9C6A;'>@" + escapeHtml(u.getUsername()) + "</div></div>" +
                "</div>"
            );
        }
    }

    private String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
    }
}