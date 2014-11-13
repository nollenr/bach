  $(function() {
    $( "#accordion-resizer" ).resizable({
      minHeight: 420,
      minWidth: 200,
      resize: function() {
        $( "#music-list" ).accordion( "refresh" );
      }
    });
    $( "#music-list" ).accordion({
      heightStyle: "fill",
      collapsible: true
    });
    $( "#music-list li" ).draggable({
      appendTo: "body",
      helper: "clone"
      //drag: function(event, ui){
      //  console.log(this.id);
      //}
    });
    $( "#playlist01 ol" ).droppable({
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
    // move this to something else other than the header :-/
    $("#playlist01").click(function(event){
      var masterArray = [];
      var masterHash = {};
     
      //get the list of music items added to the playlist
      $("#playlist01 ol li").each(function(index) {  
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
    
    //twitter-typeahead basic example
    var countries = new Bloodhound({
      datumTokenizer: function(datum) {
        return Bloodhound.tokenizers.whitespace(datum.name);
      },
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      limit: 10,
      prefetch: {
        // url points to a json file that contains an array of country names, see
        // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
        url: 'countries.json',
        // the json file contains an array of strings, but the Bloodhound
        // suggestion engine expects JavaScript objects so this converts all of
        // those strings

        filter: function(list) {
          //console.log("and the list is...", list)
          return $.map(list, function(playlistarry) { return { id: playlistarry[0], name: playlistarry[1] }; });
        }
      }
    });
 
  // kicks off the loading/processing of `local` and `prefetch`
  countries.clearPrefetchCache();
  countries.initialize();
  console.log(" Countries: ");
  console.log(countries);
 
  $('#prefetch .typeahead').typeahead(null, {
    name: 'countries',
    displayKey: 'name',
    // `ttAdapter` wraps the suggestion engine in an adapter that
    // is compatible with the typeahead jQuery plugin
    source: countries.ttAdapter(),
    updater: function(item) {
      console.log("item is: ", item);
    }
  });
  
  $('#prefetch').bind('typeahead:selected', function(obj, datum, name){
    console.log("selected datum: ", datum);
    console.log("selected name: ", name);
  });
 
});