

jQuery('#button').click(function(){

    var form = jQuery('form');
    var data = form.serialize();
    //console.log(data);

    jQuery.ajax({
        type: "POST",
        url: "/ajax.html",
        data: data,
        dataType: "json",
        success: function (far) {
            console.log(far);
           if( far ==='ok' ){ //alert('Сообщение отправлено');
						  document.location.href = 'http://www.seolab.by/contacts/success.html?aim=%C2%AB%D0%A2%D0%9E%D0%9F-SEO%3A+%D0%A2%D0%B5%D0%BE%D1%80%D0%B8%D1%8F.+%D0%9E%D0%BF%D1%8B%D1%82.+%D0%9F%D1%80%D0%B0%D0%BA%D1%82%D0%B8%D0%BA%D0%B0%C2%BB#fform';
						  window.location.href = "http://www.seolab.by/contacts/success.html?aim=%C2%AB%D0%A2%D0%9E%D0%9F-SEO%3A+%D0%A2%D0%B5%D0%BE%D1%80%D0%B8%D1%8F.+%D0%9E%D0%BF%D1%8B%D1%82.+%D0%9F%D1%80%D0%B0%D0%BA%D1%82%D0%B8%D0%BA%D0%B0%C2%BB#fform";}
            console.log('Сообщение отправлено');


            // console.log(far);
            var m= 0;
            var z;
            /*for (var i in far.Error) {
             z = far.Error.i.split("/");
             console.log(z);
             console.log(m);
             m++;
             }*/
            $('.errorMsg').remove();
            $('.errorInput').removeClass("errorInput");
            jQuery.each(far.Error, function() {
                z = this.split("/");

                //console.log(z[0]);
                // console.log(z[1]);
                //if($('['+z[1]+']').prev().hasClass("errorMsg")){$('['+z[1]+']').prev().remove(); }

                $('['+z[1]+']').after('<div class="errorMsg">'+z[0]+'</div>');
                $('['+z[1]+']').addClass("errorInput");
            });

                  var destination = $(".errorInput").offset().top;
                  console.log(destination); destination=destination-10;
                  $('body').animate( { scrollTop: destination }, 1100 );
        }
        

        
    })
    
    
   


    return false;



});


