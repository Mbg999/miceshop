/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author Miguel
 */
public class MyUtils {

    public static String getParamValue(String param) {
        if (param != null && !param.trim().equals("")) {
            return filter(param.trim());
        }
        return null;
    }

    public static String filter(String input) {
        if (!hasSpecialChars(input)) {
            return (input);
        }
        StringBuilder filtered = new StringBuilder(input.length());
        char c;
        for (int i = 0; i < input.length(); i++) {
            c = input.charAt(i);
            switch (c) {
                case '<':
                    filtered.append("&lt;");
                    break;
                case '>':
                    filtered.append("&gt;");
                    break;
                case '"':
                    filtered.append("&quot;");
                    break;
                case '&':
                    filtered.append("&amp;");
                    break;
                default:
                    filtered.append(c);
            }
        }
        return (filtered.toString());
    }

    private static boolean hasSpecialChars(String input) {
        boolean flag = false;
        if ((input != null) && (input.length() > 0)) {
            char c;
            for (int i = 0; i < input.length(); i++) {
                c = input.charAt(i);
                switch (c) {
                    case '<':
                        flag = true;
                        break;
                    case '>':
                        flag = true;
                        break;
                    case '"':
                        flag = true;
                        break;
                    case '&':
                        flag = true;
                        break;
                }
            }
        }
        return (flag);
    }

    public static boolean validateDNI(String DNI) {
        if (DNI.length() != 9) {
            return false;
        }
        String letras = "TRWAGMYFPDXBNJZSQVHLCKE"; // el DNI llega parseado a mayúscula
        char letra = DNI.charAt(8);
        String numeros = DNI.substring(0, 8);
        if (!isNumber(numeros)) {
            return false;
        }
        if (letras.charAt(Integer.parseInt(numeros) % 23) != letra) {
            return false;
        }
        return true;
    }

    public static boolean isValidDate(String date) {
        return true;
    }

    public static boolean isNumber(String n) {
        try {
            int x = Integer.parseInt(n);
            if (x < 0) {
                return false;
            }
            return true;
        } catch (NumberFormatException ex) {
            return false;
        }
    }

    public static boolean search(String[] array, String search) {
        for (String a : array) {
            if (a.equalsIgnoreCase(search)) {
                return true;
            }
        }
        return false;
    }

    public static String getImg(String img) {
        String url = "/Tienda/imgs/";
        if (img == null || img.equals("")) {
            url += "noimg.jpg";
        } else {
            url += img;
        }
        return url;
    }
}
