<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">

                <div style="max-width:600px; margin:0 auto; padding:24px 0;">

                    <%-- Success banner --%>
                        <c:if test="${updateSuccess}">
                            <div
                                style="background:#d4edda;border:1px solid #c3e6cb;color:#155724;padding:12px 18px;border-radius:12px;margin-bottom:16px;font-size:13px;">
                                <i class="fa fa-check-circle"></i> Profile updated successfully.
                            </div>
                        </c:if>

                        <%-- Profile card --%>
                            <div class="w3-card w3-white w3-round-large" style="padding:28px; background:#fff;">

                                <%-- Avatar + name header --%>
                                    <div style="display:flex;align-items:center;gap:18px;margin-bottom:24px;">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user.picture}">
                                                <img src="${sessionScope.user.picture}" class="w3-circle"
                                                    style="height:80px;width:80px;object-fit:cover;border:3px solid #E46B39;"
                                                    alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <div
                                                    style="width:80px;height:80px;border-radius:50%;background:#F4A83F;border:3px solid #E46B39;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                                    <i class="fa fa-user" style="color:white;font-size:32px;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <div style="font-family:'Pacifico',cursive;font-size:20px;color:#46331F;">
                                                ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                                            </div>
                                            <div style="color:#CE9C6A;font-size:13px;">@${sessionScope.user.username}
                                            </div>
                                            <c:if test="${sessionScope.user.verified}">
                                                <span
                                                    style="background:#E46B39;color:white;font-size:11px;padding:2px 8px;border-radius:8px;">
                                                    <i class="fa fa-check"></i> Verified
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <hr style="border:none;border-top:1px solid #f0e8df;margin-bottom:24px;">

                                    <%-- Edit form --%>
                                        <form method="post" action="UpdateProfile">

                                            <div
                                                style="display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:14px;">
                                                <div>
                                                    <label style="font-size:12px;font-weight:700;color:#46331F;">Title /
                                                        Role</label>
                                                    <input type="text" name="title" value="${sessionScope.user.title}"
                                                        placeholder="e.g. Chef, Food Blogger..."
                                                        style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;box-sizing:border-box;">
                                                </div>
                                                <div>
                                                    <label
                                                        style="font-size:12px;font-weight:700;color:#46331F;">Phone</label>
                                                    <input type="text" name="phone" value="${sessionScope.user.phone}"
                                                        placeholder="Your phone number"
                                                        style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;box-sizing:border-box;">
                                                </div>
                                            </div>

                                            <div style="margin-bottom:14px;">
                                                <label style="font-size:12px;font-weight:700;color:#46331F;">Profile
                                                    picture URL</label>
                                                <input type="text" name="picture" value="${sessionScope.user.picture}"
                                                    placeholder="https://..."
                                                    style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;box-sizing:border-box;">
                                            </div>

                                            <div style="margin-bottom:14px;">
                                                <label style="font-size:12px;font-weight:700;color:#46331F;">Bio</label>
                                                <textarea name="bio" rows="3" placeholder="Tell us about yourself..."
                                                    style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;resize:vertical;box-sizing:border-box;">${sessionScope.user.bio}</textarea>
                                            </div>

                                            <div style="margin-bottom:14px;">
                                                <label
                                                    style="font-size:12px;font-weight:700;color:#46331F;">Allergies</label>
                                                <input type="text" name="allergies"
                                                    value="${sessionScope.user.allergies}"
                                                    placeholder="e.g. Gluten, Nuts, Dairy..."
                                                    style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;box-sizing:border-box;">
                                            </div>

                                            <div style="margin-bottom:22px;">
                                                <label style="font-size:12px;font-weight:700;color:#46331F;">
                                                    Food Preferences
                                                </label>

                                                <div
                                                    style="display:grid;grid-template-columns:repeat(2,1fr);gap:8px;margin-top:8px;">

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Vegetarian"> Vegetarian</label>
                                                    <label><input type="checkbox" name="foodPreferences" value="Vegan">
                                                        Vegan</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Pescatarian"> Pescatarian</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Flexitarian"> Flexitarian</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Mediterranean"> Mediterranean</label>
                                                    <label><input type="checkbox" name="foodPreferences" value="Keto">
                                                        Keto</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Low Carb"> Low Carb</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="High Protein"> High Protein</label>

                                                    <label><input type="checkbox" name="foodPreferences" value="Paleo">
                                                        Paleo</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Whole30"> Whole30</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Gluten Free"> Gluten Free</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Dairy Free"> Dairy Free</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Low Fat"> Low Fat</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Low Sodium"> Low Sodium</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Sugar Free"> Sugar Free</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Diabetic Friendly"> Diabetic Friendly</label>

                                                    <label><input type="checkbox" name="foodPreferences" value="Halal">
                                                        Halal</label>
                                                    <label><input type="checkbox" name="foodPreferences" value="Kosher">
                                                        Kosher</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Organic"> Organic</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Plant Based"> Plant Based</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Quick Meals"> Quick Meals</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Budget Friendly"> Budget Friendly</label>

                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Family Friendly"> Family Friendly</label>
                                                    <label><input type="checkbox" name="foodPreferences"
                                                            value="Athlete Diet"> Athlete Diet</label>

                                                </div>
                                            </div>

                                            <button type="submit"
                                                style="width:100%;padding:12px;background:#E46B39;color:white;font-weight:700;font-size:14px;border:none;border-radius:12px;cursor:pointer;">
                                                <i class="fa fa-save"></i> Save Changes
                                            </button>

                                        </form>
                            </div>
                </div>

            </c:when>
            <c:otherwise>
                <p style="color:#CE9C6A;text-align:center;padding:40px;">Please <a href="Login">log in</a> to view your
                    profile.</p>
            </c:otherwise>
        </c:choose>