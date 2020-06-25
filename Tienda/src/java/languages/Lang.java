/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package languages;

import java.util.Locale;
import javax.servlet.http.Cookie;

/**
 *
 * @author Miguel
 */
public class Lang {
    
    public static Locale getLocale(Cookie cookies[]){
        if(isEnglish(cookies)){
            return Locale.ENGLISH;
        }
        return new Locale("es");
    }

    public static boolean isEnglish(Cookie cookies[]) {
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equalsIgnoreCase("en") && c.getValue().equals("1")) {
                    return true;
                }
            }
        }
        return false;
    }

    public static Cookie setEnglish() {
        Cookie c = new Cookie("en", "1");
        c.setMaxAge(60 * 60 * 24 * 7);
        return c;
    }

    public static Cookie setSpanish() {
        Cookie c = new Cookie("en", "0");
        c.setMaxAge(0);
        return c;
    }
}
