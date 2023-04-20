package com.kh.cinetalk.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.kh.cinetalk.review.model.vo.Movie;

public class MovieInfo {
   
   public static Movie getMovieInfo(int movieId) {
      Movie m = new Movie();
      String apiURL = "https://api.themoviedb.org/3/movie/" + movieId + "?api_key=71c29f7f34f0823c338ede88ca814164&language=ko";
      String apiURL2 = "https://api.themoviedb.org/3/movie/"+ movieId + "/credits?api_key=71c29f7f34f0823c338ede88ca814164&language=ko";

      String result = "";
      String result2 = "";
      try {
         URL url = new URL(apiURL);
         URL url2 = new URL(apiURL2);

         BufferedReader bf;
         BufferedReader bf2;
         bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
         bf2 = new BufferedReader(new InputStreamReader(url2.openStream(), "UTF-8"));

         result = bf.readLine();
         result2 = bf2.readLine();

         JSONParser jsonParser = new JSONParser();
         JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
         JSONObject jsonObject2 = (JSONObject)jsonParser.parse(result2);


         String movieImg = (String)jsonObject.get("poster_path");
         String title = (String)jsonObject.get("title");
         String releaseDate = (String)jsonObject.get("release_date");
         
         JSONArray genres = (JSONArray)jsonObject.get("genres");
         String genre = "";
         for(int i = 0; i < genres.size(); i++ ) {
            JSONObject genresName = (JSONObject)genres.get(i);
            genre += genresName.get("name") + "/";
         }
         genre = genre.substring(0, genre.length()-1);

         String overview = (String)jsonObject.get("overview");
         JSONArray cast = (JSONArray)jsonObject2.get("cast");
         JSONArray crew = (JSONArray)jsonObject2.get("crew");

         String actor = "";
         for(int i = 0; i < cast.size(); i++ ) {
            JSONObject actors = (JSONObject)cast.get(i);
            actor += actors.get("name") + " ";
         }

         String director = "";
         for(int i = 0; i < crew.size(); i++ ) {
            JSONObject directors = (JSONObject)crew.get(i);
            if(directors.get("job").equals("Director")) {
               director = (String)directors.get("name");
            }
         }

         Long runtime = (Long)jsonObject.get("runtime");

         m.setMovieId(movieId);
         m.setMovieImg(movieImg);
         m.setMovieTitle(title);
         m.setReleaseDate(releaseDate);
         m.setGenre(genre);
         m.setOverview(overview);
         m.setDirector(director);
         m.setActor(actor);
         m.setRuntime(runtime);

      } catch (Exception e) {
         e.printStackTrace();
      }
      
      return m;
   }
}