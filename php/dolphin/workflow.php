
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Process</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


</br>
<div class="row clearfix">
            <div></div>
                <div class="col-md-12 column">
                        <ul class="breadcrumb">
                                <li>
                                        <a href="index.php">Home</a> <span class="divider">/</span>
                                </li>
                                <li>
                                        <a href="#">Services</a> <span class="divider">/</span>
                                </li>
                                <li class="active">
                                        <a href="index.php?p=16">Dolphin</a>
                                </li>
                </ul>
            </div>
</div>
<?php


function syscall($command){
    if ($proc = popen("($command)2>&1","r")){
        while (!feof($proc)) $result .= fgets($proc, 1000);
        pclose($proc);
        $result = str_replace(PHP_EOL, '', $result);
        return $result; 
        }
    }
$com="grep ".$_SESSION['user']."\"[[:space:]]\" /data/www/bioinfo/php/dolphin/conv.file|awk {'print \$2'}";
$user = syscall($com);
print "[user:".$user."]";
?>

  <link rel="stylesheet" href="/php/dolphin/SlickGrid/slick.grid.css" type="text/css"/>
  <link rel="stylesheet" href="/php/dolphin/SlickGrid/controls/slick.pager.css" type="text/css"/>
  <link rel="stylesheet" href="/php/dolphin/SlickGrid/css/smoothness/jquery-ui-1.8.16.custom.css" type="text/css"/>
  <link rel="stylesheet" href="/php/dolphin/SlickGrid/examples/examples.css" type="text/css"/>
  <link rel="stylesheet" href="/php/dolphin/SlickGrid/controls/slick.columnpicker.css" type="text/css"/>
  <style>
   .slick-row.active .slick-cell {
     background-color: #FFB;
   }

    .slick-header-column.ui-state-default {
      background:none ;
      background-color: #e5e5e5 ;
      color: black;  
      border: none;  
      padding: 5;
      font-family: Arial, Verdana, Helvetica, sans-serif;
      font-size: 14x;
      height: 30px;
      line-height: 30px;      
    }

    .slick-headerrow-column {
      background: #87ceeb;
      text-overflow: clip;
      -moz-box-sizing: border-box;
      box-sizing: border-box;
    }

    .slick-headerrow-column input {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
      -moz-box-sizing: border-box;
      box-sizing: border-box;
    }
    .cell-title {
      font-weight: bold;
    }

    .cell-effort-driven {
      text-align: center;
    }

    .cell-selection {
      border-right-color: silver;
      border-right-style: solid;
      background: #f5f5f5;
      color: gray;
      text-align: right;
      font-size: 10px;
    }

    .slick-row.selected .cell-selection {
      background-color: transparent; /* show default selected row background */
    }
  </style>


<!-- Modal -->
<div style="position:relative">
  <div style="width:100%;">
    <div class="grid-header" style="width:100%">
      <label onclick="toggleGrid(workflowGrid)">Workflows</label>
      <span style="float:right" class="ui-icon ui-icon-carat-2-n-s" title="Toggle Grid"
            onclick="toggleGrid(workflowGrid)"></span>
      <!--<span style="float:right" class="ui-icon ui-icon-refresh" title="Refresh workflows"
            onclick="refreshGrid(grid)"></span>-->
      <span style="float:right" class="ui-icon ui-icon-search" title="Toggle search panel"
            onclick="toggleFilterRow(grid)"></span>
    </div>
    <div id="workflowGrid" class="gridshape" style="width:100%;height:500px;"></div>
    <div id="workflowpager" style="width:100%;height:20px;"></div>
    <br/>
    <div class="grid-header" style="width:100%" >
      <label onclick="toggleGrid(serviceGrid)">Services</label>
      <span style="float:right" class="ui-icon ui-icon-carat-2-n-s" title="Toggle Grid"
            onclick="toggleGrid(serviceGrid)"></span>
     <!--<span style="float:right" class="ui-icon ui-icon-refresh" title="Refresh Services"
            onclick="refreshGrid(servicegrid)"></span>
      <span style="float:right" class="ui-icon ui-icon-search" title="Toggle search panel"
            onclick="toggleFilterRow(servicegrid)"></span>-->
    </div>
    <div id="serviceGrid" class="gridshape" style="width:100%;height:500px;"></div>
    <div id="servicepager" style="width:100%;height:20px;"></div>
    <br/>
    <div class="grid-header" style="width:100%">
      <label onclick="toggleGrid(jobsGrid)">Jobs</label>
      <span style="float:right" class="ui-icon ui-icon-carat-2-n-s" title="Toggle Grid"
            onclick="toggleGrid(jobsGrid)"></span>
      <!--<span style="float:right" class="ui-icon ui-icon-refresh" title="Refresh Jobs"
            onclick="refreshJobs(jobsgrid)"></span>
      <span style="float:right" class="ui-icon ui-icon-search" title="Toggle search panel"
            onclick="toggleFilterRow(jobsgrid)"></span>-->
    </div>
    <div id="jobsGrid" class="gridshape" style="width:100%;height:500px;"></div>
    <div id="jobspager" style="width:100%;height:20px;"></div>
  </div>

  </div>
</div>

<div id="inlineFilterPanel" style="display:none;background:#dddddd;padding:3px;color:black;">
  Show workflows <input type="text" id="txtSearch2">
  and % at least &nbsp;
  <div style="width:100px;display:inline-block;" id="pcSlider2"></div>
</div>

<script src="/php/dolphin/SlickGrid/lib/firebugx.js"></script>

<script src="/php/dolphin/SlickGrid/lib/jquery-1.7.min.js"></script>
<script src="/php/dolphin/SlickGrid/lib/jquery-ui-1.8.16.custom.min.js"></script>
<script src="/php/dolphin/SlickGrid/lib/jquery.event.drag-2.2.js"></script>

<script src="/php/dolphin/SlickGrid/slick.core.js"></script>
<script src="/php/dolphin/SlickGrid/slick.formatters.js"></script>
<script src="/php/dolphin/SlickGrid/slick.editors.js"></script>
<script src="/php/dolphin/SlickGrid/plugins/slick.rowselectionmodel.js"></script>
<script src="/php/dolphin/SlickGrid/slick.grid.js"></script>
<script src="/php/dolphin/SlickGrid/slick.dataview.js"></script>
<script src="/php/dolphin/SlickGrid/controls/slick.pager.js"></script>
<script src="/php/dolphin/SlickGrid/controls/slick.columnpicker.js"></script>

<script>
var dataView;
var grid;
var servicegrid;
var jobsgrid;

var data = [];
var columns = [
  {id: "sel", name: "#", field: "num", behavior: "select", cssClass: "cell-selection", width: 50, cannotTriggerInsert: true, resizable: false, selectable: false },
  {id: "title", name: "Name", field: "title", width: 120, minWidth: 120, cssClass: "cell-title", editor: Slick.Editors.Text, validator: requiredFieldValidator, sortable: true},
  {id: "duration", name: "Duration", field: "duration", width: 20, editor: Slick.Editors.Text, sortable: true},
  {id: "%", defaultSortAsc: false, name: "% Complete", field: "percentComplete", width: 120, resizable: false, formatter: Slick.Formatters.PercentCompleteBar, editor: Slick.Editors.PercentComplete, sortable: true},
  {id: "start", name: "Start", field: "start", minWidth: 60, editor: Slick.Editors.Date, sortable: true},
  {id: "finish", name: "Finish", field: "finish", minWidth: 60, editor: Slick.Editors.Date, sortable: true},
];
var columnsJobs = [
  {id: "sel", name: "#", field: "num", behavior: "select", cssClass: "cell-selection", width: 50, cannotTriggerInsert: true, resizable: false, selectable: false },
  {id: "title", name: "Name", field: "title", width: 120, minWidth: 120, cssClass: "cell-title", editor: Slick.Editors.Text, validator: requiredFieldValidator, sortable: true},
  {id: "duration", name: "Duration", field: "duration", width: 20, editor: Slick.Editors.Text, sortable: true},
  {id: "job_num", name: "JobNum", field: "job_num", width: 50, editor: Slick.Editors.Date, sortable: true},
  {id: "submit", name: "Sumbission Time", field: "submit", minWidth: 120, editor: Slick.Editors.Date, sortable: true},
  {id: "start", name: "Start", field: "start",  minWidth: 120, editor: Slick.Editors.Date, sortable: true},
  {id: "finish", name: "Finish", field: "finish", minWidth: 120, editor: Slick.Editors.Date, sortable: true},
];

var options = {
  editable: false,
  ableAddRow: false,
  enableCellNavigation: true,
  asyncEditorLoading: true,
  syncColumnCellResize: true,
  forceFitColumns: true,
  autoExpandColumns: true,  
  topPanelHeight: 25
};

var sortcol = "title";
var sortdir = 1;
var percentCompleteThreshold = 0;
var searchString = "";

function requiredFieldValidator(value) {
  if (value == null || value == undefined || !value.length) {
    return {valid: false, msg: "This is a required field"};
  }
  else {
    return {valid: true, msg: null};
  }
}

function myFilter(item, args) {
  if (item["percentComplete"] < args.percentCompleteThreshold) {
    return false;
  }

  if (args.searchString != "" && item["title"].indexOf(args.searchString) == -1) {
    return false;
  }

  return true;
}

function percentCompleteSort(a, b) {
  return a["percentComplete"] - b["percentComplete"];
}

function comparer(a, b) {
  var x = a[sortcol], y = b[sortcol];
  return (x == y ? 0 : (x > y ? 1 : -1));
}

function toggleFilterRow(g) {
  g.setTopPanelVisibility(!g.getOptions().showTopPanel);
}

function toggleGrid(grid) {
 $(grid).toggle(300);
}

function refreshGrid(grid) {
}


$(".grid-header .ui-icon")
        .addClass("ui-state-default ui-corner-all")
        .mouseover(function (e) {
          $(e.target).addClass("ui-state-hover")
        })
        .mouseout(function (e) {
          $(e.target).removeClass("ui-state-hover")
        });

$(document).ready(function () {
  // prepare the data
  $("#jobsGrid").hide();
  $("#serviceGrid").hide();
  var dataView = new Slick.Data.DataView({ inlineFilters: true });
  $.getJSON("/php/dolphin/data.php?u=<?=$user?>", function (data) {
    dataView.beginUpdate();
    dataView.setItems(data);
    dataView.endUpdate();
  });

  grid = new Slick.Grid("#workflowGrid", dataView, columns, options);

  grid.setSelectionModel(new Slick.RowSelectionModel());

  grid.onDblClick.subscribe(function (e) {
      var cell = grid.getCellFromEvent(e);
      var row = cell.row;
      var num = grid.getDataItem(row)[grid.getColumns()[0].field];
      var serviceDataView = new Slick.Data.DataView({ inlineFilters: false });
      var url="/php/dolphin/dataservice.php?id="+num+"&u=<?=$user?>";
      $.getJSON(url, function (data) {
         serviceDataView.beginUpdate();
         serviceDataView.setItems(data);
         serviceDataView.endUpdate();
         $("#workflowGrid").hide(300);
         $("#serviceGrid").show(300);
         $("#jobsGrid").hide(300);
      });
      servicegrid = new Slick.Grid("#serviceGrid", serviceDataView, columns, options);
      servicegrid.setSelectionModel(new Slick.RowSelectionModel());
        
      var servicepager = new Slick.Controls.Pager(serviceDataView, servicegrid, $("#servicepager"));
      var servicecolumnpicker = new Slick.Controls.ColumnPicker(columns, servicegrid, options);
      servicegrid.onCellChange.subscribe(function (e, args) {
        serviceDataView.updateItem(args.item.id, args.item);
      });
      // wire up model events to drive the grid
      serviceDataView.onRowCountChanged.subscribe(function (e, args) {
        servicegrid.updateRowCount();
        servicegrid.render();
      });

      serviceDataView.onRowsChanged.subscribe(function (e, args) {
        servicegrid.invalidateRows(args.rows);
        servicegrid.render();
      });

      serviceDataView.onPagingInfoChanged.subscribe(function (e, pagingInfo) {
         var isLastPage = pagingInfo.pageNum == pagingInfo.totalPages - 1;
         var enableAddRow = isLastPage || pagingInfo.pageSize == 0;
         var options = servicegrid.getOptions();

         if (options.enableAddRow != enableAddRow) {
            servicegrid.setOptions({enableAddRow: enableAddRow});
         }
      });

   
    servicegrid.onClick.subscribe(function (e) {
      var cell = servicegrid.getCellFromEvent(e);
      var row = cell.row;
      var num = servicegrid.getDataItem(row)[servicegrid.getColumns()[0].field];
      var jobsDataView = new Slick.Data.DataView({ inlineFilters: false });
      var url="/php/dolphin/datajobs.php?id="+num+"&u=$user";
      $.getJSON(url, function (data) {
         jobsDataView.beginUpdate();
         jobsDataView.setItems(data);
         jobsDataView.endUpdate();
         $("#serviceGrid").hide(300);
         $("#jobsGrid").show(300);
      });
      $('#myModal').removeData("modal");
      $('#myModal').removeClass('modal-content');
      
      jobsgrid = new Slick.Grid("#jobsGrid", jobsDataView, columnsJobs, options);
      var jobspager = new Slick.Controls.Pager(jobsDataView, jobsgrid, $("#jobspager"));
      var jobscolumnpicker = new Slick.Controls.ColumnPicker(columnsJobs, jobsgrid, options);
      jobsgrid.onCellChange.subscribe(function (e, args) {
        jobsDataView.updateItem(args.item.id, args.item);
      });
      jobsgrid.onDblClick.subscribe(function (e) {
         e.preventDefault();
         var cell = jobsgrid.getCellFromEvent(e);
         var row = cell.row;
         var num = jobsgrid.getDataItem(row)[jobsgrid.getColumns()[0].field];
         var url="/php/dolphin/datajobout.php?id="+num;
         
         $.getJSON(url, function (data) {
             $.each(data,function(i,element){
               $( '.modal-title' ).html( element.jobname ); 
               $( '.modal-body' ).html( element.jobout ); 
             });
         });
	 $('#myModal').modal('toggle');
      });
      // wire up model events to drive the grid
      jobsDataView.onRowCountChanged.subscribe(function (e, args) {
        jobsgrid.updateRowCount();
        jobsgrid.render();
      });
      jobsDataView.onRowsChanged.subscribe(function (e, args) {
        jobsgrid.invalidateRows(args.rows);
        jobsgrid.render();
      });

      jobsDataView.onPagingInfoChanged.subscribe(function (e, pagingInfo) {
         var isLastPage = pagingInfo.pageNum == pagingInfo.totalPages - 1;
         var enableAddRow = isLastPage || pagingInfo.pageSize == 0;
         var options = servicegrid.getOptions();

         if (options.enableAddRow != enableAddRow) {
            jobsgrid.setOptions({enableAddRow: enableAddRow});
         }
      });
     
      var rows = [];
      rows.push(cell.row);
      servicegrid.setSelectedRows(rows);
      e.stopPropagation();

    });
    serviceDataView.syncGridSelection(servicegrid, true);
    var rows = [];
    rows.push(cell.row);
    grid.setSelectedRows(rows);
    e.stopPropagation();

});


  var pager = new Slick.Controls.Pager(dataView, grid, $("#workflowpager"));
  var columnpicker = new Slick.Controls.ColumnPicker(columns, grid, options);

  // move the filter panel defined in a hidden div into grid top panel
  $("#inlineFilterPanel")
      .appendTo(grid.getTopPanel())
      .show();

  grid.onCellChange.subscribe(function (e, args) {
    dataView.updateItem(args.item.id, args.item);
  });

  grid.onSort.subscribe(function (e, args) {
    sortdir = args.sortAsc ? 1 : -1;
    sortcol = args.sortCol.field;

    if ($.browser.msie && $.browser.version <= 8) {
      // using temporary Object.prototype.toString override
      // more limited and does lexicographic sort only by default, but can be much faster

      var percentCompleteValueFn = function () {
        var val = this["percentComplete"];
        if (val < 100) {
          return "00" + val;
        } else if (val < 100) {
          return "0" + val;
        } else {
          return val;
        }
      };

      // use numeric sort of % and lexicographic for everything else
      dataView.fastSort((sortcol == "percentComplete") ? percentCompleteValueFn : sortcol, args.sortAsc);
    } else {
      // using native sort with comparer
      // preferred method but can be very slow in IE with huge datasets
      dataView.sort(comparer, args.sortAsc);
    }
  });

  // wire up model events to drive the grid
  dataView.onRowCountChanged.subscribe(function (e, args) {
    grid.updateRowCount();
    grid.render();
  });

  dataView.onRowsChanged.subscribe(function (e, args) {
    grid.invalidateRows(args.rows);
    grid.render();
  });

  dataView.onPagingInfoChanged.subscribe(function (e, pagingInfo) {
    var isLastPage = pagingInfo.pageNum == pagingInfo.totalPages - 1;
    var enableAddRow = isLastPage || pagingInfo.pageSize == 0;
    var options = grid.getOptions();

    if (options.enableAddRow != enableAddRow) {
      grid.setOptions({enableAddRow: enableAddRow});
    }
  });


  var h_runfilters = null;

  // wire up the slider to apply the filter to the model
  $("#pcSlider,#pcSlider2").slider({
    "range": "min",
    "slide": function (event, ui) {
      Slick.GlobalEditorLock.cancelCurrentEdit();

      if (percentCompleteThreshold != ui.value) {
        window.clearTimeout(h_runfilters);
        h_runfilters = window.setTimeout(updateFilter, 10);
        percentCompleteThreshold = ui.value;
      }
    }
  });


  // wire up the search textbox to apply the filter to the model
  $("#txtSearch,#txtSearch2").keyup(function (e) {
    Slick.GlobalEditorLock.cancelCurrentEdit();

    // clear on Esc
    if (e.which == 27) {
      this.value = "";
    }

    searchString = this.value;
    updateFilter();
  });

  function updateFilter() {
    dataView.setFilterArgs({
      percentCompleteThreshold: percentCompleteThreshold,
      searchString: searchString
    });
    dataView.refresh();
  }

  $("#btnSelectRows").click(function () {
    if (!Slick.GlobalEditorLock.commitCurrentEdit()) {
      return;
    }

    var rows = [];
    for (var i = 0; i < 10 && i < dataView.getLength(); i++) {
      rows.push(i);
    }

    grid.setSelectedRows(rows);
  });


  // initialize the model after all the events have been hooked up
  dataView.beginUpdate();
  dataView.setItems(data);
  dataView.setFilterArgs({
    percentCompleteThreshold: percentCompleteThreshold,
    searchString: searchString
  });
  dataView.setFilter(myFilter);
  dataView.endUpdate();

  // if you don't want the items that are not visible (due to being filtered out
  // or being on a different page) to stay selected, pass 'false' to the second arg
  dataView.syncGridSelection(grid, true);

  $("#gridContainer").resizable();
})


</script>

