<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="OvenSim.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #Container{
            margin:auto;
            width:1500px;
            height:500px;
            border-radius:50px;
            background-color:black;
        }
        #Btn1{
            position:absolute;
            top: 100px;
            left: 1165px;
        }
        #Btn2{
            position:absolute;
            top: 100px;
            left: 1230px;
        }
        #Btn3{
            position:absolute;
            top: 100px;
            left: 1295px;
        }
        #Btn4{
            position:absolute;
            top: 160px;
            left: 1165px;
        }
        #Btn5{
            position:absolute;
            top: 160px;
            left: 1230px;
            right: 417px;
        }
        #Btn6{
            position:absolute;
            top: 160px;
            left: 1295px;
        }
        #Btn7{
            position:absolute;
            top: 220px;
            left: 1165px;
        }
        #Btn8{
            position:absolute;
            top: 220px;
            left: 1230px;
        }
        #Btn9{
            position:absolute;
            top: 220px;
            left: 1295px;
        }
        #Btn0{
            position:absolute;
            top: 280px;
            left: 1230px;
        }
        #HeatSettings{
            position:absolute;
            top: 265px;
            left: 725px;
            height: 65px;
            width: 330px;
        }
        #Timer{
            position:absolute;
            top: 135px;
            left: 665px;
            height: 85px;
            width: 450px;
            border-radius:25px;
        }
        #Setting{
            position:absolute;
            top: 185px;
            left: 675px;
            height: 27px;
            border-radius:25px;
            width: 90px;
        }
        #Image1{
            position:absolute;
            top: 355px;
            left: 820px;
            height: 45px;
            width: 45px;
        }
        #Image2{
            position:absolute;
            top: 355px;
            left: 750px;
            height: 45px;
            width: 45px;
        }
        #Image3{
            position:absolute;
            top: 350px;
            left: 895px;
            height: 55px;
            width: 55px;
        }
        #Image4{
            position:absolute;
            top: 355px;
            left: 985px;
            height: 45px;
            width: 45px;
        }
        #Start_Btn{
            position:absolute;
            top: 80px;
            left: 405px;
        }
        #Stop_Btn{
            position:absolute;
            top: 80px;
            left: 525px;
        }
        #Add_Btn{
            position:absolute;
            top: 200px;
            left: 405px;
        }
        #Clear_Btn{
            position:absolute;
            top: 200px;
            left: 525px;
        }
        #DisplayMinutes{
            position:absolute;
            top: 120px;
            left: 875px;
            height: 60px;
            width: 60px;
        }
        #DisplaySeconds{
            position:absolute;
            top: 120px;
            left: 1020px;
            height: 60px;
            width: 60px;
        }
        #Span{
            position:absolute;
            top: 105px;
            left: 980px;
            height: 60px;
            width: 60px;
        }
        #currentSetting{
            position:absolute;
            top: 185px;
            left: 685px;
            height: 17px;
            width: 110px;
        }
    </style>
</head>
<body>
    <form id="Container" runat="server">
        <div>
            <%-- Allows AJAX/PostBack functionality --%>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <%-- UpdatePanel holds all information that changes things. Buttons might not have needed to be in here, but shouldn't hurt anything to stay inside --%>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="TimerTick" EventName="Tick" />
                </Triggers>
                <ContentTemplate>
                    <%-- Overlapping text-boxes. Timer is the larger box, holding the timer and dynamically edited.
                        Secondary text box is the setting box which states what heating setting the oven is on--%>
                    <asp:TextBox ID="Timer" runat="server" BackColor="#2D551A"></asp:TextBox>
                    <asp:TextBox ID="Setting" runat="server" BackColor="#2D551A"></asp:TextBox>

                    <%-- Building minute and second break using labels overtop the textbox, so the rate at which number types lower differs.
                        Possibly only show after putting a number. Do by having visible be false on load, but turn true on input--%>
                    <asp:Label ID="DisplayMinutes" runat="server" Text="00" Font-Size="80pt" Font-Names="Haettenschweiler" ForeColor="#52D105"></asp:Label>
                    <asp:Label ID="Span" runat="server" Text=":" Font-Size="80pt" Font-Names="Haettenschweiler" ForeColor="#52D105">:</asp:Label>
                    <asp:Label ID="DisplaySeconds" runat="server" Text="00" Font-Size="80pt" Font-Names="Haettenschweiler" ForeColor="#52D105">00</asp:Label>
                    <asp:Label ID="currentSetting" runat="server" Text="Setting" Font-Size="20pt" Font-Names="Haettenschweiler" ForeColor="#52D105">Setting</asp:Label>

                    <%-- Buttons for timer input. Needs to only work if timer is set to stopped or cleared. 
                        Or stop working on start being pressed, but work again on clear being pressed. Timer runs every 1000 miliseconds (1sec) --%>
                    <asp:Timer ID="TimerTick" runat="server" Interval="1000" OnTick="Time_Tick" Enabled="false"></asp:Timer>
                    <asp:Button ID="Btn1" runat="server" Text="1" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn2" runat="server" Text="2" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn3" runat="server" Text="3" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn4" runat="server" Text="4" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn5" runat="server" Text="5" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn6" runat="server" Text="6" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn7" runat="server" Text="7" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn8" runat="server" Text="8" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn9" runat="server" Text="9" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />
                    <asp:Button ID="Btn0" runat="server" Text="0" BackColor="Black" BorderColor="White" BorderStyle="Outset" Font-Bold="True" Font-Names="Agency FB" Font-Size="Larger" ForeColor="White" Width="44px" OnClick="PadBtn_Click" />

                    <%-- Images under each setting to further personalize design --%>
                    <asp:Image ID="Image1" runat="server" ImageUrl="images/bake.png" />
                    <asp:Image ID="Image2" runat="server" ImageUrl="images/broil.png" />
                    <asp:Image ID="Image3" runat="server" ImageUrl="images/roast.png" />
                    <asp:Image ID="Image4" runat="server" ImageUrl="images/defrost.png" />

                    <%-- Buttons for timer manipulation. Make event using onClientClick, or its own IndexChanged.
                        Make something similar to the var btn that uses ImageButton(Sender) instead--%>
                    <asp:ImageButton ID="Start_Btn" runat="server" ImageUrl="images/start.png" OnClick="Mod_Btn" CommandName="Start" />
                    <asp:ImageButton ID="Stop_Btn" runat="server" ImageUrl="images/stop.png" OnClick="Mod_Btn" CommandName="Stop" />
                    <asp:ImageButton ID="Add_Btn" runat="server" ImageUrl="images/add.png" OnClick="Mod_Btn" CommandName="Add" />
                    <asp:ImageButton ID="Clear_Btn" runat="server" ImageUrl="images/clear.png" OnClick="Mod_Btn" CommandName="Clear" />

                    <%-- Radio list items have dedicated text and value calls, which can be sent as strings. 
                        C# code will check to be sure that the string is not "", meaning empty. Otherwise, timer isn't allowed to start --%>
                    <asp:RadioButtonList ID="HeatSettings" runat="server" OnSelectedIndexChanged="Cooking" AutoPostBack="True" RepeatDirection="Horizontal" BorderStyle="Inset" CellSpacing="5" Font-Names="Agency FB" BackColor="Black" Font-Bold="True" Font-Size="Larger" ForeColor="White">
                        <%-- Event argument will need to use either something in radio button list, or the selected values of these  --%>
                        <asp:ListItem Text="Bake" Value="Bake">Bake</asp:ListItem>
                        <asp:ListItem Text="Broil" Value="Broil">Broil</asp:ListItem>
                        <asp:ListItem Text="Roast" Value="Roast">Roast</asp:ListItem>
                        <asp:ListItem Text="Defrost" Value="Defrost">Defrost</asp:ListItem>
                    </asp:RadioButtonList>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
