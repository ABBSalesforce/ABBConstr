function hideall()
{
var L1=document.getElementById('link1');
var L2=document.getElementById('link2');
var L3=document.getElementById('link3');
var L4=document.getElementById('link4');
var L5=document.getElementById('link5');
var L6=document.getElementById('link6');
var L7=document.getElementById('link7');
var L8=document.getElementById('link8');
var L9=document.getElementById('link9');
//var L10=document.getElementById('link10');

L1.style.display="none";
L2.style.display="none";
L3.style.display="none";
L4.style.display="none";
L5.style.display="none";
L6.style.display="none";
L7.style.display="none";
L8.style.display="none";
L9.style.display="none";
//L10.style.display="none";
}



function hideORshow(group)
{

var L1=document.getElementById('link1');
var L2=document.getElementById('link2');
var L3=document.getElementById('link3');
var L4=document.getElementById('link4');
var L5=document.getElementById('link5');
var L6=document.getElementById('link6');
var L7=document.getElementById('link7');
var L8=document.getElementById('link8');
var L9=document.getElementById('link9');
//var L10=document.getElementById('link10');

var navGroup = document.getElementById(group);


   if(navGroup.style.display=="none")
   {
      L1.style.display="none";
      L2.style.display="none";
      L3.style.display="none";
      L4.style.display="none";
      L5.style.display="none";
      L6.style.display="none";
      L7.style.display="none";
      L8.style.display="none";
      L9.style.display="none";
//      L10.style.display="none";

      navGroup.style.display="block";
      navGroup.backgroundPosition="top";
   } 
   else 
   {
      L1.style.display="none";
      L2.style.display="none";
      L3.style.display="none";
      L4.style.display="none";
      L5.style.display="none";
      L6.style.display="none";
      L7.style.display="none";
      L8.style.display="none";
      L9.style.display="none";
//      L10.style.display="none";

      navGroup.style.display="none";
   }
}

function nonlink(page)
{

  var urlname = page + ".html";
//  alert(urlname);
  top.frames['main'].location = urlname;

}


function shrinknav()
{

  for(var i=260; i>250; i--)
     {
      parent.document.getElementsByTagName("FRAMESET").item(1).cols = i +',12,*';
      setTimeout(donothing(), 3000);
     } 
}




function expandnav()
{
   parent.document.getElementById('left').cols = '260,*';
   document.navadjust.src = "images/shrink.png";
}

function donothing() 
{

}
