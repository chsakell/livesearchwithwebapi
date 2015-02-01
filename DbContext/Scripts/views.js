$(document).ready(function () {
    GetViewsByGenre();
});

function GetViewsByGenre() {
    $.getJSON('api/reviewsbygenre',
        function (data) {
            $('#tbodyReviewsByGenre').empty();
            $.each(data, function (key, val) {
                $('<tr><td>' + val.Name + '</td>' +
                    '<td>' + val.Title + '</td>' +
                    '<td>' + val.Summary + '</td>' +
                    '</tr>').appendTo('#tbodyReviewsByGenre');
            });
        });
}

/* Searching Engine */

function searchReviewByTitle(title) {
    //var title = $('#txtReviewTitle').val();
    $.getJSON('api/reviews?title=' + title,
        function (data) {
            $('#divSearchReviewsByTitle').empty();
            $.each(data, function (key, val) {
                $('<span style="color:crimson">Title: </span><span>' + val.Title + '</<span><br/>' +
                    '<span style="color:crimson">Summary: </span><span>' + val.Summary + '</span><br/>' +
                    '<span style="color:crimson">Genre</span><span>' + val.Genre + '</span><br/>' +
                    '<div style="border-bottom:1px solid white"></div>' +
                    '<br/>').appendTo('#divSearchReviewsByTitle');
            });
        });
}