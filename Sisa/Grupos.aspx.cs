﻿using System;
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
            
            Response.Write("<div class='msg-grupo'>Hola estoy en el pagee <br/>");
            Response.Write("mi ID es:" + Session["Usuario_id"] +"</div>");
            //Response.End();

        }
    }
}