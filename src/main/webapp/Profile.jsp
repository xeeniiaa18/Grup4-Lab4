<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div style="max-width:600px; margin:0 auto; padding:24px 0;">

                    <c:if test="${updateSuccess}">
                        <div
                            style="background:#d4edda;border:1px solid #c3e6cb;color:#155724;padding:12px 18px;border-radius:12px;margin-bottom:16px;font-size:13px;">
                            <i class="fa fa-check-circle"></i> Profile updated successfully.
                        </div>
                    </c:if>

                    <div class="w3-card w3-white w3-round-large" style="padding:28px; background:#fff;">

                        <!-- Avatar + name header -->
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
                                <div style="color:#CE9C6A;font-size:13px;">@${sessionScope.user.username}</div>
                                <c:if test="${sessionScope.user.verified}">
                                    <span
                                        style="background:#E46B39;color:white;font-size:11px;padding:2px 8px;border-radius:8px;">
                                        <i class="fa fa-check"></i> Verified
                                    </span>
                                </c:if>
                            </div>
                        </div>

                        <hr style="border:none;border-top:1px solid #f0e8df;margin-bottom:24px;">

                        <form method="post" action="UpdateProfile">

                            <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:14px;">
                                <div>
                                    <label style="font-size:12px;font-weight:700;color:#46331F;">Title / Role</label>
                                    <input type="text" name="title" value="${sessionScope.user.title}"
                                        placeholder="e.g. Chef, Food Blogger..."
                                        style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;box-sizing:border-box;">
                                </div>
                                <div>
                                    <label style="font-size:12px;font-weight:700;color:#46331F;">Phone</label>
                                    <input type="text" name="phone" value="${sessionScope.user.phone}"
                                        placeholder="Your phone number"
                                        style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;box-sizing:border-box;">
                                </div>
                            </div>

                            <div style="margin-bottom:14px;">
                                <label style="font-size:12px;font-weight:700;color:#46331F;">Profile picture URL</label>
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
                                <label style="font-size:12px;font-weight:700;color:#46331F;">Allergies</label>
                                <input type="text" name="allergies" value="${sessionScope.user.allergies}"
                                    placeholder="e.g. Gluten, Nuts, Dairy..."
                                    style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-top:4px;box-sizing:border-box;">
                            </div>

                            <div style="margin-bottom:22px;">
                                <label style="font-size:12px;font-weight:700;color:#46331F;">Food Preferences</label>
                                <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:8px;margin-top:8px;">

                                    <c:set var="prefs" value="${sessionScope.user.foodPreferences}" />

                                    <label><input type="checkbox" name="foodPreferences" value="Vegetarian" ${not empty
                                            prefs && prefs.contains('Vegetarian') ? 'checked' : '' }> Vegetarian</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Vegan" ${not empty prefs
                                            && prefs.contains('Vegan') ? 'checked' : '' }> Vegan</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Pescatarian" ${not empty
                                            prefs && prefs.contains('Pescatarian') ? 'checked' : '' }>
                                        Pescatarian</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Flexitarian" ${not empty
                                            prefs && prefs.contains('Flexitarian') ? 'checked' : '' }>
                                        Flexitarian</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Mediterranean" ${not
                                            empty prefs && prefs.contains('Mediterranean') ? 'checked' : '' }>
                                        Mediterranean</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Keto" ${not empty prefs
                                            && prefs.contains('Keto') ? 'checked' : '' }> Keto</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Low Carb" ${not empty
                                            prefs && prefs.contains('Low Carb') ? 'checked' : '' }> Low Carb</label>
                                    <label><input type="checkbox" name="foodPreferences" value="High Protein" ${not
                                            empty prefs && prefs.contains('High Protein') ? 'checked' : '' }> High
                                        Protein</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Paleo" ${not empty prefs
                                            && prefs.contains('Paleo') ? 'checked' : '' }> Paleo</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Whole30" ${not empty
                                            prefs && prefs.contains('Whole30') ? 'checked' : '' }> Whole30</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Gluten Free" ${not empty
                                            prefs && prefs.contains('Gluten Free') ? 'checked' : '' }> Gluten
                                        Free</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Dairy Free" ${not empty
                                            prefs && prefs.contains('Dairy Free') ? 'checked' : '' }> Dairy Free</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Low Fat" ${not empty
                                            prefs && prefs.contains('Low Fat') ? 'checked' : '' }> Low Fat</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Low Sodium" ${not empty
                                            prefs && prefs.contains('Low Sodium') ? 'checked' : '' }> Low Sodium</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Sugar Free" ${not empty
                                            prefs && prefs.contains('Sugar Free') ? 'checked' : '' }> Sugar Free</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Diabetic Friendly" ${not
                                            empty prefs && prefs.contains('Diabetic Friendly') ? 'checked' : '' }>
                                        Diabetic Friendly</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Halal" ${not empty prefs
                                            && prefs.contains('Halal') ? 'checked' : '' }> Halal</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Kosher" ${not empty
                                            prefs && prefs.contains('Kosher') ? 'checked' : '' }> Kosher</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Organic" ${not empty
                                            prefs && prefs.contains('Organic') ? 'checked' : '' }> Organic</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Plant Based" ${not empty
                                            prefs && prefs.contains('Plant Based') ? 'checked' : '' }> Plant
                                        Based</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Quick Meals" ${not empty
                                            prefs && prefs.contains('Quick Meals') ? 'checked' : '' }> Quick
                                        Meals</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Budget Friendly" ${not
                                            empty prefs && prefs.contains('Budget Friendly') ? 'checked' : '' }> Budget
                                        Friendly</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Family Friendly" ${not
                                            empty prefs && prefs.contains('Family Friendly') ? 'checked' : '' }> Family
                                        Friendly</label>
                                    <label><input type="checkbox" name="foodPreferences" value="Athlete Diet" ${not
                                            empty prefs && prefs.contains('Athlete Diet') ? 'checked' : '' }> Athlete
                                        Diet</label>

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