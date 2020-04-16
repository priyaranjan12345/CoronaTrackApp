<%-- 
    Document   : Data
    Created on : 14 Apr, 2020, 12:52:10 PM
    Author     : Priyaranjan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web Scrapping</title>
        <link rel="stylesheet" type="text/css" href="CSS/Design.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body style="background-color: darkred;">
        <div class="loader_bg">
            <div class="loader">
                
            </div>
        </div>
        <div id="contener">
        <table id="t1" border="1">
            <thead >
                <tr>
                    <th>
                        Sl No
                    </th>
                    <th>
                        State Name
                    </th>
                    <th>
                        Affected
                    </th>
                    <th>
                        Recovered
                    </th>
                    <th>
                        Death
                    </th>
                    <th>
                        Total Affected
                    </th>
                </tr>
            </thead>
            <tbody>
                 <%
                    String url = "https://www.mohfw.gov.in/";
                    int af[] = new int[33];
                    int re[] = new int[33];
                    int de[] = new int[33];
                    int to[] = new int[33];
                    Document doc = null;
                    int a = 0, k=0, m=0, n=0, o=0 ,p=0;
                    int affected=0,death=0,recovred=0,total=0;
                try{
                    doc = Jsoup.connect(url).get();
                    String title = doc.title();
                    out.println("Title : "+title);
                    out.print("<input type=\"button\" value=\"World Result\"/>"); 
                    Elements table = doc.select("table");
                    
                    for(Element row : table.select("tr"))
                    {
                        k++;
                        if(k<=1)
                            continue;
                        %><tr><%
                            
                        for(Element col : row.select("td"))
                        {
                            a++;
                            if(a==3){
                                af[m] = Integer.parseInt(col.text());
                                affected=Integer.parseInt(col.text());
                                m++;
                            }
                            else if(a==4){
                                recovred=Integer.parseInt(col.text());
                                re[n] = Integer.parseInt(col.text());
                                n++;
                            }
                            else if(a==5){
                                a=0;
                                death=Integer.parseInt(col.text());
                                de[o] = Integer.parseInt(col.text());
                                o++;
                                total=affected-(death+recovred);
                                to[p] = total;
                                p++;
                            }
                        %>
                        <td><%=col.text()%></td>
                        <%}
                        if(k>1){
                        %><td><%=total%></td></tr><%}
                    
                    if(k>33)
                        break;
                    }
                }catch(Exception e){out.println("Error : "+e.getMessage());}
                int s1=0,s2=0,s3=0,s4=0;
                for(int r=0; r<re.length; r++)
                {
                    s1 += re[r];
                    s2 += de[r];
                    s3 += af[r];
                    s4 += to[r];
                }
                %>   
            </tbody>
            <tfoot>
                <tr>
                    <td>#</td>
                    <td>All State Total Result : </td>
                    <td><%=s3%>*</td>
                    <td><%=s1%></td>
                    <td><%=s2%></td>
                    <td><%=s4%></td>
                </tr>
            </tfoot>
        </table>
        
        </div>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
            <script>
                setTimeout(function(){
                    $('.loader_bg').fadeToggle();
                }, 1500);
            </script>
    </body>
</html>
