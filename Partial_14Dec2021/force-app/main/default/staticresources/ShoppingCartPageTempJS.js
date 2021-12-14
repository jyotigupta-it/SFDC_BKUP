var mainProductData = {!mainString};
            var finalFamilyString = {!producFamilyData}
            var cartData=[];
            var state;
            
            window.onload = function(){
                var fil = {!mainString};
                state= {
                    'querySet': fil,
                    'page': 1,
                    'rows': 72,
                    'window': 5,
                }
                
                if(finalFamilyString!=null && finalFamilyString.length>0){
                    var famDiv=document.getElementById("familyId");
                    var tempFam='';
                    for(var key in finalFamilyString){
                        tempFam+=`<div class="labeldisplay" id="${finalFamilyString[key]}"><label style="color: white;"><input type="checkbox" class="filterCheck" value="${finalFamilyString[key]}" onclick="filterArray(this.value)"/> ${finalFamilyString[key]}</label></br></div>`;
                        
                    }
                    famDiv.innerHTML=tempFam+`</br></br>`;
                }
                
                document.getElementById("cartValue").innerHTML=0;
                var cartDiv = document.getElementById("cartDiv");
                var img = new Image();
                var div = document.getElementById('cartDiv');
                img.onload = function() {
                    div.appendChild(img);
                };
                img.src = '{!URLFOR($Resource.EmptyCart)}'; 
                img.width=310;
                img.height=200;
                document.getElementById("cartDiv").style.marginLeft = "10px";
                cartDiv.innerHTML=mainStringOfCartModal;  
                doPagination();
            }
            
            
            
            function doPagination(){
                buildTable();
                function pagination(querySet, page, rows) {
                    
                    var trimStart = (page - 1) * rows
                    var trimEnd = trimStart + rows
                    
                    var trimmedData = querySet.slice(trimStart, trimEnd)
                    
                    var pages = Math.round(querySet.length / rows);
                    
                    return {
                        'querySet': trimmedData,
                        'pages': pages,
                    }
                }
                
                function pageButtons(pages) {
                    var wrapper = document.getElementById('pagination-wrapper')
                    
                    wrapper.innerHTML = ``
                    console.log('Pages:', pages)
                    
                    var maxLeft = (state.page - Math.floor(state.window / 2))
                    var maxRight = (state.page + Math.floor(state.window / 2))
                    
                    if (maxLeft < 1) {
                        maxLeft = 1
                        maxRight = state.window
                    }
                    
                    if (maxRight > pages) {
                        maxLeft = pages - (state.window - 1)
                        
                        if (maxLeft < 1){
                            maxLeft = 1
                        }
                        maxRight = pages
                    }
                    
                    
                    
                    for (var page = maxLeft; page <= maxRight; page++) {
                        wrapper.innerHTML += `<button value=${page} class="page btn btn-sm btn-info">${page}</button>`
                    }
                    
                    if (state.page != 1) {
                        wrapper.innerHTML = `<button value=${1} class="page btn btn-sm btn-info">&#171; First</button>` + wrapper.innerHTML
                    }
                    
                    if (state.page != pages) {
                        wrapper.innerHTML += `<button value=${pages} class="page btn btn-sm btn-info">Last &#187;</button>`
                    }
                    
                    $('.page').on('click', function() {
                        $('#table-body').empty()
                        
                        state.page = Number($(this).val())
                        
                        buildTable()
                    })
                    
                }
                
                
                function buildTable() {
                    var table = $('#table-body');
                    
                    var data = pagination(state.querySet, state.page, state.rows);
                    var myList = data.querySet
                    
                    for (var i = 0 in myList) {
                        if(myList[i].productId != undefined && myList[i].productName != undefined){
                        
                        //Keep in mind we are using "Template Litterals to create rows"
                        var row = `<div class="rowhj"><tr><td>
                        <div class="col-sm-4">
                        <div class="panel panel-primary">
                        <div class="panel-heading namepanel" style="background-color: white;border-color: black"><b style="color:black">Name: ${myList[i].productName}</b></div>
                         <div class="panel-heading" style="background-color: white;border-color: black"><b style="color:black">Family: ${myList[i].productFamily}</b></div>
                         <div class="panel-heading" style="background-color: white;border-color: black"><b style="color:black">Product Code: ${myList[i].productCode}</b></div>
                         <div class="panel-heading namepanel" style="background-color: white;border-color: black"><b style="color:black">Description: ${myList[i].productDescription}</b></div>
                         <div class="panel-footer"><div class="quantity buttons_added">
                         <b style="color:black">Quantity: </b><input type="button"  value="-" class="minus"><input id="${myList[i].productId}" type="number" step="1" min="0" max="" name="quantity" value="${myList[i].quantity}" title="Qty" onchange="validate(this.value)" class="input-text qty text" size="4" pattern="" inputmode=""><input type="button" value="+" class="plus"></div>
                         <button type="button" value ="${myList[i].productId}" onclick="addToCart(this.value)" class="add_cart">Add To Cart</button>
                         </div>
                         </div>
                         </div>
                         </td>
                         </tr>
                         </div>
                         `
                         
                         table.append(row);
                }
            }
            
            pageButtons(data.pages)
            }
            
            }
            var mainString='';
            function searchKy(val,arr){
                fil=[];
                mainString=val;
                if(arr.length>0){
                    for(var key in mainProductData){
                        var str=mainProductData[key].productName+(mainProductData[key].productFamily!=null && mainProductData[key].productFamily != undefined ?mainProductData[key].productFamily:'')+(mainProductData[key].productCode!=null && mainProductData[key].productCode != undefined ?mainProductData[key].productCode:'');
                        str = str.split(" ").join("");
                        mainString=mainString.split(" ").join("");
                        if(str.toLowerCase().includes(mainString.toLowerCase()) && arr.includes(mainProductData[key].productFamily)){
                            if(fil.includes(mainProductData[key])){
                                fil.splice(fil.indexOf(mainProductData[key]),1);
                            }
                            else{
                                fil.push(mainProductData[key]);
                            }
                            
                        }
                    }
                    console.log(fil);
                }else{
                    for(var key in mainProductData){
                        var str=mainProductData[key].productName+(mainProductData[key].productFamily!=null && mainProductData[key].productFamily != undefined ?mainProductData[key].productFamily:'')+(mainProductData[key].productCode!=null && mainProductData[key].productCode != undefined ?mainProductData[key].productCode:'');
                        str = str.split(" ").join("");
                        mainString=mainString.split(" ").join("");
                        if(str.toLowerCase().includes(mainString.toLowerCase())){
                            if(fil.includes(mainProductData[key])){
                                fil.splice(fil.indexOf(mainProductData[key]),1);
                            }
                            else{
                                fil.push(mainProductData[key]);
                            }
                            
                        }
                    }
                    console.log(fil);
                }
                
                
                state= {
                    'querySet': fil,
                    'page': 1,
                    'rows': 72,
                    'window': 5,
                }
                
                // $("#table-body tr").remove(); 
                var Table = document.getElementById("table-body");
                Table.innerHTML = "";
                
                doPagination();
            }
            var mainStringOfCartModal='';
            var validateCart=[];
            function addToCart(val){
                //navigator.vibrate(50);
                console.log(val);
                var cartWrap;
                if(validateCart.includes(val)){
                    // alert('Selected product is already in cart.');
                    var x = document.getElementById("snackbar");
                    x.innerHTML='Product is already in cart.';
                    x.className = "show";
                    console.log(x);
                    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
                }
                else{
                    var tempQuan =document.getElementById(val).value;
                    if(document.getElementById(val).value<=0 || document.getElementById(val).value==''){
                        var x = document.getElementById("snackbar");
                        x.innerHTML='Please select quantity';
                        x.className = "show";
                        console.log(x);
                        setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
                    }else{
                        cartWrap = {'cartProductIds' : val , 'cartQuantity' :tempQuan , 'cartProductName': mainProductData.find(item => item.productId == val)};
                        cartData.push(cartWrap);
                        validateCart.push(val);
                        var x = document.getElementById("snackbar");
                        x.innerHTML='Item added to cart.';
                        x.className = "show";
                        console.log(x);
                        setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
                    }
                }
                console.log(cartData);
                var tem=[];
                var cartWrap;
                if(cartData.length>0){ 
                    mainStringOfCartModal='';
                    for(var key in cartData){
                        console.log(cartData[key].cartProductName.productName);
                        var tempName=cartData[key].cartProductName.productName;
                        console.log(tempName);
                        //tem.push(mainProductData.find(item => item.productId == cartData[key].cartProductIds));
                        mainStringOfCartModal+=`<div class="col-sm-4"><div class="panel panel-primary"><div class="panel-heading">Product: ${tempName}</div>
                        <div class="panel-footer">Quantity: <div class="quantity buttons_added">
                            <input type="button"  value="-" class="minus"><input type="number" step="1" min="0" max="" name="quantity" value="${cartData[key].cartQuantity}" title="${cartData[key].cartProductIds}" onchange="changeThecartValue(this.title,this.value)" onblur="changeThecartValue(this.title,this.value)" class="input-text qty text" size="4" pattern="" inputmode=""><input type="button" value="+" class="plus"></div>
                            <button value="${cartData[key].cartProductIds}" onclick="cartRemoval(this.value)" type="button" class="remove_cart">Remove</button></div>
                                <div class="panel-footer"></div></div></div>`;
                                
                    }
                    document.getElementById("cartValue").innerHTML=cartData.length;
                    var cartDiv = document.getElementById("cartDiv");
                    cartDiv.innerHTML=mainStringOfCartModal;  
                    //console.log(tem);
                    
                }
                
            }
            function cartRemoval(val){
                //alert(val);
                //navigator.vibrate(50);
                if(validateCart.includes(val)){
                    console.log(validateCart);
                    console.log(cartData);
                    if(validateCart.length>1){
                        validateCart.splice(validateCart.indexOf(val),1);
                        for(var key in cartData){
                            if(cartData[key].cartProductIds==val){
                                cartData.splice(key,1)
                            }
                        }
                    }else{
                        validateCart=[]
                        cartData=[];
                        
                    }
                    
                }
                console.log(validateCart);
                console.log(cartData);
                prepareCartAfterRemoval();
            }
            
            function prepareCartAfterRemoval(){
                mainStringOfCartModal='';
                if(cartData.length>0){ 
                    for(var key in cartData){
                        console.log(cartData[key].cartProductName.productName);
                        var tempName=cartData[key].cartProductName.productName;
                        console.log(tempName);
                        //tem.push(mainProductData.find(item => item.productId == cartData[key].cartProductIds));
                        mainStringOfCartModal+=`<div class="col-sm-4"><div class="panel panel-primary"><div class="panel-heading">Product: ${tempName}</div>
                        <div class="panel-footer">Quantity: <div class="quantity buttons_added">
                            <input type="button"  value="-" class="minus"><input type="number" step="1" min="0" max="" name="quantity" value="${cartData[key].cartQuantity}" title="${cartData[key].cartProductIds}" onchange="changeThecartValue(this.title,this.value)" onblur="changeThecartValue(this.title,this.value)" class="input-text qty text" size="4" pattern="" inputmode=""><input type="button" value="+" class="plus"></div>
                            <button value="${cartData[key].cartProductIds}" onclick="cartRemoval(this.value)" type="button" class="remove_cart">Remove</button></div>
                                <div class="panel-footer"></div></div></div>`;
                    }
                    document.getElementById("cartValue").innerHTML=cartData.length;
                    var cartDiv = document.getElementById("cartDiv");
                    cartDiv.innerHTML=mainStringOfCartModal;  
                }else{
                    var cartDiv = document.getElementById("cartDiv");
                    
                    var img = new Image();
                    var div = document.getElementById('cartDiv');
                    img.onload = function() {
                        div.appendChild(img);
                    };
                    img.src = '{!URLFOR($Resource.EmptyCart)}'; 
                    img.width=310;
                    img.height=200;
                    document.getElementById("cartValue").innerHTML=cartData.length;
                    document.getElementById("cartDiv").style.marginLeft = "10px";
                    cartDiv.innerHTML=mainStringOfCartModal;  
                }
            }
            
            function changeThecartValue(updatedProduct,updatedValue){
                console.log(updatedProduct);  
                console.log(validateCart);
                
                if(validateCart.includes(updatedProduct) && updatedValue>0){
                    console.log(validateCart);
                    console.log(cartData);
                    
                    for(var key in cartData){
                        if(cartData[key].cartProductIds==updatedProduct && cartData[key].cartQuantity != updatedValue && updatedValue>0){
                            cartData[key].cartQuantity = updatedValue;
                        }
                        
                    }
                }else{
                    console.log(validateCart);
                    console.log(cartData);
                    
                    for(var key in cartData){
                        if(cartData[key].cartProductIds==updatedProduct && cartData[key].cartQuantity != updatedValue){
                            cartData[key].cartQuantity = 1;
                            
                        }
                        
                    }
                    prepareCartAfterRemoval();
                    alert('Please Select atleast one quantity otherwise product was not place');
                    
                }
            }
            
            
            
            function placeOrder(){
                //navigator.vibrate(50);
                var cartToBackend=[];
                var cartEach;
                if(cartData.length>0){
                    for(var key in cartData){
                        cartEach={'productToPlace':cartData[key].cartProductIds,'quantityOfProduct':cartData[key].cartQuantity};
                        cartToBackend.push(cartEach);
                    }
                    placeOrderToBacked(JSON.stringify(cartToBackend));
                    console.log(cartToBackend);
                }else
                {
                    alert('Cart Is Empty');
                    
                }
                
            }
            
            var family =[];
            function filterArray(val){
                //navigator.vibrate(50);
                if(family.includes(val)){
                    family.splice(family.indexOf(val), 1);
                }else{
                    family.push(val);
                }
                
                console.log('mainString'+mainString);
                searchKy(mainString,family);
                
            }
            
            function searchFamily(val){
                console.log(val);
                if(val != undefined){
                    
                    var x = document.getElementsByClassName("labeldisplay");
                    console.log(x);
                    for(var key in x){
                        var tem=x[key].id;
                        tem=tem.toLowerCase();
                        val = val.toLowerCase();
                        if(tem.includes(val)){
                            x[key].style.display="block";                        
                        }else{
                            x[key].style.display="none";                        
                            
                        }
                        
                    }
                }
            }
            
            function clearFilter(){
                var checkboxes = document.getElementsByClassName('filterCheck');
                family = [];
                for (var i=0; i<checkboxes.length; i++)  {
                    if (checkboxes[i].type == 'checkbox')   {
                        checkboxes[i].checked = false;
                    }
                }
                searchKy(mainString,family);
                var x = document.getElementsByClassName("labeldisplay");
                document.getElementById('familySearcher').value='';
                
                for(var key in x){
                    
                    x[key].style.display="block";                        
                    
                    
                }
                
            }
            
            function openNav() {
                document.getElementById("mySidenav").style.width = "280px";
                //document.getElementById("containerDiv").style.marginLeft = "350px";
                document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
                document.getElementById("searchInput").style.display="none";
                
                
            }
            
            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
                //document.getElementById("main").style.marginLeft= "0";
                document.body.style.backgroundColor = "white";
                document.getElementById("searchInput").style.display="block";
                
            }
            
            
            
            
            function wcqib_refresh_quantity_increments() {
                //navigator.vibrate(50);
                jQuery("div.quantity:not(.buttons_added), td.quantity:not(.buttons_added)").each(function(a, b) {
                    var c = jQuery(b);
                    c.addClass("buttons_added"), c.children().first().before('<input type="button" value="-" class="minus" />'), c.children().last().after('<input type="button" value="+" class="plus" />')
                })
            }
            String.prototype.getDecimals || (String.prototype.getDecimals = function() {
                var a = this,
                    b = ("" + a).match(/(?:\.(\d+))?(?:[eE]([+-]?\d+))?$/);
                return b ? Math.max(0, (b[1] ? b[1].length : 0) - (b[2] ? +b[2] : 0)) : 0
            }), jQuery(document).ready(function() {
                wcqib_refresh_quantity_increments()
            }), jQuery(document).on("updated_wc_div", function() {
                wcqib_refresh_quantity_increments()
            }), jQuery(document).on("click", ".plus, .minus", function() {
                var a = jQuery(this).closest(".quantity").find(".qty"),
                    b = parseFloat(a.val()),
                    c = parseFloat(a.attr("max")),
                    d = parseFloat(a.attr("min")),
                    e = a.attr("step");
                b && "" !== b && "NaN" !== b || (b = 0), "" !== c && "NaN" !== c || (c = ""), "" !== d && "NaN" !== d || (d = 0), "any" !== e && "" !== e && void 0 !== e && "NaN" !== parseFloat(e) || (e = 1), jQuery(this).is(".plus") ? c && b >= c ? a.val(c) : a.val((b + parseFloat(e)).toFixed(e.getDecimals())) : d && b <= d ? a.val(d) : b > 0 && a.val((b - parseFloat(e)).toFixed(e.getDecimals())), a.trigger("change")
            });
            
            //modify following code as your need
            function validate(val){
                //navigator.vibrate(50);
                //alert('Coming'+val);
                if (val<0 || val==''){
                    event.target.value =0;
                }else{
                }
            }