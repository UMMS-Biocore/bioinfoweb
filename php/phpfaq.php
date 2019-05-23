</br>  
<div class="row clearfix">
            <div></div>
                <div class="col-md-12 column">
                        <ul class="breadcrumb">
                                <li>
                                        <a href="index.php">Home</a> <span class="divider">/</span>
                                </li>
                                <li>
                                        <a href="#">Faq</a> <span class="divider">/</span>
                                </li>
                                <li class="active">
                                        General
                                </li>
                </ul>
            </div>
</div>

<script src="dist/lib/scriptaculous/prototype.js" type="text/javascript"></script>
<script src="dist/lib/scriptaculous/scriptaculous.js" type="text/javascript"></script>

		
<div class="container">   
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <!-- Nav tabs category -->
            <ul class="nav nav-tabs faq-cat-tabs">
              <?php
	        $active="class=\"active\"";
                $query = "SELECT * FROM faqcategory ORDER BY category_id";
	        $sth = $db->prepare($query);
	        $sth->execute();

		$arrValues = $sth->fetchAll();
                foreach ($arrValues as $row){
              ?>
                <li <?=$active?>><a href="#faq-cat-<?=$row["category_id"]?>" data-toggle="tab"><?=$row["category_name"]?></a></li>
		
              <?$active="";}?>
           </ul>
            <!-- Tab panes -->
<div class="tab-content faq-cat-content">
            <?php
	      $active="active in";
              foreach ($arrValues as $cat){
                $cat_id=$cat["category_id"];
            ?>
                <div class="tab-pane <?=$active?> fade" id="faq-cat-<?=$cat_id?>">
                    <div class="panel-group" id="accordion-cat-<?=$cat_id?>">
                        <?php
                             $query = "SELECT f.faq_id, c.category_id, c.category_name, f.faq_question, f.faq_answer FROM faqitems f, faqcategory c where f.category_id=c.category_id and c.category_id=$cat_id ORDER BY faq_id";
	                     $sth = $db->prepare($query);
	                     $sth->execute();
			     $active="";
		             $arrFAQ = $sth->fetchAll();
                             foreach ($arrFAQ as $row){
                        ?>
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-<?=$cat_id?>" href="#faq-cat-<?=$cat_id?>-sub-<?=$row["faq_id"]?>">
                                    <h4 class="panel-title">
                                        <?=$row["faq_question"]?>
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-<?=$cat_id?>-sub-<?=$row["faq_id"]?>" class="panel-collapse collapse">
                                <div class="panel-body">
				   <div style="width:400px;" id="tobeedited<?=$row["faq_id"]?>"><?=$row["faq_answer"]?></div>
<?php if (isset($_SESSION["admin"])){
    ?>
<script>
 new Ajax.InPlaceEditor($('tobeedited<?=$row["faq_id"]?>'), 'php/updatefaq.php?faq_id=', {
      rows: 5,
      okButton: true,
      cancelButton: true,
      onDoubleClick:  true,
      htmlResponse: true,
      clickToEditText: 'double-click to edit',
      submitOnBlur: false,
      highlightOnLeave: false,
      loadingText: "<h6>Loading...</h6>",
      savingText: "<h6>Saving...</h6>",
      ajaxOptions: {method: 'get'} //override so we can use a static for the result
});</script><?}?>
                                </div>
                            </div>
                        </div>
                     <?}?>
                    </div>
                </div>
               <?}?>
            </div>


          </div>
        </div>
    </div>



