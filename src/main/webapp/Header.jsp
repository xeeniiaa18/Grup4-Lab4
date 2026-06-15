<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="header-container"
            style="display:flex;align-items:center;justify-content:space-between;gap:12px;padding:12px 24px;background-color:#FFF6ED;border-bottom:1px solid #CE9C6A;box-shadow:0 2px 8px rgba(70,51,31,0.05);flex-wrap:nowrap;">

            <!-- Logo -->
            <a href="Content" class="menu"
                style="text-decoration:none;display:flex;flex-direction:column;align-items:flex-start;flex-shrink:0;">
                <img src="assets/logo.png" alt="Forkful Logo" style="height:60px;object-fit:contain;">
            </a>

            <!-- Search Bar -->
            <div class="header-search" style="flex:1 1 auto;min-width:0;max-width:400px;margin:0;position:relative;">
                <i class="fa fa-search"
                    style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#CE9C6A;font-size:14px;"></i>
                <input type="text" id="searchInput" placeholder="Search users..."
                    style="width:100%;padding:10px 14px 10px 38px;border:1.5px solid #CE9C6A;border-radius:20px;background-color:#ffffff;font-size:13px;color:#46331F;outline:none;transition:all 0.2s;"
                    onfocus="this.style.borderColor='#E46B39';this.style.boxShadow='0 0 0 3px rgba(228,107,57,0.15)';"
                    onblur="this.style.borderColor='#CE9C6A';this.style.boxShadow='none';" />
                <div id="searchResults"
                    style="display:none;position:absolute;top:calc(100% + 8px);left:0;right:0;background:white;border:1px solid #CE9C6A;border-radius:12px;max-height:300px;overflow-y:auto;z-index:1000;box-shadow:0 4px 12px rgba(0,0,0,0.1);">
                </div>
            </div>

            <!-- Actions -->
            <div style="display:flex;align-items:center;gap:12px;flex-shrink:0;">
                <c:choose>
                    <c:when test="${not empty user}">
                        <a href="Logout" id="btnLogout"
                            style="text-decoration:none;display:flex;align-items:center;gap:6px;padding:8px 16px;border:1.5px solid #E46B39;border-radius:12px;color:#E46B39;font-weight:700;font-size:13px;background-color:transparent;transition:all 0.2s;cursor:pointer;"
                            onmouseover="this.style.backgroundColor='#FFF6ED';"
                            onmouseout="this.style.backgroundColor='transparent';">
                            <i class="fa fa-sign-out"></i> Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="menu" href="Login"
                            style="text-decoration:none;display:flex;align-items:center;gap:6px;padding:8px 16px;font-weight:700;font-size:13px;color:#46331F;transition:all 0.2s;">
                            <i class="fa fa-sign-in"></i> Log In
                        </a>
                        <a class="menu" href="Register"
                            style="text-decoration:none;display:flex;align-items:center;gap:6px;padding:8px 16px;border-radius:12px;background-color:#E46B39;color:white;font-weight:700;font-size:13px;box-shadow:0 4px 10px rgba(228,107,57,0.2);transition:all 0.2s;">
                            <i class="fa fa-user-plus"></i> Register
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <script>
            $('#btnLogout').off('click').on('click', function (e) {
                e.preventDefault();
                $.post('Logout', function () {
                    App.reloadChrome();
                    $('#content').load('Content');
                });
            });

            // Search Users Logic
            let allUsersList = null;

            function performSearch(q) {
                let res = $('#searchResults');
                if (!q || q.length === 0 || !allUsersList) {
                    res.hide();
                    return;
                }
                let filtered = allUsersList.filter(u =>
                    (u.username && u.username.toLowerCase().includes(q)) ||
                    (u.firstName && u.firstName.toLowerCase().includes(q)) ||
                    (u.lastName && u.lastName.toLowerCase().includes(q))
                );

                if (filtered.length === 0) {
                    res.html('<div style="padding:10px; color:#CE9C6A; font-size:13px; text-align:center;">No users found</div>');
                } else {
                    let html = '';
                    filtered.forEach(u => {
                        let haspic = u.picture && u.picture.trim() !== '' && u.picture !== 'null';
                        let avatar = haspic
                            ? '<img src="' + u.picture + '" style="width:32px;height:32px;border-radius:50%;object-fit:cover;flex-shrink:0;">'
                            : '<div style="width:32px;height:32px;border-radius:50%;background:#FFF6ED;border:1.5px solid #CE9C6A;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-weight:700;color:#E46B39;font-size:13px;">'
                            + (u.username ? u.username.charAt(0).toUpperCase() : '?')
                            + '</div>';

                        html += '<a href="#" class="search-result-user" data-uid="' + u.uid + '" '
                            + 'style="display:flex;align-items:center;gap:10px;padding:10px;text-decoration:none;border-bottom:1px solid #f0e8df;transition:background 0.2s;"'
                            + 'onmouseover="this.style.background=\'#FFF6ED\';" onmouseout="this.style.background=\'white\';">'
                            + avatar
                            + '<div>'
                            + '<div style="font-weight:700;color:#46331F;font-size:13px;">' + (u.firstName || '') + ' ' + (u.lastName || '') + '</div>'
                            + '<div style="color:#CE9C6A;font-size:11px;">@' + (u.username || '') + '</div>'
                            + '</div></a>';
                    });
                    res.html(html);
                }
                res.show();
            }

            $('#searchInput').on('focus input', function () {
                let q = $(this).val().toLowerCase();
                if (allUsersList === null) {
                    allUsersList = []; // prevent multiple requests
                    $.getJSON('SearchUsers')
                        .done(function (data) {
                            allUsersList = data;
                            performSearch($('#searchInput').val().toLowerCase());
                        })
                        .fail(function () {
                            allUsersList = null; // retry later
                        });
                } else {
                    performSearch(q);
                }
            });

            $(document).on('click', function (e) {
                if (!$(e.target).closest('#searchInput, #searchResults').length) {
                    $('#searchResults').hide();
                }
            });

            $(document).on('click', '.search-result-user', function (e) {
                e.preventDefault();
                let uid = $(this).data('uid');
                $('#content').load('ViewProfile?uid=' + uid);
                $('#searchResults').hide();
                $('#searchInput').val('');
            });
        </script>