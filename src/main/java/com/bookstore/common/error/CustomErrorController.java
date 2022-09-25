package com.bookstore.common.error;


import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class CustomErrorController implements ErrorController {

    @GetMapping("/errorPage")
    public String handleError(HttpServletRequest request, Model model) {

        Object status = request.getAttribute("javax.servlet.error.status_code");

        model.addAttribute("status", status);
        model.addAttribute("path", request.getAttribute("javax.servlet.error.request_uri"));
        model.addAttribute("timestamp", new Date());

        Object exceptionObj = request.getAttribute("javax.servlet.error.exception");
        if (exceptionObj != null) {
            Throwable e = ((Exception) exceptionObj).getCause();
            model.addAttribute("exception", e.getClass().getName());
            model.addAttribute("message", e.getMessage());
        }

        return "/error/error";

    }


}
