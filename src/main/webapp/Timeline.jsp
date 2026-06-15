<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#iterator').load('Posts');

                // Toggle post creation form
                $('#btnShowShare').click(function () {
                    $('#shareFormContainer').slideToggle(250, function () {
                        $('#postTypeSelect').trigger('change');
                    });
                });
                // Toggle fields based on post type selection
                $('#postTypeSelect').change(function () {
                    var selectedType = $(this).val();
                    $('.type-fields').hide();
                    if (selectedType === 'recipe') {
                        $('#recipeFields').show();
                    } else if (selectedType === 'review') {
                        $('#reviewFields').show();
                    }
                });

                // Submit post via AJAX
                $('#btnSubmitPost').click(function (event) {
                    event.preventDefault();

                    var selectedType = $('#postTypeSelect').val();
                    var postData = {
                        type: selectedType,
                        content: $('#postContent').val()
                    };

                    if (selectedType === 'recipe') {
                        postData.title = $('#recipeTitle').val();
                        postData.servings = $('#recipeServings').val();
                        postData.cookingTime = $('#recipeCookingTime').val();
                        postData.ingredients = $('#recipeIngredients').val();
                        postData.instructions = $('#recipeInstructions').val();
                    } else if (selectedType === 'review') {
                        postData.reviewTitle = $('#reviewTitle').val();
                        postData.reviewName = $('#reviewName').val();
                        postData.location = $('#reviewLocation').val();
                        postData.rating = $('#reviewRating').val();
                    }

                    $.post("AddPost", postData, function () {
                        // Reset form fields
                        $('#postContent').val('');
                        $('#recipeTitle').val('');
                        $('#recipeServings').val('');
                        $('#recipeCookingTime').val('');
                        $('#recipeIngredients').val('');
                        $('#recipeInstructions').val('');
                        $('#reviewTitle').val('');
                        $('#reviewName').val('');
                        $('#reviewLocation').val('');
                        $('#reviewRating').val('5');

                        // Hide container and reload feed
                        $('#shareFormContainer').slideUp(250);
                        $('#iterator').load('Posts');
                    });
                });
            });
        </script>

        <div
            style="display:flex; align-items:center; justify-content:space-between; margin-bottom:20px; flex-wrap:wrap; gap:10px;">
            <div>
                <h1 style="margin:0; font-family:'Pacifico',cursive; color:#46331F; font-size:28px;">Feed</h1>
                <p style="margin:4px 0 0; color:#CE9C6A; font-size:13px; font-weight:600;">Discover and share amazing
                    recipes and reviews</p>
            </div>

            <c:if test="${not empty user}">
                <button id="btnShowShare"
                    style="background-color:#E46B39; color:white; border:none; border-radius:20px; padding:10px 20px; font-weight:700; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:6px; box-shadow:0 4px 10px rgba(228,107,57,0.25); transition:all 0.2s; white-space:nowrap; flex-shrink:0;"
                    onmouseover="this.style.backgroundColor='#d05325';"
                    onmouseout="this.style.backgroundColor='#E46B39';">
                    <i class="fa fa-plus"></i> Share
                </button>
            </c:if>
        </div>

        <!-- Add Post Form (Hidden initially) -->
        <c:if test="${not empty user}">
            <div id="shareFormContainer"
                style="display: none; background-color: #ffffff; border-radius: 16px; border: 1.5px solid #CE9C6A; padding: 20px; margin-bottom: 24px; box-shadow: 0 4px 12px rgba(70,51,31,0.05);">
                <h3 style="margin: 0 0 16px; font-size: 15px; font-weight: 700; color: #46331F;">What are you cooking up
                    today?</h3>

                <form>
                    <div style="margin-bottom: 12px;">
                        <label
                            style="font-size: 12px; font-weight: 600; color: #CE9C6A; display: block; margin-bottom: 4px;">
                            <i class="fa fa-tag"></i> Post Type
                        </label>
                        <select id="postTypeSelect"
                            style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;">
                            <option value="recipe">Recipe</option>
                            <option value="review">Review</option>
                        </select>
                    </div>

                    <!-- Recipe Fields (Hidden initially) -->
                    <div id="recipeFields" class="type-fields"
                        style="display: none; border-top: 1px dashed #CE9C6A; padding-top: 12px; margin-bottom: 12px;">
                        <div style="margin-bottom: 10px;">
                            <label
                                style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Recipe
                                Title</label>
                            <input type="text" id="recipeTitle" placeholder="e.g. Creamy Tuscan Chicken"
                                style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;" />
                        </div>
                        <div style="display: flex; gap: 10px; margin-bottom: 10px;">
                            <div style="flex: 1;">
                                <label
                                    style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Servings</label>
                                <input type="number" id="recipeServings" min="1" placeholder="4"
                                    style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;" />
                            </div>
                            <div style="flex: 1;">
                                <label
                                    style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Cooking
                                    Time (minutes)</label>
                                <input type="number" id="recipeCookingTime" min="1" placeholder="30"
                                    style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <label
                                style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Ingredients</label>
                            <textarea id="recipeIngredients"
                                placeholder="e.g. 2 chicken breasts, 1 cup heavy cream, spinach..." rows="2"
                                style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F; resize: vertical;"></textarea>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <label
                                style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Instructions</label>
                            <textarea id="recipeInstructions" placeholder="e.g. 1. Sear chicken. 2. Prepare sauce..."
                                rows="3"
                                style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F; resize: vertical;"></textarea>
                        </div>
                    </div>

                    <!-- Review Fields (Hidden initially) -->
                    <div id="reviewFields" class="type-fields"
                        style="display: none; border-top: 1px dashed #CE9C6A; padding-top: 12px; margin-bottom: 12px;">
                        <div style="margin-bottom: 10px;">
                            <label
                                style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Review
                                Title / Subject</label>
                            <input type="text" id="reviewTitle" placeholder="e.g. Best pizza in town!"
                                style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;" />
                        </div>
                        <div style="display: flex; gap: 10px; margin-bottom: 10px;">
                            <div style="flex: 1;">
                                <label
                                    style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Dish
                                    / Restaurant Name</label>
                                <input type="text" id="reviewName" placeholder="e.g. Pizzeria Luigi"
                                    style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;" />
                            </div>
                            <div style="flex: 1;">
                                <label
                                    style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Location</label>
                                <input type="text" id="reviewLocation" placeholder="e.g. Barcelona, Spain"
                                    style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <label
                                style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">
                                <i class="fa fa-star"></i> Rating
                            </label>
                            <select id="reviewRating"
                                style="width: 100%; padding: 8px 12px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F;">
                                <option value="5.0">★★★★★ 5.0</option>
                                <option value="4.5">★★★★½ 4.5</option>
                                <option value="4.0">★★★★ 4.0</option>
                                <option value="3.5">★★★½ 3.5</option>
                                <option value="3.0">★★★ 3.0</option>
                                <option value="2.5">★★½ 2.5</option>
                                <option value="2.0">★★ 2.0</option>
                                <option value="1.5">★½ 1.5</option>
                                <option value="1.0">★ 1.0</option>
                                <option value="0.5">½ 0.5</option>
                            </select>
                        </div>
                    </div>

                    <!-- General Description / Comment Content -->
                    <div style="margin-bottom: 16px;">
                        <label
                            style="font-size: 12px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Share
                            your thoughts / description</label>
                        <textarea id="postContent"
                            placeholder="Describe the recipe, write the review detail, or post a comment..." rows="3"
                            required
                            style="width: 100%; padding: 10px 14px; border: 1.5px solid #CE9C6A; border-radius: 10px; font-size: 13px; outline: none; color: #46331F; resize: vertical;"></textarea>
                    </div>

                    <div style="display: flex; justify-content: flex-end;">
                        <button type="submit" id="btnSubmitPost"
                            style="background-color: #E46B39; color: white; border: none; border-radius: 10px; padding: 10px 20px; font-weight: 700; font-size: 13px; cursor: pointer; transition: all 0.2s; display:flex; align-items:center; gap:6px;">
                            <i class="fa fa-paper-plane"></i> Post
                        </button>
                    </div>
                </form>
            </div>
        </c:if>

        <div id="iterator">
            <!-- Posts/Feed will be loaded here dynamically -->
        </div>