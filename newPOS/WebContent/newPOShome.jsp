<!DOCTYPE html>
<html lang="en">
<head>
  <title>Project POS</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
 
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../../jquery.easyui.min.js"></script>
  
  <script type="text/javascript" src="items.json"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 490px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #cccccc;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
       
    
    tbody{
    color:green;
    border-collapse: collapse;
    border-spacing: 0;
    font-weight:bold;

    }
    
    .btn{
     border-radius:30%; 
    border-color: brown;
    color:black;
    font-weight:bold;
    width:100px;
    box-shadow:2px 5px gray;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
    
   
	
	#keypad {margin:auto; margin-top:20px;}

	#keypad tr td {
	vertical-align:middle;
	text-align:center;
	border:10px solid #000000;
	font-size:18px;
	font-weight:bold;
	width:100px;
	height:60px;
	cursor:pointer;
	background-color:#666666;
	color:#CCCCCC;}

	#keypad tr td:hover {background-color:#999999; color:#FFFF00;}

	output{
	border:10px solid #000000;
	text-align:right;
	background-color:#ffffb3;
	font-size:20px;
	color:#cc0000;
	font-weight:bold;
	}
	
	.modal {
	
	padding-top: 100px;
    background-color:rgba(0,0,0,0.4);
	}
	
	.close{
	display:none;
	}
	
	output{
	margin: auto;
    width: 25%;
    padding: 10px;
	}
	
	#creditmsg{
	border:10px solid #000000;
	margin: auto;
    width: 100%;
    background-color:#ffff99;
    padding: 10px;
	}
	
	#receipt{
	border:10px solid #000000;
	margin: auto;
    background-color:#ffff99;
    padding: 10px;
    color:#990000;
    font-size:20px;
    font-weight:bold;
	}
	
	#msFront{
	border:1px solid #000000;
	margin: auto;
    background-color:#ffff99;
    padding: 1px;
    color:#990000;
    font-size:16px;
    font-weight:bold;
	}
	
	.table-wrapper{
    width: 100%;
    height: 80%;
    overflow: auto;
	}

  </style>
  
 	
<!--   all function calls -->
  <script>
  //initializing variables
  var count=1; 				// number of items in cart
  var total=0;				// total price
  var cash="";				// cash received
  var balance=0;			// cash balance
  
// addings items to shopping cart
  function searchItem(itemcode){
	   var addItem;
	   
// getting item details from JSON file
	   $.getJSON("JSON/items.json", function (data) {
		    var name = data.rows[itemcode].item;
		    var cost = data.rows[itemcode].price;
		    var amount = cost;
		    
			addItem="<tr onclick='passCount(this)'>"
			  +"<td>"+count+"</td>"
			  +"<td>"+name+"</td>"
			  +"<td><div id='cst"+count+"'>"+cost+"</div></td>"
			  +"<td><div id='qua"+count+"' class='sum' contenteditable>1</div></td>"			  
			  +"<td><div id='amou'>"+(amount)+"</div></td></tr>";
			
// adding item to end of table
			  $("#screenout").append(addItem);
			  total=0;
			  for(var i=1; i<=count;i++){
				itemtotal=document.getElementById("screenout").rows[i].cells[4].childNodes[0].innerHTML;				  
			  	total= +total + +itemtotal;  
			  }
			  count++;
// diplay sutotal at the bottom			  
			  $("#tot").text(total);
			  $("#tot").show();
  			} );
  		}
  
// functions
// f for finding total price of each item entered
  function passCount(count1) {
	 var count2=count1.rowIndex; 	
	 var tabdat = document.getElementById("screenout");
	 var dat=tabdat.rows[count2].cells[3];
     var quantity=dat.childNodes[0].innerHTML;
// reading quantity entered for each item	 
     $('#qua'+count2+'').keyup(function (event) {
		  
		    if (event.keycode == 13) {		//preventing cursor from moving to next line on enter key (not working)
		    	event.preventDefault();
		    }
		  var price=document.getElementById("screenout").rows[count2].cells[2].childNodes[0].innerHTML;
		  var quantity=document.getElementById("screenout").rows[count2].cells[3].childNodes[0].innerHTML;
  		  document.getElementById("screenout").rows[count2].cells[4].childNodes[0].innerHTML=(price*quantity).toFixed(2);
  		  totalPrice(count);	 		    
		});  
  } 
// f for finding total price of all items in cart  
  function totalPrice(count){
	  total=0;
	  for(var i=1; i<count;i++){
		itemtotal=document.getElementById("screenout").rows[i].cells[4].childNodes[0].innerHTML;  
	  	total= (+total + +itemtotal).toFixed(2);
	  	}
	  $("#tot").text(total);
	  $("#tot").show();
  	}
// f for dialog boxes  
  $( function() {
//hiding all dialog boxes
	    $( "#keys" ).dialog({
	      autoOpen: false,
	    	});
	    $( "#creditmsg" ).dialog({
		      autoOpen: false,
		      width:'50%'
		    });
	    $("#receipt").dialog({
	    	autoOpen: false,
	    	width:'50%',
	    	height:400,
	    	});
	    $( "#msFront" ).dialog({
		      autoOpen: false,
		      width:'30%',
		      height:500,
		    });
	    
//opening dialog boxes	 
	//for cash- open keypad
	    $( "#cashbutton" ).on( "click", function() {
	      $( "#keys" ).dialog( "open" );
	    });
	//for credit card    
	    $("#creditButton").on("click", function(){
	    	$("#creditmsg").dialog("open");
	    	$("#creditmsg").closest(".ui-dialog").find(".ui-dialog-titlebar-close").hide();
	    });
	//for gift card
	    $("#giftButton").on("click", function(){
	    	$("#creditmsg").dialog("open");
	    	$("#creditmsg").closest(".ui-dialog").find(".ui-dialog-titlebar-close").hide();
	    });
	// manager settings page
	    $("#managerButton").on("click", function(){
	    	$("#msFront").dialog("open");
	    	
	    });
  } );
// f for reading values from cash keypad  
  function addCode(keyvalue){
	  cash=cash+keyvalue;
	  document.getElementById("out").innerHTML = cash;
	  balance = (cash-total).toFixed(2);	  	  
  }
// f for done button in cash keypad  
  function cashDone(){
	  if(cash==""){
		  cash=0;
	  	}
//hiding close button on this dialog box	  
	  $("#receipt").closest(".ui-dialog").find(".ui-dialog-titlebar-close").hide();
	  document.getElementById("out").innerHTML = '0.00';
	  $( '#keys' ).dialog( 'close' );	// closing cash keypad
	  $("#receipt").dialog("open");		// opening receipt dialog box
	  $("#recTotal").html(total);		// receipt details
	  $("#recCash").html(cash);
	  $("#recBalance").html(balance); 
	  cash=0; 							// resetting cash after each transaction
  }
  
  
  </script>

</head>

<body>

<!-- navigation bar -->
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header"> 
      <a class="navbar-brand" href="#"><img src="https://www.romiyo.com/wp-content/uploads/2016/11/Romiyo-logo1000px.jpg" width="100"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">  
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<!-- main screen - menu items and shopping cart table -->  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-4 sidenav">
    
  		<p id="time"></p>  
   		 <script>
			var d = new Date();
			document.getElementById("time").innerHTML = d;
		 </script>
<div class="table-wrapper">
	<table id="screenout" class="table table-striped" >
    <thead>
      <tr>
        <th>#</th>
        <th>Items</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
      </tr>
    </thead>
    <tbody>
      
      
    </tbody>
  </table>
  </div>
  
<div class="col-sm-4">
<p style="color:#991f00; font-size:15px; font-weight:bold">Sub Total</p>
</div>
<div>
 <span style="color:#991f00; font-size:20px; font-weight:bold" id="tot">0</span>
 
</div>

     
      
    </div>
    <div class="col-sm-8 text-left"> 
    
    <div class="container-fluid">
      <h3>Bakery</h3>
   
		<button class="btn btn-info btn-lg" onclick="searchItem(0)">Bread</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(1)">Roll</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(2)">Pie</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(3)">Danish</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(4)">Muffins</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(5)">Cake</button>   
		<button class="btn btn-info btn-lg" onclick="searchItem(6)">Croissant</button><br><br>   
		<button class="btn btn-info btn-lg" onclick="searchItem(7)">Bagel</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(8)">Donut</button><br>
		      
      </div>
    
    <div class="container-fluid">
      <h3>Fruits</h3>
   
		<button class="btn btn-info btn-lg" onclick="searchItem(9)">Apple</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(10)">Orange</button>
		<button class="btn btn-info btn-lg" onclick="searchItem(11)">Grape</button>   
		<button class="btn btn-info btn-lg" onclick="searchItem(12)">Banana</button>   
		<button class="btn btn-info btn-lg" onclick="searchItem(13)">Peach</button><br>
		      
      </div>
      
      <div class="container">
      <h3>Drinks</h3>
      	<button class="btn btn-info btn-lg"  onclick="searchItem(14)">Milk</button>
		<button class="btn btn-info btn-lg"  onclick="searchItem(15)">Soda</button>
		<button class="btn btn-info btn-lg"  onclick="searchItem(16)">Juice</button>
		<button class="btn btn-info btn-lg"  onclick="searchItem(17)">Tea</button>
		<button class="btn btn-info btn-lg"  onclick="searchItem(18)">Coffee</button>   
		<button class="btn btn-info btn-lg"  onclick="searchItem(19)">Beer</button><br>
		   
      </div>
      
      
      <!-- <div class="container">
      <h3>Misc</h3>
      	<button class="btn btn-success">Candy</button>
      	<button class="btn btn-success">Toys</button><br><br>
      	
      </div> -->
    
    </div>
    
  </div>
</div>

<!-- payment options -->
<footer class="container-fluid">
<button type="button" class="btn btn-danger" id="cashbutton">Cash</button>
<button type="button" class="btn btn-danger" id="creditButton">Credit</button>
<button type="button" class="btn btn-danger" id="giftButton">Gift Card</button>
  <input type="button" value="Manager" id="managerButton" style="float: right;">
  
 
</footer>

<!-- Keypad for cash payment -->
<div id="keys" class="modal">
<output id="out">0.00</output>
<table id="keypad">
	<tr>
    	<td onclick="addCode('1');">1</td>
        <td onclick="addCode('2');">2</td>
        <td onclick="addCode('3');">3</td>
    </tr>
    <tr>
    	<td onclick="addCode('4');">4</td>
        <td onclick="addCode('5');">5</td>
        <td onclick="addCode('6');">6</td>
    </tr>
    <tr>
    	<td onclick="addCode('7');">7</td>
        <td onclick="addCode('8');">8</td>
        <td onclick="addCode('9');">9</td>
    </tr>
    <tr>
    	<td onclick="addCode('.');">.</td>
        <td onclick="addCode('0');">0</td>
        <td onclick="addCode('00');">00</td>
    </tr>
    <tfoot>
    <tr>
    <td style="background-color:#b30000" colspan="3" onclick="cashDone()">DONE</td>
    </tr>
    </tfoot>
</table>
</div>

<!-- Credit card and gift card screen -->
<div id="creditmsg" >
<h2> Swipe your card </h2>
<h3>Follow the instructions on card reader.</h3>
<div><a href="POSHome.jsp">
		<button style="background-color:#99ff99;margin:auto;display:block">Done</button>
	</a></div>
</div>

<!-- transaction summary -->
<div id="receipt">
	<div class="col-sm-6">
		<p>Sub Total </p>
	</div>
	<div id="recTotal"></div><br>
	
	<div class="col-sm-6">
		<p>Cash Received</p>
	</div>
	<div id="recCash"></div><br>
	
	<div class="col-sm-6">
		<p>Balance </p>
	</div>
	<div id="recBalance"></div><br>
	<div><a href="newPOShome.jsp">
		<button style="background-color:#99ff99;margin:auto;display:block">Done</button>
	</a></div>	
</div>

<div id="msFront">
	<div class="container">
  	<h3>Settings</h3>
  	<ul class="nav nav-tabs">
    	<li><a href="#">ADD</a></li>
    	<li><a href="#">EDIT</a></li>
    	<li><a href="#">DELETE</a></li>
  	</ul>
	</div>
</div>
<div id="msAdd" hidden=""></div>
<div id="msEdit" hidden=""></div>
<div id="msDelete" hidden=""></div>
</body>
</html>
