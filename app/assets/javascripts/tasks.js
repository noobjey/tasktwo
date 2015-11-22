$(document).ready(function() {

  $('.tasks-table thead th.my-sortable').each(function() {
    var title = $(this).text();
    $(this).html('<input type="text" placeholder="Search ' + title + '" />');
  });

  // DataTable
  var table = $('.tasks-table').DataTable(
    {
      paging: false,
      dom: 'lrti',
      "aoColumns": [
        null,
        { "bSortable": false },
        null,
        null,
        { "bSortable": false }
      ]
    }
  );

  // Apply the search
  table.columns().every(function() {
    var that = this;

    $('input', this.header()).on('keyup change', function() {
      if (that.search() !== this.value) {
        that
          .search(this.value)
          .draw();
      }
    });
  });

});

