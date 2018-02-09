using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
    public partial class Grupos : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            // Deberia levantar el ID del usuario, para saber sus grupos

            Response.Write("<div class='msg-welcome'><div class='navbar-brand text-welcome'> <i class='fas fa-user-circle'></i> " + Session["Nombre"] + "</div><p>");
            Response.Write(DateTime.Now.ToString() + "</p></div>");
            //Response.End();

        }
    }
}