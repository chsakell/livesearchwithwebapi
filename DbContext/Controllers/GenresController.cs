using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DbContext.Models;

namespace DbContext.Controllers
{
    public class GenresController : ApiController
    {
        private MovieStoreEntities db = new MovieStoreEntities();

        // GET api/Genres
        public IEnumerable<Genre> GetGenres()
        {
            return db.Genres.AsEnumerable();
        }

        // GET api/Genres/5
        public Genre GetGenre(int id)
        {
            Genre genre = db.Genres.Find(id);
            if (genre == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return genre;
        }

        // PUT api/Genres/5
        public HttpResponseMessage PutGenre(int id, Genre genre)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != genre.Id)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            db.Entry(genre).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK,genre);
        }

        // POST api/Genres
        public HttpResponseMessage PostGenre(Genre genre)
        {
            if (ModelState.IsValid)
            {
                db.Genres.Add(genre);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, genre);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = genre.Id }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/Genres/5
        public HttpResponseMessage DeleteGenre(int id)
        {
            Genre genre = db.Genres.Find(id);
            if (genre == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.Entry(genre).Collection(g => g.Reviews).Load();
            var reviewsToRemoved = (from r in db.Reviews
                                    where r.GenreId == id
                                    select r).ToList();
            foreach (var review in reviewsToRemoved)
                db.Reviews.Remove(review);

            db.Genres.Remove(genre);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, genre);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}