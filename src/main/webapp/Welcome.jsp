<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#rcolumn').load('NotFollowed');

                $('#btnGoToFeed').click(function () {
                    $('#content').load('Content');
                });

                setTimeout(function () {
                    $('#content').load('Content');
                }, 3000);
            });
        </script>

        <div class="w3-white w3-round w3-card w3-section" style="overflow:hidden;">
            <div style="height:5px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);"></div>

            <div style="padding: 40px 28px; text-align: center;">
                <i class="fa fa-cutlery" style="font-size:56px; color:#E46B39; margin-bottom:16px; display:block;"></i>
                <h2 style="margin:0 0 8px; color:#46331F; font-family:'Pacifico', cursive;">Welcome to Forkful!</h2>

                <c:choose>
                    <c:when test="${not empty user}">
                        <p style="color:#CE9C6A; font-size:15px; font-weight:600; margin:8px 0 4px;">
                            Hello, <strong style="color:#E46B39;">${user.firstName} ${user.lastName}</strong>
                        </p>
                        <p style="color:#CE9C6A; font-size:13px; margin:0 0 20px;">
                            @${user.username} — you can now share recipes, write reviews, and connect with foodies.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p style="color:#CE9C6A; font-size:14px; font-weight:600; margin:8px 0 20px;">
                            Discover recipes, share reviews, and connect with food lovers around the world.
                        </p>
                    </c:otherwise>
                </c:choose>

                <button id="btnGoToFeed"
                    style="background: linear-gradient(135deg, #E46B39, #d05325); color: white; border: none; border-radius: 12px; padding: 12px 28px; font-size: 14px; font-weight: 700; cursor: pointer; box-shadow: 0 4px 14px rgba(228,107,57,0.3); transition: all 0.2s;"
                    onmouseover="this.style.transform='scale(1.03)';" onmouseout="this.style.transform='scale(1)';">
                    Explore the Feed
                </button>

                <p style="color:#CE9C6A; font-size:11px; margin-top:12px;">Redirecting automatically in a few seconds...
                </p>
            </div>
        </div>