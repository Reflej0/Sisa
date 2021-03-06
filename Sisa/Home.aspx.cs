﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //NULL indica que es la primera vez que entro.
            //-1 o -2 indican que INTENTE entrar pero tengo creedenciales incorrectas.
            if (Session["Usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                int usuario_id = Int32.Parse(Session["Usuario_id"].ToString());
                if(usuario_id < 0)
                {
                    Response.Redirect("Login.aspx");
                }
                Response.Write("<div class='msg-welcome'><div class='navbar-brand text-welcome'> <i class='fas fa-user-circle'></i> <label id='nombreUsuario'>" + Session["Nombre"] + "</label> </div><p>");
                Response.Write(DateTime.Now.ToString() + "</p></div>");
            }
        }
    }
}