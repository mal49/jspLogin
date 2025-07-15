import bean.coupon;
import service.couponService;
import viewModel.couponViewModel;
import util.dateFormatter;
import util.numberFormatter;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class couponServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private couponService couponService;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            System.out.println("Initializing CouponServlet...");
            couponService = new couponService();
            System.out.println("CouponService initialized successfully.");

            // Test database connection
            System.out.println("Testing database connection...");
            couponService.testDatabaseConnection();
            System.out.println("Database connection test completed.");

        } catch (Exception e) {
            System.err.println("Failed to initialize CouponService: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Failed to initialize CouponService", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Default action is list if no action parameter is provided
        if (action == null) {
            action = "list";
        }

        System.out.println("CouponServlet: Processing action = " + action);

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertCoupon(request, response);
                    break;
                case "delete":
                    deleteCoupon(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateCoupon(request, response);
                    break;
                case "view":
                    viewCoupon(request, response);
                    break;
                case "list":
                default:
                    listCoupons(request, response);
                    break;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Exception in CouponServlet: " + ex.getMessage());
            ex.printStackTrace();
            throw new ServletException(ex);
        } catch (Exception ex) {
            System.err.println("Unexpected Exception in CouponServlet: " + ex.getMessage());
            ex.printStackTrace();
            throw new ServletException(ex);
        }
    }

    private void listCoupons(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            System.out.println("CouponServlet: Starting listCoupons method");

            // Check if service is initialized
            if (couponService == null) {
                System.err.println("CouponService is null!");
                request.setAttribute("error", "Coupon service is not initialized. Please contact administrator.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-list.jsp");
                dispatcher.forward(request, response);
                return;
            }

            System.out.println("CouponServlet: Getting all coupons from service");
            List<coupon> coupons = couponService.getAllCoupons();
            System.out.println("CouponServlet: Retrieved " + (coupons != null ? coupons.size() : 0) + " coupons");

            List<couponViewModel> couponViewModels = new ArrayList<>();

            if (coupons != null) {
                System.out.println("CouponServlet: Creating view models");
                for (coupon coupon : coupons) {
                    if (coupon != null) {
                        try {
                            couponViewModels.add(new couponViewModel(coupon, couponService));
                        } catch (Exception e) {
                            System.err.println("Error creating view model for coupon ID " + coupon.getId() + ": "
                                    + e.getMessage());
                            e.printStackTrace();
                        }
                    }
                }
                System.out.println("CouponServlet: Created " + couponViewModels.size() + " view models");
            }

            request.setAttribute("couponViewModels", couponViewModels);
            request.setAttribute("isEmpty", couponViewModels.isEmpty());

            System.out.println("CouponServlet: Forwarding to coupon-list.jsp");
            RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-list.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            System.err.println("SQL Exception in listCoupons: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.setAttribute("couponViewModels", new ArrayList<couponViewModel>());
            request.setAttribute("isEmpty", true);
            RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.err.println("Unexpected Exception in listCoupons: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error loading coupons: " + e.getMessage());
            request.setAttribute("couponViewModels", new ArrayList<couponViewModel>());
            request.setAttribute("isEmpty", true);
            RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-list.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("isEdit", false);
        request.setAttribute("formTitle", "Add New Coupon");
        request.setAttribute("formAction", "CouponServlet");
        request.setAttribute("formActionType", "insert");
        request.setAttribute("buttonText", "Create Coupon");

        RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            coupon coupon = couponService.getCouponById(id);

            if (coupon != null) {
                couponViewModel couponViewModel = new couponViewModel(coupon, couponService);
                request.setAttribute("couponViewModel", couponViewModel);
                request.setAttribute("isEdit", true);
                request.setAttribute("formTitle", "Edit Coupon");
                request.setAttribute("formAction", "CouponServlet");
                request.setAttribute("formActionType", "update");
                request.setAttribute("buttonText", "Update Coupon");

                RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-form.jsp");
                dispatcher.forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Coupon not found");
                response.sendRedirect("CouponServlet?action=list");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid coupon ID");
            response.sendRedirect("CouponServlet?action=list");
        }
    }

    private void insertCoupon(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            System.out.println("=== Starting coupon creation ===");
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            System.out.println("Code: " + code + ", Description: " + description);

            // Check for null parameters early
            if (code == null || code.trim().isEmpty()) {
                throw new IllegalArgumentException("Coupon code is required and cannot be empty");
            }
            if (description == null || description.trim().isEmpty()) {
                throw new IllegalArgumentException("Coupon description is required and cannot be empty");
            }

            // Use simpler parsing with fallbacks
            double discountAmount = 0;
            try {
                String discountStr = request.getParameter("discountAmount");
                if (discountStr != null && !discountStr.trim().isEmpty()) {
                    discountAmount = Double.parseDouble(discountStr);
                }
            } catch (NumberFormatException e) {
                discountAmount = 0;
            }

            String discountType = request.getParameter("discountType");
            String expiryDateStr = request.getParameter("expiryDate");
            System.out.println("DiscountType: " + discountType + ", ExpiryDateStr: " + expiryDateStr);

            // Check for null discount type
            if (discountType == null || discountType.trim().isEmpty()) {
                throw new IllegalArgumentException("Discount type is required");
            }

            int usageLimit = 0;
            try {
                String usageLimitStr = request.getParameter("usageLimit");
                if (usageLimitStr != null && !usageLimitStr.trim().isEmpty()) {
                    usageLimit = Integer.parseInt(usageLimitStr);
                }
            } catch (NumberFormatException e) {
                usageLimit = 0;
            }

            boolean isActive = "true".equals(request.getParameter("isActive"));

            // Simple date parsing
            Date expiryDate = null;
            if (expiryDateStr != null && !expiryDateStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    expiryDate = sdf.parse(expiryDateStr);
                } catch (ParseException e) {
                    // Try another format
                    try {
                        SimpleDateFormat sdf2 = new SimpleDateFormat("MM/dd/yyyy");
                        expiryDate = sdf2.parse(expiryDateStr);
                    } catch (ParseException e2) {
                        expiryDate = new Date(); // Default to today
                    }
                }
            } else {
                expiryDate = new Date(); // Default to today
            }

            System.out.println("Creating coupon with values - Code: " + code + ", DiscountType: " + discountType +
                    ", DiscountAmount: " + discountAmount + ", UsageLimit: " + usageLimit + ", IsActive: " + isActive);

            coupon newCoupon = new coupon(code, description, discountAmount, discountType, expiryDate, usageLimit);
            newCoupon.setActive(isActive);
            System.out.println("Coupon object created: " + newCoupon.toString());

            System.out.println("Calling coupon service to create coupon...");
            if (couponService == null) {
                throw new IllegalStateException("Coupon service is not initialized");
            }
            couponService.createCoupon(newCoupon);
            System.out.println("Coupon created successfully!");
            request.getSession().setAttribute("message", "Coupon created successfully!");

        } catch (Exception e) {
            e.printStackTrace(); // This will help debug
            String errorMessage = e.getMessage();
            if (errorMessage == null || errorMessage.trim().isEmpty()) {
                errorMessage = "An unexpected error occurred: " + e.getClass().getSimpleName();
            }
            request.setAttribute("error", "Error creating coupon: " + errorMessage);
            request.setAttribute("isEdit", false);
            request.setAttribute("formTitle", "Add New Coupon");
            request.setAttribute("formAction", "CouponServlet");
            request.setAttribute("formActionType", "insert");
            request.setAttribute("buttonText", "Create Coupon");

            // Preserve form data
            preserveFormData(request);

            RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-form.jsp");
            dispatcher.forward(request, response);
            return;
        }

        response.sendRedirect("CouponServlet?action=list");
    }

    private void updateCoupon(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String code = request.getParameter("code");
            String description = request.getParameter("description");

            // Use simpler parsing with fallbacks
            double discountAmount = 0;
            try {
                String discountStr = request.getParameter("discountAmount");
                if (discountStr != null && !discountStr.trim().isEmpty()) {
                    discountAmount = Double.parseDouble(discountStr);
                }
            } catch (NumberFormatException e) {
                discountAmount = 0;
            }

            String discountType = request.getParameter("discountType");
            String expiryDateStr = request.getParameter("expiryDate");

            int usageLimit = 0;
            try {
                String usageLimitStr = request.getParameter("usageLimit");
                if (usageLimitStr != null && !usageLimitStr.trim().isEmpty()) {
                    usageLimit = Integer.parseInt(usageLimitStr);
                }
            } catch (NumberFormatException e) {
                usageLimit = 0;
            }

            boolean isActive = "true".equals(request.getParameter("isActive"));

            // Simple date parsing
            Date expiryDate = null;
            if (expiryDateStr != null && !expiryDateStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    expiryDate = sdf.parse(expiryDateStr);
                } catch (ParseException e) {
                    try {
                        SimpleDateFormat sdf2 = new SimpleDateFormat("MM/dd/yyyy");
                        expiryDate = sdf2.parse(expiryDateStr);
                    } catch (ParseException e2) {
                        expiryDate = new Date();
                    }
                }
            } else {
                expiryDate = new Date();
            }

            coupon coupon = new coupon(code, description, discountAmount, discountType, expiryDate, usageLimit);
            coupon.setId(id);
            coupon.setActive(isActive);

            // Get existing coupon to preserve created date and used count
            coupon existingCoupon = couponService.getCouponById(id);
            if (existingCoupon != null) {
                coupon.setCreatedAt(existingCoupon.getCreatedAt());
                coupon.setUsedCount(existingCoupon.getUsedCount());
            }

            couponService.updateCoupon(coupon);
            request.getSession().setAttribute("message", "Coupon updated successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage();
            if (errorMessage == null || errorMessage.trim().isEmpty()) {
                errorMessage = "An unexpected error occurred: " + e.getClass().getSimpleName();
            }
            request.setAttribute("error", "Error updating coupon: " + errorMessage);

            // Try to load existing coupon for the form
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                coupon coupon = couponService.getCouponById(id);
                if (coupon != null) {
                    couponViewModel couponViewModel = new couponViewModel(coupon, couponService);
                    request.setAttribute("couponViewModel", couponViewModel);
                }
            } catch (Exception ex) {
                // Ignore if we can't load the existing coupon
            }

            request.setAttribute("isEdit", true);
            request.setAttribute("formTitle", "Edit Coupon");
            request.setAttribute("formAction", "CouponServlet");
            request.setAttribute("formActionType", "update");
            request.setAttribute("buttonText", "Update Coupon");

            // Preserve form data
            preserveFormData(request);

            RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-form.jsp");
            dispatcher.forward(request, response);
            return;
        }

        response.sendRedirect("CouponServlet?action=list");
    }

    private void deleteCoupon(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            couponService.deleteCoupon(id);
            request.getSession().setAttribute("message", "Coupon deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage();
            if (errorMessage == null || errorMessage.trim().isEmpty()) {
                errorMessage = "An unexpected error occurred: " + e.getClass().getSimpleName();
            }
            request.getSession().setAttribute("error", "Error deleting coupon: " + errorMessage);
        }
        response.sendRedirect("CouponServlet?action=list");
    }

    private void viewCoupon(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            coupon coupon = couponService.getCouponById(id);

            if (coupon != null) {
                couponViewModel couponViewModel = new couponViewModel(coupon, couponService);
                request.setAttribute("couponViewModel", couponViewModel);

                RequestDispatcher dispatcher = request.getRequestDispatcher("coupon-view.jsp");
                dispatcher.forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Coupon not found");
                response.sendRedirect("CouponServlet?action=list");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid coupon ID");
            response.sendRedirect("CouponServlet?action=list");
        }
    }

    private void preserveFormData(HttpServletRequest request) {
        request.setAttribute("preservedCode", request.getParameter("code"));
        request.setAttribute("preservedDescription", request.getParameter("description"));
        request.setAttribute("preservedDiscountAmount", request.getParameter("discountAmount"));
        request.setAttribute("preservedDiscountType", request.getParameter("discountType"));
        request.setAttribute("preservedExpiryDate", request.getParameter("expiryDate"));
        request.setAttribute("preservedUsageLimit", request.getParameter("usageLimit"));
        request.setAttribute("preservedIsActive", request.getParameter("isActive"));
    }
}