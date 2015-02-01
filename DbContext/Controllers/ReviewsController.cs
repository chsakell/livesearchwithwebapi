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
    public class ReviewsController : ApiController
    {
        private MovieStoreEntities db = new MovieStoreEntities();

        // GET api/Reviews
        public IEnumerable<ReviewDTO> GetReviews()
        {
            List<ReviewDTO> reviewsDTO = new List<ReviewDTO>();
            var reviews = db.Reviews.Include(r => r.Genre);
            foreach (var review in reviews)
            {
                ReviewDTO dto = new ReviewDTO
                {
                    Id = review.Id,
                    Title = review.Title,
                    Summary = review.Summary,
                    Body = review.Body,
                    Authorized = review.Authorized,
                    Genre = review.Genre.Name,
                    CreateDateTime = review.CreateDateTime,
                    UpdateDateTime = review.UpdateDateTime
                };
                reviewsDTO.Add(dto);
            }
            return reviewsDTO.AsEnumerable();
        }

        // GET api/Reviews/5
        public Review GetReview(int id)
        {
            Review review = db.Reviews.Find(id);
            if (review == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return review;
        }

        [HttpGet]
        public IEnumerable<ReviewDTO> SearchReviewByTitle(string title)
        {
            List<ReviewDTO> reviewsDTO = new List<ReviewDTO>();
            var reviews = from r in db.Reviews.Include(r => r.Genre)
                          where r.Title.Contains(title)
                          select new ReviewDTO
                          {
                              Title = r.Title,
                              Summary = r.Summary,
                              Genre = r.Genre.Name
                          };
            foreach (var review in reviews)
            {
                reviewsDTO.Add(review);
            }
            return reviewsDTO.AsEnumerable();
        }

        // PUT api/Reviews/5
        public HttpResponseMessage PutReview(int id, Review review)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != review.Id)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            db.Entry(review).State = EntityState.Modified;

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

        // POST api/Reviews
        public HttpResponseMessage PostReview(ReviewDTO reviewDTO)
        {
            if (ModelState.IsValid)
            {
                Genre genre = db.Genres.Where(g => g.Name == reviewDTO.Genre).Single();
                Review review = new Review
                {
                    Title = reviewDTO.Title,
                    Summary = reviewDTO.Summary,
                    Body = reviewDTO.Body,
                    Authorized = reviewDTO.Authorized,
                    GenreId = genre.Id,
                    CreateDateTime = DateTime.Now,
                    UpdateDateTime = DateTime.Now
                };
                db.Reviews.Add(review);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, reviewDTO);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = review.Id }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/Reviews/5
        public HttpResponseMessage DeleteReview(int id)
        {
            Review review = db.Reviews.Find(id);
            if (review == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.Reviews.Remove(review);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, review.Title);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}