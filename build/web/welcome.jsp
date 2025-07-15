<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Coupon Management System</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <style>
            body {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                min-height: 100vh;
            }

            .dashboard-card {
                backdrop-filter: blur(10px);
                background: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                border: none;
            }

            .action-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                cursor: pointer;
                border: none;
                background: white;
            }

            .action-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
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

            .btn-outline-custom {
                border: 2px solid #ff6b6b;
                color: #ff6b6b;
                background: transparent;
            }

            .btn-outline-custom:hover {
                background: #ff6b6b;
                color: white;
                border-color: #ff6b6b;
            }

            .coupon-icon {
                background: linear-gradient(45deg, #ff6b6b, #ee5a24);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .stats-card {
                background: white;
                border-radius: 10px;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
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
                    <a href="LogoutServlet" class="btn btn-outline-light">
                        <i class="bi bi-box-arrow-right me-1"></i>Sign Out
                    </a>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container py-5">
            <!-- Welcome Header -->
            <div class="row mb-5">
                <div class="col-12">
                    <div class="dashboard-card p-5 text-center">
                        <i class="bi bi-ticket-perforated-fill coupon-icon" style="font-size: 4rem;"></i>
                        <h1 class="fw-bold mt-3 mb-2">Welcome to Your Dashboard</h1>
                        <p class="lead text-muted">Manage your coupon campaigns and track performance</p>
                    </div>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="row mb-5">
                <div class="col-md-3 mb-3">
                    <div class="stats-card">
                        <i class="bi bi-ticket text-primary" style="font-size: 2rem;"></i>
                        <h4 class="mt-2 mb-1">Total Coupons</h4>
                        <h2 class="text-primary mb-0">--</h2>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card">
                        <i class="bi bi-graph-up text-success" style="font-size: 2rem;"></i>
                        <h4 class="mt-2 mb-1">Active Campaigns</h4>
                        <h2 class="text-success mb-0">--</h2>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card">
                        <i class="bi bi-people text-info" style="font-size: 2rem;"></i>
                        <h4 class="mt-2 mb-1">Total Redeemed</h4>
                        <h2 class="text-info mb-0">--</h2>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card">
                        <i class="bi bi-currency-dollar text-warning" style="font-size: 2rem;"></i>
                        <h4 class="mt-2 mb-1">Savings Given</h4>
                        <h2 class="text-warning mb-0">$--</h2>
                    </div>
                </div>
            </div>

            <!-- Main Actions -->
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="action-card dashboard-card p-4 h-100"
                        onclick="window.location.href='CouponServlet?action=list'">
                        <div class="text-center">
                            <i class="bi bi-list-ul" style="font-size: 3rem; color: #667eea;"></i>
                            <h3 class="mt-3 mb-3">View All Coupons</h3>
                            <p class="text-muted mb-4">Browse, edit, and manage your existing coupon campaigns</p>
                            <div class="btn btn-outline-custom btn-lg">
                                <i class="bi bi-eye me-2"></i>View Coupons
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="action-card dashboard-card p-4 h-100"
                        onclick="window.location.href='CouponServlet?action=new'">
                        <div class="text-center">
                            <i class="bi bi-plus-circle" style="font-size: 3rem; color: #28a745;"></i>
                            <h3 class="mt-3 mb-3">Create New Coupon</h3>
                            <p class="text-muted mb-4">Design and launch a new coupon campaign for your business</p>
                            <div class="btn btn-primary-custom btn-lg">
                                <i class="bi bi-plus me-2"></i>Create Coupon
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Additional Features -->
            <div class="row mt-4">
                <div class="col-md-4 mb-3">
                    <div class="action-card dashboard-card p-3 text-center h-100">
                        <i class="bi bi-bar-chart text-primary" style="font-size: 2rem;"></i>
                        <h5 class="mt-2">Analytics</h5>
                        <p class="text-muted small">View performance metrics</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="action-card dashboard-card p-3 text-center h-100">
                        <i class="bi bi-gear text-secondary" style="font-size: 2rem;"></i>
                        <h5 class="mt-2">Settings</h5>
                        <p class="text-muted small">Configure your account</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="action-card dashboard-card p-3 text-center h-100">
                        <i class="bi bi-question-circle text-info" style="font-size: 2rem;"></i>
                        <h5 class="mt-2">Help</h5>
                        <p class="text-muted small">Get support and guides</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>