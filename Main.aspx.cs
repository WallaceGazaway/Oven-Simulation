using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OvenSim
{
    public partial class Main : System.Web.UI.Page
    {
        //Will be used to have the timer box empty on initial load
        bool timeInput;

        protected void Page_Load(object sender, EventArgs e)
        {
            //On initial load timer is completely blank.
            //Consider code here that locks hitting start, or removes/grays button entirely until a time above 0 is input
            if (!Page.IsPostBack)
            {
                timeInput = false;
                DisplayMinutes.Visible = false;
                Span.Visible = false;
                DisplaySeconds.Visible = false;
                currentSetting.Visible = false;
            }
        }

        public void PadBtn_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.Button btn;
            btn = (System.Web.UI.WebControls.Button)sender;
            //var btn = (Button)sender;

            timeInput = true;

            //Session Variable start. Allow variable modification post-load. First line checks if variable already exists.
            if (Session["InputTime"] == null) Session["InputTime"] = "";
            //Convert object and given text variables of button presses to string.
            var newTime = Session["InputTime"].ToString() + btn.Text;
            //Updates time to newly made string variable.
            Session["InputTime"] = newTime;
            //Converts to integer. Breaks user given input into minute and second values. If input is not 3 characters or more, the minute value is 0.
            //Code starts at start of string until two characters from end before stopping. The last 2 characters are reserved for seconds
            //Parse is functionally similar to Convert.Int16, save that it makes it a 32bit int, and lacks the null to 0 methodology
            var currentMin = (newTime.Length > 2) ? int.Parse(newTime.Substring(0, newTime.Length - 2)) : 0;
            //Seconds version. Strips everything away except the last two given characters, in event it goes beyond 2 inputs.
            //Rather than starting at the beginning of the string and then stopping 2 characters from the end, this begins at that end point and goes from there.
            var currentSec = (newTime.Length > 2) ? int.Parse(newTime.Substring(newTime.Length - 2)) : int.Parse(newTime);

            //New Session Variables to count remaining minutes and seconds.
            Session["MinRemaining"] = currentMin;
            Session["SecRemaining"] = currentSec;
            //Changes the default given text of the timer to reflect and update based on input and time passage.
            DisplayMinutes.Text = String.Format("{0:00}", currentMin);
            DisplaySeconds.Text = String.Format("{0:00}", currentSec);
            //Makes timer visible once numbers are input
            if (timeInput)
            {
                DisplayMinutes.Visible = true;
                Span.Visible = true;
                DisplaySeconds.Visible = true;
            }
            //Lock user input if 4 numbers are present
            if (newTime.Length == 4)
            {
                Btn1.Enabled = false;
                Btn2.Enabled = false;
                Btn3.Enabled = false;
                Btn4.Enabled = false;
                Btn5.Enabled = false;
                Btn6.Enabled = false;
                Btn7.Enabled = false;
                Btn8.Enabled = false;
                Btn9.Enabled = false;
                Btn0.Enabled = false;
            }

        }

        public void Mod_Btn(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.ImageButton choice;
            choice = (System.Web.UI.WebControls.ImageButton)sender;
            //var choice = (ImageButton)sender;

            if (choice.ID.Contains("Start"))
            {
                //Begins timer.
                TimerTick.Enabled = true;
                //Clears Time variable so new inputs can be freshly added.
                Session["InputTime"] = null;

                //Removes ability to keep adding seconds and minutes while active.
                Btn1.Enabled = false;
                Btn2.Enabled = false;
                Btn3.Enabled = false;
                Btn4.Enabled = false;
                Btn5.Enabled = false;
                Btn6.Enabled = false;
                Btn7.Enabled = false;
                Btn8.Enabled = false;
                Btn9.Enabled = false;
                Btn0.Enabled = false;
            }

            if (choice.ID.Contains("Stop"))
            {
                //Pauses Timer.
                TimerTick.Enabled = false;
            }

            if (choice.ID.Contains("Clear"))
            {
                //Makes timer invisible again.
                timeInput = false;
                DisplayMinutes.Visible = false;
                Span.Visible = false;
                DisplaySeconds.Visible = false;

                //Resets Timer.
                TimerTick.Enabled = false;
                Session["MinRemaining"] = 0;
                Session["SecRemaining"] = 0;
                DisplayMinutes.Text = String.Format("{0:00}", 0);
                DisplaySeconds.Text = String.Format("{0:00}", 0);

                //Return numeric inputs.
                Btn1.Enabled = true;
                Btn2.Enabled = true;
                Btn3.Enabled = true;
                Btn4.Enabled = true;
                Btn5.Enabled = true;
                Btn6.Enabled = true;
                Btn7.Enabled = true;
                Btn8.Enabled = true;
                Btn9.Enabled = true;
                Btn0.Enabled = true;
            }

            if (choice.ID.Contains("Add"))
            {
                //Brings in what is already in a different argument.
                var currentMin = int.Parse(Session["MinRemaining"].ToString());

                Session["MinRemaining"] = currentMin + 1;
                
                DisplayMinutes.Text = String.Format("{0:00}", currentMin);
                
            }
        }

        public void Cooking(object sender, EventArgs e)
        {
            //Sets cooking display based on chosen radio button
            currentSetting.Visible = true;
            currentSetting.Text = HeatSettings.Text;
        }

        public void Time_Tick(object sender, EventArgs e)
        {
            //Replicate data from different argument.
            var currentMin = int.Parse(Session["MinRemaining"].ToString());
            var currentSec = int.Parse(Session["SecRemaining"].ToString());
            //Countdown seconds constantly.
            currentSec--;
            //Locks timer if no amount is placed.
            if (currentMin == 0 && currentSec == 0)
            {
                TimerTick.Enabled = false;
            }
            else if (currentSec < 0)
            {
                //Countdown minutes every time seconds pass 0, and then returns seconds to 59 to then count down again.
                currentMin--;
                currentSec = 59;
            }
            //Timer update and display here as well.
            Session["MinRemaining"] = currentMin;
            Session["SecRemaining"] = currentSec;
            DisplayMinutes.Text = String.Format("{0:00}", currentMin);
            DisplaySeconds.Text = String.Format("{0:00}", currentSec);
        }
    }
}