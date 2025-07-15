<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="viewModel.couponViewModel" %>
        <%
    // Get attributes from request
    couponViewModel couponViewModel = (couponViewModel) request.getAttribute("couponViewModel");
    Boolean isEdit = (Boolean) request.getAttribute("isEdit");
    String formTitle = (String) request.getAttribute("formTitle");
    String formAction = (String) request.getAttribute("formAction");
    String buttonText = (String) request.getAttribute("buttonText");
    String error = (String) request.getAttribute("error");
    
    // Preserved form data in case of validation errors
    String preservedCode = (String) request.getAttribute("preservedCode");
    String preservedDescription = (String) request.getAttribute("preservedDescription");
    String preservedDiscountAmount = (String) request.getAttribute("preservedDiscountAmount");
    String preservedDiscountType = (String) request.getAttribute("preservedDiscountType");
    String preservedExpiryDate = (String) request.getAttribute("preservedExpiryDate");
    String preservedUsageLimit = (String) request.getAttribute("preservedUsageLimit");
    String preservedIsActive = (String) request.getAttribute("preservedIsActive");
    
    // Default values
    if (isEdit == null) {
        isEdit = false;
    }
    
    if (formAction == null) {
        formAction = "CouponServlet";
    }
    
    if (buttonText == null) {
        buttonText = isEdit ? "Update Coupon" : "Create Coupon";
    }
    
    if (formTitle == null) {
        formTitle = isEdit ? "Edit Coupon" : "Add New Coupon";
    }
%>
            <%!
    // Helper method for HTML escaping - moved to declaration section
    String escapeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#x27;");
    }
%>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>
                        <%= formTitle %> - Coupon Management System
                    </title>
                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Bootstrap Icons -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                    <style>
                        body {
                            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                            min-height: 100vh;
                        }

                        .form-container {
                            backdrop-filter: blur(10px);
                            background: rgba(255, 255, 255, 0.95);
                            border-radius: 15px;
                            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                            border: none;
                        }

                        .required {
                            color: #dc3545;
                        }

                        .btn-primary-custom {
                            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                            border: none;
                            color: white;
                        }

                        .btn-primary-custom:hover {
                            background: linear-gradient(135deg, #ff5252 0%, #d84315 100%);
                            color: white;
                        }

                        .form-control:focus {
                            border-color: #ff6b6b;
                            box-shadow: 0 0 0 0.2rem rgba(255, 107, 107, 0.25);
                        }

                        .form-select:focus {
                            border-color: #ff6b6b;
                            box-shadow: 0 0 0 0.2rem rgba(255, 107, 107, 0.25);
                        }

                        .coupon-icon {
                            background: linear-gradient(45deg, #ff6b6b, #ee5a24);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            background-clip: text;
                        }

                        .input-group-text {
                            background: rgba(255, 107, 107, 0.1);
                            border-color: #ff6b6b;
                            color: #ff6b6b;
                        }

                        .current-usage-card {
                            background: rgba(255, 193, 7, 0.1);
                            border-left: 4px solid #ffc107;
                            border-radius: 8px;
                            padding: 1rem;
                        }
                    </style>
                </head>

                <body>
                    <!-- Navigation -->
                    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                        <div class="container">
                            <a class="navbar-brand" href="welcome.jsp">
                                <i class="bi bi-ticket-perforated-fill me-2"></i>Coupon Management System
                            </a>
                            <div class="navbar-nav ms-auto">
                                <a href="CouponServlet?action=list" class="nav-link">
                                    <i class="bi bi-list me-1"></i>Coupon List
                                </a>
                                <a href="welcome.jsp" class="nav-link">
                                    <i class="bi bi-house me-1"></i>Dashboard
                                </a>
                            </div>
                        </div>
                    </nav>

                    <div class="container py-4">
                        <div class="row justify-content-center">
                            <div class="col-md-8 col-lg-6">
                                <div class="form-container p-5">
                                    <div class="text-center mb-4">
                                        <% if (isEdit) { %>
                                            <i class="bi bi-pencil-square coupon-icon" style="font-size: 3rem;"></i>
                                            <h2 class="fw-bold mt-3 mb-2">Edit Coupon</h2>
                                            <p class="text-muted">Update your coupon details</p>
                                            <% } else { %>
                                                <i class="bi bi-plus-circle coupon-icon" style="font-size: 3rem;"></i>
                                                <h2 class="fw-bold mt-3 mb-2">Create New Coupon</h2>
                                                <p class="text-muted">Design your coupon campaign</p>
                                                <% } %>
                                    </div>

                                    <!-- Error Messages -->
                                    <% if (error !=null) { %>
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <i class="bi bi-exclamation-triangle me-2"></i>
                                            <%= escapeHtml(error) %>
                                                <button type="button" class="btn-close"
                                                    data-bs-dismiss="alert"></button>
                                        </div>
                                        <% } %>

                                            
                                                <!-- Hidden fields for MVC -->
                                                <% if (isEdit && couponViewModel !=null) { %>
                                                    <input type="hidden" name="id"
                                                        value="<%= couponViewModel.getId() %>" />
                                                    <input type="hidden" name="action" value="update" />
                                                    <% } else { %>
                                                        <input type="hidden" name="action" value="insert" />
                                                        <% } %>

                                                            <!-- Coupon Code -->
                                                            <div class="mb-3">
                                                                <label for="code" class="form-label">
                                                                    <i class="bi bi-tag me-1"></i>Coupon Code <span
                                                                        class="required">*</span>
                                                                </label>
                                                                <% String codeValue="" ; if (preservedCode !=null) {
                                                                    codeValue=preservedCode; } else if (couponViewModel
                                                                    !=null) { codeValue=couponViewModel.getCode(); } %>
                                                                    <div class="input-group">
                                                                        <span class="input-group-text"><i
                                                                                class="bi bi-tag"></i></span>
                                                                        <input type="text" class="form-control"
                                                                            id="code" name="code"
                                                                            value="<%= escapeHtml(codeValue) %>"
                                                                            placeholder="e.g., SAVE20, WELCOME50"
                                                                            required maxlength="20"
                                                                            pattern="[A-Za-z0-9]+"
                                                                            title="Only letters and numbers allowed">
                                                                        <div class="invalid-feedback">
                                                                            Please provide a valid coupon code.
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-text">Only letters and numbers,
                                                                        maximum 20 characters</div>
                                                            </div>

                                                            <!-- Description -->
                                                            <div class="mb-3">
                                                                <label for="description" class="form-label">
                                                                    <i class="bi bi-card-text me-1"></i>Description
                                                                    <span class="required">*</span>
                                                                </label>
                                                                <% String descriptionValue="" ; if (preservedDescription
                                                                    !=null) { descriptionValue=preservedDescription; }
                                                                    else if (couponViewModel !=null) {
                                                                    descriptionValue=couponViewModel.getDescription(); }
                                                                    %>
                                                                    <textarea class="form-control" id="description"
                                                                        name="description" rows="3"
                                                                        placeholder="Describe what this coupon offers..."
                                                                        required><%= escapeHtml(descriptionValue) %></textarea>
                                                                    <div class="invalid-feedback">
                                                                        Please provide a description.
                                                                    </div>
                                                            </div>

                                                            <!-- Discount Type and Amount -->
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <div class="mb-3">
                                                                        <label for="discountType" class="form-label">
                                                                            <i
                                                                                class="bi bi-collection me-1"></i>Discount
                                                                            Type <span class="required">*</span>
                                                                        </label>
                                                                        <% String selectedDiscountType="" ; if
                                                                            (preservedDiscountType !=null) {
                                                                            selectedDiscountType=preservedDiscountType;
                                                                            } else if (couponViewModel !=null) {
                                                                            selectedDiscountType=couponViewModel.getDiscountType();
                                                                            } %>
                                                                            <select class="form-select"
                                                                                id="discountType" name="discountType"
                                                                                required
                                                                                onchange="updateDiscountLabel()">
                                                                                <option value="">Select Type</option>
                                                                                <option value="percentage"
                                                                                    <%="percentage"
                                                                                    .equals(selectedDiscountType)
                                                                                    ? "selected" : "" %>>Percentage (%)
                                                                                </option>
                                                                                <option value="fixed" <%="fixed"
                                                                                    .equals(selectedDiscountType)
                                                                                    ? "selected" : "" %>>Fixed Amount
                                                                                    ($)</option>
                                                                            </select>
                                                                            <div class="invalid-feedback">
                                                                                Please select a discount type.
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="mb-3">
                                                                        <label for="discountAmount" id="discountLabel"
                                                                            class="form-label">
                                                                            <i class="bi bi-percent me-1"></i>Discount
                                                                            Amount <span class="required">*</span>
                                                                        </label>
                                                                        <% String discountAmountValue="" ; if
                                                                            (preservedDiscountAmount !=null) {
                                                                            discountAmountValue=preservedDiscountAmount;
                                                                            } else if (couponViewModel !=null) {
                                                                            discountAmountValue=String.valueOf(couponViewModel.getDiscountAmount());
                                                                            } %>
                                                                            <div class="input-group">
                                                                                <span class="input-group-text"
                                                                                    id="amountSymbol">%</span>
                                                                                <input type="number"
                                                                                    class="form-control"
                                                                                    id="discountAmount"
                                                                                    name="discountAmount"
                                                                                    value="<%= escapeHtml(discountAmountValue) %>"
                                                                                    placeholder="Enter amount" required
                                                                                    step="0.01" min="0.01">
                                                                                <div class="invalid-feedback">
                                                                                    Please provide a valid amount.
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Expiry Date and Usage Limit -->
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <div class="mb-3">
                                                                        <label for="expiryDate" class="form-label">
                                                                            <i class="bi bi-calendar me-1"></i>Expiry
                                                                            Date <span class="required">*</span>
                                                                        </label>
                                                                        <% String expiryDateValue="" ; if
                                                                            (preservedExpiryDate !=null) {
                                                                            expiryDateValue=preservedExpiryDate; } else
                                                                            if (couponViewModel !=null &&
                                                                            couponViewModel.getFormattedExpiryDateForInput()
                                                                            !=null) {
                                                                            expiryDateValue=couponViewModel.getFormattedExpiryDateForInput();
                                                                            } %>
                                                                            <input type="date" class="form-control"
                                                                                id="expiryDate" name="expiryDate"
                                                                                value="<%= escapeHtml(expiryDateValue) %>"
                                                                                required>
                                                                            <div class="invalid-feedback">
                                                                                Please select an expiry date.
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="mb-3">
                                                                        <label for="usageLimit" class="form-label">
                                                                            <i class="bi bi-graph-up me-1"></i>Usage
                                                                            Limit
                                                                        </label>
                                                                        <% String usageLimitValue="" ; if
                                                                            (preservedUsageLimit !=null) {
                                                                            usageLimitValue=preservedUsageLimit; } else
                                                                            if (couponViewModel !=null) {
                                                                            usageLimitValue=String.valueOf(couponViewModel.getUsageLimit());
                                                                            } %>
                                                                            <input type="number" class="form-control"
                                                                                id="usageLimit" name="usageLimit"
                                                                                value="<%= escapeHtml(usageLimitValue) %>"
                                                                                placeholder="0 for unlimited" min="0">
                                                                            <div class="form-text">Enter 0 for unlimited
                                                                                usage</div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Active Status -->
                                                            
                                                                
                                                                     <%
                            boolean isActiveChecked = false;
                            if (preservedIsActive != null) {
                                isActiveChecked = "true".equals(preservedIsActive);
                            } else if (couponViewModel != null) {
                                isActiveChecked = couponViewModel.isActive();
                            } else {
                                isActiveChecked = true; // Default for new coupons
                            }
                        %>
                                                                        <input class="form-check-input" type="checkbox"
                                                                            id="isActive" name="isActive" value="true"
                                                                            <%=isActiveChecked ? "checked" : "" %>>
                                                                        <label class="form-check-label" for="isActive">
                                                                            <i
                                                                                class="bi bi-shield-check me-1"></i>Active
                                                                            Coupon
                                                                        </label>
                                                                        <div class="form-text">Inactive coupons cannot
                                                                            be used by customers</div>
                                                                
                                                            

                                                            <!-- Current Usage (Edit mode only) -->
                                                            <% if (isEdit && couponViewModel !=null) { %>
                                                                <div class="current-usage-card mb-4">
                                                                    <h6><i class="bi bi-info-circle me-1"></i>Current
                                                                        Usage Statistics</h6>
                                                                    <p class="mb-0">
                                                                        Used <span class="fw-bold">
                                                                            <%= couponViewModel.getUsedCount() %>
                                                                        </span> times
                                                                        <% if (couponViewModel.getUsageLimit()> 0) { %>
                                                                            out of <span class="fw-bold">
                                                                                <%= couponViewModel.getUsageLimit() %>
                                                                            </span> allowed
                                                                            <% } else { %>
                                                                                (unlimited usage)
                                                                                <% } %>
                                                                    </p>
                                                                </div>
                                                                <% } %>

                                                                    <!-- Submit Buttons -->
                                                                    <div
                                                                        class="d-grid gap-2 d-md-flex justify-content-md-center">
                                                                        <button type="submit"
                                                                            class="btn btn-primary-custom btn-lg">
                                                                            <i class="bi bi-check-lg me-2"></i>
                                                                            <%= buttonText %>
                                                                        </button>
                                                                        <a href="CouponServlet?action=list"
                                                                            class="btn btn-outline-secondary btn-lg">
                                                                            <i class="bi bi-x-lg me-2"></i>Cancel
                                                                        </a>
                                                                    </div>

                                                                    <!-- Additional Navigation -->
                                                                    <div class="text-center mt-3">
                                                                        <a href="welcome.jsp"
                                                                            class="btn btn-outline-primary me-2">
                                                                            <i class="bi bi-house me-1"></i>Dashboard
                                                                        </a>
                                                                        <a href="javascript:history.back()"
                                                                            class="btn btn-outline-info">
                                                                            <i class="bi bi-arrow-left me-1"></i>Back
                                                                        </a>
                                                                    </div>
                                            
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                    <script>
                        // Update discount label and symbol based on type selection
                        function updateDiscountLabel() {
                            var discountType = document.getElementById('discountType').value;
                            var label = document.getElementById('discountLabel');
                            var input = document.getElementById('discountAmount');
                            var symbol = document.getElementById('amountSymbol');

                            if (discountType === 'percentage') {
                                label.innerHTML = '<i class="bi bi-percent me-1"></i>Discount Percentage (%) <span class="required">*</span>';
                                symbol.innerHTML = '%';
                                input.setAttribute('max', '100');
                                input.setAttribute('placeholder', 'Enter percentage (1-100)');
                            } else if (discountType === 'fixed') {
                                label.innerHTML = '<i class="bi bi-currency-dollar me-1"></i>Discount Amount ($) <span class="required">*</span>';
                                symbol.innerHTML = '$';
                                input.removeAttribute('max');
                                input.setAttribute('placeholder', 'Enter fixed amount');
                            } else {
                                label.innerHTML = '<i class="bi bi-percent me-1"></i>Discount Amount <span class="required">*</span>';
                                symbol.innerHTML = '%';
                                input.removeAttribute('max');
                                input.setAttribute('placeholder', 'Enter amount');
                            }
                        }

                        // Set minimum date to today
                        document.getElementById('expiryDate').min = new Date().toISOString().split('T')[0];

                        // Initialize discount label on page load
                        updateDiscountLabel();

                        // Bootstrap form validation
                        (function () {
                            'use strict';
                            window.addEventListener('load', function () {
                                var forms = document.getElementsByClassName('needs-validation');
                                var validation = Array.prototype.filter.call(forms, function (form) {
                                    form.addEventListener('submit', function (event) {
                                        var discountType = document.getElementById('discountType').value;
                                        var discountAmount = parseFloat(document.getElementById('discountAmount').value);

                                        if (discountType === 'percentage' && discountAmount > 100) {
                                            event.preventDefault();
                                            event.stopPropagation();
                                            alert('Percentage discount cannot exceed 100%');
                                            return false;
                                        }

                                        if (discountAmount <= 0) {
                                            event.preventDefault();
                                            event.stopPropagation();
                                            alert('Discount amount must be greater than 0');
                                            return false;
                                        }

                                        // Check if expiry date is in the past
                                        var expiryDate = new Date(document.getElementById('expiryDate').value);
                                        var today = new Date();
                                        today.setHours(0, 0, 0, 0);

                                        if (expiryDate < today) {
                                            if (!confirm('The expiry date is in the past. Do you want to continue?')) {
                                                event.preventDefault();
                                                event.stopPropagation();
                                                return false;
                                            }
                                        }

                                        if (form.checkValidity() === false) {
                                            event.preventDefault();
                                            event.stopPropagation();
                                        }
                                        form.classList.add('was-validated');
                                    }, false);
                                });
                            }, false);
                        })();
                    </script>
                </body>

                </html>