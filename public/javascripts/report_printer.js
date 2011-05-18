function print_content(id){
  var data = document.getElementById(id).innerHTML;
  var popupWindow = window.open('','printwin',
          'left=100,top=100,width=400,height=400');
     popupWindow.document.write('<HTML>\n<HEAD>\n');
     popupWindow.document.write('<TITLE></TITLE>\n');
     popupWindow.document.write('<URL></URL>\n');
     popupWindow.document.write('<script>\n');
     popupWindow.document.write('function print_win(){\n');
     popupWindow.document.write('\nwindow.print();\n');
     popupWindow.document.write('\nwindow.close();\n');
     popupWindow.document.write('}\n');
     popupWindow.document.write('<\/script>\n');
     popupWindow.document.write('</HEAD>\n');
     popupWindow.document.write('<BODY onload="print_win()">\n');
     popupWindow.document.write(data);
     popupWindow.document.write('</BODY>\n');
     popupWindow.document.write('</HTML>\n');
     popupWindow.document.close();
    }
