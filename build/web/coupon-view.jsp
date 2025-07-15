<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="viewModel.couponViewModel" %>
        <%@ page import="java.util.Date" %>
            <% couponViewModel couponViewModel=(couponViewModel) request.getAttribute("couponViewModel"); %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Coupon Details - <%= couponViewModel !=null ? couponViewModel.getCode() : "Unknown" %> -
                            Coupon Management System</title>
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

                        .coupon-card {
                            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                            color: white;
                            border-radius: 15px;
                            padding: 30px;
                            margin-bottom: 30px;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                        }

                        .coupon-code {
                            font-size: 2.5em;
                            font-weight: bold;
                            text-align: center;
                            border: 3px dashed white;
                            padding: 20px;
                            border-radius: 10px;
                            margin: 20px 0;
                            letter-spacing: 3px;
                            background: rgba(255, 255, 255, 0.1);
                            backdrop-filter: blur(10px);
                        }

                        .detail-card {
                            backdrop-filter: blur(10px);
                            background: rgba(255, 255, 255, 0.95);
                            border-radius: 15px;
                            padding: 20px;
                            margin-bottom: 20px;
                            border: none;
                            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                        }

                        .status-valid {
                            border-left: 5px solid #28a745;
                            background: rgba(40, 167, 69, 0.1);
                        }

                        .status-expired {
                            border-left: 5px solid #dc3545;
                            background: rgba(220, 53, 69, 0.1);
                        }

                        .status-inactive {
                            border-left: 5px solid #6c757d;
                            background: rgba(108, 117, 125, 0.1);
                        }

                        .status-limit {
                            border-left: 5px solid #ffc107;
                            background: rgba(255, 193, 7, 0.1);
                        }

                        .progress-usage {
                            height: 25px;
                            border-radius: 15px;
                        }

                        .btn-action {
                            margin: 5px;
                            border-radius: 25px;
                            padding: 10px 25px;
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

                        .coupon-icon {
                            background: linear-gradient(45deg, #ff6b6b, #ee5a24);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            background-clip: text;
                        }

                        .stat-icon {
                            width: 50px;
                            height: 50px;
                            border-radius: 10px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 1.5rem;
                            margin-right: 15px;
                        }

                        .stat-primary {
                            background: rgba(255, 107, 107, 0.1);
                            color: #ff6b6b;
                        }

                        .stat-success {
                            background: rgba(40, 167, 69, 0.1);
                            color: #28a745;
                        }

                        .stat-warning {
                            background: rgba(255, 193, 7, 0.1);
                            color: #ffc107;
                        }

                        .stat-info {
                            background: rgba(13, 202, 240, 0.1);
                            color: #0dcaf0;
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
                        <% if (couponViewModel !=null) { %>
                            <!-- Coupon Card -->
                            <div class="coupon-card">
                                <div class="row align-items-center">
                                    <div class="col-md-8">
                                        <h1><i class="bi bi-ticket-perforated-fill me-2"></i>Coupon Details</h1>
                                        <div class="coupon-code">
                                            <%= couponViewModel.escapeHtml(couponViewModel.getCode()) %>
                                        </div>
                                        <p class="lead mb-0">
                                            <%= couponViewModel.escapeHtml(couponViewModel.getDescription()) %>
                                        </p>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <div class="p-3"
                                            style="background: rgba(255, 255, 255, 0.1); border-radius: 10px; backdrop-filter: blur(10px);">
                                            <% if (couponViewModel.isPercentageDiscount()) { %>
                                                <h2><i class="bi bi-percent me-1"></i>
                                                    <%= couponViewModel.getFormattedDiscount() %>
                                                </h2>
                                                <small>Percentage Discount</small>
                                                <% } else { %>
                                                    <h2><i class="bi bi-currency-dollar me-1"></i>
                                                        <%= couponViewModel.getFormattedDiscount() %>
                                                    </h2>
                                                    <small>Fixed Amount Discount</small>
                                                    <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Status Information -->
                            <div class="detail-card <%= couponViewModel.getStatusCssClass() %>">
                                <h4><i class="bi bi-info-circle me-2"></i>Status Information</h4>
                                <div class="row">
                                    <div class="col-lg-3 col-md-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon stat-primary">
                                                <i class="bi bi-shield-check"></i>
                                            </div>
                                            <div>
                                                <strong>Current Status</strong><br>
                                                <span class="badge <%= couponViewModel.getStatusBadgeClass() %>">
                                                    <%= couponViewModel.getStatusText() %>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon stat-warning">
                                                <i class="bi bi-calendar-x"></i>
                                            </div>
                                            <div>
                                                <strong>Expiry Date</strong><br>
                                                <%= couponViewModel.getFormattedExpiryDate() %>
                                                    <% if (couponViewModel.isExpired()) { %>
                                                        <br><small class="text-danger">Expired</small>
                                                        <% } %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon stat-info">
                                                <i class="bi bi-calendar-plus"></i>
                                            </div>
                                            <div>
                                                <strong>Created</strong><br>
                                                <%= couponViewModel.getFormattedCreatedDate() %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-3">
                                        <div class="d-flex align-items-center">
                                            <div class="stat-icon stat-success">
                                                <i class="bi bi-clock"></i>
                                            </div>
                                            <div>
                                                <strong>Time Remaining</strong><br>
                                                <span class="<%= couponViewModel.getTimeRemainingCssClass() %>">
                                                    <%= couponViewModel.getTimeRemainingText() %>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Usage Information -->
                            <div class="detail-card">
                                <h4><i class="bi bi-bar-chart me-2"></i>Usage Analytics</h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <strong><i class="bi bi-graph-up me-1"></i>Times Used:</strong>
                                            <span class="fs-5 text-primary fw-bold ms-2">
                                                <%= couponViewModel.getFormattedUsage() %>
                                            </span>
                                        </div>

                                        <!-- Usage Progress Bar -->
                                        <% if (couponViewModel.getUsageLimit()> 0) { %>
                                            <div class="mb-3">
                                                <label class="form-label small text-muted">Usage Progress</label>
                                                <div class="progress progress-usage">
                                                    <div class="progress-bar <%= couponViewModel.getProgressBarClass() %>"
                                                        role="progressbar"
                                                        style="width: <%= Math.min(couponViewModel.getUsagePercentage(), 100) %>%;"
                                                        aria-valuenow="<%= couponViewModel.getUsagePercentage() %>"
                                                        aria-valuemin="0" aria-valuemax="100">
                                                        <%= couponViewModel.getFormattedUsagePercentage() %>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } %>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <strong><i class="bi bi-speedometer me-1"></i>Usage Limit:</strong>
                                            <span class="fs-5 text-success fw-bold ms-2">
                                                <%= couponViewModel.getUsageLimitDisplayText() %>
                                            </span>
                                            <% if (couponViewModel.isUsageLimitReached()) { %>
                                                <br><small class="text-danger"><i
                                                        class="bi bi-exclamation-triangle me-1"></i>Limit
                                                    reached!</small>
                                                <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Validation Result -->
                            <div class="detail-card">
                                <h4><i class="bi bi-shield-check me-2"></i>Validation Status</h4>
                                <div class="alert <%= couponViewModel.getValidationAlertClass() %>" role="alert">
                                    <% if (couponViewModel.isValid()) { %>
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-check-circle-fill fs-3 me-3 text-success"></i>
                                            <div>
                                                <h5 class="alert-heading mb-2">✅ This coupon is VALID and ready to use!
                                                </h5>
                                                <ul class="mb-0">
                                                    <li><i class="bi bi-check me-1"></i>Coupon is active</li>
                                                    <li><i class="bi bi-check me-1"></i>Not expired</li>
                                                    <% if (couponViewModel.getUsageLimit()> 0) { %>
                                                        <li><i class="bi bi-check me-1"></i>Usage limit not reached (<%=
                                                                couponViewModel.getFormattedRemainingUsage() %> uses
                                                                remaining)</li>
                                                        <% } else { %>
                                                            <li><i class="bi bi-check me-1"></i>Unlimited usage
                                                                available</li>
                                                            <% } %>
                                                </ul>
                                            </div>
                                        </div>
                                        <% } else { %>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-x-circle-fill fs-3 me-3 text-danger"></i>
                                                <div>
                                                    <h5 class="alert-heading mb-2">❌ This coupon is INVALID and cannot
                                                        be used!</h5>
                                                    <ul class="mb-0">
                                                        <% if (!couponViewModel.isActive()) { %>
                                                            <li><i class="bi bi-x me-1"></i>Coupon is inactive</li>
                                                            <% } %>
                                                                <% if (couponViewModel.isExpired()) { %>
                                                                    <li><i class="bi bi-x me-1"></i>Coupon has expired
                                                                    </li>
                                                                    <% } %>
                                                                        <% if (couponViewModel.isUsageLimitReached()) {
                                                                            %>
                                                                            <li><i class="bi bi-x me-1"></i>Usage limit
                                                                                has been reached</li>
                                                                            <% } %>
                                                    </ul>
                                                </div>
                                            </div>
                                            <% } %>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="text-center">
                                <div class="d-flex flex-wrap justify-content-center gap-2">
                                    <a href="CouponServlet?action=edit&id=<%= couponViewModel.getId() %>"
                                        class="btn btn-primary-custom btn-action">
                                        <i class="bi bi-pencil me-1"></i>Edit Coupon
                                    </a>
                                    <a href="CouponServlet?action=list" class="btn btn-outline-secondary btn-action">
                                        <i class="bi bi-list me-1"></i>Back to List
                                    </a>
                                    <a href="welcome.jsp" class="btn btn-outline-primary btn-action">
                                        <i class="bi bi-house me-1"></i>Dashboard
                                    </a>
                                    <a href="javascript:history.back()" class="btn btn-outline-info btn-action">
                                        <i class="bi bi-arrow-left me-1"></i>Previous Page
                                    </a>
                                    <a href="CouponServlet?action=delete&id=<%= couponViewModel.getId() %>"
                                        class="btn btn-outline-danger btn-action"
                                        onclick="return confirm('Are you sure you want to delete this coupon?')">
                                        <i class="bi bi-trash me-1"></i>Delete Coupon
                                    </a>
                                </div>
                            </div>

                            <% } else { %>
                                <!-- Error: Coupon not found -->
                                <div class="detail-card text-center">
                                    <div class="py-5">
                                        <i class="bi bi-exclamation-triangle-fill text-danger"
                                            style="font-size: 4rem;"></i>
                                        <h4 class="mt-3">Coupon Not Found</h4>
                                        <p class="text-muted">The requested coupon could not be found or an error
                                            occurred while loading it.</p>
                                        <a href="CouponServlet?action=list" class="btn btn-primary-custom">
                                            <i class="bi bi-list me-1"></i>Back to Coupon List
                                        </a>
                                    </div>
                                </div>
                                <% } %>
                    </div>

                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>