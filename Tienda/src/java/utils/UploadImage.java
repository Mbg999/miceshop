/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.Article;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.GregorianCalendar;
import javax.servlet.http.Part;

/**
 *
 * @author IES TRASSIERRA
 */
public class UploadImage {

    public static String uploadImage(Part img, Article article, String context) throws IOException, SQLException {
        Part file = img;
        if (file == null || file.getSubmittedFileName().equals("")) { // IMG UPLOAD
            return null;
        } else {
            String fileName = file.getSubmittedFileName();
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String validExtensions[] = {".png", ".jpg", ".gif", ".webp"};
            if (!MyUtils.search(validExtensions, extension)) {
                return null;
            } else {
                // VALID EXTENSION
                boolean ok = true;
                OutputStream out = null;
                InputStream filecontent = null;
                File f;
                String path = null;
                try {
                    f = new File(fileName);
                    path = f.getAbsolutePath();
                    out = new FileOutputStream(f);
                    filecontent = file.getInputStream();

                    int read = 0;
                    final byte[] bytes = new byte[1024];

                    while ((read = filecontent.read(bytes)) != -1) {
                        out.write(bytes, 0, read);
                    }

                } catch (FileNotFoundException fne) {
                    ok = false;

                } finally {
                    if (out != null) {
                        out.close();
                    }
                    if (filecontent != null) {
                        filecontent.close();
                    }
                }
                if (ok) {
                    fileName = String.valueOf(new GregorianCalendar().getTimeInMillis()); // avoid browser cache
                    Files.move(Paths.get(path), Paths.get(context + File.separator + fileName + extension)); //, StandardCopyOption.REPLACE_EXISTING);
                    // solo se  guarda el nombre de la imagen y su extensión, para que no se repitan los datos del path en la bdd y así ahorrar espacio, además de la independencia de path
                    article.setNewPath_imagen(fileName, extension, context);
                } else {
                    return null;
                }

                return fileName+extension;
            }
        }
    }
}
