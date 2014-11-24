  $(function() {
    $( "#accordion-resizer" ).resizable({
      minHeight: 420,
      minWidth: 200,
      resize: function() {
        $( "#music-list" ).accordion( "refresh" );
      }
    });
    $( "#music-list" ).accordion({
      heightStyle: "content",
      collapsible: true
    });
    $( "#music-list li" ).draggable({
      appendTo: "body",
      helper: "clone"
      //drag: function(event, ui){
      //  console.log(this.id);
      //}
      });
    $( "#playlist01-contents ol" ).droppable({
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

    // This is the working section of the Model updates.
    $("#updatePlaylist01").click(function(event){
      var masterArray = [];
      var masterHash = {};
      var v_playlistName = $("#birds").val();
      var v_playlistID = $("#birdsID").val();
      console.log("Playlist: ", v_playlistName, "  Playlist Id:", v_playlistID);
     
      //get the list of music items added to the playlist
      $("#playlist01-contents ol li").each(function(index) {  
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
      console.log("MasterArray:");
      console.log(masterArray);
      $.post( 
        "/update_cart", { playlist: { id: v_playlistID, name: v_playlistName, playlist_songs_attributes: masterArray }}
      );
    });

    $( "#birds" ).autocomplete({
      source: "/jsonplaylist.json",
      minLength: 0,
      select: function( event, ui ) {
        console.log("Select firing");
        document.getElementById("birds").value = ui.item.value;
        document.getElementById("birdsID").value = ui.item.id;
        return false;
      },
      response: function(event, ui){
        if (ui.content.length == 1) {
          console.log("Response firing: 1 value");
          ui.item = ui.content[0];
          //$(this).val(ui.content[0].value);
          $(this).data('ui-autocomplete')._trigger('select', 'autocompleteselect', ui);
          $(this).autocomplete("close");
        }
        else if (ui.content.length == 0) {
          console.log("Response firing: 0 values");
          document.getElementById("birdsID").value = '';  
        }
        else {
          console.log("Response firing: many values");
          document.getElementById("birdsID").value = '';
        }
      }
    });  // this ends the .data(ui-autocomplete)
    
    $( "#birds").blur(function(){
      console.log("Blurring...");
      if (document.getElementById("birdsID").value) {
        $.get("/get_playlist_songs", {id: document.getElementById("birdsID").value});
      }
      else {
        $("#playlist01-ol").empty();
        $("#playlist01-ol").html("<li class=\"placeholder\">Add your items here</li>");
      }
    });
    
    $( "#musicDisplay" ).selectmenu({
      width: $("#musicDisplay").parent().css("width"),
      change: function( event, data) {
       $.get("/get_music_list", {id: data.item.value, list: $( "#musicDisplaySegment").val()}); 
      }
    });
    $( "#musicDisplaySegment" ).selectmenu({
      width: $("#musicDisplaySegment").parent().css("width")
      });

  });