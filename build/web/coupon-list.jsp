<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="viewModel.couponViewModel" %>
        <%@ page import="java.util.List" %>
            <% // Fix: Remove the @SuppressWarnings annotation and use proper JSP syntax @SuppressWarnings("unchecked")
                List<couponViewModel> couponViewModels = (List<couponViewModel>)
                    request.getAttribute("couponViewModels");
                    Boolean isEmpty = (Boolean) request.getAttribute("isEmpty");
                    String message = (String) session.getAttribute("message");
                    String error = (String) session.getAttribute("error");
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Coupon List - Coupon Management System</title>
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

                            .main-card {
                                backdrop-filter: blur(10px);
                                background: rgba(255, 255, 255, 0.95);
                                border-radius: 15px;
                                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                                border: none;
                            }

                            .table-container {
                                background: white;
                                border-radius: 10px;
                                overflow: hidden;
                                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                            }

                            .expired {
                                background-color: #f8d7da;
                            }

                            .inactive {
                                background-color: #d1ecf1;
                            }

                            .limit-reached {
                                background-color: #fff3cd;
                            }

                            .valid {
                                background-color: #d4edda;
                            }

                            .status-badge {
                                font-size: 0.8em;
                                padding: 4px 8px;
                                border-radius: 12px;
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

                            .action-buttons {
                                background: rgba(255, 255, 255, 0.9);
                                border-radius: 10px;
                                padding: 1rem;
                                margin-bottom: 1.5rem;
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
                                    <a href="welcome.jsp" class="nav-link">
                                        <i class="bi bi-house me-1"></i>Dashboard
                                    </a>
                                    <a href="LogoutServlet" class="nav-link">
                                        <i class="bi bi-box-arrow-right me-1"></i>Sign Out
                                    </a>
                                </div>
                            </div>
                        </nav>

                        <div class="container py-4">
                            <div class="main-card p-4">
                                <!-- Header -->
                                <div class="text-center mb-4">
                                    <i class="bi bi-ticket-perforated-fill coupon-icon" style="font-size: 3rem;"></i>
                                    <h2 class="fw-bold mt-3 mb-2">Coupon Management</h2>
                                    <p class="text-muted">Manage all your coupon campaigns</p>
                                </div>

                                <!-- Success/Error Messages -->
                                <% if (message !=null) { %>
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="bi bi-check-circle me-2"></i>
                                        <%= message %>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                    <% session.removeAttribute("message"); %>
                                        <% } %>

                                            <% if (error !=null) { %>
                                                <div class="alert alert-danger alert-dismissible fade show"
                                                    role="alert">
                                                    <i class="bi bi-exclamation-triangle me-2"></i>
                                                    <%= error %>
                                                        <button type="button" class="btn-close"
                                                            data-bs-dismiss="alert"></button>
                                                </div>
                                                <% session.removeAttribute("error"); %>
                                                    <% } %>

                                                        <!-- Action Buttons -->
                                                        <div class="action-buttons">
                                                            <div class="d-flex flex-wrap gap-2">
                                                                <a href="CouponServlet?action=new"
                                                                    class="btn btn-primary-custom">
                                                                    <i class="bi bi-plus-lg me-1"></i> Add New Coupon
                                                                </a>
                                                                <a href="welcome.jsp" class="btn btn-outline-primary">
                                                                    <i class="bi bi-house me-1"></i> Dashboard
                                                                </a>
                                                                <a href="javascript:history.back()"
                                                                    class="btn btn-outline-secondary">
                                                                    <i class="bi bi-arrow-left me-1"></i> Back
                                                                </a>
                                                            </div>
                                                        </div>

                                                        <!-- Coupons Table -->
                                                        <div class="table-container">
                                                            <div class="table-responsive">
                                                                <table class="table table-hover mb-0">
                                                                    <thead class="table-dark">
                                                                        <tr>
                                                                            <th><i class="bi bi-hash me-1"></i>ID</th>
                                                                            <th><i class="bi bi-tag me-1"></i>Code</th>
                                                                            <th><i
                                                                                    class="bi bi-card-text me-1"></i>Description
                                                                            </th>
                                                                            <th><i
                                                                                    class="bi bi-percent me-1"></i>Discount
                                                                            </th>
                                                                            <th><i
                                                                                    class="bi bi-collection me-1"></i>Type
                                                                            </th>
                                                                            <th><i
                                                                                    class="bi bi-calendar me-1"></i>Expiry
                                                                                Date</th>
                                                                            <th><i class="bi bi-graph-up me-1"></i>Usage
                                                                            </th>
                                                                            <th><i
                                                                                    class="bi bi-shield-check me-1"></i>Status
                                                                            </th>
                                                                            <th><i class="bi bi-gear me-1"></i>Actions
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <% if (couponViewModels !=null &&
                                                                            !couponViewModels.isEmpty()) { %>
                                                                            <% for (couponViewModel couponViewModel :
                                                                                couponViewModels) { %>
                                                                                <tr
                                                                                    class="<%= couponViewModel.getStatusCssClass() %>">
                                                                                    <td>
                                                                                        <%= couponViewModel.getId() %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <span
                                                                                            class="fw-bold text-primary">
                                                                                            <%= couponViewModel.escapeHtml(couponViewModel.getCode())
                                                                                                %>
                                                                                        </span>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%= couponViewModel.escapeHtml(couponViewModel.getDescription())
                                                                                            %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <span class="fw-bold">
                                                                                            <%= couponViewModel.getFormattedDiscount()
                                                                                                %>
                                                                                        </span>
                                                                                    </td>
                                                                                    <td>
                                                                                        <span
                                                                                            class="badge bg-secondary">
                                                                                            <%= couponViewModel.getDiscountTypeDisplayText()
                                                                                                %>
                                                                                        </span>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%= couponViewModel.getFormattedExpiryDate()
                                                                                            %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%= couponViewModel.getFormattedUsage()
                                                                                            %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <span
                                                                                            class="badge <%= couponViewModel.getStatusBadgeClass() %> status-badge">
                                                                                            <%= couponViewModel.getStatusText()
                                                                                                %>
                                                                                        </span>
                                                                                    </td>
                                                                                    <td>
                                                                                        <div class="btn-group"
                                                                                            role="group">
                                                                                            <a href="CouponServlet?action=view&id=<%= couponViewModel.getId() %>"
                                                                                                class="btn btn-outline-info btn-sm">
                                                                                                <i
                                                                                                    class="bi bi-eye"></i>
                                                                                            </a>
                                                                                            <a href="CouponServlet?action=edit&id=<%= couponViewModel.getId() %>"
                                                                                                class="btn btn-outline-primary btn-sm">
                                                                                                <i
                                                                                                    class="bi bi-pencil"></i>
                                                                                            </a>
                                                                                            <a href="CouponServlet?action=delete&id=<%= couponViewModel.getId() %>"
                                                                                                class="btn btn-outline-danger btn-sm"
                                                                                                onclick="return confirm('Are you sure you want to delete this coupon?')">
                                                                                                <i
                                                                                                    class="bi bi-trash"></i>
                                                                                            </a>
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                                <% } %>
                                                                                    <% } else { %>
                                                                                        <tr>
                                                                                            <td colspan="9"
                                                                                                class="text-center py-5">
                                                                                                <i class="bi bi-inbox"
                                                                                                    style="font-size: 3rem; color: #6c757d;"></i>
                                                                                                <h5
                                                                                                    class="mt-3 text-muted">
                                                                                                    No coupons found
                                                                                                </h5>
                                                                                                <p class="text-muted">
                                                                                                    Get started by
                                                                                                    creating your first
                                                                                                    coupon</p>
                                                                                                <a href="CouponServlet?action=new"
                                                                                                    class="btn btn-primary-custom">
                                                                                                    <i
                                                                                                        class="bi bi-plus-lg me-1"></i>Create
                                                                                                    Your First Coupon
                                                                                                </a>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>

                                                        <!-- Legend -->
                                                        <div class="mt-4 p-3"
                                                            style="background: rgba(248, 249, 250, 0.8); border-radius: 8px;">
                                                            <small class="text-muted">
                                                                <strong><i class="bi bi-info-circle me-1"></i>Status
                                                                    Legend:</strong>
                                                                <span class="badge bg-success ms-2">Valid</span>
                                                                <span class="badge bg-danger ms-1">Expired</span>
                                                                <span class="badge bg-warning text-dark ms-1">Limit
                                                                    Reached</span>
                                                                <span class="badge bg-secondary ms-1">Inactive</span>
                                                            </small>
                                                        </div>
                            </div>
                        </div>

                        <!-- Bootstrap JS -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    </body>

                    </html>