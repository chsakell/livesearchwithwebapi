using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DbContext.Models
{
    public class ReviewDTO
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Summary { get; set; }
        public string Body { get; set; }
        public string Genre { get; set; }
        public bool Authorized { get; set; }
        public System.DateTime CreateDateTime { get; set; }
        public System.DateTime UpdateDateTime { get; set; }

    }
}