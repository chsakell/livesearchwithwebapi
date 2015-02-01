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
    public class ReviewsByGenreController : ApiController
    {
        private MovieStoreEntities db = new MovieStoreEntities();

        // GET api/ReviewsByGenre
        public IEnumerable<vWGetReviewsByGenre> GetvWGetReviewsByGenres()
        {
            var reviewsByGenre = from vW in db.vWGetReviewsByGenres
                                 orderby vW.Name
                                 select vW;
            return reviewsByGenre.AsEnumerable();
        }

        // GET api/ReviewsByGenre/5
        public vWGetReviewsByGenre GetvWGetReviewsByGenre(string id)
        {
            vWGetReviewsByGenre vwgetreviewsbygenre = db.vWGetReviewsByGenres.Find(id);
            if (vwgetreviewsbygenre == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return vwgetreviewsbygenre;
        }

        // PUT api/ReviewsByGenre/5
        public HttpResponseMessage PutvWGetReviewsByGenre(string id, vWGetReviewsByGenre vwgetreviewsbygenre)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != vwgetreviewsbygenre.Name)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            db.Entry(vwgetreviewsbygenre).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        // POST api/ReviewsByGenre
        public HttpResponseMessage PostvWGetReviewsByGenre(vWGetReviewsByGenre vwgetreviewsbygenre)
        {
            if (ModelState.IsValid)
            {
                db.vWGetReviewsByGenres.Add(vwgetreviewsbygenre);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, vwgetreviewsbygenre);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = vwgetreviewsbygenre.Name }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/ReviewsByGenre/5
        public HttpResponseMessage DeletevWGetReviewsByGenre(string id)
        {
            vWGetReviewsByGenre vwgetreviewsbygenre = db.vWGetReviewsByGenres.Find(id);
            if (vwgetreviewsbygenre == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.vWGetReviewsByGenres.Remove(vwgetreviewsbygenre);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, vwgetreviewsbygenre);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}