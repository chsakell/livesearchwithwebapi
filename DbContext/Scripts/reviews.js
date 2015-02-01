$(document).ready(function () {
    $(document).ready(function () {
        GetReviews();
    });
});

function GetReviews() {
    $.getJSON('api/reviews',
        function (data) {
            $('#tbodyReviews').empty();
            $.each(data, function (key, val) {
                $('<tr><td>'+ val.Id + '</td>' +
                    '<td>' + val.Title + '</td>' +
                    '<td>' + val.Summary + '</td>' +
                    '<td>' + val.Genre + '</td>' +
                    '<td>' + val.Authorized + '</td>' +
                    '<td><input type=button value="Delete" onclick="deleteReview(' + val.Id + ')"</td>' +
                    '</tr>').appendTo('#tbodyReviews');
            });

        });
}

function addReview() {

    var review = {
        Title: $('#txtNewReviewTitle').val(),
        Genre: $('#txtNewReviewGenre').val(),
        Summary: $('#txtNewReviewSummary').val(),
        Body: $('#txtNewReviewBody').val(),
        Authorized: $('#chkReviewAuthorized').is(":checked")
    };
    $.ajax({
        url: 'api/reviews',
        type: 'POST',
        data: JSON.stringify(review),
        contentType: "application/json;charset=utf-8",
        success: function (data) {
            alert(data.Title + ' added');
            $('#txtNewReviewTitle').val('');
            $('#txtNewReviewGenre').val('');
            $('#txtNewReviewSummary').val('');
            $('#txtNewReviewBody').val('');
            GetReviews();
            GetViewsByGenre();
        },
        error: function (x, y, z) {
            alert(x + '\n' + y + '\n' + z);
        }
    });
}

function deleteReview(id) {
    $.ajax({
        url: 'api/reviews/' + id,
        type: 'DELETE',
        success: function (data) {
            alert(data + ' deleted..');
            GetReviews();
        },
        error: function (x, y, z) {
            alert(x + '\n' + y + '\n' + z);
        }
    });
}