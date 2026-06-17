<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

        <div style="padding:20px; background:#FFF6ED; min-height:80vh; box-sizing:border-box; max-width:100%;">

            <h2 style="font-family:'Pacifico',cursive; color:#46331F; margin-bottom:4px;">
                <i class="fa fa-shield"></i> Admin Panel
            </h2>
            <p style="color:#7A5533; margin-top:0; font-size:13px;">
                Logged in as <strong>@<c:out value="${sessionScope.user.username}"/></strong>
            </p>

            <%-- VERIFICATION REQUESTS --%>
            <c:if test="${not empty verificationRequests}">
                <h3 style="color:#46331F; border-bottom:2px solid #CE9C6A; padding-bottom:6px;">
                    <i class="fa fa-shield"></i> Verification Requests
                    <span style="background:#E46B39;color:white;border-radius:50%;padding:2px 8px;font-size:14px;margin-left:6px;">${verificationRequests.size()}</span>
                </h3>

                <div class="admin-table-wrapper">
                <table class="w3-table w3-card w3-white w3-round-large w3-margin-bottom" style="min-width:520px;">
                    <thead>
                        <tr style="background:#3D7A5A; color:white; font-weight:700;">
                            <th style="padding:10px;">User</th>
                            <th>Message</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="req" items="${verificationRequests}">
                            <tr style="border-bottom:1px solid #f0e8df;">
                                <td style="padding:10px; display:flex; align-items:center; gap:10px;">
                                    <c:choose>
                                        <c:when test="${not empty req.picture}">
                                            <img src="${fn:escapeXml(req.picture)}" class="w3-circle" style="width:36px;height:36px;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width:36px;height:36px;border-radius:50%;background:#CE9C6A;display:flex;align-items:center;justify-content:center;">
                                                <i class="fa fa-user" style="color:white;font-size:14px;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <strong style="color:#46331F;"><c:out value="${req.firstName}"/> <c:out value="${req.lastName}"/></strong><br>
                                        <span style="color:#7A5533; font-size:12px;">@<c:out value="${req.username}"/></span>
                                    </div>
                                </td>
                                <td style="color:#46331F; font-size:13px; max-width:300px;">
                                    <c:choose>
                                        <c:when test="${empty req.message}"><em style="color:#7A5533">No message provided</em></c:when>
                                        <c:otherwise><c:out value="${req.message}"/></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="color:#7A5533; font-size:12px;"><c:out value="${req.createdAt}"/></td>
                                <td style="display:flex; gap:6px; padding:10px;">
                                    <form class="admin-form" method="post" action="AdminPanel" style="display:inline;">
                                        <input type="hidden" name="action" value="acceptVerification">
                                        <input type="hidden" name="id" value="${req.id}">
                                        <button type="submit" class="w3-button w3-small w3-round"
                                            style="background:#3D7A5A;color:white;font-size:12px;padding:4px 10px;">
                                            <i class="fa fa-check"></i> Accept
                                        </button>
                                    </form>
                                    <form class="admin-form" method="post" action="AdminPanel" style="display:inline;">
                                        <input type="hidden" name="action" value="rejectVerification">
                                        <input type="hidden" name="id" value="${req.id}">
                                        <button type="submit" class="w3-button w3-small w3-round"
                                            style="background:#d9534f;color:white;font-size:12px;padding:4px 10px;">
                                            <i class="fa fa-times"></i> Reject
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
            </c:if>

            <%-- USERS --%>
                <h3 style="color:#46331F; border-bottom:2px solid #CE9C6A; padding-bottom:6px;">
                    <i class="fa fa-users"></i> Users
                </h3>

                <div class="admin-table-wrapper">
                <table class="w3-table w3-card w3-white w3-round-large w3-margin-bottom" style="min-width:520px;">
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
                                        <strong style="color:#46331F;"><c:out value="${u.firstName}"/> <c:out value="${u.lastName}"/></strong><br>
                                        <span style="color:#7A5533; font-size:12px;">@<c:out value="${u.username}"/></span>
                                    </td>
                                    <td style="color:#46331F; font-size:13px;"><c:out value="${u.email}"/></td>
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
                                        <form class="admin-form" method="post" action="AdminPanel"
                                            style="display:inline;">
                                            <input type="hidden" name="id" value="${u.id}">
                                            <c:choose>
                                                <c:when test="${u.banned}">
                                                    <input type="hidden" name="action" value="unban">
                                                    <button type="submit" class="w3-button w3-small w3-round"
                                                        style="background:#3D7A5A;color:white;font-size:12px;padding:4px 10px;">
                                                        Unban
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="hidden" name="action" value="ban">
                                                    <button type="submit" class="w3-button w3-small w3-round"
                                                        style="background:#F4A83F;color:#46331F;font-size:12px;padding:4px 10px;">
                                                        Ban
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>

                                        <form class="admin-form" method="post" action="AdminPanel"
                                            style="display:inline;">
                                            <input type="hidden" name="action" value="deleteUser">
                                            <input type="hidden" name="id" value="${u.id}">
                                            <button type="submit" class="w3-button w3-small w3-round"
                                                onclick="return confirm('Permanently delete this user? This cannot be undone.');"
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
                </div>

                <%-- POSTS --%>
                    <h3 style="color:#46331F; border-bottom:2px solid #CE9C6A; padding-bottom:6px; margin-top:36px;">
                        <i class="fa fa-trash"></i> Posts
                    </h3>

                    <c:forEach var="post" items="${posts}">
                        <div class="w3-card w3-white w3-round-large w3-margin-bottom" style="overflow:hidden;">
                            <div style="height:4px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);">
                            </div>
                            <div style="padding:16px 18px;">

                                <%-- Author + meta --%>
                                    <div
                                        style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;">
                                        <div>
                                            <span style="font-weight:700;color:#46331F;">@<c:out value="${post.uname}"/></span>
                                            <span
                                                style="color:#7A5533;font-size:11px;margin-left:8px;"><c:out value="${post.postDateTime}"/></span>
                                            <c:if test="${post.type == 'recipe'}">
                                                <span
                                                    style="background:#E46B39;color:white;padding:1px 7px;border-radius:6px;font-size:11px;margin-left:6px;">Recipe</span>
                                            </c:if>
                                            <c:if test="${post.type == 'review'}">
                                                <span
                                                    style="background:#3D7A5A;color:white;padding:1px 7px;border-radius:6px;font-size:11px;margin-left:6px;">Review</span>
                                            </c:if>
                                        </div>
                                        <form class="admin-form" method="post" action="AdminPanel">
                                            <input type="hidden" name="action" value="deletePost">
                                            <input type="hidden" name="id" value="${post.id}">
                                            <button type="submit" class="w3-button w3-small w3-round"
                                                onclick="return confirm('Delete this post permanently?');"
                                                style="background:#d9534f;color:white;font-size:12px;padding:4px 10px;">
                                                <i class="fa fa-trash"></i> Remove
                                            </button>
                                        </form>
                                    </div>

                                    <%-- Recipe fields --%>
                                        <c:if test="${post.type == 'recipe'}">
                                            <c:if test="${not empty post.title}">
                                                <h4 style="margin:0 0 6px;color:#46331F;"><c:out value="${post.title}"/></h4>
                                            </c:if>
                                            <div
                                                style="display:flex;gap:16px;font-size:12px;color:#7A5533;font-weight:600;margin-bottom:8px;">
                                                <c:if test="${post.servings != null}"><span><i class="fa fa-users"></i>
                                                        <c:out value="${post.servings}"/> servings</span></c:if>
                                                <c:if test="${post.cookingTime != null}"><span><i
                                                            class="fa fa-clock-o"></i> <c:out value="${post.cookingTime}"/> min</span>
                                                </c:if>
                                            </div>
                                            <c:if test="${not empty post.ingredients}">
                                                <div
                                                    style="background:#FFF6ED;border-radius:8px;padding:8px 12px;margin-bottom:6px;font-size:13px;">
                                                    <strong>Ingredients:</strong> <c:out value="${post.ingredients}"/>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty post.instructions}">
                                                <div
                                                    style="background:#FFF6ED;border-radius:8px;padding:8px 12px;margin-bottom:6px;font-size:13px;">
                                                    <strong>Instructions:</strong> <c:out value="${post.instructions}"/>
                                                </div>
                                            </c:if>
                                        </c:if>

                                        <%-- Review fields --%>
                                            <c:if test="${post.type == 'review'}">
                                                <c:if test="${not empty post.reviewTitle}">
                                                    <h4 style="margin:0 0 6px;color:#46331F;"><c:out value="${post.reviewTitle}"/></h4>
                                                </c:if>
                                                <div
                                                    style="display:flex;gap:16px;font-size:12px;color:#7A5533;font-weight:600;margin-bottom:8px;">
                                                    <c:if test="${not empty post.reviewName}"><span><i
                                                                class="fa fa-cutlery"></i> <c:out value="${post.reviewName}"/></span>
                                                    </c:if>
                                                    <c:if test="${not empty post.location}"><span><i
                                                                class="fa fa-map-marker"></i> <c:out value="${post.location}"/></span>
                                                    </c:if>
                                                </div>
                                                <c:if test="${post.rating != null}">
                                                    <div style="margin-bottom:8px;">
                                                        <c:forEach begin="1" end="5" var="star">
                                                            <c:choose>
                                                                <c:when test="${star le post.rating}">
                                                                    <i class="fa fa-star" style="color:#F4A83F;"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fa fa-star-o" style="color:#7A5533;"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        <span
                                                            style="color:#7A5533;font-size:12px;margin-left:4px;"><c:out value="${post.rating}"/></span>
                                                    </div>
                                                </c:if>
                                            </c:if>

                                            <%-- Text body --%>
                                                <c:if test="${not empty post.content}">
                                                    <p style="color:#46331F;font-size:13px;margin:6px 0 0;">
                                                        <c:out value="${post.content}"/></p>
                                                </c:if>

                                                <%-- Image --%>
                                                    <c:if test="${not empty post.image}">
                                                        <img src="${fn:escapeXml(post.image)}"
                                                            style="width:100%;border-radius:8px;margin-top:10px;"
                                                            alt="Post image">
                                                    </c:if>

                            </div>
                        </div>
                    </c:forEach>

        </div>

        <script>
            // Handle admin forms independently, bypassing the global form handler
            // which calls App.reloadChrome() unnecessarily and can cause issues.
            $(document).off('submit', '.admin-form').on('submit', '.admin-form', function (event) {
                event.stopImmediatePropagation();
                event.preventDefault();
                var form = this;
                $.ajax({
                    type: 'POST',
                    url: $(form).attr('action'),
                    data: new FormData(form),
                    processData: false,
                    contentType: false
                }).done(function (html) {
                    $('#content').html(html);
                });
            });
        </script>
