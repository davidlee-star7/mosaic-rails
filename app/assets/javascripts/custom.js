jQuery(document).ready(function() {

    if (window.initvar == 1) {
        return false;
    };

   if (typeof(window.initvar)=="undefined") {
    window.initvar = 1;
   };

    jQuery("a[rel='tooltip'],label[rel='tooltip']").tooltip();

    var duration = 250;
    var delay = 0.80;
    var opacity = 0.60;
    var overlay = '#ccc';

    jQuery('#addsurvey-pop-1-link').click(function() {
        jQuery('#addsurvey-pop-1').modal({
            fadeDuration: 250,
            fadeDelay: 0.80,
            opacity: 0.55,
            overlay: "#ccc",
            zIndex: 1,
            escapeClose: false,
            clickClose: false,
            showClose: false,
            closeText: 'Never Mind',
            modalClass: "modal",
            spinnerHtml: null,
            showSpinner: true
        });
    })

    jQuery("a.doaction").click(function(e){
        e.preventDefault();
        var $this = jQuery(this);
        var did = $this.attr("id");
        if(confirm("Are You Sure Delete this User"))  
        jQuery.get(jQuery(this).attr('href'),function(){
            jQuery(".list-user-row-"+did).hide(500);
        })
    })

    jQuery(".modal-control .control-item").click(function(){
       var url = jQuery(this).data("url");
       var bool = jQuery(this).find("i.check").hasClass("fa-check-circle") ? true : false;

       if (bool) {
        jQuery(this).find("i.check").removeClass("fa-check-circle")
        jQuery(this).find("i.check").addClass("fa-times")
       }else{
        jQuery(this).find("i.check").removeClass("fa-times")
        jQuery(this).find("i.check").addClass("fa-check-circle")
       }

       jQuery.ajax({
            type: 'post',
            url: url,
            success: function(opt){
                jQuery(".ajax-msg").html(opt.message)
                jQuery(".ajax-msg").css("color",opt.color)
            },
            dataType: 'json'
       })
    })


    jQuery('.child-pages').click(function(e) {
        e.preventDefault();
        var nextul = jQuery(this).next('ul');
        nextul.slideToggle('fast');
    });

    jQuery('.m-access-det .first span').click(function(e) {
        // alert("test");
        e.preventDefault();
        var nextul = jQuery(this).parent().parent().addClass("test");
        nextul.hide();
    });


    jQuery('a.removeimage').click(function(e) {
        e.preventDefault();
        // alert("test")
        jQuery(this).prev('removeimage').addClass('tests');
    });

    jQuery('.m-access-det > a').click(function(e) {
        e.preventDefault();
        jQuery('.m-access-det  > ul').not(this).hide();
        var nextul = jQuery(this).next('ul');
        nextul.slideToggle('fast');
    });

    jQuery(document).keyup(function(e) {
        if (e.keyCode == 27) jQuery('.m-access-det  > ul').slideUp(); // enter
        // if (e.keyCode == 27) $('.cancel').click();   // esc
    });

    jQuery("a.fancybox").fancybox();


    jQuery(".msitegroup").click(function() {
        var microsites = groups = "";
        jQuery(".micrisitelistwrapeer li .checkboxcontainer input").each(function(i, element) {
            if (jQuery(element).is(":checked")) {
                var ipval = jQuery(element).val();
                microsites += ipval + ","
            };
        })

        groups = jQuery(".assigntogroup input.ui-autocomplete-input").val();

        if (groups == null) {
        	alert("Please fill the groups, assign to microsites");
            return false;
        };


        microsites = microsites.replace(/^,|,$/g, '');

        if (microsites.length < 1) {
            alert("Please select the microsites, assign to groups");
            return false;
        }

        jQuery(".assigntogroup form input#microsites").val(microsites);

       // return false;
    })

    jQuery(".template-block-p .field").click(function(){
        jQuery(".template-block-p .field").removeClass("active");
        jQuery(this).addClass("active");
    })


   $('a.fullwidthfancybox').on('click', function(e) {
        e.preventDefault();
        var itshref = $(this).attr('href');
        // alert(itshref);
        $.ajax(itshref, {
            success: function(result) {
                // alert(result);
                $.fancybox({
                    'width': 800,
                     height:500,
                    'enableEscapeButton': false,
                    'overlayShow': true,
                    'overlayOpacity': 0,
                    'hideOnOverlayClick': false,
                    'content': result
                });
            }
        });
    });


    $('a.fancyajax').on('click', function(e) {
        e.preventDefault();
        var itshref = $(this).attr('href');
        // alert(itshref);
        $.ajax(itshref, {
            success: function(result) {
                // alert(result);
                $.fancybox({
                    'width': 100,
                    'height': 100,
                    'enableEscapeButton': false,
                    'overlayShow': true,
                    'overlayOpacity': 0,
                    'hideOnOverlayClick': false,
                    'content': result
                });
            }
        });
    });

    jQuery('.datetimepicker').datetimepicker({
        timepicker: false,
        format: 'Y/m/d'
    });

    jQuery('.next-pre-controles ul li.active').click(function(event) {
        event.preventDefault();
    })
    jQuery('input.create_slug').blur(function() {

        var slug = jQuery(this).val();

        jQuery.ajax({
            type: 'post',
            url: '/admin/create_slug',
            data: {
                slug: slug
            },
            //dataType : 'json',
            complete: function(msg) {
                //window.console.log(msg)
                jQuery('input.put_slug').val(msg.responseText);
            }
        })
    })

    $('.has-sub').click(function() {
        // 	 var isVisible = $(this).next('ul').is(":visible");
        // 	 if(isVisible){
        // $(this).children('span').toggleClass('opened');
        // 	 }else{
        // $(this).children('span').toggleClass('opened');
        // 	 }
        $(this).next('ul').slideToggle();
    });
    jQuery('.confirm-delete').click(function() {
        var conf = confirm('Really Wants to Delete!')
        if (!conf) {
            return false;
        };
    })

    selectQuestionType('add');

     /*
	# this function is used to edit 
	# existing question and its fields a#editquestionmodal
	# # edit question button */
    jQuery('a.question_modal[rel="ajax:modal"]').click(function(event) {

        var btnname = 'Save Question';
        //var tid = jQuery(this).data('target');
        var sectionid = jQuery(this).data('sectionid');
        var questionid = jQuery(this).data('questionid');
        var action_type = 'edit_question';
        var target_action = jQuery(this).data('action');
        var question_title = jQuery(this).data('title');
        var field_type = jQuery(this).data('field_type');
        var turl = jQuery(this).attr('href');
        jQuery.ajax({
            url: turl,
            success: function(newHTML, textStatus, jqXHR) {
                // jQuery(newHTML).appendTo('body').modal();
                jQuery('#addNewQuestionModal').css('width', (jQuery(window).width() - 100))
                jQuery('#addNewQuestionModal').css('height', (jQuery(window).height() - 50))
                jQuery('#addNewQuestionModal').html(newHTML).modal();
                selectQuestionType('edit');
                addtiona_field_nav();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                // Handle AJAX errors
            }
            // More AJAX customization goes here.
        });
        return false;
    })


    /* this code is written for update
    //admin/listRoleCapability/37
     permition under roles*/

    jQuery('.listability ul.sub-1 form input[type="checkbox"]').click(function(e) {
        var formid = jQuery(this).attr('id');
        var formobj = '#form_cap_' + formid;
        var button_is = jQuery(this).is(':checked');
        //e.preventDefault(); 
        var formdata = jQuery(formobj).serialize();
        formdata += '&button_is=' + button_is;
        var turl = jQuery(formobj).attr('action');

        jQuery.ajax({
            type: 'post',
            url: turl,
            data: formdata,
            success: function(resp) {
                jQuery('#formresponse').html(resp);
            },
            error: function() {
                alert('error detected')
            }
        })
        //jQuery(this).submit();
        //	return fasle;
    })

    jQuery('input.number').keyup(function(evt) {

        var charCode = (evt.which) ? evt.which : event.keyCode;

        if (charCode > 31 && (charCode < 48 || charCode > 57))
            if (!(charCode == 190 || charCode == 110))
                if (!(charCode > 95 && charCode < 106))
                    jQuery(this).val('');
        return true;
    })
    //add_more_questions();


    /*end ready function*/
})

/* nav bar for addtion fields  */

function addtiona_field_nav() {

    jQuery('.nav-bar-question ul li').click(function() {
        var role = jQuery(this).attr('role');
        jQuery('.add-new-question .quest-block').fadeOut(250);
        jQuery('.sur-' + role).fadeIn(250);
        if (jQuery(this).hasClass('edit')) {
           
        }
    })
}

/*-----------
# thse codes are created 
# to add new options under 
# selected question
# type
#--------*/
function add_more_questions() {
    var hold = jQuery('.questions-add-option ul li:last-child');
    var last_id = parseInt(hold.data('id'));
    last_id++;
    var newobj = hold.clone();
    var fieldObj = newobj.find('textarea');
    /*for delete button*/
    newobj.find('a.remove_field').attr('href', '#');
    newobj.find('a.remove_field').attr('role', last_id);

    if (!fieldObj[0])
    fieldObj = newobj.find('input');

    newobj.attr('data-id', last_id);
    newobj.attr('class', 'field-rem-' + last_id);

    fieldObj.attr('name', 'qoption[' + last_id + ']');
    fieldObj.attr('placeholder', 'Option ' + last_id);
    fieldObj.attr('id', 'qoption_' + last_id);
    fieldObj.attr('data-id', last_id);
    fieldObj.val('');
    newobj.show(250);

    //jQuery('.questions-add-option ul').html(newobj)
    jQuery('.questions-add-option ul').append(newobj);

    //remove_fileds(); 
}

/* 
	 # this function is used 
	 # when user click on select 
	 # qustion type button
	 # 	This same function is used to 
	 # edit the Question
	 # change question type
	 */

function selectQuestionType(type) {

    jQuery('button.dropdown-btn').click(function() {
        jQuery('ul.dropdown').toggle(200);
        jQuery('.question-type ul.dropdown li').click(function() {
            jQuery('ul.dropdown').fadeOut(250);
            var dataval = jQuery(this).data('val');
            var btnName = jQuery(this).find('label').html();

            jQuery('button.dropdown-btn span.ftype').html(btnName);
            jQuery('.dropdown-btn label').attr('class', '');
            jQuery('.dropdown-btn label').addClass('field-' + dataval);

            jQuery('form.add_edit_question input#qtype').val(dataval);
            var questionid = parseInt(jQuery('.add_edit_question input#question_id').val());

            if (!questionid) {
                questionid = '';
            };

            jQuery.ajax({
                type: 'post',
                url: '/question/field_type',
                data: {
                    ftype: dataval,
                    question_id: questionid
                },
                success: function(resp) {
                    jQuery('#addNewQuestionModal .js-answer-grids').html(resp);
                }
            })
        })
    })

    /*add-coulumnto-row*/
    var elmentId = 1;
    
    jQuery("a.add-coulumnto-row").click(function(e){
        e.preventDefault();

        var newinput = document.createElement("input");
        jQuery(newinput).attr("class","form-control");
        jQuery(newinput).attr("name","extraelemrnt[]")
        jQuery(newinput).attr("value",exampleval)
        jQuery(newinput).focus(function(){
            if (jQuery(this).val() == exampleval) {
                jQuery(this).val("");
            };
            
        })
        jQuery(newinput).blur(function(){
            if (jQuery(this).val() == "") {
                 jQuery(this).val(exampleval);
            };
        })
        jQuery(".extracoulmn-add").append(newinput);
        elmentId++;
    })

    jQuery("a.remove-coulumnto-row").click(function(){

       

        if (jQuery(".extracoulmn-add input").length > 0) {
            jQuery(".extracoulmn-add input").last("input").remove();
        };

    })

    jQuery("a.remove-edited-extra-fild").click(function(e){
        e.preventDefault();
       var field = jQuery(this).data("rel"); 
       var purl = jQuery(this).data("url");
       var fid = jQuery(this).data("fid");
       jQuery(this).hide();
       if (confirm("Are you sure, This process can`t be undone.")) {
         jQuery("."+field).remove();
         jQuery(".extra-field-col-"+fid).hide(500);
         jQuery.ajax({
             url: purl,
             type: "get",
             success: function(resp){
                window.console.log(resp)
             }
         })
         return false;
       };
        
    })

}

// function to remove fields 
//from question fields
function remove_fileds(obj) {
    var turl = jQuery(obj).attr('href');
    var masterel = jQuery(obj).attr('role');
    jQuery('.field-rem-' + masterel).fadeOut(250);
    var sure = confirm('Really wants to Delete!');

    if (!sure) {
        return false;
    };

    if (turl != '' && typeof(turl) != 'undefined' && turl != '#') {
        jQuery.ajax({
            url: turl,
            type: 'post',
            success: function(resp) {},
            dataType: 'json'
        })
    };
    return false;
}

/* this function create duplicate fields
for question header fields*/

function addMoreHeaderFields($this) {
    var hold = jQuery('.qhfields-block.add-field ul li:last-child');
    var newobj = hold.clone();
    var last_id = parseInt(hold.data('id'));
    last_id++;
    newobj.attr('data-id', last_id);
    var inputobj = newobj.find('input.qhoption');
    inputobj.attr('name', 'qhoption[' + last_id + ']');
    inputobj.attr('placeholder', 'Row ' + last_id);
    inputobj.attr('id', 'qhoption_' + last_id);
    inputobj.find('qhoption.input').attr('data-id', last_id);
    jQuery('.qhfields-block.add-field ul').append(newobj);
}



function puColumn(colId,colType,colName,page_id){
    if(typeof(colId)=="undefined" || typeof(colType)=="undefined" || typeof(colName)=="undefined")
        return;

 var resstr = "";
 var colqet = colType.split(",");
    for(var i = 0; i < colqet.length; i++ ){
         resstr +="<input type='hidden' name='extrafield[]' value='"+colId+":"+colqet[i]+"' />";
    }
    resstr +="<input type='hidden' name='field_name' value='"+colName+"' />";
    resstr +="<input type='hidden' name='page_id' value='"+page_id+"' />";
    resstr +="<input type='submit' value='Create' />";
    


    jQuery(".new_field_col_block form").html(resstr);

    submit_extra_field_form();
}

function submit_extra_field_form(){
    jQuery(".new_field_col_block form").submit(function(e){
        e.preventDefault();
        var formdata = jQuery(this).serialize();
        var purl = jQuery(this).attr("action");
        jQuery.ajax({
            url: purl,
            type: "post",
            data: formdata,
            success: function(resp){
                var nfl = "";
                for(var i=0; i < resp.length; i++){
                    nfl += "<textarea class='ck_editor_load' name='extra_field["+resp[i].id+"]' id='extra_field_"+resp[i].id+"' />";
                }

                jQuery(".extracoulmn-add").append(nfl);
               jQuery.modal.close();
               window.location="";
            }
        })
    })
}

