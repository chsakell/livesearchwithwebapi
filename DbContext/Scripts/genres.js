$(document).ready(function () {
    $(document).ready(function () {
        GetGenres();
    });
});

function GetGenres() {
    $.getJSON('api/genres',
            function (data) {
                $('#tbodyGenres').empty();
                $.each(data, function (key, val) {
                    $('<tr><td>' + val.Id + '</td>' +
                        '<td>' + val.Name + '</td>' +
                        '<td>' + val.SortOrder + '</td>' +
                        '<td><input type=button value="Delete" onclick="deleteGenre('+val.Id+')"</td>' +
                        '</tr>').appendTo('#tbodyGenres');
                });
            }
        );
}

function addGenre() {
    var genre = {
        //Id: 0,
        Name: $('#txtNewGenreName').val(),
        SortOrder: $('#txtNewGenreOrder').val()
    };
    $.ajax({
        url: 'api/genres',
        type: 'POST',
        data: JSON.stringify(genre),
        contentType: "application/json;charset=utf-8",
        success: function (data) {
            $('#txtNewGenreName').val('');
            $('#txtNewGenreOrder').val('');
            alert(data.Name + ' added!');
            GetGenres();
        },
        error: function (x, y, z) {
            alert(x + '\n' + y + '\n' + z);
        }
    });    
}

function deleteGenre(id) {
    $.ajax({
        url: 'api/genres/'+id,
        type: 'DELETE',
        success: function (data) {
            alert(data.Name + ' removed..');
            GetGenres();
            GetReviews();
            GetViewsByGenre();
        },
        error: function (x, y, z) {
            alert(x + '\n' + y + '\n' + z);
        }
    });
}

function updateGenre() {
    var id = $('#txtEditGenreId').val();
    var newName = $('#txtEditGenreName').val();
    var newOrder = $('#txtEditGenreOrder').val();
    var genre = {
        Id : id,
        Name : newName,
        SortOrder : newOrder
    };
    $.ajax({
        url: 'api/genres/' + id,
        type: 'PUT',
        data: JSON.stringify(genre),
        contentType: "application/json;charset=utf-8",
        success: function (data) {
            $('#txtEditGenreId').val('');
            $('#txtEditGenreName').val('');
            $('#txtEditGenreOrder').val('');
            alert(data.Name + ' updated..');
            GetGenres();
            GetViewsByGenre();
        },
        error: function (x, y, z) {
            alert(x + '\n' + y + '\n' + z);
        }
    });
}