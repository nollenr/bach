  $(function() {
    $( "#accordion-resizer" ).resizable({
      minHeight: 420,
      minWidth: 200,
      resize: function() {
        $( "#catalog" ).accordion( "refresh" );
      }
    });
    $( "#catalog" ).accordion({
      heightStyle: "fill",
      collapsible: true
    });
    $( "#catalog li" ).draggable({
      appendTo: "body",
      helper: "clone"
      //drag: function(event, ui){
      //  console.log(this.id);
      //}
    });
    $( "#cart ol" ).droppable({
      activeClass: "ui-state-default",
      hoverClass: "ui-state-hover",
      accept: ":not(.ui-sortable-helper)",
      drop: function( event, ui ) {
        console.log( $(ui.draggable).attr('id') );
        var liID = $(ui.draggable).attr('id');
        console.log(liID);
        $( this ).find( ".placeholder" ).remove();
        $( "<li></li>" ).text( ui.draggable.text() ).attr('id', $(ui.draggable).attr('id') ).appendTo( this );
      }
    }).sortable({
      items: "li:not(.placeholder)",
      sort: function() {
        // gets added unintentionally by droppable interacting with sortable
        // using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
        $( this ).removeClass( "ui-state-default" );
      }
    });
  });