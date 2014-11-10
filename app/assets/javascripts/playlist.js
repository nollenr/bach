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
    $("#cart").click(function(event){
      var masterArray = [];
      var masterHash = {};
     
      //get the list of music items added to the playlist
      $("#cart ol li").each(function(index) {  
         var musiclistHash = {};
         var idArray = this.id.split("-");
        // var indexArray = [index, Number(idArray[1])];
        console.log(index.toString() + " " + this.id + " " + idArray[1].toString());
        // console.log(indexArray);
        // musiclistArray.push(indexArray);
        // console.log(musiclistArray);
        musiclistHash['playlist_order'] = index;
        musiclistHash['master_library_file_id'] = idArray[1];
        masterArray.push(musiclistHash);
      });
      console.log("clicked on cart");
      console.log("MasterArray:");
      console.log(masterArray);
      $.post( 
        "/update_cart", { playlist: { id: 16, playlist_songs_attributes: masterArray }}
      );
    });
  });