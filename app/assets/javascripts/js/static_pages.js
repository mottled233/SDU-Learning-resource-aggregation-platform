function load()
{
  changecolor(11);
  changecolor(12);
}
function changecolor(id)
{
	id=id.toString();
	for (var i=1;i<=3;++i)
	{
		if (document.getElementById(i.toString()+id.substring(1,2)))
			document.getElementById(i.toString()+id.substring(1,2)).style.color='#777';
	}
	if (id.substring(0,1)=="1")
		document.getElementById("1"+id.substring(1,2)).style.color="#CE6";
	else if (id.substring(0,1)=="2")
		document.getElementById("2"+id.substring(1,2)).style.color="#E6C";
	else if (id.substring(0,1)=="3")
		document.getElementById("3"+id.substring(1,2)).style.color="#6CE";
		
		var x={};
			x.authenticity_token=$("meta[name='csrf-token']").attr("content");
			x.specify=parseInt(id);
			var h=new XMLHttpRequest();
			h.open('POST','/home_change?no_notification_check=true');
			h.setRequestHeader('Content-Type','application/json');
			h.onload=function()
			{
				console.log(h.response);
				var o=JSON.parse(h.response);
				if (o.status=="200"){
					document.getElementById("row"+id.substring(1,2)+"0").innerHTML="";
					document.getElementById("row"+id.substring(1,2)+"1").innerHTML="";
					var type="";
					if (id.substring(1,2)=="1")
						type="blogs";
					else
						type="resources";
					for (var j=0;j<=7;++j)
					{
						var span3 = document.createElement("div");
						span3.setAttribute("class","span3");
						var thumbnail = document.createElement("div");
						thumbnail.setAttribute("class","thumbnail");
						thumbnail.setAttribute("style","height:110px");
						var h2 = document.createElement("h2");
						var a = document.createElement("a");
						var small1 = document.createElement("small");
						var book = document.createElement("span");
						book.setAttribute("class","icon-book");
						var p = document.createElement("p");
						var textcenter = document.createElement("p");
						textcenter.setAttribute("class","text-center");
						var small2 = document.createElement("small");
						var dld = document.createElement("span");
						dld.setAttribute("class","icon-download-alt");
						var comment = document.createElement("span");
						comment.setAttribute("class","icon-comment");
						var thup = document.createElement("span");
						thup.setAttribute("class","icon-thumbs-up");
						var calendar = document.createElement("span");
						calendar.setAttribute("class","icon-calendar");
						a.innerHTML = o.data[j].title;
						a.setAttribute("href","http://"+document.domain+"/"+type+"/"+o.data[j].id);
						h2.appendChild(a);
						small1.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp";
						h2.appendChild(small1);
						thumbnail.appendChild(h2);
						p.innerHTML = o.data[j].content.substring(0,30)+(o.data[j].content.length>30?"...":"");
						thumbnail.appendChild(p);
						if (id.substring(1,2)=="1")
						{
							small2.appendChild(comment);
							small2.innerHTML=small2.innerHTML+" "+o.reply[j]+"&nbsp;&nbsp;&nbsp;&nbsp;";
						}
						else
						{
							small2.appendChild(dld);
							small2.innerHTML=small2.innerHTML+" "+o.data[j].download_count+"&nbsp;&nbsp;&nbsp;&nbsp;";
						}
						small2.appendChild(thup);
						small2.innerHTML=small2.innerHTML+" "+(o.data[j].good-o.data[j].bad)+"<br />";
						small2.appendChild(calendar);
						small2.innerHTML=small2.innerHTML+" "+o.data[j].created_at.substring(0,10);
						textcenter.appendChild(small2);
						thumbnail.appendChild(textcenter);
						span3.appendChild(thumbnail);
						document.getElementById("row"+id.substring(1,2)+parseInt(j/4)).appendChild(span3);
					}
				}
			}
			h.send(JSON.stringify(x));
			console.log(JSON.stringify(x));
}
function dropdownOnClick(e,id)
{
	var targ
	if (e.target) targ = e.target;
		else if (e.srcElement) targ = e.srcElement;
	if (targ.nodeType == 3) // defeat Safari bug
		targ = targ.parentNode;
	var tname;
	tname=targ.tagName;
	if (tname.toLowerCase()=='li')
	{
		document.getElementById('dropdown'+id).innerHTML=e.target.innerHTML+' <span class="caret">';
		document.getElementById('dropdown'+id).setAttribute("data-id",e.target.getAttribute("data-id"));
		if (document.getElementById('dropdown'+(parseInt(id)+1).toString()))
		{
				
			var x={};
			x.authenticity_token=$("meta[name='csrf-token']").attr("content");
			x.department_id=e.target.getAttribute("data-id");
			x.specify=parseInt(id);
			var h=new XMLHttpRequest();
			h.open('POST','/show_speciality');
			h.setRequestHeader('Content-Type','application/json');
			h.onload=function()
			{
				console.log(h.response);
				var o=JSON.parse(h.response);
				console.log(o.status);
				console.log(o.message);
				console.log(o.data);
				if (o.status=="200"){
					if (document.getElementById('dropdown'+(parseInt(id)+2).toString()))
					{
						document.getElementById('dropdown'+(parseInt(id)+2).toString()).parentNode.style.display="none";
						document.getElementById('ul'+(parseInt(id)+2).toString()).innerHTML="";
					}
					document.getElementById('dropdown'+(parseInt(id)+1).toString()).parentNode.style.display="inline";
						document.getElementById('ul'+(parseInt(id)+1).toString()).innerHTML="";
					for (var i=0;i<o.count;++i)
					{
						var newli=document.createElement("li");
						newli.setAttribute("data-id",o.data[i].id);
						if (o.data[i].name)
							newli.innerHTML=o.data[i].name;
						else
						{
							newli.innerHTML=o.data[i].course_name;
						  
						}
						document.getElementById('ul'+(parseInt(id)+1).toString()).appendChild(newli);
					}
				}
			}
			h.send(JSON.stringify(x));
			console.log(JSON.stringify(x));
		}
		if (id=='3')
		{
		  var url = "http://"+document.domain+"/courses/"+e.target.getAttribute("data-id");
			document.getElementById('goButton').style.display="inline";
			document.getElementById('goButton').setAttribute('onclick','window.open("'+url+'")');
		}
		else
			document.getElementById('goButton').style.display="none";
	}
}