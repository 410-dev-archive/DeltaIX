<%@ page import="org.mcmasterkboys.codenamehenryford.objects.User" %>
<%@ page import="org.mcmasterkboys.codenamehenryford.objects.banking.BankAccount" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.mcmasterkboys.codenamehenryford.objects.banking.Transactions" %>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Main</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .container {
            width: 250px;
            height: 140px;
            overflow: yes;
        }

        .container::-webkit-scrollbar {
            width: 10px;
        }

        .container::-webkit-scrollbar-thumb {
            background-color: #2f3542;
            border-radius: 10px;
            background-clip: padding-box;
            border: 2px solid transparent;
        }

        .container::-webkit-scrollbar-track {
            background-color: grey;
            border-radius: 10px;
            box-shadow: inset 0px 0px 5px white;
        }

        html,
        body {
            display: flex;
            flex-direction: column;
            flex: 1;
            justify-content: center;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
    </style>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
      <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

          var datstruct = [
            ['Month', 'Last_Month', 'This_Month']
          ];

          var lastMon = 0;
          var thisMon = 0;

          for(var i = 0; i < 31; i++) {
            lastMon += Math.floor(Math.random() * 300);
            thisMon += Math.floor(Math.random() * 300);
            var e = [(i+1) + '', lastMon, thisMon];
            datstruct.push(e);
          }

          var data = google.visualization.arrayToDataTable(datstruct);


          var options = {
            curveType: 'function',
            legend: { position: 'bottom' }
          };

          var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

          chart.draw(data, options);
        }
      </script>

</head>

<%

    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get bank accounts
    BankAccount[] accounts = null;
    try {
        accounts = u.getBankAccounts();
    } catch (Exception e) {
        e.printStackTrace();
        return;
    }

    // Get transactions
    ArrayList<Transactions> transactionsThisMonth = new ArrayList<>();
    ArrayList<Transactions> transactionsLastMonth = new ArrayList<>();

    for (BankAccount account : accounts) {
        transactionsLastMonth.addAll(account.getTransactions("2022-12-01", "2022-12-31"));
        transactionsThisMonth.addAll(account.getTransactions("2023-01-01", "2023-01-30"));
    }

    // Get total spending
    double[] spendingLastMonth = new double[31];
    double[] spendingThisMonth = new double[31];
    double totalSpending = 0;

    for (Transactions transaction : transactionsLastMonth) {
        spendingLastMonth[transaction.getDay() - 1] += transaction.getAmount() * -1;
    }

    for (Transactions transaction : transactionsThisMonth) {
        spendingThisMonth[transaction.getDay() - 1] += transaction.getAmount() * -1;
        totalSpending += transaction.getAmount() * -1;
    }

%>
<jsp:include page="include/header.jsp">
    <jsp:param name="name" value="<%=u.getFirstName()%>" />
</jsp:include>
    <body>
    <div style="font-size:80px; font-weight:bold; text-align:e; margin-left:185; margin-top:70px;"> Welcome, <%=u.getFirstName()%>! </div>
    <div class="w-[100vw] h-[100vh] relative overflow-hidden bg-white">
        <div class="flex flex-col justify-start items-center absolute left-[175px] top-[480px] gap-[43px] p-[30px] rounded-[30px] bg-[#D8E5C4]" style="box-shadow: 0px 2px 5px 0 rgba(38,51,77,1);">
            <div class="flex justify-between items-center flex-grow-0 flex-shrink-0 w-[1565px] relative">
                <p class="flex-grow-0 flex-shrink-0 w-[1093px] h-[30px] text-4xl font-bold text-left text-black"> New to Canada? </p>
            </div>
            <a href="categoryview.jsp?category=B0B4C866-1212-42B6-9DFA-4381C8EE1B02&title=Bank">Bank</a>
            <a href="categoryview.jsp?category=28DA7D3C-9FF4-41A8-9785-0D96F5D98C6A&title=Transportation">Transportation</a>
            <a href="categoryview.jsp?category=4BEBCB22-BACE-4CE8-A174-C50160B4F20F&title=School">School</a>
            <a href="categoryview.jsp?category=7D470298-959B-45DF-9A65-DAB317050F32&title=Housing">Housing</a>
            <a href="categoryview.jsp?category=AF87B972-4096-42CF-BADD-4575A5AFB577&title=Forums">Forums</a>
        </div>
<%--        <div class="flex flex-col justify-start items-center absolute left-[175px] top-[840px] gap-[43px] p-[30px] rounded-[30px] bg-[#FDF4EA]" style="box-shadow: 0px 2px 5px 0 rgba(38,51,77,1);">--%>
<%--            <div class="flex justify-between items-center flex-grow-0 flex-shrink-0 w-[2010px] h-[0] relative">--%>
<%--              <form action="" method="">--%>
<%--                <div>--%>
<%--                    <input type="text" placeholder="     If you have a question Put your Question Here and press enter to submit" maxlength="200" style="width:2000; height:210px; margin-top:250px;">--%>
<%--                </div>--%>
<%--                <input type="submit" value="Submit" hidden>--%>
<%--              </form>--%>
<%--            </div>--%>
<%--            <svg width="996" height="193" viewBox="0 0 996 193" fill="none" xmlns="http://www.w3.org/2000/svg" class="flex-grow-0 flex-shrink-0 w-[992px] h-[193px] relative" preserveAspectRatio="none">--%>
<%--            </svg>--%>
<%--        </div>--%>
        <div class="flex flex-col justify-start items-start w-[1000px] h-[421px] absolute left-[800px] top-[25px] gap-[30px] px-10 pt-10 pb-[98px] rounded-[30px] bg-neutral-50" style="box-shadow: 0px 2px 5px 0 rgba(38,51,77,1);">
            <div class="flex justify-between items-center self-stretch flex-grow-0 flex-shrink-0 relative">
                <p class="flex-grow-0 flex-shrink-0 text-2xl font-bold text-left text-[#4d5e80]"> Transactions </p>
                <div class="flex justify-start items-center flex-grow-0 flex-shrink-0" style="filter: drop-shadow(0px 2px 5px rgba(38,51,77,0.03));">
                </div>
            </div>
            <div class="flex flex-col justify-start items-start flex-grow-0 flex-shrink-0 h-[268px] w-[343px] gap-[31px] pb-[130px]">
                <div class="flex justify-between items-center self-stretch flex-grow-0 flex-shrink-0 relative">
                    <div class="flex justify-start items-center flex-grow-0 flex-shrink-0 gap-[25px]">
                        <div class="flex justify-center items-center flex-grow-0 flex-shrink-0 relative gap-2.5 p-[15px] rounded-[100px] bg-[#f7f8fa]">
                            <svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg" class="flex-grow-0 flex-shrink-0 w-[30px] h-[30px] relative" preserveAspectRatio="none">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M9.00148 4.20126C9.71892 3.78706 10.6363 4.03289 11.0505 4.75034L12.022 6.43307C12.7118 6.0658 13.4992 5.82341 14.3426 5.74207H15.6035C16.447 5.82344 17.2344 6.06586 17.9242 6.43317L18.8959 4.7503C19.3101 4.03286 20.2275 3.78706 20.9449 4.20128C21.6623 4.6155 21.9081 5.53289 21.4939 6.25032L20.1703 8.54284C20.1578 8.56452 20.1448 8.58578 20.1314 8.6066C20.4436 9.20694 20.6213 9.87154 20.631 10.5713H9.31507C9.32481 9.87146 9.50251 9.20681 9.81476 8.60643C9.80137 8.58565 9.78842 8.56444 9.77593 8.5428L8.4524 6.25029C8.0382 5.53284 8.28403 4.61546 9.00148 4.20126ZM7.25471 11.8327C7.94758 11.8327 8.50934 12.3945 8.50934 13.0874V18.4698C8.50934 19.1628 7.94758 19.7245 7.25471 19.7245C6.56176 19.7245 6 19.1628 6 18.4699V13.0875C5.99991 12.3946 6.56167 11.8327 7.25471 11.8327ZM19.0582 20.9897H19.1195C19.9813 20.9897 20.6755 20.283 20.6755 19.4061V11.2513C20.6755 11.2027 20.6737 11.1544 20.6697 11.107H9.27841C9.27427 11.1546 9.27066 11.2027 9.27066 11.2513V19.4061C9.27066 20.2831 9.96485 20.9897 10.8266 20.9897H10.8882V24.2152C10.8882 24.9082 11.45 25.4698 12.1428 25.4698C12.8358 25.4698 13.3975 24.9082 13.3975 24.2152V20.9897H16.5488V24.2152C16.5488 24.9082 17.1106 25.4698 17.8034 25.4698C18.4964 25.4698 19.0582 24.9082 19.0582 24.2152V20.9897ZM23.9463 13.0874C23.9463 12.3945 23.3845 11.8327 22.6916 11.8327C21.9987 11.8327 21.4369 12.3946 21.4369 13.0875V18.4699C21.4369 19.1628 21.9987 19.7245 22.6916 19.7245C23.3845 19.7245 23.9463 19.1628 23.9463 18.4698V13.0874Z" fill="#29CC39"></path>
                            </svg>
                        </div>
                        <div class="flex flex-col justify-start items-start flex-grow-0 flex-shrink-0 relative gap-[5px]">
                            <p class="flex-grow-0 flex-shrink-0 text-sm font-bold text-left text-[#4d5e80]"> Google Play Purchase </p>
                            <p class="flex-grow-0 flex-shrink-0 text-xs font-bold text-left text-[#adb8cc]"> 25 Ocr 2045 </p>
                        </div>
                    </div>
                    <p class="flex-grow-0 flex-shrink-0 text-lg font-bold text-left text-[#4d5e80]">-$21</p>
                </div>
                <div class="flex justify-between items-center flex-grow-0 flex-shrink-0 w-[343px] relative">
                    <div class="flex justify-start items-center flex-grow-0 flex-shrink-0 gap-[25px]">
                        <div class="flex justify-center items-center flex-grow-0 flex-shrink-0 relative gap-2.5 p-[15px] rounded-[100px] bg-[#f7f8fa]">
                            <svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg" class="flex-grow-0 flex-shrink-0 w-[30px] h-[30px] relative" preserveAspectRatio="none">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M24 13C25.1 13 26 12.1 26 11C26 9.9 25.1 9 24 9C22.9 9 22 9.9 22 11C22 11.18 22.02 11.35 22.07 11.51L18.52 15.07C18.36 15.02 18.18 15 18 15C17.82 15 17.64 15.02 17.48 15.07L14.93 12.52C14.98 12.36 15 12.18 15 12C15 10.9 14.1 10 13 10C11.9 10 11 10.9 11 12C11 12.18 11.02 12.36 11.07 12.52L6.51 17.07C6.35 17.02 6.18 17 6 17C4.9 17 4 17.9 4 19C4 20.1 4.9 21 6 21C7.1 21 8 20.1 8 19C8 18.82 7.98 18.65 7.93 18.49L12.48 13.93C12.64 13.98 12.82 14 13 14C13.18 14 13.36 13.98 13.52 13.93L16.07 16.48C16.02 16.64 16 16.82 16 17C16 18.1 16.9 19 18 19C19.1 19 20 18.1 20 17C20 16.82 19.98 16.64 19.93 16.48L23.49 12.93C23.65 12.98 23.82 13 24 13Z" fill="#3361FF"></path>
                            </svg>
                        </div>
                        <div class="flex flex-col justify-start items-start flex-grow-0 flex-shrink-0 relative gap-[5px]">
                            <p class="flex-grow-0 flex-shrink-0 text-sm font-bold text-left text-[#4d5e80]"> Buy Apple Stocks </p>
                            <p class="flex-grow-0 flex-shrink-0 text-xs font-bold text-left text-[#adb8cc]"> 25 Ocr 2045 </p>
                        </div>
                    </div>
                    <p class="flex-grow-0 flex-shrink-0 text-lg font-bold text-left text-[#4d5e80]"> -$2,455 </p>
                </div>
                <div class="flex justify-between items-center self-stretch flex-grow-0 flex-shrink-0 relative">
                    <div class="flex justify-start items-center flex-grow-0 flex-shrink-0 gap-[25px]">
                        <div class="flex justify-center items-center flex-grow-0 flex-shrink-0 relative gap-2.5 p-[15px] rounded-[100px] bg-[#f7f8fa]">
                            <svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg" class="flex-grow-0 flex-shrink-0 w-[30px] h-[30px] relative" preserveAspectRatio="none">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M14.19 4.1725L7.19 7.2825C6.47 7.6025 6 8.3225 6 9.1125V13.8125C6 19.3625 9.84 24.5525 15 25.8125C20.16 24.5525 24 19.3625 24 13.8125V9.1125C24 8.3225 23.53 7.6025 22.81 7.2825L15.81 4.1725C15.3 3.9425 14.7 3.9425 14.19 4.1725ZM12.29 19.1025L9.7 16.5125C9.51275 16.3257 9.40751 16.072 9.40751 15.8075C9.40751 15.543 9.51275 15.2893 9.7 15.1025C10.09 14.7125 10.72 14.7125 11.11 15.1025L13 16.9825L18.88 11.1025C19.27 10.7125 19.9 10.7125 20.29 11.1025C20.68 11.4925 20.68 12.1225 20.29 12.5125L13.7 19.1025C13.32 19.4925 12.68 19.4925 12.29 19.1025Z" fill="#FF6633"></path>
                            </svg>
                        </div>
                        <div class="flex flex-col justify-start items-start flex-grow-0 flex-shrink-0 relative gap-[5px]">
                            <p class="flex-grow-0 flex-shrink-0 text-sm font-bold text-left text-[#4d5e80]"> VPN Buy Services </p>
                            <p class="flex-grow-0 flex-shrink-0 text-xs font-bold text-left text-[#adb8cc]"> 25 Ocr 2045 </p>
                        </div>
                    </div>
                    <p class="flex-grow-0 flex-shrink-0 text-lg font-bold text-left text-[#4d5e80]"> -$124 </p>
                </div>
            </div>
          <div style="polstion:absolute; width:1000px; height:500px; margin-top:-392px; margin-left:380;">
            <div id="curve_chart" style=" width: 550px; height: 400px;"></div>
          </div>
        </div>
        <div class="flex flex-col justify-start items-start w-[590px] h-[424px] absolute left-[175px] top-[25px] gap-5 p-10 rounded-[30px] bg-[#1A2233]" style="box-shadow: px 5px 10px 0px rgba(255,255,255,1);">
            <div class="flex justify-between items-start self-stretch flex-grow-0 flex-shrink-0 relative">
                <p class="flex-grow-0 flex-shrink-0 text-2xl font-bold text-left text-withe">
                    <span class="flex-grow-0 flex-shrink-0 text-2xl font-bold text-left text-White">Account Summary</span>
                </p>
                <a href="transactions.jsp"><div class="flex justify-center items-center flex-grow-0 flex-shrink-0 relative gap-2.5 p-[15px] rounded-[100px] bg-[#26334d] border-2 border-[#26334d]">
                    <svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg" class="flex-grow-0 flex-shrink-0 w-[30px] h-[30px] relative" preserveAspectRatio="none">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M8 15.5925H19.17L14.29 20.4725C13.9 20.8625 13.9 21.5025 14.29 21.8925C14.68 22.2825 15.31 22.2825 15.7 21.8925L22.29 15.3025C22.68 14.9125 22.68 14.2825 22.29 13.8925L15.71 7.29249C15.5232 7.10523 15.2695 7 15.005 7C14.7405 7 14.4868 7.10523 14.3 7.29249C13.91 7.68249 13.91 8.31249 14.3 8.70249L19.17 13.5925H8C7.45 13.5925 7 14.0425 7 14.5925C7 15.1425 7.45 15.5925 8 15.5925Z" fill="white"></path>
                    </svg>
                </div></a>
            </div>
            <div class="flex flex-col justify-start items-start flex-grow-0 flex-shrink-0 h-[269px] w-[424px] gap-4 pb-[26px]">
                <div class="flex justify-start items-start flex-grow-0 flex-shrink-0 w-[312px] h-[68px] relative gap-9">
                    <img src="imgs/icons/rbc.png" class="flex-grow-0 flex-shrink-0 w-[60px] h-[60px] rounded-[30px] object-cover" />
                    <p class="flex-grow-0 flex-shrink-0 text-4xl font-medium text-left text-white"> $ <%=accounts[0].getBalance()%> </p>
                </div>
                <div class="flex justify-start items-start flex-grow-0 flex-shrink-0 w-[312px] h-[79px] relative gap-9">
                    <img src="imgs/icons/rbc.png" class="flex-grow-0 flex-shrink-0 w-[60px] h-[60px] rounded-[30px] object-cover" />
                    <p class="flex-grow-0 flex-shrink-0 text-4xl font-medium text-left text-white"> $ <%=accounts[1].getBalance()%> </p>
                </div>
                <div class="flex justify-start items-start self-stretch flex-grow-0 flex-shrink-0 gap-[60px]">
                    <div class="flex flex-col justify-start items-start flex-grow relative">
                        <p class="flex-grow-0 flex-shrink-0 text-3xl font-medium text-left text-white"> $ <%=totalSpending%> </p>
                        <p class="flex-grow-0 flex-shrink-0 text-sm font-bold text-left text-[#6b7a99]"> Spent this month </p>
                    </div>
                    <div class="flex flex-col justify-start items-start flex-grow relative">
                        <p class="flex-grow-0 flex-shrink-0 text-3xl font-medium text-left text-white"> $ <%=Math.abs(accounts[0].getBalance() + accounts[1].getBalance())%> </p>
                        <p class="flex-grow-0 flex-shrink-0 text-sm font-bold text-left text-[#6b7a99]"> Total Balance </p>
                    </div>
                </div>
<%--                <div class="flex justify-start items-start flex-grow-0 flex-shrink-0 gap-5">--%>
<%--                    <div class="flex justify-start items-start flex-grow-0 flex-shrink-0 w-16 h-0.5 gap-2.5 p-2.5 rounded-[10px] bg-black"></div>--%>
<%--                    <div class="flex justify-start items-start flex-grow-0 flex-shrink-0 w-16 h-0.5 gap-2.5 p-2.5 rounded-[10px] bg-[#346]"></div>--%>
<%--                    <div class="flex justify-start items-start flex-grow-0 flex-shrink-0 w-16 h-0.5 gap-2.5 p-2.5 rounded-[10px] bg-[#346]"></div>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</body>

</html>
