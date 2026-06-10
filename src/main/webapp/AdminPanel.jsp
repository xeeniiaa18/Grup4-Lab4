<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <c:if test="${empty user or user.role != 'admin'}">
            <c:redirect url="/Login" />
        </c:if>

        <%@ include file="Header.jsp" %>

            <div style="display:flex; min-height:100vh; background:#FFF6ED;">

                <div style="width:220px; flex-shrink:0; padding:20px 10px;">
                    <%@ include file="MenuLogged.jsp" %>
                </div>

                <div style="flex:1; padding:30px 40px;">

                    <h2 style="font-family:'Pacifico',cursive; color:#46331F; margin-bottom:4px;">
                        <i class="fa fa-shield"></i> Admin Panel
                    </h2>
                    <p style="color:#CE9C6A; margin-top:0; font-size:13px;">
                        Logged in as <strong>@${user.username}</strong>
                    </p>

                    <%-- USERS --%>
                        <h3 style="color:#46331F; border-bottom:2px solid #CE9C6A; padding-bottom:6px;">
                            <i class="fa fa-users"></i> Users
                        </h3>

                        <table class="w3-table w3-card w3-white w3-round-large w3-margin-bottom">
                            <thead>
                                <tr style="background:#F4A83F; color:#46331F; font-weight:700;">
                                    <th style="padding:10px;">User</th>
                                    <th>Email</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${users}">
                                    <c:if test="${u.role != 'admin'}">
                                        <tr style="border-bottom:1px solid #f0e8df;">
                                            <td style="padding:10px;">
                                                <strong style="color:#46331F;">${u.firstName} ${u.lastName}</strong><br>
                                                <span style="color:#CE9C6A; font-size:12px;">@${u.username}</span>
                                            </td>
                                            <td style="color:#46331F; font-size:13px;">${u.email}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.banned}">
                                                        <span
                                                            style="color:#d9534f; font-weight:700; font-size:12px;">Banned</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            style="color:#3D7A5A; font-weight:700; font-size:12px;">Active</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="display:flex; gap:6px; padding:10px;">

                                                <form method="post" action="AdminPanel" style="display:inline;">
                                                    <input type="hidden" name="id" value="${u.id}">
                                                    <c:choose>
                                                        <c:when test="${u.banned}">
                                                            <input type="hidden" name="action" value="unban">
                                                            <button class="w3-button w3-small w3-round"
                                                                style="background:#3D7A5A;color:white;font-size:12px;padding:4px 10px;">
                                                                Unban
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="hidden" name="action" value="ban">
                                                            <button class="w3-button w3-small w3-round"
                                                                style="background:#F4A83F;color:#46331F;font-size:12px;padding:4px 10px;">
                                                                Ban
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>

                                                <form method="post" action="AdminPanel" style="display:inline;"
                                                    onsubmit="return confirm('Permanently delete @${u.username}? This cannot be undone.');">
                                                    <input type="hidden" name="action" value="deleteUser">
                                                    <input type="hidden" name="id" value="${u.id}">
                                                    <button class="w3-button w3-small w3-round"
                                                        style="background:#d9534f;color:white;font-size:12px;padding:4px 10px;">
                                                        Delete
                                                    </button>
                                                </form>

                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>

                        <%-- POSTS --%>
                            <h3
                                style="color:#46331F; border-bottom:2px solid #CE9C6A; padding-bottom:6px; margin-top:36px;">
                                <i class="fa fa-trash"></i> Posts
                            </h3>

                            <c:forEach var="post" items="${posts}">
                                <div class="w3-card w3-white w3-round-large w3-margin-bottom"
                                    style="padding:14px 18px; display:flex; justify-content:space-between; align-items:flex-start; gap:16px;">

                                    <div style="flex:1;">
                                        <span style="font-weight:700; color:#46331F;">@${post.uname}</span>
                                        <span
                                            style="color:#CE9C6A; font-size:11px; margin-left:8px;">${post.postDateTime}</span>
                                        <span
                                            style="background:#CE9C6A;color:white;padding:1px 7px;border-radius:6px;font-size:11px;margin-left:6px;">${post.type}</span>
                                        <p style="color:#46331F; margin:6px 0 0; font-size:13px;">${post.content}</p>
                                    </div>

                                    <form method="post" action="AdminPanel" style="flex-shrink:0;"
                                        onsubmit="return confirm('Delete this post permanently?');">
                                        <input type="hidden" name="action" value="deletePost">
                                        <input type="hidden" name="id" value="${post.id}">
                                        <button class="w3-button w3-small w3-round"
                                            style="background:#d9534f;color:white;font-size:12px;padding:4px 10px;">
                                            <i class="fa fa-trash"></i> Remove
                                        </button>
                                    </form>

                                </div>
                            </c:forEach>

                </div>
            </div>