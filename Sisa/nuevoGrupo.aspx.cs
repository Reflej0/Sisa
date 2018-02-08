using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
	public partial class nuevoGrupo : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            Response.Write("<div class='msg-grupo'>Bienvenido, " + Session["Nombre"] + "<br/>");
            Response.Write(DateTime.Now.ToString() + "</div>");
        }
	}
}