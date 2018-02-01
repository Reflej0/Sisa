using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //NULL indica que es la primera vez que entro.
            //-1 o -2 indican que INTENTE entrar pero tengo creedenciales incorrectas.
            if(Session["Usuario_id"] == null || Convert.ToInt32(Session["Usuario_id"]) < 0) // No puedo acceder a esta página si no estoy logeado.
            {
                Response.Redirect("Login.asmx");
            }
        }
    }
}